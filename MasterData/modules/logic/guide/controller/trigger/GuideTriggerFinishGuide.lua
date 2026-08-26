-- chunkname: @modules/logic/guide/controller/trigger/GuideTriggerFinishGuide.lua

module("modules.logic.guide.controller.trigger.GuideTriggerFinishGuide", package.seeall)

local GuideTriggerFinishGuide = class("GuideTriggerFinishGuide", BaseGuideTrigger)

function GuideTriggerFinishGuide:ctor(triggerKey)
	GuideTriggerFinishGuide.super.ctor(self, triggerKey)
	GuideController.instance:registerCallback(GuideEvent.FinishGuideLastStep, self._checkStartGuide, self)
	GameSceneMgr.instance:registerCallback(SceneType.Main, self._onMainScene, self)
end

function GuideTriggerFinishGuide:assertGuideSatisfy(param, configParam)
	local guideId = tonumber(configParam)

	return (GuideModel.instance:isGuideFinish(guideId))
end

function GuideTriggerFinishGuide:_onMainScene(sceneLevelId, Exit0Enter1)
	if Exit0Enter1 == 1 then
		self:checkStartGuide()
	end
end

function GuideTriggerFinishGuide:_checkStartGuide()
	self:checkStartGuide()
end

return GuideTriggerFinishGuide
