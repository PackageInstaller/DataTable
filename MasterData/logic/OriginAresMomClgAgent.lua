-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originaresmom/agent/OriginAresMomClgAgent.lua

module("logic.extensions.originaresmomclg.agent.OriginAresMomClgAgent", package.seeall)

local OriginAresMomClgAgent = class("OriginAresMomClgAgent", BaseAgent)

function OriginAresMomClgAgent:sendPM_OriginAresMomClgInfoReq(activityId)
	local req = OriginAresMomClgExtension_pb.PM_OriginAresMomClgInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function OriginAresMomClgAgent:handlePM_OriginAresMomClgInfoRes(status, msg)
	if status == 0 then
		OriginaresmomModel.instance:setInfo(msg)
		GlobalDispatcher:dispatch(GlobalNotify.OriginAresMomClgInfoRes)
	end
end

function OriginAresMomClgAgent:sendPM_OriginAresMomClgExtremeChallengeReq(activityId, stageId, form)
	local req = OriginAresMomClgExtension_pb.PM_OriginAresMomClgExtremeChallengeReq()

	req.activityId = activityId
	req.stageId = stageId

	req.form:ParseFromString(form:SerializeToString())
	self:sendMsg(req)
end

function OriginAresMomClgAgent:handlePM_OriginAresMomClgExtremeChallengeRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.OriginAresMomClgExtremeChallengeRes)
	end
end

function OriginAresMomClgAgent:sendPM_OriginAresMomClgResetExtremeStageReq(activityId, stageId)
	local req = OriginAresMomClgExtension_pb.PM_OriginAresMomClgResetExtremeStageReq()

	req.activityId = activityId
	req.stageId = stageId

	self:sendMsg(req)
end

function OriginAresMomClgAgent:handlePM_OriginAresMomClgResetExtremeStageRes(status, msg)
	if status == 0 then
		OriginaresmomModel.instance:onResetExtremeStageRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.OriginAresMomClgResetExtremeStageRes)
	end
end

function OriginAresMomClgAgent:sendPM_OriginAresMomClgNormalChallengeReq(activityId, teamId, form)
	local req = OriginAresMomClgExtension_pb.PM_OriginAresMomClgNormalChallengeReq()

	req.activityId = activityId
	req.teamId = teamId

	req.form:ParseFromString(form:SerializeToString())
	self:sendMsg(req)
end

function OriginAresMomClgAgent:handlePM_OriginAresMomClgNormalChallengeRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.OriginAresMomClgNormalChallengeRes)
	end
end

function OriginAresMomClgAgent:sendPM_OriginAresMomClgGainNormalPrizeReq(activityId, prizeId)
	local req = OriginAresMomClgExtension_pb.PM_OriginAresMomClgGainNormalPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function OriginAresMomClgAgent:handlePM_OriginAresMomClgGainNormalPrizeRes(status, msg)
	if status == 0 then
		OriginaresmomModel.instance:onGainNormalPrizeRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.OriginAresMomClgGainNormalPrizeRes)
	end
end

function OriginAresMomClgAgent:handlePM_Notify_OriginAresMomClgExtremeChallengeRes(status, msg)
	if status == 0 then
		OriginaresmomController.instance:onExtremeChallengeRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.Notify_OriginAresMomClgExtremeChallengeRes)
	end
end

function OriginAresMomClgAgent:handlePM_Notify_OriginAresMomClgNormalChallengeRes(status, msg)
	if status == 0 then
		OriginaresmomController.instance:onNormalChallengeRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.Notify_OriginAresMomClgNormalChallengeRes)
	end
end

OriginAresMomClgAgent.instance = OriginAresMomClgAgent.New()

return OriginAresMomClgAgent
