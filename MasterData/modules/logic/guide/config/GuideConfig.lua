-- chunkname: @modules/logic/guide/config/GuideConfig.lua

module("modules.logic.guide.config.GuideConfig", package.seeall)

local GuideConfig = class("GuideConfig", BaseConfig)

function GuideConfig:ctor()
	self._guideList = {}
	self._guide2StepList = {}
	self._stepId2AdditionStepMap = {}
	self._stepId2AdditionStepList = {}
	self._triggerTypeDict = {}
	self._triggerParamDict = {}
	self._invalidTypeListDict = {}
	self._invalidListDict = {}
end

function GuideConfig:reqConfigNames()
	return {
		"guide",
		"guide_step",
		"guide_mask",
		"guide_step_addition"
	}
end

function GuideConfig:onConfigLoaded(configName, configTable)
	if configName == "guide" then
		for _, guideCO in ipairs(configTable.configList) do
			if guideCO.isOnline == 1 then
				table.insert(self._guideList, guideCO)

				local temp = string.split(guideCO.trigger, "#")

				self._triggerTypeDict[guideCO.id] = temp[1]
				self._triggerParamDict[guideCO.id] = temp[2]
				temp = GameUtil.splitString2(guideCO.invalid, false, "|", "#")
				self._invalidTypeListDict[guideCO.id] = {}
				self._invalidListDict[guideCO.id] = {}

				if not string.nilorempty(guideCO.invalid) then
					for _, one in ipairs(temp) do
						table.insert(self._invalidTypeListDict[guideCO.id], one[1])
						table.insert(self._invalidListDict[guideCO.id], one)
					end
				end
			end
		end
	elseif configName == "guide_step" then
		for _, stepCO in ipairs(configTable.configList) do
			local stepList = self._guide2StepList[stepCO.id]

			if not stepList then
				stepList = {}
				self._guide2StepList[stepCO.id] = stepList
			end

			table.insert(stepList, stepCO)
		end
	elseif configName == "guide_step_addition" then
		self._stepId2AdditionStepMap = configTable.configDict

		for _, stepCO in ipairs(configTable.configList) do
			local stepList = self._stepId2AdditionStepList[stepCO.id]

			if not stepList then
				stepList = {}
				self._stepId2AdditionStepList[stepCO.id] = stepList
			end

			table.insert(stepList, stepCO)
		end
	end
end

function GuideConfig:getGuideList()
	return self._guideList
end

function GuideConfig:getGuideCO(guideId)
	return lua_guide.configDict[guideId]
end

function GuideConfig:getStepList(guideId)
	return self._guide2StepList[guideId]
end

function GuideConfig:getStepCO(guideId, stepId)
	local guideStepDict = lua_guide_step.configDict[guideId]

	if guideStepDict then
		return guideStepDict[stepId]
	else
		return self:getAddtionStepCfg(guideId, stepId)
	end
end

function GuideConfig:getAddtionStepCfg(guideId, stepId)
	local guideStepDict = self._stepId2AdditionStepMap[guideId]

	if guideStepDict then
		return guideStepDict[stepId]
	end
end

function GuideConfig:getHighestPriorityGuideId(guideIds)
	local highestGuideId, priority

	for i, guideId in ipairs(guideIds) do
		local guideConfig = self:getGuideCO(guideId)

		if guideConfig and (not highestGuideId or not priority or priority < guideConfig.priority) then
			highestGuideId = guideId
			priority = guideConfig.priority
		end
	end

	return highestGuideId or guideIds and guideIds[1]
end

function GuideConfig:getTriggerType(guideId)
	return self._triggerTypeDict[guideId]
end

function GuideConfig:getTriggerParam(guideId)
	return self._triggerParamDict[guideId]
end

function GuideConfig:getInvalidTypeList(guideId)
	return self._invalidTypeListDict[guideId]
end

function GuideConfig:getInvalidList(guideId)
	return self._invalidListDict[guideId]
end

function GuideConfig:getPrevStepId(guideId, stepId)
	local stepCOList = self:getStepList(guideId)

	if stepCOList[1].stepId == stepId then
		return 0
	end

	for i = 2, #stepCOList do
		if stepCOList[i].stepId == stepId then
			return stepCOList[i - 1].stepId
		end
	end

	return -1
end

function GuideConfig:getNextStepId(guideId, stepId)
	local stepCOList = self:getStepList(guideId) or self._stepId2AdditionStepList[guideId]

	if stepCOList then
		for i = 1, #stepCOList - 1 do
			if stepCOList[i].stepId == stepId then
				return stepCOList[i + 1].stepId
			end
		end
	end

	return -1
end

GuideConfig.instance = GuideConfig.New()

return GuideConfig
