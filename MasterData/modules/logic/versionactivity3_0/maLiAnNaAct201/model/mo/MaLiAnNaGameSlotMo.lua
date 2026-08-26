-- chunkname: @modules/logic/versionactivity3_0/maLiAnNaAct201/model/mo/MaLiAnNaGameSlotMo.lua

module("modules.logic.versionactivity3_0.maLiAnNaAct201.model.mo.MaLiAnNaGameSlotMo", package.seeall)

local MaLiAnNaGameSlotMo = class("MaLiAnNaGameSlotMo", MaLiAnNaLaLevelMoSlot)

function MaLiAnNaGameSlotMo.create(slotData)
	local instance = MaLiAnNaGameSlotMo.New()

	instance:updatePos(slotData.posX, slotData.posY)
	instance:init(slotData.id, slotData.configId)
	instance:updateHeroId(slotData.heroId)

	return instance
end

function MaLiAnNaGameSlotMo:ctor()
	MaLiAnNaGameSlotMo.super.ctor(self)
end

function MaLiAnNaGameSlotMo:init(id, configId)
	self.id = id
	self.configId = configId
	self._slotSoldierList = {}
	self._config = Activity201MaLiAnNaConfig.instance:getSlotConfigById(self.configId)
	self._slotCamp = self._config.initialCamp
	self._generateSoliderSpeed = self._config.soldierRecover
	self._soliderLimit = self._config.soldierLimit
	self._dispatchInterval = self._config.dispatchInterval
	self._dispatchValue = 0
	self._dispatchPath = {}
	self._generateTime = 0
	self._dispatchTime = 0
	self._skillGenerateSoliderEffectTime = 0
	self._soliderCampIndex = {}

	for _, v in pairs(Activity201MaLiAnNaEnum.CampType) do
		self._soliderCampIndex[v] = {}
	end

	self._slotType = Activity201MaLiAnNaEnum.SlotType.normal
	self._skill = nil

	if not string.nilorempty(self._config.type) then
		local keys = string.splitToNumber(self._config.type, "#")

		self._slotType = keys[1]
	end

	local _, _, offsetX, offsetY = self:getSlotConstValue()
	local x, y = self:getPosXY()

	self.basePosX = x
	self.basePosY = y

	self:updatePos(x + offsetX, y + offsetY)
	self:initByConfig()
	self:initPassiveSkill()
end

function MaLiAnNaGameSlotMo:initByConfig()
	if self._config == nil then
		return
	end

	for i = 1, self._config.initialSoldier do
		self:createSolider(self._slotCamp)
	end
end

function MaLiAnNaGameSlotMo:updateHeroId(heroId)
	self.heroId = heroId

	if self.heroId and self.heroId ~= 0 then
		self:createSolider(self._slotCamp, self.heroId)
	end
end

function MaLiAnNaGameSlotMo:update(deltaTime)
	self:_generateSolider(deltaTime)
	self:_dispatchSoldier(deltaTime)

	for _, solider in pairs(self._slotSoldierList) do
		if solider then
			solider:update(deltaTime)

			if solider:getCamp() ~= self._slotCamp then
				solider:setCamp(self._slotCamp)
			end
		end
	end

	if isDebugBuild then
		-- block empty
	end
end

function MaLiAnNaGameSlotMo:_generateSolider(deltaTime)
	self._skillGenerateSoliderEffectTime = math.max(self._skillGenerateSoliderEffectTime - deltaTime, 0)

	if self._skillGenerateSoliderEffectTime > 0 then
		return
	end

	self._generateTime = self._generateTime + deltaTime * 1000 * (1 + self:_getSlotSoliderSpeedPercent() / 1000)

	if self._generateTime < self._generateSoliderSpeed then
		return
	end

	self._generateTime = 0

	local isLimit = self:soliderCountIsLimit()

	if isLimit then
		return
	end

	self:createSolider(self._slotCamp)
	Activity201MaLiAnNaGameController.instance:dispatchEvent(Activity201MaLiAnNaEvent.GenerateSolider, self:getId(), 1)
end

function MaLiAnNaGameSlotMo:soliderCountIsLimit()
	local normalSoliderCount, _, _ = self:getSoliderCount()

	return normalSoliderCount >= self._soliderLimit
end

function MaLiAnNaGameSlotMo:createSolider(camp, configId)
	if configId == nil then
		local id = Activity201MaLiAnNaEnum.soliderGenerateIdByCamp.mySolider

		if camp == Activity201MaLiAnNaEnum.CampType.Enemy then
			id = Activity201MaLiAnNaEnum.soliderGenerateIdByCamp.enemySolider
		end

		configId = Activity201MaLiAnNaConfig.instance:getConstValueNumber((camp == Activity201MaLiAnNaEnum.CampType.Middle or nil) and Activity201MaLiAnNaEnum.soliderGenerateIdByCamp.middleSolider)
	end

	if configId then
		local soliderMo = MaLiAnNaLaSoliderMoUtil.instance:createSoliderMo(configId)

		soliderMo:setCamp(camp and camp or self._slotCamp)
		soliderMo:setLocalPos(self.posX, self.posY)
		self:_updateSoliderList(soliderMo, false)

		return true
	end

	return false
end

function MaLiAnNaGameSlotMo:removeSolider()
	local count = #self._slotSoldierList

	if count <= 0 then
		return nil
	end

	local soliderMo

	for i = 1, count do
		local solider = self._slotSoldierList[i]

		if not solider:isHero() then
			soliderMo = solider

			table.remove(self._slotSoldierList, i)

			break
		end
	end

	self:_updateCurCamp()

	return soliderMo
end

function MaLiAnNaGameSlotMo:enterSoldier(soldierMo, fastEnter)
	if soldierMo == nil or soldierMo:isDead() then
		return false
	end

	if self._slotCamp ~= soldierMo:getCamp() then
		if self._slotType == Activity201MaLiAnNaEnum.SlotType.trench and self._skill ~= nil then
			local canUse = self._skill:canUseSkill(self, soldierMo)

			if canUse then
				local hp = soldierMo:getHp()
				local buffHp = self._skill:getHp()

				soldierMo:updateHp(-buffHp, false)
				self._skill:soliderAttack(hp)

				return true
			end
		end

		local soliderCount = #self._slotSoldierList

		if soliderCount > 0 then
			local solider = self._slotSoldierList[soliderCount]

			if solider and solider:getCamp() ~= soldierMo:getCamp() and not solider:isDead() and not soldierMo:isDead() then
				local soliderMoHp = soldierMo:getHp()
				local soliderHp = solider:getHp()

				soldierMo:updateHp(-soliderHp, false)
				solider:updateHp(-soliderMoHp, false)

				return true, solider
			end
		end
	elseif soldierMo:isMoveEnd() or fastEnter then
		self:_updateSoliderList(soldierMo, true)
		self:_checkSoliderEnterPassive(soldierMo)

		return false
	end

	return true
end

function MaLiAnNaGameSlotMo:_clearCampIndex()
	if self._soliderCampIndex == nil then
		return
	end

	for _, v in pairs(self._soliderCampIndex) do
		tabletool.clear(v)
	end
end

function MaLiAnNaGameSlotMo:_updateSoliderList(soliderMo)
	if soliderMo == nil or soliderMo:isDead() then
		return
	end

	if not soliderMo:isDead() then
		soliderMo:changeState(Activity201MaLiAnNaEnum.SoliderState.InSlot)
		table.insert(self._slotSoldierList, soliderMo)
	end

	self:_updateCurCamp()
end

function MaLiAnNaGameSlotMo:soliderDead(soliderMo)
	if self._slotSoldierList == nil or #self._slotSoldierList <= 0 or soliderMo == nil then
		return false
	end

	local needUpdate = false

	for i = 1, #self._slotSoldierList do
		if soliderMo:getId() == self._slotSoldierList[i]:getId() then
			table.remove(self._slotSoldierList, i)

			needUpdate = true

			break
		end
	end

	if needUpdate then
		self:_updateCurCamp()
	end

	return needUpdate
end

function MaLiAnNaGameSlotMo:_updateCurCamp()
	self:_sortSoliderList()

	if #self._slotSoldierList > 0 then
		self:updateSlotCamp(self._slotSoldierList[1]:getCamp())
	else
		self:updateSlotCamp(Activity201MaLiAnNaEnum.CampType.Middle)
	end
end

function MaLiAnNaGameSlotMo:setDispatchSoldierInfo(dispatchId, disPatchPath, isHeroFirst)
	self._dispatchId = dispatchId
	self._disPatchHeroFirst = isHeroFirst

	if not self:isSame(disPatchPath) then
		self._dispatchValue = 0
	end

	local dispatchConstValue = Activity201MaLiAnNaConfig.instance:getConstValueNumber(2)

	self._dispatchValue = dispatchConstValue + self._dispatchValue

	if self._dispatchPath then
		tabletool.clear(self._dispatchPath)
	end

	if disPatchPath then
		tabletool.addValues(self._dispatchPath, disPatchPath)
	end
end

function MaLiAnNaGameSlotMo:clearDisPatchInfo()
	self._dispatchValue = 0
	self._dispatchId = nil
	self._disPatchHeroFirst = false

	if self._dispatchPath ~= nil then
		tabletool.clear(self._dispatchPath)
	end
end

function MaLiAnNaGameSlotMo:isSame(disPatchPath)
	if disPatchPath == nil or self._dispatchPath == nil then
		return false
	end

	if #disPatchPath ~= #self._dispatchPath then
		return false
	end

	for i = 1, #disPatchPath do
		if disPatchPath[i] ~= self._dispatchPath[i] then
			return false
		end
	end

	return true
end

function MaLiAnNaGameSlotMo:_dispatchSoldier(deltaTime)
	self._dispatchTime = self._dispatchTime + deltaTime * 1000

	if self._dispatchTime < self._dispatchInterval then
		return
	end

	self._dispatchTime = 0

	if self._dispatchId == nil then
		return
	end

	if not self:canDispatch() then
		return
	end

	if self._dispatchValue == 0 and self._dispatchId ~= nil then
		self:clearDisPatchInfo()

		return
	end

	local solider = self:getDisPatchSolider()

	if solider then
		solider:setMovePointPath(self._dispatchPath)
		solider:setDispatchGroupId(self._dispatchId)
		Activity201MaLiAnNaGameController.instance:dispatchSolider(solider)
		solider:changeState(Activity201MaLiAnNaEnum.SoliderState.Moving)

		self._dispatchValue = self._dispatchValue - 1
	end
end

function MaLiAnNaGameSlotMo:getDisPatchList()
	local dispatchConstValue = Activity201MaLiAnNaConfig.instance:getConstValueNumber(2)
	local count = #self._slotSoldierList
	local disPatchValue = math.min(dispatchConstValue, count - 1)
	local list = {}

	if not self._disPatchHeroFirst then
		for i = 1, disPatchValue do
			local index = count - i + 1

			if index > 1 then
				local nextIndex = index - 1
				local isHero = self._slotSoldierList[nextIndex]:isHero()

				if isHero then
					index = nextIndex
				end
			end

			table.insert(list, index)
		end
	else
		for i = 1, disPatchValue do
			table.insert(list, i)
		end
	end

	return list
end

function MaLiAnNaGameSlotMo:getDisPatchSolider()
	local removeIndex = self._disPatchHeroFirst and 1 or #self._slotSoldierList

	if not self._disPatchHeroFirst and removeIndex > 1 then
		local nextIndex = removeIndex - 1
		local isHero = self._slotSoldierList[nextIndex]:isHero()

		if isHero then
			removeIndex = nextIndex
		end
	end

	return table.remove(self._slotSoldierList, removeIndex)
end

function MaLiAnNaGameSlotMo:isInCanSelectRange(x, y)
	local dragSureRange, _, _, _ = self:getSlotConstValue()

	return MathUtil.isPointInCircleRange(self.posX, self.posY, dragSureRange, x, y)
end

function MaLiAnNaGameSlotMo:getSlotConstValue()
	return Activity201MaLiAnNaConfig.instance:getSlotConstValue(self.configId)
end

function MaLiAnNaGameSlotMo:canDispatch()
	local count = tabletool.len(self._slotSoldierList)

	return count > 1 and self._skillGenerateSoliderEffectTime <= 0
end

function MaLiAnNaGameSlotMo:getSlotCamp()
	return self._slotCamp
end

function MaLiAnNaGameSlotMo:campIsSameInit()
	return self._slotCamp == self._config.initialCamp
end

function MaLiAnNaGameSlotMo:isInDispatch()
	return self._dispatchId ~= nil
end

function MaLiAnNaGameSlotMo:updateSlotCamp(camp)
	if self._slotCamp == nil or self._slotCamp ~= camp then
		self._slotCamp = camp

		Activity201MaLiAnNaGameController.instance:dispatchEvent(Activity201MaLiAnNaEvent.SlotChangeCamp, self.configId, camp)
		self:clearDisPatchInfo()

		self._skillGenerateSoliderEffectTime = 0
	end
end

function MaLiAnNaGameSlotMo:_sortSoliderList()
	if self._slotSoldierList == nil then
		return
	end

	table.sort(self._slotSoldierList, function(a, b)
		if a:isHero() and not b:isHero() then
			return true
		elseif not a:isHero() and b:isHero() then
			return false
		end

		return a:getId() < b:getId()
	end)
end

function MaLiAnNaGameSlotMo:getAndRemoveNormalSolider()
	local solider = table.remove(self._slotSoldierList, #self._slotSoldierList)

	self:_updateCurCamp()

	return solider
end

function MaLiAnNaGameSlotMo:getSoliderCount()
	local normalSoliderCount = 0
	local allCount = 0

	for _, solider in ipairs(self._slotSoldierList) do
		if not solider:isHero() then
			normalSoliderCount = normalSoliderCount + 1
		end

		allCount = allCount + 1
	end

	return normalSoliderCount, allCount - normalSoliderCount, allCount
end

function MaLiAnNaGameSlotMo:getHeroSoliderList()
	if self._heroList == nil then
		self._heroList = {}
	end

	tabletool.clear(self._heroList)

	for _, solider in ipairs(self._slotSoldierList) do
		if solider:isHero() then
			self._heroList[#self._heroList + 1] = solider
		end
	end

	return self._heroList
end

function MaLiAnNaGameSlotMo:getNormalSolider()
	if self._slotSoldierList == nil then
		return
	end

	for _, solider in ipairs(self._slotSoldierList) do
		if not solider:isHero() then
			return solider
		end
	end

	return nil
end

function MaLiAnNaGameSlotMo:getId()
	return self.id
end

function MaLiAnNaGameSlotMo:getConfig()
	return self._config
end

function MaLiAnNaGameSlotMo:getBasePosXY()
	return self.basePosX, self.basePosY
end

function MaLiAnNaGameSlotMo:getSoliderPercent()
	local normalCount, _, _ = self:getSoliderCount()

	return normalCount / self._soliderLimit * 1000
end

function MaLiAnNaGameSlotMo:getDistanceTo(slotB)
	if slotB == nil then
		return 0
	end

	return MathUtil.vec2_lengthSqr(self.posX, self.posY, slotB.posX, slotB.posY)
end

function MaLiAnNaGameSlotMo:canAI()
	return self._slotCamp == Activity201MaLiAnNaEnum.CampType.Enemy
end

function MaLiAnNaGameSlotMo:setSkillGenerateSoliderEffectTime(time)
	self._skillGenerateSoliderEffectTime = time
end

function MaLiAnNaGameSlotMo:skillToCreateSolider(num, camp)
	if num == nil or camp == nil then
		return
	end

	for i = 1, num do
		self:createSolider(camp)
	end
end

function MaLiAnNaGameSlotMo:skillToRemoveSolider(num, camp)
	if num == nil or camp == nil then
		return
	end

	local normalSoliderCount = self:getSoliderCount()
	local count = math.min(normalSoliderCount, num)

	for i = #self._slotSoldierList, 1, -1 do
		if count == 0 then
			return
		end

		local solider = self._slotSoldierList[i]

		if solider and not solider:isHero() and solider:getCamp() == camp then
			solider:updateHp(-1, true)

			count = count - 1
		end
	end
end

function MaLiAnNaGameSlotMo:_checkSoliderEnterPassive(soliderMo)
	if soliderMo == nil then
		return
	end

	local camp, num = soliderMo:getEnterSlotSkillValue()

	if camp == nil then
		return
	end

	if num ~= nil then
		if num > 0 then
			self:skillToCreateSolider(num, camp)

			if isDebugBuild then
				logNormal("技能增加据点英雄：" .. self:getConfig().baseId .. " 数量：" .. num .. " 阵营: " .. camp)
			end
		else
			self:skillToRemoveSolider(num, camp)

			if isDebugBuild then
				logNormal("技能减少据点英雄：" .. self:getConfig().baseId .. " 数量：" .. num .. " 阵营: " .. camp)
			end
		end
	end
end

function MaLiAnNaGameSlotMo:_getSlotSoliderSpeedPercent()
	local percent = 0

	for _, solider in ipairs(self._slotSoldierList) do
		percent = percent + solider:getSkillSpeedUp()
	end

	percent = math.max(0, percent)

	return percent
end

function MaLiAnNaGameSlotMo:initPassiveSkill()
	if self._skill ~= nil then
		return
	end

	self._skill = MaLiAnNaSkillUtils.createSkillBySlotType(self._config.type)

	if self._slotType == Activity201MaLiAnNaEnum.SlotType.bunker then
		self._skill:setParams(self.posX, self.posY, self._slotCamp)
	end
end

function MaLiAnNaGameSlotMo:skillUpdate(deltaTime)
	if self._skill == nil then
		return
	end

	self._skill:update(deltaTime)
end

function MaLiAnNaGameSlotMo:getSkill()
	return self._skill
end

function MaLiAnNaGameSlotMo:destroy()
	self._skill = nil
	self._config = nil

	for _, solider in pairs(self._slotSoldierList) do
		if solider then
			solider:clear()
		end
	end

	self._slotSoldierList = nil
end

function MaLiAnNaGameSlotMo:dumpInfo()
	local info = ""

	info = info .. self.id .. "------------------------\n"
	info = info .. "据点阵营:" .. tostring(self._slotCamp) .. "\n"
	info = info .. "士兵数量:" .. tostring(#self._slotSoldierList) .. "\n"
	info = info .. "士兵列表:\n"

	local allId = ""

	for i = 1, #self._slotSoldierList do
		local solider = self._slotSoldierList[i]

		allId = allId .. tostring(solider:getId()) .. ", "
	end

	info = info .. "士兵ID:" .. allId .. "\n"

	logNormal("MaLiAnNaGameSlotMo->:", info)
end

return MaLiAnNaGameSlotMo
