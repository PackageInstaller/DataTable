-- chunkname: @modules/logic/guide/controller/action/impl/GuideActionExitEpisode.lua

module("modules.logic.guide.controller.action.impl.GuideActionExitEpisode", package.seeall)

local GuideActionExitEpisode = class("GuideActionExitEpisode", BaseGuideAction)

function GuideActionExitEpisode:onStart(context)
	GuideActionExitEpisode.super.onStart(self, context)

	if GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
		FightSystem.instance:dispose()
		FightController.instance:exitFightScene()
	else
		logError("not in episode, guide_" .. self.guideId .. "_" .. self.stepId)
		self:onDone(true)
	end
end

return GuideActionExitEpisode
