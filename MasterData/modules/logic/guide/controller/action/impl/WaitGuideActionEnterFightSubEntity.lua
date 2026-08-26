-- chunkname: @modules/logic/guide/controller/action/impl/WaitGuideActionEnterFightSubEntity.lua

module("modules.logic.guide.controller.action.impl.WaitGuideActionEnterFightSubEntity", package.seeall)

local WaitGuideActionEnterFightSubEntity = class("WaitGuideActionEnterFightSubEntity", BaseGuideAction)

function WaitGuideActionEnterFightSubEntity:onStart(context)
	WaitGuideActionEnterFightSubEntity.super.onStart(self, context)
	FightController.instance:registerCallback(FightEvent.OnStartSequenceFinish, self._onRoundStart, self, LuaEventSystem.High)
end

function WaitGuideActionEnterFightSubEntity:_onRoundStart()
	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.DistributeCard) or FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Operate then
		local mySideList = FightDataHelper.entityMgr:getMyNormalList()

		if not mySideList or #mySideList < 3 then
			return
		end

		local mySideSub = FightDataHelper.entityMgr:getMySubList()

		if not mySideSub or #mySideSub == 0 then
			return
		end

		local doingGuideId = GuideModel.instance:getDoingGuideId()

		if doingGuideId then
			return
		end

		if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightDoingEnterPassedEpisode) then
			return
		end

		if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightLeadRoleSkillGuide) then
			return
		end

		self:clearWork()
		self:onDone(true)
	end
end

function WaitGuideActionEnterFightSubEntity:clearWork()
	FightController.instance:unregisterCallback(FightEvent.OnStartSequenceFinish, self._onRoundStart, self)
end

return WaitGuideActionEnterFightSubEntity
