-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineteshamuclg/agent/DivineTeshamuAgent.lua

module("logic.extensions.divineteshamu.agent.DivineTeshamuAgent", package.seeall)

local DivineTeshamuAgent = class("DivineTeshamuAgent", BaseAgent)

function DivineTeshamuAgent:sendPM_DivineTeshamuInfoReq(activityId)
	local req = DivineTeshamuExtension_pb.PM_DivineTeshamuInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DivineTeshamuAgent:handlePM_DivineTeshamuInfoRes(status, msg)
	if status == 0 then
		DivineteshamuclgModel.instance:setInfo(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DivineTeshamuInfoRes)
	end
end

function DivineTeshamuAgent:sendPM_DivineTeshamuResetFloorReq(activityId, floorId)
	local req = DivineTeshamuExtension_pb.PM_DivineTeshamuResetFloorReq()

	req.activityId = activityId
	req.floorId = floorId

	self:sendMsg(req)
end

function DivineTeshamuAgent:handlePM_DivineTeshamuResetFloorRes(status, msg)
	if status == 0 then
		local activityId = msg.activityId
		local floorId = msg.floorId

		DivineteshamuclgModel.instance:onResetFloor(activityId, floorId)
		GlobalDispatcher:dispatch(GlobalNotify.DivineTeshamuResetFloorRes)
	end
end

function DivineTeshamuAgent:sendPM_DivineTeshamuChallengeReq(activityId, form, floorId, stageId)
	local req = DivineTeshamuExtension_pb.PM_DivineTeshamuChallengeReq()

	req.activityId = activityId

	req.form:ParseFromString(form:SerializeToString())

	req.floorId = floorId
	req.stageId = stageId

	self:sendMsg(req)
end

function DivineTeshamuAgent:handleDivineTeshamuChallengeRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.DivineTeshamuChallengeRes)
	end
end

function DivineTeshamuAgent:handlePM_DivineTeshamuChallengeRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.DivineTeshamuChallengeRes)
	end
end

function DivineTeshamuAgent:handlePM_DivineTeshamuNotifyChallengeRes(status, msg)
	if status == 0 then
		DivineteshamuclgController.instance:onNotifyChallengeRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DivineTeshamuNotifyChallengeRes)
	end
end

function DivineTeshamuAgent:sendPM_DivineTeshamuSaveReq(activityId, res)
	local req = DivineTeshamuExtension_pb.PM_DivineTeshamuSaveReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DivineTeshamuAgent:handlePM_DivineTeshamuSaveRes(status, msg)
	if status == 0 then
		DivineTeshamuAgent.instance:sendPM_DivineTeshamuInfoReq(msg.activityId)
		DivineteshamuclgController.instance:onSaveRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DivineTeshamuSaveRes)
	end
end

function DivineTeshamuAgent:sendPM_DivineTeshamuAdvanceReq(activityId, floorId, stageId)
	local req = DivineTeshamuExtension_pb.PM_DivineTeshamuAdvanceReq()

	req.activityId = activityId
	req.floorId = floorId
	req.stageId = stageId

	self:sendMsg(req)
end

function DivineTeshamuAgent:handlePM_DivineTeshamuAdvanceRes(status, msg)
	if status == 0 then
		DivineteshamuclgModel.instance:onAdvanceRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DivineTeshamuAdvanceRes)
	end
end

DivineTeshamuAgent.instance = DivineTeshamuAgent.New()

return DivineTeshamuAgent
