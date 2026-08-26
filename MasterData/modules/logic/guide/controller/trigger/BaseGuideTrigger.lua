-- chunkname: @modules/logic/guide/controller/trigger/BaseGuideTrigger.lua

module("modules.logic.guide.controller.trigger.BaseGuideTrigger", package.seeall)

local BaseGuideTrigger = class("BaseGuideTrigger")

function BaseGuideTrigger:ctor(triggerKey)
	self._triggerKey = triggerKey
	self._guideIdList = nil
	self._canTrigger = false
end

function BaseGuideTrigger:onReset()
	self._canTrigger = false
end

function BaseGuideTrigger:setCanTrigger(canTrigger)
	self._canTrigger = canTrigger
end

function BaseGuideTrigger:assertGuideSatisfy(param, configParam)
	return false
end

function BaseGuideTrigger:getParam()
	return nil
end

function BaseGuideTrigger:hasSatisfyGuide()
	self:_classifyGuide()

	if self._guideIdList then
		if not #self._guideIdList then
			local count = 0

			for i = 1, count do
				local guideId = self._guideIdList[i]
				local guideMO = GuideModel.instance:getById(guideId)
				local guideCO = GuideConfig.instance:getGuideCO(guideId)

				if (guideMO == nil or guideMO.isFinish and guideCO.restart == 1) and not GuideInvalidController.instance:isInvalid(guideId) then
					local triggerParam = GuideConfig.instance:getTriggerParam(guideId)

					if guideCO.parallel ~= 1 and self:assertGuideSatisfy(self:getParam(), triggerParam) then
						return true
					end
				end
			end

			return false
		end
	end
end

function BaseGuideTrigger:checkStartGuide(param, toTriggerGuideId)
	if not self._canTrigger then
		return
	end

	if toTriggerGuideId then
		self:_checkStartOneGuide(param, toTriggerGuideId)
	else
		self:_classifyGuide()

		for i = 1, #self._guideIdList do
			local guideId = self._guideIdList[i]

			self:_checkStartOneGuide(param, guideId)
		end
	end
end

function BaseGuideTrigger:_checkStartOneGuide(param, guideId)
	local guideMO = GuideModel.instance:getById(guideId)
	local guideCO = GuideConfig.instance:getGuideCO(guideId)

	if guideMO == nil or guideMO.isFinish and guideCO.restart == 1 then
		local triggerParam = GuideConfig.instance:getTriggerParam(guideId)

		if not GuideInvalidController.instance:isInvalid(guideId) and self:assertGuideSatisfy(param, triggerParam) then
			if guideCO.parallel == 1 then
				GuideController.instance:startGudie(guideId)
			elseif GuideModel.instance:getDoingGuideId() == nil then
				GuideController.instance:toStartGudie(guideId)
			end
		end
	end
end

function BaseGuideTrigger:_classifyGuide()
	if self._guideIdList == nil then
		self._guideIdList = {}

		local list = GuideConfig.instance:getGuideList()

		for _, guideCO in ipairs(list) do
			local triggerType = GuideConfig.instance:getTriggerType(guideCO.id)

			if triggerType == self._triggerKey then
				table.insert(self._guideIdList, guideCO.id)
			end
		end
	end
end

return BaseGuideTrigger
