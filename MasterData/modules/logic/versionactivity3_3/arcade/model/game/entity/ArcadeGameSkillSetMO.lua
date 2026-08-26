-- chunkname: @modules/logic/versionactivity3_3/arcade/model/game/entity/ArcadeGameSkillSetMO.lua

module("modules.logic.versionactivity3_3.arcade.model.game.entity.ArcadeGameSkillSetMO", package.seeall)

local ArcadeGameSkillSetMO = class("ArcadeGameSkillSetMO")

function ArcadeGameSkillSetMO:ctor(id, unitMO)
	self.id = id or 0
	self.unitMO = unitMO
	self._skillDict = {}
	self._skillList = {}
	self._skillCounterDict = {}
	self._opIndex = 0
end

function ArcadeGameSkillSetMO:addSkillById(skillId)
	local isPassiveSkill = ArcadeGameHelper.getIsPassiveSkill(skillId)

	if not isPassiveSkill then
		return
	end

	local skill = self._skillDict[skillId]

	if not skill then
		skill = self:_getNewSkill(skillId)
	elseif skill:getIsActive() then
		return
	end

	skill:setIsActive(true)
	table.insert(self._skillList, skill)
	table.sort(self._skillList, ArcadeGameHelper.sortSkillList)

	self._opIndex = self._opIndex + 1

	local counter2ParamsDict = skill:getSkillNeedCounter2ParamsDict()

	for counterName, counterParamList in pairs(counter2ParamsDict) do
		self:_beginSkillCounter(skillId, counterName, counterParamList)
	end
end

function ArcadeGameSkillSetMO:_getNewSkill(skillId)
	local skill = ArcadeSkillFactory.instance:createSkillById(skillId)
	local entityType, uid

	if self.unitMO and self.unitMO.getIsCollection then
		local isCollection = self.unitMO:getIsCollection()

		if isCollection then
			entityType = ArcadeGameEnum.EntityType.Character

			skill:setSpecBelongSkillSetMO(self)
		else
			entityType = self.unitMO:getEntityType()
			uid = self.unitMO:getUid()
		end
	end

	skill:setOwner(entityType, uid)

	self._skillDict[skillId] = skill

	return skill
end

function ArcadeGameSkillSetMO:removeSkillById(skillId)
	local isPassiveSkill = ArcadeGameHelper.getIsPassiveSkill(skillId)

	if not isPassiveSkill then
		return
	end

	local skill = self._skillDict[skillId]

	if skill then
		skill:setIsActive(false)
		tabletool.removeValue(self._skillList, skill)

		self._skillDict[skillId] = nil
		self._isRemoveOp = true
		self._opIndex = self._opIndex + 1
	end

	if self._skillCounterDict then
		self._skillCounterDict[skillId] = nil
	end
end

function ArcadeGameSkillSetMO:getOwner()
	return self.unitMO
end

function ArcadeGameSkillSetMO:getSkillList()
	if self._isRemoveOp then
		self._isRemoveOp = false

		for i = #self._skillList, 1, -1 do
			local skill = self._skillList[i]
			local isActive = skill:getIsActive()

			if not isActive then
				table.remove(self._skillList, i)
			end
		end
	end

	return self._skillList
end

function ArcadeGameSkillSetMO:getSkillIdList()
	local result = {}

	for skillId, skill in pairs(self._skillDict) do
		local isActive = skill and skill:getIsActive()

		if isActive then
			result[#result + 1] = skillId
		end
	end

	return result
end

function ArcadeGameSkillSetMO:getSkillById(skillId)
	return self._skillDict[skillId]
end

function ArcadeGameSkillSetMO:getOpIdx()
	return self._opIndex
end

function ArcadeGameSkillSetMO:getSkillCounterDict()
	return self._skillCounterDict
end

function ArcadeGameSkillSetMO:getSkillCounter(skillId, counterName)
	local skill = self:getSkillById(skillId)

	if not skill then
		return
	end

	local result

	return (self._skillCounterDict[skillId] or nil) and self._skillCounterDict[skillId][counterName]
end

function ArcadeGameSkillSetMO:getSkillCounterRecord(skillId, counterName, counterParam)
	local counter = self:getSkillCounter(skillId, counterName)

	return (counter or nil) and counter:getRecord(counterParam)
end

function ArcadeGameSkillSetMO:getNeedSaveSkillCounterBox()
	if not self._skillCounterDict then
		return
	end

	local result = {}

	for skillId, counterDict in pairs(self._skillCounterDict) do
		local counters = {}

		for counterName, counter in pairs(counterDict) do
			if ArcadeGameEnum.NeedSaveGameCounter[counterName] then
				local boxList = counter:getSaveCounterBoxList()

				for _, box in ipairs(boxList) do
					counters[#counters + 1] = {
						key = box.key,
						count = box.count
					}
				end
			end
		end

		if #counters > 0 then
			result[#result + 1] = {
				skillId = skillId,
				counters = counters
			}
		end
	end

	return result
end

function ArcadeGameSkillSetMO:_beginSkillCounter(skillId, counterName, counterParamList)
	local skill = self:getSkillById(skillId)

	if not skill or not self._skillCounterDict then
		return
	end

	local counterDict = GameUtil.tabletool_checkDictTable(self._skillCounterDict, skillId)

	if not ArcadeGameEnum.GameCounterCls[counterName] then
		counterDict[counterName] = ArcadeGameEnum.GameCounterCls[counterName].New(counterName, counterParamList)
	end
end

function ArcadeGameSkillSetMO:triggerSkillCounterRecord(counterName, counterParam, count)
	if not self._skillCounterDict or not self._skillList then
		return
	end

	for skillId, _ in pairs(self._skillDict) do
		local counter = self:getSkillCounter(skillId, counterName)

		if counter then
			counter:triggerRecord(counterParam, count)
		end
	end
end

function ArcadeGameSkillSetMO:setSkillCounterBox(skillCounterBox)
	if not self._skillCounterDict or not skillCounterBox then
		return
	end

	for _, box in ipairs(skillCounterBox) do
		local counter2ParamsDict = {}
		local counter2ParamsRecordDict = {}

		if box.counters then
			for _, counter in ipairs(box.counters) do
				local key = counter.key
				local count = counter.count
				local keyArr = string.split(key, "#")
				local counterName = keyArr[1]
				local counterParam = keyArr[2]
				local counterParamList = GameUtil.tabletool_checkDictTable(counter2ParamsDict, counterName)
				local paramRecordDict = GameUtil.tabletool_checkDictTable(counter2ParamsRecordDict, counterName)

				if not string.nilorempty(counterParam) then
					counterParamList[#counterParamList + 1] = counterParam
					paramRecordDict[counterParam] = count
				end
			end
		end

		for counterName, counterParamList in pairs(counter2ParamsDict) do
			self:_beginSkillCounter(box.skillId, counterName, counterParamList)
		end

		for counterName, paramRecordDict in pairs(counter2ParamsRecordDict) do
			for param, record in pairs(paramRecordDict) do
				self:triggerSkillCounterRecord(counterName, param, record)
			end
		end
	end
end

function ArcadeGameSkillSetMO:clearSkillCounterRecordOnExitRoom()
	if not self._skillCounterDict then
		return
	end

	for _, counterDict in pairs(self._skillCounterDict) do
		for counterName, counter in pairs(counterDict) do
			if not ArcadeGameEnum.NeedSaveGameCounter[counterName] then
				counter:clearRecord()
			end
		end
	end
end

function ArcadeGameSkillSetMO:reset()
	self._isRemoveOp = false
	self._skillDict = {}
	self._skillList = {}
	self._skillCounterDict = {}
	self._opIndex = 0
end

return ArcadeGameSkillSetMO
