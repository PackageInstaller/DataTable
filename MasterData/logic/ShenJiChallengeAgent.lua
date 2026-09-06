-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shenjichallenge/agent/ShenJiChallengeAgent.lua

module("logic.extensions.shenjichallenge.agent.ShenJiChallengeAgent", package.seeall)

local ShenJiChallengeAgent = class("ShenJiChallengeAgent", BaseAgent)

function ShenJiChallengeAgent:sendPM_ShenJiChallengeGetInfoReq(actId)
	local req = ShenJiChallengeExtension_pb.PM_ShenJiChallengeGetInfoReq()

	req.actId = actId

	self:sendMsg(req)
end

function ShenJiChallengeAgent:handlePM_ShenJiChallengeGetInfoRes(status, msg)
	if status == 0 then
		ShenJiChallengeModel.instance:onGetInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.ShenJiChallengeGetInfoRes)
	end
end

function ShenJiChallengeAgent:sendPM_ShenJiChallengeSelectClgReq(actId, stageId, form)
	local req = ShenJiChallengeExtension_pb.PM_ShenJiChallengeSelectClgReq()

	req.actId = actId
	req.stageId = stageId

	req.form:ParseFromString(form:SerializeToString())
	self:sendMsg(req)
end

function ShenJiChallengeAgent:handlePM_ShenJiChallengeSelectClgRes(status, msg)
	if status == 0 then
		ShenJiChallengeModel.instance:onSelectClgRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.ShenJiChallengeSelectClgRes)
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function ShenJiChallengeAgent:sendPM_ShenJiChallengeBossClgReq(actId, bossId, form, isEmulate)
	local req = ShenJiChallengeExtension_pb.PM_ShenJiChallengeBossClgReq()

	req.actId = actId
	req.bossId = bossId

	req.form:ParseFromString(form:SerializeToString())

	req.isEmulate = isEmulate

	self:sendMsg(req)
end

function ShenJiChallengeAgent:handlePM_ShenJiChallengeBossClgRes(status, msg)
	if status == 0 then
		ShenJiChallengeModel.instance:onBossClgRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.ShenJiChallengeBossClgRes)
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function ShenJiChallengeAgent:sendPM_ShenJiChallengeResetBossStageReq(actId, bossId)
	local req = ShenJiChallengeExtension_pb.PM_ShenJiChallengeResetBossStageReq()

	req.actId = actId
	req.bossId = bossId

	self:sendMsg(req)
end

function ShenJiChallengeAgent:handlePM_ShenJiChallengeResetBossStageRes(status, msg)
	if status == 0 then
		ShenJiChallengeModel.instance:onResetBossStageRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.ShenJiChallengeResetBossStageRes)
	end
end

function ShenJiChallengeAgent:sendPM_ShenJiChallengeGainPrizeReq(actId, bossId)
	local req = ShenJiChallengeExtension_pb.PM_ShenJiChallengeGainPrizeReq()

	req.actId = actId
	req.bossId = bossId

	self:sendMsg(req)
end

function ShenJiChallengeAgent:handlePM_ShenJiChallengeGainPrizeRes(status, msg)
	if status == 0 then
		ShenJiChallengeModel.instance:onGainPrizeRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.ShenJiChallengeGainPrizeRes)
	end
end

function ShenJiChallengeAgent:handlePM_KingJiChallengeNotifySelectClgRes(status, msg)
	if status == 0 then
		ShenJiChallengeModel.instance:onKingJiChallengeNotifySelectClgRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.KingJiChallengeNotifySelectClgRes)
	end
end

function ShenJiChallengeAgent:handlePM_KingJiChallengeNotifyBossClgRes(status, msg)
	if status == 0 then
		ShenJiChallengeModel.instance:onKingJiChallengeNotifyBossClgRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.KingJiChallengeNotifyBossClgRes, msg.actId, msg.isEmulate, msg.isWin)
	end
end

ShenJiChallengeAgent.instance = ShenJiChallengeAgent.New()

return ShenJiChallengeAgent
