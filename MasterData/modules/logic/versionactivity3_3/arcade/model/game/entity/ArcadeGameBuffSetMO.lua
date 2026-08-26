-- chunkname: @modules/logic/versionactivity3_3/arcade/model/game/entity/ArcadeGameBuffSetMO.lua

module("modules.logic.versionactivity3_3.arcade.model.game.entity.ArcadeGameBuffSetMO", package.seeall)

local ArcadeGameBuffSetMO = class("ArcadeGameBuffSetMO")

function ArcadeGameBuffSetMO:ctor(unitMO)
	self.unitMO = unitMO
	self._buffDict = {}
	self._buffList = {}
	self._effectNameDict = {}
	self._effectNameWithParamDict = {}
end

function ArcadeGameBuffSetMO:getBuffList()
	return self._buffList
end

function ArcadeGameBuffSetMO:getBuffDictByEffectParam(effectName, param)
	if string.nilorempty(effectName) then
		return
	end

	if string.nilorempty(param) then
		if self._effectNameDict then
			local dict = self._effectNameDict[effectName]

			if not dict and self._effectNameWithParamDict and self._effectNameWithParamDict[effectName] then
				dict = {}

				for _, param2BuffDict in pairs(self._effectNameWithParamDict[effectName]) do
					for buffId, buff in pairs(param2BuffDict) do
						dict[buffId] = buff
					end
				end
			end

			return dict
		end
	elseif self._effectNameWithParamDict then
		local dict = self._effectNameWithParamDict[effectName]

		return dict and dict[param]
	end
end

function ArcadeGameBuffSetMO:hasEffectParamBuff(effectName, param)
	local buffDict = self:getBuffDictByEffectParam(effectName, param)

	if buffDict then
		return next(buffDict)
	end
end

function ArcadeGameBuffSetMO:getBuffById(buffId)
	return self._buffDict[buffId]
end

function ArcadeGameBuffSetMO:checkBuffsReduceInRoundBegin()
	local removeBuffList = {}

	for _, buff in ipairs(self._buffList) do
		local buffId = buff:getId()
		local notSubInRoundBegin = ArcadeConfig.instance:getArcadeBuffIsNotSubInRoundBegin(buffId)

		if not notSubInRoundBegin then
			buff:subLiveRound()

			local remainRound = buff:getRemainLiveRound()

			if remainRound <= 0 then
				removeBuffList[#removeBuffList + 1] = buffId
			end
		end
	end

	return removeBuffList
end

function ArcadeGameBuffSetMO:reduceBuffRoundByEffectParam(effectName, param)
	local removeBuffList = {}
	local buffDict = self:getBuffDictByEffectParam(effectName, param)

	if buffDict then
		for _, buff in pairs(buffDict) do
			buff:subLiveRound()

			local remainRound = buff:getRemainLiveRound()

			if remainRound <= 0 then
				removeBuffList[#removeBuffList + 1] = buff:getId()
			end
		end
	end

	return removeBuffList
end

function ArcadeGameBuffSetMO:reduceBuffRound(buffId)
	local isCanRemove = false
	local buff = self:getBuffById(buffId)

	if buff then
		buff:subLiveRound()

		local remainRound = buff:getRemainLiveRound()

		if remainRound <= 0 then
			isCanRemove = true
		end
	end

	return isCanRemove
end

local function _sortBuffList(aBuff, bBuff)
	local aBuffId = aBuff:getId()
	local bBuffId = bBuff:getId()
	local aShowPriority = ArcadeConfig.instance:getArcadeBuffShowPriority(aBuffId)
	local bShowPriority = ArcadeConfig.instance:getArcadeBuffShowPriority(bBuffId)

	if aShowPriority ~= bShowPriority then
		return aShowPriority < bShowPriority
	end

	return aBuffId < bBuffId
end

function ArcadeGameBuffSetMO:addBuffById(buffId)
	if self._buffDict[buffId] then
		self._buffDict[buffId]:resetLiveRound()
	else
		local buff = ArcadeGameBuffMO.New(buffId, self.unitMO)

		self._buffDict[buffId] = buff

		local effectNameList = ArcadeConfig.instance:getArcadeBuffEffectNameList(buffId)
		local effectParamList = ArcadeConfig.instance:getArcadeBuffEffectParamList(buffId)

		if effectNameList and #effectNameList > 0 then
			for i, effectName in ipairs(effectNameList) do
				local buffDict
				local param = effectParamList[i]

				if not string.nilorempty(param) then
					local effectNameDict = ArcadeGameHelper.checkDictTable(self._effectNameWithParamDict, effectName)

					buffDict = ArcadeGameHelper.checkDictTable(effectNameDict, param)
				else
					buffDict = ArcadeGameHelper.checkDictTable(self._effectNameDict, effectName)
				end

				if buffDict then
					buff:addEffectNameParam(effectName, param)

					buffDict[buffId] = buff
				end
			end
		end

		table.insert(self._buffList, buff)
		table.sort(self._buffList, _sortBuffList)

		local skillList = ArcadeConfig.instance:getArcadeBuffPassiveSkillList(buffId)
		local skillSetMO = self.unitMO:getSkillSetMO()

		for _, skillId in ipairs(skillList) do
			skillSetMO:addSkillById(skillId)
		end
	end
end

function ArcadeGameBuffSetMO:removeBuffById(buffId)
	if self._buffDict[buffId] then
		local buff = self._buffDict[buffId]

		self._buffDict[buffId] = nil

		local effectNameList = ArcadeConfig.instance:getArcadeBuffEffectNameList(buffId)
		local effectParamList = ArcadeConfig.instance:getArcadeBuffEffectParamList(buffId)

		if effectNameList and #effectNameList > 0 then
			for i, effectName in ipairs(effectNameList) do
				local param = effectParamList[i]

				if string.nilorempty(param) then
					if self._effectNameDict[effectName] then
						self._effectNameDict[effectName][buffId] = nil
					end
				elseif self._effectNameWithParamDict[effectName] and self._effectNameWithParamDict[effectName][param] then
					self._effectNameWithParamDict[effectName][param][buffId] = nil
				end
			end
		end

		tabletool.removeValue(self._buffList, buff)

		local skillSetMO = self.unitMO:getSkillSetMO()
		local skillList = ArcadeConfig.instance:getArcadeBuffPassiveSkillList(buffId)

		for _, skillId in ipairs(skillList) do
			skillSetMO:removeSkillById(skillId)
		end
	end
end

function ArcadeGameBuffSetMO:reset()
	local skillSetMO = self.unitMO:getSkillSetMO()

	if skillSetMO then
		for _, buff in ipairs(self._buffList) do
			local buffId = buff:getId()
			local skillList = ArcadeConfig.instance:getArcadeBuffPassiveSkillList(buffId)

			for _, skillId in ipairs(skillList) do
				skillSetMO:removeSkillById(skillId)
			end
		end
	end

	self._buffDict = {}
	self._buffList = {}
	self._effectNameDict = {}
	self._effectNameWithParamDict = {}
end

return ArcadeGameBuffSetMO
