-- chunkname: @modules/logic/guide/controller/action/impl/GuideActionDispatchFightEvent.lua

module("modules.logic.guide.controller.action.impl.GuideActionDispatchFightEvent", package.seeall)

local GuideActionDispatchFightEvent = class("GuideActionDispatchFightEvent", BaseGuideAction)

function GuideActionDispatchFightEvent:ctor(guideId, stepId, actionParam)
	GuideActionDispatchFightEvent.super.ctor(self, guideId, stepId, actionParam)

	local sp = string.split(actionParam, "#")
	local evtStr = sp[1]

	self._evtId = FightEvent[evtStr]
	self._evtParamList = nil

	for i = 2, #sp, 2 do
		local value = sp[i]
		local type = sp[i + 1]

		value = string.getValueByType(value, type) or value
		self._evtParamList = self._evtParamList or {}

		table.insert(self._evtParamList, value)
	end
end

function GuideActionDispatchFightEvent:onStart(context)
	GuideActionDispatchFightEvent.super.onStart(self, context)

	if self._evtParamList then
		FightController.instance:dispatchEvent(self._evtId, unpack(self._evtParamList))
	else
		FightController.instance:dispatchEvent(self._evtId)
	end

	self:onDone(true)
end

return GuideActionDispatchFightEvent
