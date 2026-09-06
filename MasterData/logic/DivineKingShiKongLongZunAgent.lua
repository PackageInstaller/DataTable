-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingshikongllongzun/agent/DivineKingShiKongLongZunAgent.lua

module("logic.extensions.divinekingshikongllongzun.agent.DivineKingShiKongLongZunAgent", package.seeall)

local DivineKingShiKongLongZunAgent = class("DivineKingShiKongLongZunAgent", BaseAgent)

function DivineKingShiKongLongZunAgent:sendPM_DivineKingSpaceDragonInfoReq(activityId)
	local req = DivineKingSpaceDragonExtension_pb.PM_DivineKingSpaceDragonInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DivineKingShiKongLongZunAgent:handlePM_DivineKingSpaceDragonInfoRes(status, msg)
	if status == 0 then
		DivineKingShiKongLongZunController.instance:handlePM_DivineKingSpaceDragonInfoRes(msg)
	end
end

function DivineKingShiKongLongZunAgent:sendPM_DivineKingSpaceDragonResetFloorReq(activityId, floorId)
	local req = DivineKingSpaceDragonExtension_pb.PM_DivineKingSpaceDragonResetFloorReq()

	req.activityId = activityId
	req.floorId = floorId

	self:sendMsg(req)
end

function DivineKingShiKongLongZunAgent:handlePM_DivineKingSpaceDragonResetFloorRes(status, msg)
	if status == 0 then
		DivineKingShiKongLongZunController.instance:handlePM_DivineKingSpaceDragonResetFloorRes(msg)
	end
end

function DivineKingShiKongLongZunAgent:sendPM_DivineKingSpaceDragonChallengeReq(activityId, form, floorId, stageId)
	local req = DivineKingSpaceDragonExtension_pb.PM_DivineKingSpaceDragonChallengeReq()

	req.activityId = activityId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	req.floorId = floorId
	req.stageId = stageId

	self:sendMsg(req)
end

function DivineKingShiKongLongZunAgent:handlePM_DivineKingSpaceDragonChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function DivineKingShiKongLongZunAgent:handlePM_DivineKingSpaceDragonNotifyChallengeRes(status, msg)
	if status == 0 then
		DivineKingShiKongLongZunController.instance:handlePM_DivineKingSpaceDragonNotifyChallengeRes(msg)
	end
end

DivineKingShiKongLongZunAgent.instance = DivineKingShiKongLongZunAgent.New()

return DivineKingShiKongLongZunAgent
