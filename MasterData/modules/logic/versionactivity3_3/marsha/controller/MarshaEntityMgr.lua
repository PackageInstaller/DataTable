-- chunkname: @modules/logic/versionactivity3_3/marsha/controller/MarshaEntityMgr.lua

module("modules.logic.versionactivity3_3.marsha.controller.MarshaEntityMgr", package.seeall)

local MarshaEntityMgr = class("MarshaEntityMgr")

function MarshaEntityMgr:ctor()
	self._uniqueId = 0
	self._entities = {}
	self._grid = {}

	for i = 1, 60 do
		self._grid[i] = {}

		for j = 1, 40 do
			self._grid[i][j] = false
		end
	end

	self.dispatchEnd = false
end

function MarshaEntityMgr:noPut(x, y)
	for i = x - 1, x + 1 do
		for j = y - 1, y + 1 do
			if i ~= 0 and j ~= 0 and self._grid[i][j] then
				return true
			end
		end
	end

	return false
end

function MarshaEntityMgr:findEmptyPos()
	local count = 0
	local gridX = math.random(1, 59)
	local gridY = math.random(1, 39)

	while self:noPut(gridX, gridY) do
		count = count + 1

		if count >= 100 then
			break
		end

		gridX = math.random(1, 59)
		gridY = math.random(1, 39)
	end

	if count < 100 then
		self._grid[gridX][gridY] = true

		return 64 * gridX, 54 * gridY
	end
end

function MarshaEntityMgr:setRoot(expLayer, ballLayer, itemMap)
	self._expItem = itemMap[MarshaEnum.UnitType.Exp]
	self._expLayer = expLayer
	self._ballLayer = ballLayer
	self._type2GoMap = itemMap
end

function MarshaEntityMgr:initParam(mapId)
	self._gameCo = MarshaConfig.instance:getGameConfig(mapId)
	self._minPaperScraps = string.splitToNumber(self._gameCo.type7Num, "#")[1]
	self._maxPaperScraps = string.splitToNumber(self._gameCo.type7Num, "#")[2]

	local param = string.splitToNumber(self._gameCo.type7Weight, "#")

	self._minExpWeight = param[1]
	self._maxExpWeight = param[2]
end

function MarshaEntityMgr:addEntity(config)
	self._uniqueId = self._uniqueId + 1

	local unitType = config.unitType

	if not MarshaEnum.UnitTypeToName[unitType] then
		local name = ""
		local go = self._type2GoMap[unitType]
		local cloneGo = gohelper.clone(go, self._ballLayer, name)

		gohelper.setActive(cloneGo, true)

		local entity

		if unitType == MarshaEnum.UnitType.Player then
			if self._playerEntity then
				logError("配置错误，存在不止一个玩家小球")

				return
			end

			entity = MonoHelper.addNoUpdateLuaComOnceToGo(cloneGo, MarshaPlayerEntity)

			entity:initData(config, self._uniqueId)

			self._playerEntity = entity
		else
			entity = MonoHelper.addNoUpdateLuaComOnceToGo(cloneGo, MarshaEnemyEntity)

			entity:initData(config, self._uniqueId)

			self._entities[#self._entities + 1] = entity
		end
	end
end

function MarshaEntityMgr:addExpEntity()
	local x, y = self:findEmptyPos()

	if x then
		self._uniqueId = self._uniqueId + 1

		local name = MarshaEnum.UnitTypeToName[MarshaEnum.UnitType.Exp]
		local go = gohelper.clone(self._expItem, self._expLayer, name)
		local entity = MonoHelper.addNoUpdateLuaComOnceToGo(go, MarshaExpEntity)
		local weight = math.random(self._minExpWeight, self._maxExpWeight)

		entity:initData(self._uniqueId, weight, x, y)
		gohelper.setActive(entity.go, true)

		self._entities[#self._entities + 1] = entity
	end
end

function MarshaEntityMgr:removeEntity(index)
	local entity = self._entities[index]

	if entity.unitType == MarshaEnum.UnitType.Exp then
		local gridX = entity.x / 64
		local gridY = entity.y / 54

		self._grid[gridX][gridY] = false

		local expCnt = self:getBallCnt(MarshaEnum.UnitType.Exp)

		if expCnt < self._minPaperScraps then
			for i = 1, self._minPaperScraps - expCnt do
				self:addExpEntity()
			end
		end
	end

	entity:dispose()
	table.remove(self._entities, index)
end

function MarshaEntityMgr:getPlayerEntity(try)
	if self._playerEntity then
		return self._playerEntity
	elseif not try then
		logError("请检查配置,未生成玩家小球")
	end
end

function MarshaEntityMgr:getEntity(uid)
	for k, entity in ipairs(self._entities) do
		if entity.uid == uid then
			return entity, k
		end
	end

	logError(string.format("找不到UID为%s的小球", uid))
end

function MarshaEntityMgr:getEntities()
	return self._entities
end

function MarshaEntityMgr:getBallCnt(unitType)
	local count = 0

	for _, entity in ipairs(self._entities) do
		if entity.unitType == unitType then
			count = count + 1
		end
	end

	return count
end

function MarshaEntityMgr:beginTick()
	TaskDispatcher.runRepeat(self.frameTick, self, 0, -1)
end

function MarshaEntityMgr:pauseTick()
	TaskDispatcher.cancelTask(self.frameTick, self)
end

function MarshaEntityMgr:frameTick()
	local count = 3
	local dt = Mathf.Clamp(UnityEngine.Time.deltaTime, 0.01, 0.1)

	dt = dt / count

	for _ = 1, count do
		self:_tickDt(dt)
	end
end

function MarshaEntityMgr:_tickDt(dt)
	for _, entity in pairs(self._entities) do
		entity:tick(dt)
	end

	if self._playerEntity.unControl then
		self._playerEntity:tick(dt)
	end

	for i, entityA in ipairs(self._entities) do
		for j = i + 1, #self._entities do
			local entityB = self._entities[j]

			if tabletool.indexOf(MarshaEnum.TriggerType[entityA.unitType], entityB.unitType) then
				local hitX, hitY = MarshaHelper.getHitInfo(entityA, entityB)

				if hitX then
					local hitPos = Vector2(hitX, hitY)

					MarshaSkillHelper.CollideTriggerSkill(entityA, entityB, hitPos)
					MarshaSkillHelper.CollideTriggerSkill(entityB, entityA, hitPos)
				end
			end
		end

		if tabletool.indexOf(MarshaEnum.TriggerType[entityA.unitType], MarshaEnum.UnitType.Player) then
			local hitX, hitY = MarshaHelper.getHitInfo(entityA, self._playerEntity)

			if hitX then
				self._playerEntity:playAnim("touch", true)
				MarshaSkillHelper.CollideTriggerSkill(entityA, self._playerEntity, Vector2(hitX, hitY))
			elseif self._playerEntity.adsorbDis and tabletool.indexOf(self._playerEntity.adsorbConditions, entityA.unitType) then
				local dis = Vector2.Distance(self._playerEntity:getAnchorPos(), entityA:getAnchorPos()) - (self._playerEntity.width + entityA.width)

				if dis <= self._playerEntity.adsorbDis then
					local weight = self._playerEntity.weight + entityA.weight

					self._playerEntity:setWeight(weight)
					entityA:setDead()
				end
			end
		end
	end

	for k, entity in ipairs(self._entities) do
		if entity.isDead then
			self:removeEntity(k)

			if entity.unitType ~= MarshaEnum.UnitType.Exp then
				MarshaController.instance:dispatchEvent(MarshaEvent.BallDead, entity.unitType)
			end
		end
	end

	if self._playerEntity.isDead and not self.dispatchEnd then
		MarshaController.instance:dispatchEvent(MarshaEvent.GameEnd, false, MarshaEnum.FailReason.NoHp)

		self.dispatchEnd = true

		return
	end

	self:checkTarget()
end

function MarshaEntityMgr:clear()
	TaskDispatcher.cancelTask(self.frameTick, self)

	for _, entity in pairs(self._entities) do
		entity:dispose()
	end

	self._entities = {}

	if self._playerEntity then
		self._playerEntity:dispose()

		self._playerEntity = nil
	end

	for i = 1, 60 do
		for j = 1, 40 do
			self._grid[i][j] = false
		end
	end

	self.dispatchEnd = false
end

function MarshaEntityMgr:checkTarget()
	local targetParam = string.split(self._gameCo.targets, "#")

	if targetParam[1] == MarshaEnum.TargetType.Weight then
		local weight = tonumber(targetParam[2])

		if weight <= self._playerEntity.weight then
			MarshaController.instance:dispatchEvent(MarshaEvent.GameEnd, true)
		end
	elseif targetParam[1] == MarshaEnum.TargetType.KillType then
		local types = string.splitToNumber(targetParam[2], ",")
		local isFinish = true

		for _, type in ipairs(types) do
			local count = self:getBallCnt(type)

			if count ~= 0 then
				isFinish = false

				break
			end
		end

		if isFinish then
			MarshaController.instance:dispatchEvent(MarshaEvent.GameEnd, true)
		end
	end
end

MarshaEntityMgr.instance = MarshaEntityMgr.New()

return MarshaEntityMgr
