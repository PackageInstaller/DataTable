-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/treasureraider/agent/RichManAgent.lua

module("logic.extensions.treasureraider.agent.RichManAgent", package.seeall)

local RichManAgent = class("RichManAgent", BaseAgent)

function RichManAgent:sendPM_RichManGetInfoReq(activityId)
	local req = RichManExtension_pb.PM_RichManGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function RichManAgent:handlePM_RichManGetInfoRes(status, msg)
	TreasureRaiderController.instance:onRichManGetInfoRes(status, msg)
end

function RichManAgent:sendPM_RichManWalkReq(activityId, point)
	local req = RichManExtension_pb.PM_RichManWalkReq()

	req.activityId = activityId
	req.point = point

	self:sendMsg(req)
end

function RichManAgent:handlePM_RichManWalkRes(status, msg)
	TreasureRaiderController.instance:onRichManWalkRes(status, msg)
end

function RichManAgent:sendPM_RichManActionReq(activityId, buildingGrid, action, newBuildingCfgId)
	local req = RichManExtension_pb.PM_RichManActionReq()

	req.activityId = activityId
	req.buildingGrid = buildingGrid
	req.action = action
	req.newBuildingCfgId = newBuildingCfgId

	self:sendMsg(req)
end

function RichManAgent:handlePM_RichManActionRes(status, msg)
	TreasureRaiderController.instance:onRichManActionRes(status, msg)
end

function RichManAgent:sendPM_RichManEditMapReq(req)
	self:sendMsg(req)
end

function RichManAgent:handlePM_RichManEditMapRes(status, msg)
	TreasureRaiderController.instance:onRichManEditMapRes(status, msg)
end

function RichManAgent:sendPM_RichManDefendSetFormReq(req)
	self:sendMsg(req)
end

function RichManAgent:handlePM_RichManDefendSetFormRes(status, msg)
	TreasureRaiderController.instance:onRichManDefendSetFormRes(status, msg)
end

function RichManAgent:sendPM_RichManResourcePrizeReq(activityId)
	local req = RichManExtension_pb.PM_RichManResourcePrizeReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function RichManAgent:handlePM_RichManResourcePrizeRes(status, msg)
	if status == 0 then
		TreasureRaiderController.instance:onRichManResourcePrizeRes(status, msg)
	end
end

function RichManAgent:sendPM_RichManAttackMatchReq(activityId)
	local req = RichManExtension_pb.PM_RichManAttackMatchReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function RichManAgent:handlePM_RichManAttackMatchRes(status, msg)
	TreasureRaiderController.instance:onRichManAttackMatchRes(status, msg)
end

function RichManAgent:sendPM_RichManAttackWalkReq(point)
	local req = RichManExtension_pb.PM_RichManAttackWalkReq()

	req.point = point

	self:sendMsg(req)
end

function RichManAgent:handlePM_RichManAttackWalkRes(status, msg)
	TreasureRaiderController.instance:onRichManAttackWalkRes(status, msg)
end

function RichManAgent:sendPM_RichManAttackFightReq(req)
	self:sendMsg(req)
end

function RichManAgent:handlePM_RichManAttackFightRes(status, msg)
	TreasureRaiderController.instance:onRichManAttackFightRes(status, msg)
end

function RichManAgent:handlePM_RichManFightResultRes(status, msg)
	TreasureRaiderController.instance:onNotifyRichManFightResultRes(status, msg)
end

function RichManAgent:sendPM_RichManGetRecordReq(activityId, type)
	local req = RichManExtension_pb.PM_RichManGetRecordReq()

	req.activityId = activityId
	req.type = type

	self:sendMsg(req)
end

function RichManAgent:handlePM_RichManGetRecordRes(status, msg)
	TreasureRaiderController.instance:onRichManGetRecordRes(status, msg)
end

function RichManAgent:sendPM_RichManRevengeReq(activityId, targetId)
	local req = RichManExtension_pb.PM_RichManRevengeReq()

	req.activityId = activityId
	req.targetId = targetId

	self:sendMsg(req)
end

function RichManAgent:handlePM_RichManRevengeRes(status, msg)
	TreasureRaiderController.instance:onRichManRevengeRes(status, msg)
end

function RichManAgent:sendPM_RichManGetRankReq(activityId)
	local req = RichManExtension_pb.PM_RichManGetRankReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function RichManAgent:handlePM_RichManGetRankRes(status, msg)
	TreasureRaiderController.instance:onRichManGetRankRes(status, msg)
end

function RichManAgent:sendPM_RichManAttackSetFormReq(req)
	self:sendMsg(req)
end

function RichManAgent:handlePM_RichManAttackSetFormRes(status, msg)
	TreasureRaiderController.instance:onRichManAttackSetFormRes(status, msg)
end

function RichManAgent:sendPM_RichManGetTotalResourceReq(activityId)
	local req = RichManExtension_pb.PM_RichManGetTotalResourceReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function RichManAgent:handlePM_RichManGetTotalResourceRes(status, msg)
	TreasureRaiderController.instance:onRichManGetTotalResourceRes(status, msg)
end

RichManAgent.instance = RichManAgent.New()

return RichManAgent
