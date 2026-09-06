-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinehope/agent/DivineHopeAgent.lua

module("logic.extensions.divinehope.agent.DivineHopeAgent", package.seeall)

local DivineHopeAgent = class("DivineHopeAgent", BaseAgent)

function DivineHopeAgent:sendPM_DivineHopeInfoReq(activityId)
	local req = DivineHopeExtension_pb.PM_DivineHopeInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DivineHopeAgent:handlePM_DivineHopeInfoRes(status, msg)
	if status == 0 then
		DivinehopeModel.instance:setInfo(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DivineHopeInfoRes)
	end
end

function DivineHopeAgent:sendPM_DivineHopeResetFloorReq(activityId, floorId)
	local req = DivineHopeExtension_pb.PM_DivineHopeResetFloorReq()

	req.activityId = activityId
	req.floorId = floorId

	self:sendMsg(req)
end

function DivineHopeAgent:handlePM_DivineHopeResetFloorRes(status, msg)
	if status == 0 then
		DivinehopeModel.instance:onResetFloorRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DivineHopeResetFloorRes)
	end
end

function DivineHopeAgent:sendPM_DivineHopeChallengeReq(activityId, form, floorId, stageId, wishId)
	local req = DivineHopeExtension_pb.PM_DivineHopeChallengeReq()

	req.activityId = activityId

	req.form:ParseFromString(form:SerializeToString())

	req.floorId = floorId
	req.stageId = stageId
	req.wishId = wishId

	self:sendMsg(req)
end

function DivineHopeAgent:handlePM_DivineHopeChallengeRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.DivineHopeChallengeRes)
	end
end

function DivineHopeAgent:handlePM_DivineHopeNotifyChallengeRes(status, msg)
	if status == 0 then
		DivinehopeModel.instance:onNotifyChallengeRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DivineHopeNotifyChallengeRes)
	end
end

DivineHopeAgent.instance = DivineHopeAgent.New()

return DivineHopeAgent
