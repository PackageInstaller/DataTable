-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nightfeastbosschallenge/agent/NightFeastBossChallengeAgent.lua

module("logic.extensions.nightfeastbosschallenge.agent.NightFeastBossChallengeAgent", package.seeall)

local NightFeastBossChallengeAgent = class("NightFeastBossChallengeAgent", BaseAgent)

function NightFeastBossChallengeAgent:sendPM_NightFeastBossClgGetInfoReq(activityId)
	local req = NightFeastBossChallengeExtension_pb.PM_NightFeastBossClgGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function NightFeastBossChallengeAgent:handlePM_NightFeastBossClgGetInfoRes(status, msg)
	if status == 0 then
		NightFeastBossModel.instance:onNightFeastBossClgGetInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.NightFeastBossClgGetInfoRes)
	end
end

function NightFeastBossChallengeAgent:sendPM_NightFeastBossClgFight4BuffReq(activityId, stageId, form)
	local req = NightFeastBossChallengeExtension_pb.PM_NightFeastBossClgFight4BuffReq()

	req.activityId = activityId
	req.stageId = stageId

	req.form:ParseFromString(form:SerializeToString())
	self:sendMsg(req)
	NightFeastBossController.instance:saveLastActivityId(activityId)
end

function NightFeastBossChallengeAgent:handlePM_NightFeastBossClgFight4BuffRes(status, msg)
	if status == 0 then
		NightFeastBossModel.instance:onNightFeastBossClgFight4BuffRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.NightFeastBossClgFight4BuffRes)
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function NightFeastBossChallengeAgent:handlePM_NightFeastBossClgFight4BuffNotifyFightResultRes(status, msg)
	if status == 0 then
		NightFeastBossModel.instance:onNightFeastBossClgFight4BuffNotifyFightResultRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.NightFeastBossClgFight4BuffNotifyFightResultRes)
	end
end

function NightFeastBossChallengeAgent:sendPM_NightFeastBossClgFightBossReq(activityId, form, bossId)
	local req = NightFeastBossChallengeExtension_pb.PM_NightFeastBossClgFightBossReq()

	req.activityId = activityId

	req.form:ParseFromString(form:SerializeToString())

	req.bossId = bossId

	self:sendMsg(req)
	NightFeastBossController.instance:saveLastActivityId(activityId)
	NightFeastBossController.instance:saveLastBossId(bossId)
end

function NightFeastBossChallengeAgent:handlePM_NightFeastBossClgFightBossRes(status, msg)
	if status == 0 then
		NightFeastBossModel.instance:onNightFeastBossClgFightBossRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.NightFeastBossClgFightBossRes, msg.activityId)
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function NightFeastBossChallengeAgent:handlePM_NightFeastBossClgFightBossNotifyFightResultRes(status, msg)
	if status == 0 then
		NightFeastBossModel.instance:onNightFeastBossClgFightBossNotifyFightResultRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.NightFeastBossClgFightBossNotifyFightResultRes)
	end
end

function NightFeastBossChallengeAgent:sendPM_NightFeastBossClgLvlUpBuffReq(activityId, buffId)
	local req = NightFeastBossChallengeExtension_pb.PM_NightFeastBossClgLvlUpBuffReq()

	req.activityId = activityId
	req.buffId = buffId

	self:sendMsg(req)
end

function NightFeastBossChallengeAgent:handlePM_NightFeastBossClgLvlUpBuffRes(status, msg)
	if status == 0 then
		NightFeastBossModel.instance:onNightFeastBossClgLvlUpBuffRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.NightFeastBossClgLvlUpBuffRes)
	end
end

function NightFeastBossChallengeAgent:sendPM_NightFeastBossClgResetBuffReq(activityId)
	local req = NightFeastBossChallengeExtension_pb.PM_NightFeastBossClgResetBuffReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function NightFeastBossChallengeAgent:handlePM_NightFeastBossClgResetBuffRes(status, msg)
	if status == 0 then
		NightFeastBossModel.instance:onNightFeastBossClgResetBuffRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.NightFeastBossClgResetBuffRes)
	end
end

function NightFeastBossChallengeAgent:sendPM_NightFeastBossClgGainProgressPrizeReq(activityId, dataBitId, bossId)
	local req = NightFeastBossChallengeExtension_pb.PM_NightFeastBossClgGainProgressPrizeReq()

	req.activityId = activityId
	req.dataBitId = dataBitId
	req.bossId = bossId

	self:sendMsg(req)
end

function NightFeastBossChallengeAgent:handlePM_NightFeastBossClgGainProgressPrizeRes(status, msg)
	if status == 0 then
		NightFeastBossModel.instance:onNightFeastBossClgGainProgressPrizeRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.NightFeastBossClgGainProgressPrizeRes)
	end
end

function NightFeastBossChallengeAgent:sendPM_NightFeastBossClgGetRankReq(activityId, bossId)
	local req = NightFeastBossChallengeExtension_pb.PM_NightFeastBossClgGetRankReq()

	req.activityId = activityId
	req.bossId = bossId

	self:sendMsg(req)
end

function NightFeastBossChallengeAgent:handlePM_NightFeastBossClgGetRankRes(status, msg)
	if status == 0 then
		NightFeastBossModel.instance:onNightFeastBossClgGetRankRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.NightFeastBossClgGetRankRes)
	end
end

NightFeastBossChallengeAgent.instance = NightFeastBossChallengeAgent.New()

return NightFeastBossChallengeAgent
