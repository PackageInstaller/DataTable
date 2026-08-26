-- chunkname: @modules/logic/versionactivity3_4/bbs/model/V3a4BBSPostStepMO.lua

module("modules.logic.versionactivity3_4.bbs.model.V3a4BBSPostStepMO", package.seeall)

local V3a4BBSPostStepMO = class("V3a4BBSPostStepMO")

function V3a4BBSPostStepMO:ctor(co)
	self.co = co
	self._triggerList = GameUtil.splitString2(co.trigger, false, ",", "#")
	self._triggerIndex = 0

	if not string.nilorempty(co.citeStep) then
		self._quoteInfos = string.splitToNumber(co.citeStep, "#")
	end
end

function V3a4BBSPostStepMO:getQuoteInfo()
	return self._quoteInfos
end

function V3a4BBSPostStepMO:getTriggerOpeation()
	if self._triggerList and self._triggerList[self._triggerIndex] then
		return self._triggerList[self._triggerIndex]
	end
end

function V3a4BBSPostStepMO:getNextTriggerOpeation()
	if self._triggerList and self._triggerList[self._triggerIndex + 1] then
		return self._triggerList[self._triggerIndex + 1]
	end
end

function V3a4BBSPostStepMO:isEmptyTrigger()
	return string.nilorempty(self.co.trigger)
end

function V3a4BBSPostStepMO:getTriggerIndex()
	return self._triggerIndex
end

function V3a4BBSPostStepMO:setTriggerIndex(index)
	self._triggerIndex = index
end

function V3a4BBSPostStepMO:finishTrigger()
	self._triggerIndex = self._triggerIndex + 1
end

function V3a4BBSPostStepMO:isSent()
	for i = 1, self._triggerIndex do
		local opeation = self._triggerList[i]

		if opeation[2] == V3a4BBSEnum.TriggerType.send then
			return true
		end
	end
end

return V3a4BBSPostStepMO
