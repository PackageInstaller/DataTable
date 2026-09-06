-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingjiclg/agent/DivineKingJiClgAgent.lua

module("logic.extensions.divinekingjiclg.agent.DivineKingJiClgAgent", package.seeall)

local DivineKingJiClgAgent = class("DivineKingJiClgAgent", BaseAgent)

function DivineKingJiClgAgent:sendPM_DivineKingJiClgGetInfoReq(activityId)
	local req = DivineKingJiClgExtension_pb.PM_DivineKingJiClgGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DivineKingJiClgAgent:handlePM_DivineKingJiClgGetInfoRes(status, msg)
	if status == 0 then
		DivinekingjiclgModel.instance:setInfo(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DivineKingJiClgGetInfoRes)
	end
end

function DivineKingJiClgAgent:sendPM_DivineKingJiClgFightReq(activityId, stageId, form)
	local req = DivineKingJiClgExtension_pb.PM_DivineKingJiClgFightReq()

	req.activityId = activityId
	req.stageId = stageId

	req.form:ParseFromString(form:SerializeToString())
	self:sendMsg(req)
end

function DivineKingJiClgAgent:handlePM_DivineKingJiClgFightRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.DivineKingJiClgFightRes)
	end
end

function DivineKingJiClgAgent:sendPM_DivineKingJiClgConfirmReq(activityId, stageId, confirm)
	local req = DivineKingJiClgExtension_pb.PM_DivineKingJiClgConfirmReq()

	req.activityId = activityId
	req.stageId = stageId
	req.confirm = confirm

	self:sendMsg(req)
end

function DivineKingJiClgAgent:handlePM_DivineKingJiClgConfirmRes(status, msg)
	if status == 0 then
		DivinekingjiclgController.instance:onConfirmRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DivineKingJiClgConfirmRes)
	end
end

function DivineKingJiClgAgent:sendPM_DivineKingJiClgResetReq(activityId)
	local req = DivineKingJiClgExtension_pb.PM_DivineKingJiClgResetReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DivineKingJiClgAgent:handlePM_DivineKingJiClgResetRes(status, msg)
	if status == 0 then
		local activityId = msg.activityId

		DivinekingjiclgModel.instance:onResetClg(activityId)
		GlobalDispatcher:dispatch(GlobalNotify.DivineKingJiClgResetRes)
	end
end

function DivineKingJiClgAgent:handlePM_DivineKingJiClgNotifyFightRes(status, msg)
	if status == 0 then
		DivinekingjiclgController.instance:onClgNotifyFightRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DivineKingJiClgNotifyFightRes)
	end
end

DivineKingJiClgAgent.instance = DivineKingJiClgAgent.New()

return DivineKingJiClgAgent
