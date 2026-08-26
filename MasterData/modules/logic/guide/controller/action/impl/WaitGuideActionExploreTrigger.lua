-- chunkname: @modules/logic/guide/controller/action/impl/WaitGuideActionExploreTrigger.lua

module("modules.logic.guide.controller.action.impl.WaitGuideActionExploreTrigger", package.seeall)

local WaitGuideActionExploreTrigger = class("WaitGuideActionExploreTrigger", BaseGuideAction)

function WaitGuideActionExploreTrigger:onStart(context)
	ExploreController.instance:registerCallback(ExploreEvent.ExploreTriggerGuide, self._onTriggerGuide, self)
end

function WaitGuideActionExploreTrigger:_onTriggerGuide(guideId)
	if self.guideId == guideId then
		ExploreController.instance:unregisterCallback(ExploreEvent.ExploreTriggerGuide, self._onTriggerGuide, self)
		self:onDone(true)
	end
end

function WaitGuideActionExploreTrigger:clearWork()
	ExploreController.instance:unregisterCallback(ExploreEvent.ExploreTriggerGuide, self._onTriggerGuide, self)
end

return WaitGuideActionExploreTrigger
