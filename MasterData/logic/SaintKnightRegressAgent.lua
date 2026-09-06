-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/saintknightregress/agent/SaintKnightRegressAgent.lua

module("logic.extensions.saintknightregress.agent.SaintKnightRegressAgent", package.seeall)

local SaintKnightRegressAgent = class("SaintKnightRegressAgent", BaseAgent)

function SaintKnightRegressAgent:sendPM_SaintKnightRegressGetInfoReq(activityId)
	local req = SaintKnightRegressExtension_pb.PM_SaintKnightRegressGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function SaintKnightRegressAgent:handlePM_SaintKnightRegressGetInfoRes(status, msg)
	if status == 0 then
		SaintKnightRegressController.instance:handlePM_SaintKnightRegressGetInfoRes(msg)
	end
end

function SaintKnightRegressAgent:sendPM_SaintKnightRegressGainPrizeReq(activityId, partnerPrizeList, prizeIds)
	local req = SaintKnightRegressExtension_pb.PM_SaintKnightRegressGainPrizeReq()

	req.activityId = activityId
	req.partnerPrizeList = partnerPrizeList
	req.prizeIds = prizeIds

	self:sendMsg(req)
end

function SaintKnightRegressAgent:handlePM_SaintKnightRegressGainPrizeRes(status, msg)
	if status == 0 then
		SaintKnightRegressController.instance:handlePM_SaintKnightRegressGainPrizeRes(msg)
	end
end

function SaintKnightRegressAgent:sendPM_SaintKnightRegressLotteryReq(activityId)
	local req = SaintKnightRegressExtension_pb.PM_SaintKnightRegressLotteryReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function SaintKnightRegressAgent:handlePM_SaintKnightRegressLotteryRes(status, msg)
	if status == 0 then
		SaintKnightRegressController.instance:handlePM_SaintKnightRegressLotteryRes(msg)
	end
end

function SaintKnightRegressAgent:sendPM_SaintKnightRegressFillMsgReq(activityId, msg)
	local req = SaintKnightRegressExtension_pb.PM_SaintKnightRegressFillMsgReq()

	req.activityId = activityId

	req.msg:ParseFromString(msg:SerializeToString())
	self:sendMsg(req)
end

function SaintKnightRegressAgent:handlePM_SaintKnightRegressFillMsgRes(status, msg)
	if status == 0 then
		SaintKnightRegressController.instance:handlePM_SaintKnightRegressFillMsgRes(msg)
	end
end

function SaintKnightRegressAgent:sendPM_SaintKnightRegressBindCodeReq(activityId, inviteCode)
	local req = SaintKnightRegressExtension_pb.PM_SaintKnightRegressBindCodeReq()

	req.activityId = activityId
	req.inviteCode = inviteCode

	self:sendMsg(req)
end

function SaintKnightRegressAgent:handlePM_SaintKnightRegressBindCodeRes(status, msg)
	if status == 0 then
		SaintKnightRegressController.instance:handlePM_SaintKnightRegressBindCodeRes(msg)
	end
end

function SaintKnightRegressAgent:sendPM_SaintKnightRegressOneKeyGainPrizeReq(activityId)
	local req = SaintKnightRegressExtension_pb.PM_SaintKnightRegressOneKeyGainPrizeReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function SaintKnightRegressAgent:handlePM_SaintKnightRegressOneKeyGainPrizeRes(status, msg)
	if status == 0 then
		SaintKnightRegressController.instance:handlePM_SaintKnightRegressOneKeyGainPrizeRes(msg)
	end
end

function SaintKnightRegressAgent:sendPM_SaintKnightRegressGetTaskInfoReq(activityId, playerId)
	local req = SaintKnightRegressExtension_pb.PM_SaintKnightRegressGetTaskInfoReq()

	req.activityId = activityId
	req.playerId = playerId

	self:sendMsg(req)
end

function SaintKnightRegressAgent:handlePM_SaintKnightRegressGetTaskInfoRes(status, msg)
	if status == 0 then
		SaintKnightRegressController.instance:handlePM_SaintKnightRegressGetTaskInfoRes(msg)
	end
end

SaintKnightRegressAgent.instance = SaintKnightRegressAgent.New()

return SaintKnightRegressAgent
