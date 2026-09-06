-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/skypeak/controller/SkyPeakController.lua

module("logic.extensions.skypeak.controller.SkyPeakController", package.seeall)

local SkyPeakController = class("SkyPeakController", BaseController)

function SkyPeakController:onInit()
	self:onReset()
end

function SkyPeakController:onReset()
	self._fmtMoMapStage = {}
	self._fmtMoMapBoss = {}
end

function SkyPeakController:getInfo(activityId)
	SkyPeakAgent.instance:sendPM_SkyPeakGetInfoReq(activityId)
end

function SkyPeakController:handlePM_SkyPeakGetInfoRes(msg)
	SkyPeakModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_SkyPeakGetInfoRes)
end

function SkyPeakController:getStageInfo(activityId, stageId)
	SkyPeakAgent.instance:sendPM_SkyPeakGetStageInfoReq(activityId, stageId)
end

function SkyPeakController:handlePM_SkyPeakGetStageInfoRes(msg)
	SkyPeakModel.instance:onGetStageInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_SkyPeakGetStageInfoRes)
end

function SkyPeakController:challengeStage(activityId, stageId, form_pb)
	SkyPeakModel.instance:clearLastChallengeResult()
	BattleFacade.instance:registerResultHandler(GameUtil.handler(self._onBattleEndStage, self))
	SkyPeakAgent.instance:sendPM_SkyPeakChallengeStageReq(activityId, stageId, form_pb)
end

function SkyPeakController:handlePM_SkyPeakChallengeStageRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_SkyPeakChallengeStageRes)
end

function SkyPeakController:challengeBoss(activityId, bossId, form_pb)
	SkyPeakModel.instance:clearLastChallengeResult()
	BattleFacade.instance:registerResultHandler(GameUtil.handler(self._onBattleEndBoss, self))
	SkyPeakAgent.instance:sendPM_SkyPeakChallengeBossReq(activityId, bossId, form_pb)
end

function SkyPeakController:handlePM_SkyPeakChallengeBossRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_SkyPeakChallengeBossRes)
end

function SkyPeakController:sweep(activityId)
	SkyPeakAgent.instance:sendPM_SkyPeakSweepReq(activityId)
end

function SkyPeakController:handlePM_SkyPeakSweepRes(msg)
	SkyPeakModel.instance:onSweep(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_SkyPeakSweepRes)
end

function SkyPeakController:unlockBuffNode(activityId, nodeId)
	SkyPeakAgent.instance:sendPM_SkyPeakUnlockBuffNodeReq(activityId, nodeId)
end

function SkyPeakController:handlePM_SkyPeakUnlockBuffNodeRes(msg)
	SkyPeakModel.instance:onUnlockBuffNode(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_SkyPeakUnlockBuffNodeRes)
end

function SkyPeakController:resetBuff(activityId)
	SkyPeakAgent.instance:sendPM_SkyPeakResetBuffReq(activityId)
end

function SkyPeakController:handlePM_SkyPeakResetBuffRes(msg)
	SkyPeakModel.instance:onResetBuff(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_SkyPeakResetBuffRes)
end

function SkyPeakController:getRankInfo(activityId)
	SkyPeakAgent.instance:sendPM_SkyPeakGetRankInfoReq(activityId)
end

function SkyPeakController:handlePM_SkyPeakGetRankInfoRes(msg)
	SkyPeakModel.instance:onGetRankInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_SkyPeakGetRankInfoRes)
end

function SkyPeakController:notifyStageChallengeResult(msg)
	SkyPeakModel.instance:onNotifyStageChallengeResult(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_Notify_SkyPeakStageChallengeResultRes)
end

function SkyPeakController:notifyBossChallengeResult(msg)
	SkyPeakModel.instance:onNotifyBossChallengeResult(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_Notify_SkyPeakBossChallengeResultRes)
end

function SkyPeakController:getDefaultActivityId()
	return 592001
end

function SkyPeakController:showMissionViewStage(activityId, stageId)
	local fmtMo = self._fmtMoMapStage[activityId]

	if not fmtMo then
		fmtMo = SkyPeakStageFmtMo.New()
		self._fmtMoMapStage[activityId] = fmtMo
	end

	fmtMo:initParams(activityId, stageId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function SkyPeakController:showMissionViewBoss(activityId, bossId)
	local fmtMo = self._fmtMoMapBoss[activityId]

	if not fmtMo then
		fmtMo = SkyPeakBossFmtMo.New()
		self._fmtMoMapBoss[activityId] = fmtMo
	end

	fmtMo:initParams(activityId, bossId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function SkyPeakController:_onBattleEndStage()
	BattleFacade.instance:registerResultHandler(nil, nil)

	local lastFightInfo = SkyPeakModel.instance:getLastStageChallengeResult()

	if lastFightInfo then
		if lastFightInfo.win then
			UIStateManager.instance:push(ViewName.SkyPeakStageResultView)
		else
			UIStateManager.instance:open(ViewName.BattleSettlementFailSimple)
		end
	else
		UIStateManager.instance:push(ViewName.BattleSettlementFailSimple)
	end

	return true
end

function SkyPeakController:_onBattleEndBoss()
	BattleFacade.instance:registerResultHandler(nil, nil)
	UIStateManager.instance:push(ViewName.SkyPeakBossResultView)

	return true
end

function SkyPeakController:getKillPetName(activityId)
	local fmtMo = self._fmtMoMapStage[activityId]

	if fmtMo then
		return fmtMo:getCurKillScorePetName()
	end

	return ""
end

SkyPeakController.instance = SkyPeakController.New()

return SkyPeakController
