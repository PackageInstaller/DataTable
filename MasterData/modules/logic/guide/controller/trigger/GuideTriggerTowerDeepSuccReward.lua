-- chunkname: @modules/logic/guide/controller/trigger/GuideTriggerTowerDeepSuccReward.lua

module("modules.logic.guide.controller.trigger.GuideTriggerTowerDeepSuccReward", package.seeall)

local GuideTriggerTowerDeepSuccReward = class("GuideTriggerTowerDeepSuccReward", BaseGuideTrigger)

function GuideTriggerTowerDeepSuccReward:ctor(triggerKey)
	GuideTriggerTowerDeepSuccReward.super.ctor(self, triggerKey)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, self._onOpenView, self)
end

function GuideTriggerTowerDeepSuccReward:assertGuideSatisfy(param, configParam)
	if param == configParam then
		local succDeepTaskMo = TowerDeepTaskModel.instance:getSuccRewardTaskMo()

		if succDeepTaskMo then
			return TowerDeepTaskModel.instance:isTaskCanGet(succDeepTaskMo)
		end
	end

	return false
end

function GuideTriggerTowerDeepSuccReward:_onOpenView(viewName, viewParam)
	self:checkStartGuide(viewName)
end

return GuideTriggerTowerDeepSuccReward
