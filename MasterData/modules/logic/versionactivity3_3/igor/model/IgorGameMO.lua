-- chunkname: @modules/logic/versionactivity3_3/igor/model/IgorGameMO.lua

module("modules.logic.versionactivity3_3.igor.model.IgorGameMO", package.seeall)

local IgorGameMO = class("IgorGameMO")

function IgorGameMO:ctor(id)
	self.id = id
	self.config = IgorConfig.instance:getGameConfig(id)

	local topRoot = ViewMgr.instance:getTopUIRoot()

	self.uiRoot = topRoot.transform
	self.tempVector2 = Vector2.zero
end

function IgorGameMO:setEpisodeCo(episodeCo)
	self.episodeCo = episodeCo
end

function IgorGameMO:initGame()
	self.startTime = Time.realtimeSinceStartup
	self.entityDict = {}
	self.entityList = {}
	self.entityCountList = {}
	self.waitDelEntityList = {}
	self.unitIdCount = 0
	self.gameCost = 0
	self._isInited = false
	self._isPaused = false
	self.gameCostDeltaTime = 0
	self.costSpeedUpTime = tonumber(IgorConfig.instance:getConstValue(IgorEnum.ConstId.CostSpeedUpTime))
	self.costRecoverySpeed = tonumber(IgorConfig.instance:getConstValue(IgorEnum.ConstId.CostRecoverySpeed))

	for _, campType in ipairs(IgorEnum.RefreshList) do
		self:getCampDict(campType)
	end

	self:setPutTempPos()
end

function IgorGameMO:getStartTime()
	return self.startTime
end

function IgorGameMO:resetGame()
	self:initGame()
	IgorController.instance:dispatchEvent(IgorEvent.OnGameReset)
end

function IgorGameMO:setInited()
	self._isInited = true

	IgorController.instance:dispatchEvent(IgorEvent.OnGameInited)
end

function IgorGameMO:isInited()
	return self._isInited
end

function IgorGameMO:setPaused(isPaused)
	self._isPaused = isPaused

	IgorController.instance:dispatchEvent(IgorEvent.OnGamePause, isPaused)
end

function IgorGameMO:isPaused()
	return self._isPaused
end

function IgorGameMO:canUpdate()
	return self._isInited and not self._isPaused
end

function IgorGameMO:update(deltaTime)
	self:updateGameCost(deltaTime)
	self:udateEntity(deltaTime)
	self:addOrDelDeadEntity()
	self:checkGameEnd()
end

function IgorGameMO:udateEntity(deltaTime)
	for _, campType in ipairs(IgorEnum.RefreshList) do
		for _, mo in ipairs(self.entityList[campType]) do
			mo:update(deltaTime)
			mo:updateState()
		end
	end
end

function IgorGameMO:updateGameCost(deltaTime)
	if self.costSpeedUpTime > 0 then
		self.costSpeedUpTime = self.costSpeedUpTime - deltaTime

		if self.costSpeedUpTime <= 0 then
			GameFacade.showToast(ToastEnum.V3A3IgorCostSpeedUp)
		end
	end

	local cost = self:getGameCost()
	local max = self:getGameCostMax()

	if max <= cost then
		return
	end

	self.gameCostDeltaTime = self.gameCostDeltaTime + deltaTime

	local speed = self:getGameCostSpeed()

	if speed <= self.gameCostDeltaTime then
		self.gameCostDeltaTime = self.gameCostDeltaTime - speed

		self:changeGameCost(1)
	end
end

function IgorGameMO:addOrDelDeadEntity()
	if self.waitAddEntityList then
		for _, mo in ipairs(self.waitAddEntityList) do
			self:realAddEntity(mo)
		end

		self.waitAddEntityList = nil
	end

	if self.waitDelEntityList then
		for _, mo in ipairs(self.waitDelEntityList) do
			self:realDelEntity(mo)
		end

		self.waitDelEntityList = nil
	end
end

function IgorGameMO:checkGameEnd()
	if not self.oursideMo or self.oursideMo:isDead() or not self.enemyMo or self.enemyMo:isDead() then
		self:setPaused(true)
	end
end

function IgorGameMO:createSoldier(soldierId, campType, customPosX, customPosY)
	local config = IgorConfig.instance:getSoldierConfig(soldierId)

	if campType == IgorEnum.CampType.Ourside and not self:tryCost(config.cost) then
		return
	end

	local mo = IgorSoldierMO.New()

	mo:init(soldierId, campType)
	self:addEntity(mo, customPosX, customPosY)
end

function IgorGameMO:addEntity(mo, customPosX, customPosY, immediately)
	local campType = mo.campType

	if campType ~= IgorEnum.SoldierType.Base then
		customPosX = customPosX or campType == IgorEnum.CampType.Ourside and self.startPosX or self.endPosX
		customPosX = Mathf.Clamp(customPosX, self.startPosX, self.endPosX)
		customPosY = customPosY or self:calculateEvenlyDistributedY(campType)
		customPosY = Mathf.Clamp(customPosY, self.startPosY, self.endPosY)

		self.tempVector2:Set(customPosX, customPosY)

		local anchorPosX, anchorPosY = recthelper.screenPosToAnchorPos2(self.tempVector2, self.uiRoot)

		mo:initPos(anchorPosX, anchorPosY)
	end

	if immediately then
		self:realAddEntity(mo)

		return
	end

	self.waitAddEntityList = self.waitAddEntityList or {}

	table.insert(self.waitAddEntityList, mo)
end

function IgorGameMO:delEntity(mo)
	self.waitDelEntityList = self.waitDelEntityList or {}

	table.insert(self.waitDelEntityList, mo)
end

function IgorGameMO:realAddEntity(mo)
	local unitId = self:getUnitId(mo)
	local campType = mo.campType
	local entityDict = self:getCampDict(campType)

	if entityDict[unitId] then
		return
	end

	entityDict[unitId] = mo

	table.insert(self.entityList[campType], mo)

	self.entityCountList[campType] = self.entityCountList[campType] + 1

	if mo.type ~= IgorEnum.SoldierType.Base then
		IgorController.instance:dispatchEvent(IgorEvent.OnEntityAdd, mo)
	end
end

function IgorGameMO:realDelEntity(mo)
	local unitId = self:getUnitId(mo)
	local campType = mo.campType
	local entityDict = self:getCampDict(campType)

	if not entityDict[unitId] then
		return
	end

	entityDict[unitId] = nil

	tabletool.removeValue(self.entityList[campType], mo)

	self.entityCountList[campType] = self.entityCountList[campType] - 1

	if mo.type ~= IgorEnum.SoldierType.Base then
		IgorController.instance:dispatchEvent(IgorEvent.OnEntityDel, mo)
	end
end

function IgorGameMO:getEntityMoByUnitId(unitId, campType)
	local entityDict = self:getCampDict(campType)

	return entityDict[unitId]
end

function IgorGameMO:getCampDict(campType)
	local campDict = self.entityDict[campType]

	if not campDict then
		campDict = {}
		self.entityDict[campType] = campDict
		self.entityList[campType] = {}
		self.entityCountList[campType] = 0
	end

	return campDict
end

function IgorGameMO:getOtherCampEntityList(campType)
	for _, _campType in pairs(IgorEnum.CampType) do
		if _campType ~= campType then
			return self.entityList[_campType], self.entityCountList[_campType]
		end
	end
end

function IgorGameMO:sortEntity()
	for campType, list in pairs(self.entityList) do
		if campType == IgorEnum.CampType.Ourside then
			table.sort(list, IgorGameMO.sortOurSide)
		else
			table.sort(list, IgorGameMO.sortEnemy)
		end
	end
end

function IgorGameMO.sortOurSide(a, b)
	return a.posX < b.posX
end

function IgorGameMO.sortEnemy(a, b)
	return a.posX > b.posX
end

function IgorGameMO:getUnitId(mo)
	local unitId = mo.unitId

	if not unitId then
		self.unitIdCount = self.unitIdCount + 1
		unitId = self.unitIdCount

		mo:setParam(self.unitIdCount, self)
	end

	return unitId
end

function IgorGameMO:getGameCost()
	return self.gameCost
end

function IgorGameMO:tryCost(cost)
	local curCost = self:getGameCost()

	if curCost < cost then
		return false
	end

	self:changeGameCost(-cost)

	return true
end

function IgorGameMO:changeGameCost(cost)
	local max = self:getGameCostMax()
	local ret = self.gameCost + cost

	if max < ret then
		return
	end

	self.gameCost = ret

	IgorController.instance:dispatchEvent(IgorEvent.OnGameCostChange)
end

function IgorGameMO:getGameCostMax()
	local config = self.oursideMo:getConfig()

	return config.costLimit
end

function IgorGameMO:getGameCostSpeed()
	return (self.costSpeedUpTime <= 0 or nil) and self.costRecoverySpeed * 0.5
end

function IgorGameMO:setStartAndEndPos(startPosX, endPosX, startPosY, endPosY, campWidth)
	self.startPosX = startPosX
	self.endPosX = endPosX
	self.startPosY = startPosY
	self.endPosY = endPosY
	self.campWidth = campWidth
end

function IgorGameMO:initCampMo()
	local halfWidth = self.campWidth / 2

	self.oursideMo = self.oursideMo or IgorCampOursideMO.New()

	local oursideId = self.config.oursideId

	self.oursideMo:init(oursideId, IgorEnum.CampType.Ourside)
	self:addEntity(self.oursideMo, self.startPosX - halfWidth)

	self.enemyMo = self.enemyMo or IgorCampEnemyMO.New()

	local enemyId = self.config.enemyId

	self.enemyMo:init(enemyId, IgorEnum.CampType.Enemy)
	self:addEntity(self.enemyMo, self.endPosX + halfWidth)
	self:setInited()
end

function IgorGameMO:getOursideMo()
	return self.oursideMo
end

function IgorGameMO:getCurLevel()
	return self.oursideMo.level
end

function IgorGameMO:calculateEvenlyDistributedY(campType)
	return math.random(self.startPosY, self.endPosY)
end

function IgorGameMO:isInLimitRect(posX, posY)
	local ret = posX >= self.startPosX and posX <= self.endPosX and posY >= self.startPosY and posY <= self.endPosY
	local clampedPosX = Mathf.Clamp(posX, self.startPosX, self.endPosX)
	local clampedPosY = Mathf.Clamp(posY, self.startPosY, self.endPosY)

	return ret, clampedPosX, clampedPosY
end

function IgorGameMO:setPutTempPos(posX, posY)
	self.putTempPosX = posX
	self.putTempPosY = posY
end

function IgorGameMO:getPutTempPos()
	return self.putTempPosX, self.putTempPosY
end

return IgorGameMO
