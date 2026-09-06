-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/emperorsubdue/agent/EmperorSubdueAgent.lua

module("logic.extensions.emperorsubdue.agent.EmperorSubdueAgent", package.seeall)

local EmperorSubdueAgent = class("EmperorSubdueAgent", BaseAgent)

function EmperorSubdueAgent:sendPM_EmperorSubdueInfoReq(activityId)
	local req = EmperorSubdueExtension_pb.PM_EmperorSubdueInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function EmperorSubdueAgent:handlePM_EmperorSubdueInfoRes(status, msg)
	if status == 0 then
		EmperorSubdueController.instance:handleGetInfo(msg)
	end
end

function EmperorSubdueAgent:sendPM_EmperorSubdueStageClgReq(activityId, form_pb, stageId)
	local req = EmperorSubdueExtension_pb.PM_EmperorSubdueStageClgReq()

	req.activityId = activityId

	if form_pb ~= nil then
		req.form:ParseFromString(form_pb:SerializeToString())
	end

	req.stageId = stageId

	self:sendMsg(req)
end

function EmperorSubdueAgent:handlePM_EmperorSubdueStageClgRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function EmperorSubdueAgent:sendPM_EmperorSubdueBossClgReq(activityId, selectBuffId, isTrial, form_pb)
	local req = EmperorSubdueExtension_pb.PM_EmperorSubdueBossClgReq()

	req.activityId = activityId
	req.selectBuffId = selectBuffId
	req.isTrial = isTrial

	if form_pb ~= nil then
		req.form:ParseFromString(form_pb:SerializeToString())
	end

	self:sendMsg(req)
end

function EmperorSubdueAgent:handlePM_EmperorSubdueBossClgRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function EmperorSubdueAgent:sendPM_EmperorSubdueResetReq(activityId)
	local req = EmperorSubdueExtension_pb.PM_EmperorSubdueResetReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function EmperorSubdueAgent:handlePM_EmperorSubdueResetRes(status, msg)
	if status == 0 then
		EmperorSubdueController.instance:handleResetStage(msg)
	end
end

function EmperorSubdueAgent:handlePM_EmperorSubdueNotifyStageClgRes(status, msg)
	if status == 0 then
		EmperorSubdueController.instance:handleNotifyStageChallenge(msg)
	end
end

function EmperorSubdueAgent:handlePM_EmperorSubdueNotifyBossClgRes(status, msg)
	if status == 0 then
		EmperorSubdueController.instance:handleNotifyBossChallenge(msg)
	end
end

function EmperorSubdueAgent:sendPM_EmperorSubdueRankViewReq(activityId)
	local req = EmperorSubdueExtension_pb.PM_EmperorSubdueRankViewReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function EmperorSubdueAgent:handlePM_EmperorSubdueRankViewRes(status, msg)
	if status == 0 then
		EmperorSubdueController.instance:handleGetRankList(msg)
	end
end

EmperorSubdueAgent.instance = EmperorSubdueAgent.New()

return EmperorSubdueAgent
