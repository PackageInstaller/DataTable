-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineyuhui/agent/DivineYuHuiAgent.lua

module("logic.extensions.divineyuhui.agent.DivineYuHuiAgent", package.seeall)

local DivineYuHuiAgent = class("DivineYuHuiAgent", BaseAgent)

function DivineYuHuiAgent:sendPM_DivineYuHuiClgInfoReq(activityId)
	local req = DivineYuHuiClgExtension_pb.PM_DivineYuHuiClgInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DivineYuHuiAgent:handlePM_DivineYuHuiClgInfoRes(status, msg)
	if status == 0 then
		DivineYuHuiController.instance:handlePM_DivineYuHuiClgInfoRes(msg)
	end
end

function DivineYuHuiAgent:sendPM_DivineYuHuiClgChallengeReq(activityId, stageId, form)
	local req = DivineYuHuiClgExtension_pb.PM_DivineYuHuiClgChallengeReq()

	req.activityId = activityId
	req.stageId = stageId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function DivineYuHuiAgent:handlePM_DivineYuHuiClgChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function DivineYuHuiAgent:sendPM_DivineYuHuiClgResetReq(activityId, stageId)
	local req = DivineYuHuiClgExtension_pb.PM_DivineYuHuiClgResetReq()

	req.activityId = activityId
	req.stageId = stageId

	self:sendMsg(req)
end

function DivineYuHuiAgent:handlePM_DivineYuHuiClgResetRes(status, msg)
	if status == 0 then
		DivineYuHuiController.instance:handlePM_DivineYuHuiClgResetRes(msg)
	end
end

function DivineYuHuiAgent:handlePM_NotifyDivineYuHuiClgFinishRes(status, msg)
	if status == 0 then
		DivineYuHuiController.instance:handlePM_NotifyDivineYuHuiClgFinishRes(msg)
	end
end

DivineYuHuiAgent.instance = DivineYuHuiAgent.New()

return DivineYuHuiAgent
