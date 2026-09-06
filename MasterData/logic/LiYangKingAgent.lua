-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/liyangking/agent/LiYangKingAgent.lua

module("logic.extensions.liyangking.agent.LiYangKingAgent", package.seeall)

local LiYangKingAgent = class("LiYangKingAgent", BaseAgent)

function LiYangKingAgent:sendPM_PrinceLiyangInfoReq(activityId)
	local req = PrinceLiyangExtension_pb.PM_PrinceLiyangInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function LiYangKingAgent:handlePM_PrinceLiyangInfoRes(status, msg)
	if status == 0 then
		LiYangKingController.instance:handlePM_PrinceLiyangInfoRes(msg)
	end
end

function LiYangKingAgent:sendPM_PrinceLiyangGainHangingReq(activityId)
	local req = PrinceLiyangExtension_pb.PM_PrinceLiyangGainHangingReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function LiYangKingAgent:handlePM_PrinceLiyangGainHangingRes(status, msg)
	LiYangKingController.instance:handlePM_PrinceLiyangGainHangingRes(status, msg)
end

function LiYangKingAgent:sendPM_PrinceLiyangUnlockBuildingReq(activityId, buildingId)
	local req = PrinceLiyangExtension_pb.PM_PrinceLiyangUnlockBuildingReq()

	req.activityId = activityId
	req.buildingId = buildingId

	self:sendMsg(req)
end

function LiYangKingAgent:handlePM_PrinceLiyangUnlockBuildingRes(status, msg)
	if status == 0 then
		LiYangKingController.instance:handlePM_PrinceLiyangUnlockBuildingRes(msg)
	end
end

function LiYangKingAgent:sendPM_PrinceLiyangUpgradeBuildingReq(activityId, buildingId)
	local req = PrinceLiyangExtension_pb.PM_PrinceLiyangUpgradeBuildingReq()

	req.activityId = activityId
	req.buildingId = buildingId

	self:sendMsg(req)
end

function LiYangKingAgent:handlePM_PrinceLiyangUpgradeBuildingRes(status, msg)
	if status == 0 then
		LiYangKingController.instance:handlePM_PrinceLiyangUpgradeBuildingRes(msg)
	end
end

function LiYangKingAgent:sendPM_PrinceLiyangHandleEventReq(activityId, eventId, optionId)
	local req = PrinceLiyangExtension_pb.PM_PrinceLiyangHandleEventReq()

	req.activityId = activityId
	req.eventId = eventId
	req.optionId = optionId

	self:sendMsg(req)
end

function LiYangKingAgent:handlePM_PrinceLiyangHandleEventRes(status, msg)
	if status == 0 then
		LiYangKingController.instance:handlePM_PrinceLiyangHandleEventRes(msg)
	end
end

function LiYangKingAgent:sendPM_PrinceLiyangOneKeyGainPrizeReq(activityId)
	local req = PrinceLiyangExtension_pb.PM_PrinceLiyangOneKeyGainPrizeReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function LiYangKingAgent:handlePM_PrinceLiyangOneKeyGainPrizeRes(status, msg)
	if status == 0 then
		LiYangKingController.instance:handlePM_PrinceLiyangOneKeyGainPrizeRes(msg)
	end
end

function LiYangKingAgent:handlePM_NotifyPrinceLiyangChangeRes(status, msg)
	if status == 0 then
		LiYangKingController.instance:handlePM_NotifyPrinceLiyangChangeRes(msg)
	end
end

function LiYangKingAgent:sendPM_PrinceLiyangRankInfoReq(activityId)
	local req = PrinceLiyangExtension_pb.PM_PrinceLiyangRankInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function LiYangKingAgent:handlePM_PrinceLiyangRankInfoRes(status, msg)
	if status == 0 then
		LiYangKingController.instance:handlePM_PrinceLiyangRankInfoRes(msg)
	end
end

function LiYangKingAgent:sendPM_PrinceLiyangClgInfoReq(activityId)
	local req = PrinceLiyangExtension_pb.PM_PrinceLiyangClgInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function LiYangKingAgent:handlePM_PrinceLiyangClgInfoRes(status, msg)
	if status == 0 then
		LiYangKingController.instance:handlePM_PrinceLiyangClgInfoRes(msg)
	end
end

function LiYangKingAgent:sendPM_PrinceLiyangClgSelectStarReq(activityId, positionId, star)
	local req = PrinceLiyangExtension_pb.PM_PrinceLiyangClgSelectStarReq()

	req.activityId = activityId
	req.positionId = positionId
	req.star = star

	self:sendMsg(req)
end

function LiYangKingAgent:handlePM_PrinceLiyangClgSelectStarRes(status, msg)
	if status == 0 then
		LiYangKingController.instance:handlePM_PrinceLiyangClgSelectStarRes(msg)
	end
end

function LiYangKingAgent:sendPM_PrinceLiyangClgSelfClgReq(activityId, positionId, form)
	local req = PrinceLiyangExtension_pb.PM_PrinceLiyangClgSelfClgReq()

	req.activityId = activityId
	req.positionId = positionId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function LiYangKingAgent:handlePM_PrinceLiyangClgSelfClgRes(status, msg)
	if status == 0 then
		LiYangKingController.instance:handlePM_PrinceLiyangClgSelfClgRes(msg)
	end
end

function LiYangKingAgent:sendPM_PrinceLiyangClgSeekHelpReq(activityId, positionId)
	local req = PrinceLiyangExtension_pb.PM_PrinceLiyangClgSeekHelpReq()

	req.activityId = activityId
	req.positionId = positionId

	self:sendMsg(req)
end

function LiYangKingAgent:handlePM_PrinceLiyangClgSeekHelpRes(status, msg)
	if status == 0 then
		LiYangKingController.instance:handlePM_PrinceLiyangClgSeekHelpRes(msg)
	end
end

function LiYangKingAgent:sendPM_PrinceLiyangClgResetStarReq(activityId, positionId, star)
	local req = PrinceLiyangExtension_pb.PM_PrinceLiyangClgResetStarReq()

	req.activityId = activityId
	req.positionId = positionId
	req.star = star

	self:sendMsg(req)
end

function LiYangKingAgent:handlePM_PrinceLiyangClgResetStarRes(status, msg)
	if status == 0 then
		LiYangKingController.instance:handlePM_PrinceLiyangClgResetStarRes(msg)
	end
end

function LiYangKingAgent:sendPM_PrinceLiyangClgHelpInfoReq(activityId, otherUserId, positionId, helpId)
	local req = PrinceLiyangExtension_pb.PM_PrinceLiyangClgHelpInfoReq()

	req.activityId = activityId
	req.otherUserId = otherUserId
	req.positionId = positionId
	req.helpId = helpId

	self:sendMsg(req)
end

function LiYangKingAgent:handlePM_PrinceLiyangClgHelpInfoRes(status, msg)
	if status == 0 then
		LiYangKingController.instance:handlePM_PrinceLiyangClgHelpInfoRes(msg)
	end
end

function LiYangKingAgent:sendPM_PrinceLiyangClgHelpCenterReq(activityId, star)
	local req = PrinceLiyangExtension_pb.PM_PrinceLiyangClgHelpCenterReq()

	req.activityId = activityId
	req.star = star

	self:sendMsg(req)
end

function LiYangKingAgent:handlePM_PrinceLiyangClgHelpCenterRes(status, msg)
	if status == 0 then
		LiYangKingController.instance:handlePM_PrinceLiyangClgHelpCenterRes(msg)
	end
end

function LiYangKingAgent:sendPM_PrinceLiyangClgHelpClgReq(activityId, otherUserId, helpId, positionId, form)
	local req = PrinceLiyangExtension_pb.PM_PrinceLiyangClgHelpClgReq()

	req.activityId = activityId
	req.otherUserId = otherUserId
	req.helpId = helpId
	req.positionId = positionId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function LiYangKingAgent:handlePM_PrinceLiyangClgHelpClgRes(status, msg)
	if status == 0 then
		LiYangKingController.instance:handlePM_PrinceLiyangClgHelpClgRes(msg)
	end
end

LiYangKingAgent.instance = LiYangKingAgent.New()

return LiYangKingAgent
