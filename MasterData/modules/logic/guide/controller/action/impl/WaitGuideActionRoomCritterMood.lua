-- chunkname: @modules/logic/guide/controller/action/impl/WaitGuideActionRoomCritterMood.lua

module("modules.logic.guide.controller.action.impl.WaitGuideActionRoomCritterMood", package.seeall)

local WaitGuideActionRoomCritterMood = class("WaitGuideActionRoomCritterMood", BaseGuideAction)

function WaitGuideActionRoomCritterMood:onStart(context)
	WaitGuideActionRoomCritterMood.super.onStart(self, context)
	CritterController.instance:registerCallback(CritterEvent.CritterInfoPushUpdate, self._onCritterInfoPushUpdate, self)

	self._moodValue = tonumber(self.actionParam)

	self:_check()
end

function WaitGuideActionRoomCritterMood:_check()
	local list = CritterModel.instance:getMoodCritters(self._moodValue)

	if #list > 0 then
		self:onDone(true)
	end
end

function WaitGuideActionRoomCritterMood:_onCritterInfoPushUpdate()
	self:_check()
end

function WaitGuideActionRoomCritterMood:clearWork()
	CritterController.instance:unregisterCallback(CritterEvent.CritterInfoPushUpdate, self._onCritterInfoPushUpdate, self)
end

return WaitGuideActionRoomCritterMood
