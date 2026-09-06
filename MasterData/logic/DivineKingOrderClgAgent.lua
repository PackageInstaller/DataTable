-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingorderclg/agent/DivineKingOrderClgAgent.lua

module("logic.extensions.divinekingorderclg.agent.DivineKingOrderClgAgent", package.seeall)

local DivineKingOrderClgAgent = class("DivineKingOrderClgAgent", BaseAgent)

function DivineKingOrderClgAgent:sendPM_DivineKingOrderClgGetInfoReq(activityId)
	local req = DivineKingOrderClgExtension_pb.PM_DivineKingOrderClgGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DivineKingOrderClgAgent:handlePM_DivineKingOrderClgGetInfoRes(status, msg)
	if status == 0 then
		DivineKingOrderClgController.instance:handleGetInfo(msg)
	else
		DivineKingOrderClgController.instance:_onError(status)
	end
end

function DivineKingOrderClgAgent:sendPM_DivineKingOrderClgFightReq(activityId, form)
	local req = DivineKingOrderClgExtension_pb.PM_DivineKingOrderClgFightReq()

	req.activityId = activityId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function DivineKingOrderClgAgent:handlePM_DivineKingOrderClgFightRes(status, msg)
	if status == 0 then
		DivineKingOrderClgController.instance:handleFight(msg)
	else
		DivineKingOrderClgController.instance:_onError(status)
	end
end

function DivineKingOrderClgAgent:handlePM_DivineKingOrderClgNotifyFightResultRes(status, msg)
	if status == 0 then
		DivineKingOrderClgController.instance:handleNotifyFightResult(msg)
	else
		DivineKingOrderClgController.instance:_onError(status)
	end
end

function DivineKingOrderClgAgent:sendPM_DivineKingOrderClgFightConfirmReq(activityId, confirmNum, save)
	local req = DivineKingOrderClgExtension_pb.PM_DivineKingOrderClgFightConfirmReq()

	req.activityId = activityId
	req.confirmNum = confirmNum
	req.save = save

	self:sendMsg(req)
end

function DivineKingOrderClgAgent:handlePM_DivineKingOrderClgFightConfirmRes(status, msg)
	DivineKingOrderClgController.instance:handleConfirmSave(msg, status)
end

function DivineKingOrderClgAgent:sendPM_DivineKingOrderClgResetReq(activityId)
	local req = DivineKingOrderClgExtension_pb.PM_DivineKingOrderClgResetReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DivineKingOrderClgAgent:handlePM_DivineKingOrderClgResetRes(status, msg)
	if status == 0 then
		DivineKingOrderClgController.instance:handleResetFight(msg)
	else
		DivineKingOrderClgController.instance:_onError(status)
	end
end

DivineKingOrderClgAgent.instance = DivineKingOrderClgAgent.New()

return DivineKingOrderClgAgent
