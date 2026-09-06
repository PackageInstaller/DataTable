-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wisdomcourageclg/agent/WisdomCourageClgAgent.lua

module("logic.extensions.wisdomcourageclg.agent.WisdomCourageClgAgent", package.seeall)

local WisdomCourageClgAgent = class("WisdomCourageClgAgent", BaseAgent)

function WisdomCourageClgAgent:sendPM_WisdomCourageClgBossInfoReq(activityId)
	local req = WisdomCourageClgExtension_pb.PM_WisdomCourageClgBossInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function WisdomCourageClgAgent:handlePM_WisdomCourageClgBossInfoRes(status, msg)
	if status == 0 then
		WisdomCourageClgController.instance:handlePM_WisdomCourageClgBossInfoRes(msg)
	end
end

function WisdomCourageClgAgent:sendPM_WisdomCourageClgBossChallengeReq(activityId, bossId, simulated, form)
	local req = WisdomCourageClgExtension_pb.PM_WisdomCourageClgBossChallengeReq()

	req.activityId = activityId
	req.bossId = bossId
	req.simulated = simulated

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function WisdomCourageClgAgent:handlePM_WisdomCourageClgBossChallengeRes(status, msg)
	if status == 0 then
		WisdomCourageClgController.instance:handlePM_WisdomCourageClgBossChallengeRes(msg)
	end
end

function WisdomCourageClgAgent:sendPM_WisdomCourageClgBossRankInfoReq(activityId)
	local req = WisdomCourageClgExtension_pb.PM_WisdomCourageClgBossRankInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function WisdomCourageClgAgent:handlePM_WisdomCourageClgBossRankInfoRes(status, msg)
	if status == 0 then
		WisdomCourageClgController.instance:handlePM_WisdomCourageClgBossRankInfoRes(msg)
	end
end

function WisdomCourageClgAgent:sendPM_WisdomCourageClgSupportInfoReq(activityId)
	local req = WisdomCourageClgExtension_pb.PM_WisdomCourageClgSupportInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function WisdomCourageClgAgent:handlePM_WisdomCourageClgSupportInfoRes(status, msg)
	if status == 0 then
		WisdomCourageClgController.instance:handlePM_WisdomCourageClgSupportInfoRes(msg)
	end
end

function WisdomCourageClgAgent:sendPM_WisdomCourageClgSupportChallengeReq(activityId, stageId, form)
	local req = WisdomCourageClgExtension_pb.PM_WisdomCourageClgSupportChallengeReq()

	req.activityId = activityId
	req.stageId = stageId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function WisdomCourageClgAgent:handlePM_WisdomCourageClgSupportChallengeRes(status, msg)
	if status == 0 then
		WisdomCourageClgController.instance:handlePM_WisdomCourageClgSupportChallengeRes(msg)
	end
end

function WisdomCourageClgAgent:sendPM_WisdomCourageClgSupportConfirmReq(activityId, save)
	local req = WisdomCourageClgExtension_pb.PM_WisdomCourageClgSupportConfirmReq()

	req.activityId = activityId
	req.save = save

	self:sendMsg(req)
end

function WisdomCourageClgAgent:handlePM_WisdomCourageClgSupportConfirmRes(status, msg)
	WisdomCourageClgController.instance:handlePM_WisdomCourageClgSupportConfirmRes(status, msg)
end

function WisdomCourageClgAgent:sendPM_WisdomCourageClgSupportResetReq(activityId)
	local req = WisdomCourageClgExtension_pb.PM_WisdomCourageClgSupportResetReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function WisdomCourageClgAgent:handlePM_WisdomCourageClgSupportResetRes(status, msg)
	if status == 0 then
		WisdomCourageClgController.instance:handlePM_WisdomCourageClgSupportResetRes(msg)
	end
end

function WisdomCourageClgAgent:sendPM_WisdomCourageClgSupportRankInfoReq(activityId)
	local req = WisdomCourageClgExtension_pb.PM_WisdomCourageClgSupportRankInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function WisdomCourageClgAgent:handlePM_WisdomCourageClgSupportRankInfoRes(status, msg)
	if status == 0 then
		WisdomCourageClgController.instance:handlePM_WisdomCourageClgSupportRankInfoRes(msg)
	end
end

function WisdomCourageClgAgent:handlePM_NotifyWisdomCourageClgBossChallengeFinishRes(status, msg)
	if status == 0 then
		WisdomCourageClgController.instance:handlePM_NotifyWisdomCourageClgBossChallengeFinishRes(msg)
	end
end

function WisdomCourageClgAgent:handlePM_NotifyWisdomCourageClgSupportChallengeFinishRes(status, msg)
	if status == 0 then
		WisdomCourageClgController.instance:handlePM_NotifyWisdomCourageClgSupportChallengeFinishRes(msg)
	end
end

WisdomCourageClgAgent.instance = WisdomCourageClgAgent.New()

return WisdomCourageClgAgent
