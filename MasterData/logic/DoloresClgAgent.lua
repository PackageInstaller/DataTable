-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/doloresclg/agent/DoloresClgAgent.lua

module("logic.extensions.doloresclg.agent.DoloresClgAgent", package.seeall)

local DoloresClgAgent = class("DoloresClgAgent", BaseAgent)

function DoloresClgAgent:sendPM_DoloresClgGetInfoReq(activityId)
	local req = DoloresClgExtension_pb.PM_DoloresClgGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DoloresClgAgent:handlePM_DoloresClgGetInfoRes(status, msg)
	if status == 0 then
		DoloresController.instance:onGetInfo(msg)
	end
end

function DoloresClgAgent:sendPM_DoloresClgChallengeReq(activityId, phaseId, stageId, form_pb)
	local req = DoloresClgExtension_pb.PM_DoloresClgChallengeReq()

	req.activityId = activityId
	req.phaseId = phaseId
	req.stageId = stageId

	if form_pb ~= nil then
		req.form:ParseFromString(form_pb:SerializeToString())
	end

	self:sendMsg(req)
end

function DoloresClgAgent:handlePM_DoloresClgChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function DoloresClgAgent:sendPM_DoloresClgResetReq(activityId, phaseId, stageId)
	local req = DoloresClgExtension_pb.PM_DoloresClgResetReq()

	req.activityId = activityId
	req.phaseId = phaseId
	req.stageId = stageId

	self:sendMsg(req)
end

function DoloresClgAgent:handlePM_DoloresClgResetRes(status, msg)
	if status == 0 then
		DoloresController.instance:onResetInfo(msg)
	end
end

function DoloresClgAgent:handlePM_Notify_DoloresClgChallengeResultRes(status, msg)
	if status == 0 then
		DoloresController.instance:onGetFighMsg(msg)
	end
end

DoloresClgAgent.instance = DoloresClgAgent.New()

return DoloresClgAgent
