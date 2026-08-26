-- chunkname: @modules/logic/guide/controller/action/impl/WaitGuideActionEnterPassedEpisode.lua

module("modules.logic.guide.controller.action.impl.WaitGuideActionEnterPassedEpisode", package.seeall)

local WaitGuideActionEnterPassedEpisode = class("WaitGuideActionEnterPassedEpisode", BaseGuideAction)

function WaitGuideActionEnterPassedEpisode:onStart(context)
	WaitGuideActionEnterPassedEpisode.super.onStart(self, context)
	FightController.instance:registerCallback(FightEvent.OnStartSequenceFinish, self._onRoundStart, self)
end

function WaitGuideActionEnterPassedEpisode:_onRoundStart()
	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.DistributeCard) or FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Operate then
		local fightParam = FightModel.instance:getFightParam()

		if not DungeonModel.instance:hasPassLevel(fightParam.episodeId) then
			return
		end

		local doingGuideId = GuideModel.instance:getDoingGuideId()

		if doingGuideId then
			return
		end

		if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightDoingSubEntity) then
			return
		end

		if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightLeadRoleSkillGuide) then
			return
		end

		self:onDone(true)
	end
end

function WaitGuideActionEnterPassedEpisode:clearWork()
	FightController.instance:unregisterCallback(FightEvent.OnStartSequenceFinish, self._onRoundStart, self)
end

return WaitGuideActionEnterPassedEpisode
