-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinemimengliclg/agent/DivineMiMengLiClgAgent.lua

module("logic.extensions.divinemimengliclg.agent.DivineMiMengLiClgAgent", package.seeall)

local DivineMiMengLiClgAgent = class("DivineMiMengLiClgAgent", BaseAgent)

function DivineMiMengLiClgAgent:sendPM_DivineMiMengLiClgGetInfoReq(activityId)
	local req = DivineMiMengLiClgExtension_pb.PM_DivineMiMengLiClgGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DivineMiMengLiClgAgent:handlePM_DivineMiMengLiClgGetInfoRes(status, msg)
	if status == 0 then
		DivineMiMengLiClgController.instance:handlePM_DivineMiMengLiClgGetInfoRes(msg)
	end
end

function DivineMiMengLiClgAgent:sendPM_DivineMiMengLiClgFightReq(activityId, stageId, teamId, form)
	local req = DivineMiMengLiClgExtension_pb.PM_DivineMiMengLiClgFightReq()

	req.activityId = activityId
	req.stageId = stageId
	req.teamId = teamId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function DivineMiMengLiClgAgent:handlePM_DivineMiMengLiClgFightRes(status, msg)
	if status == 0 then
		DivineMiMengLiClgController.instance:handlePM_DivineMiMengLiClgFightRes(msg)
	end
end

function DivineMiMengLiClgAgent:sendPM_DivineMiMengLiClgConfirmReq(activityId, stageId, teamId)
	local req = DivineMiMengLiClgExtension_pb.PM_DivineMiMengLiClgConfirmReq()

	req.activityId = activityId
	req.stageId = stageId
	req.teamId = teamId

	self:sendMsg(req)
end

function DivineMiMengLiClgAgent:handlePM_DivineMiMengLiClgConfirmRes(status, msg)
	if status == 0 then
		DivineMiMengLiClgController.instance:handlePM_DivineMiMengLiClgConfirmRes(msg)
	end
end

function DivineMiMengLiClgAgent:sendPM_DivineMiMengLiClgResetReq(activityId, stageId)
	local req = DivineMiMengLiClgExtension_pb.PM_DivineMiMengLiClgResetReq()

	req.activityId = activityId
	req.stageId = stageId

	self:sendMsg(req)
end

function DivineMiMengLiClgAgent:handlePM_DivineMiMengLiClgResetRes(status, msg)
	if status == 0 then
		DivineMiMengLiClgController.instance:handlePM_DivineMiMengLiClgResetRes(msg)
	end
end

function DivineMiMengLiClgAgent:handlePM_DivineMiMengLiNotifyFightRes(status, msg)
	if status == 0 then
		DivineMiMengLiClgController.instance:handlePM_DivineMiMengLiNotifyFightRes(msg)
	end
end

DivineMiMengLiClgAgent.instance = DivineMiMengLiClgAgent.New()

return DivineMiMengLiClgAgent
