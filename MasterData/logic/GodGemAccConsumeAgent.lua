-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godgemconsume/agent/GodGemAccConsumeAgent.lua

module("logic.extensions.godgemaccconsume.agent.GodGemAccConsumeAgent", package.seeall)

local GodGemAccConsumeAgent = class("GodGemAccConsumeAgent", BaseAgent)

GodGemAccConsumeAgent.PM_GGACGetRankInfoRes = "GodGemAccConsumeAgent_PM_GGACGetRankInfoRes"
GodGemAccConsumeAgent.PM_GGACChangeRecipientInfoRes = "GodGemAccConsumeAgent_PM_GGACChangeRecipientInfoRes"
GodGemAccConsumeAgent.PM_GGACGainProgressPrizeRes = "GodGemAccConsumeAgent_PM_GGACGainProgressPrizeRes"
GodGemAccConsumeAgent.PM_GGACGetActivityInfoRes = "GodGemAccConsumeAgent_PM_GGACGetActivityInfoRes"
GodGemAccConsumeAgent.PM_GGACOneKeyGainPrizeRes = "GodGemAccConsumeAgent_PM_GGACOneKeyGainPrizeRes"

function GodGemAccConsumeAgent:sendPM_GGACGetActivityInfoReq(activityId)
	local req = GodGemAccConsumeExtension_pb.PM_GGACGetActivityInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function GodGemAccConsumeAgent:handlePM_GGACGetActivityInfoRes(status, msg)
	if status == 0 then
		-- block empty
	end

	self:dispatch(GodGemAccConsumeAgent.PM_GGACGetActivityInfoRes, status, msg)
end

function GodGemAccConsumeAgent:sendPM_GGACGainProgressPrizeReq(activityId, prizeId)
	local req = GodGemAccConsumeExtension_pb.PM_GGACGainProgressPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function GodGemAccConsumeAgent:handlePM_GGACGainProgressPrizeRes(status, msg)
	if status == 0 then
		-- block empty
	end

	self:dispatch(GodGemAccConsumeAgent.PM_GGACGainProgressPrizeRes, status, msg)
end

function GodGemAccConsumeAgent:sendPM_GGACOneKeyGainPrizeReq(activityId, prizeIds)
	local req = GodGemAccConsumeExtension_pb.PM_GGACOneKeyGainPrizeReq()

	req.activityId = activityId

	for i, v in ipairs(prizeIds) do
		req.prizeIds:append(v)
	end

	self:sendMsg(req)
end

function GodGemAccConsumeAgent:handlePM_GGACOneKeyGainPrizeRes(status, msg)
	if status == 0 then
		GodgemconsumeController.instance:PM_GGACOneKeyGainPrizeRes(status, msg)
	end
end

function GodGemAccConsumeAgent:sendPM_GGACChangeRecipientInfoReq(activityId, recipientInfo)
	local req = GodGemAccConsumeExtension_pb.PM_GGACChangeRecipientInfoReq()

	req.activityId = activityId
	req.recipientInfo.recipient = recipientInfo.recipient
	req.recipientInfo.telephone = recipientInfo.telephone
	req.recipientInfo.qq = recipientInfo.qq
	req.recipientInfo.province = recipientInfo.province
	req.recipientInfo.city = recipientInfo.city
	req.recipientInfo.area = recipientInfo.area
	req.recipientInfo.addressDetail = recipientInfo.addressDetail

	self:sendMsg(req)
end

function GodGemAccConsumeAgent:handlePM_GGACChangeRecipientInfoRes(status, msg)
	if status == 0 then
		-- block empty
	end

	self:dispatch(GodGemAccConsumeAgent.PM_GGACChangeRecipientInfoRes, status, msg)
end

function GodGemAccConsumeAgent:sendPM_GGACGetRankInfoReq(activityId)
	local req = GodGemAccConsumeExtension_pb.PM_GGACGetRankInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function GodGemAccConsumeAgent:handlePM_GGACGetRankInfoRes(status, msg)
	if status == 0 then
		-- block empty
	end

	self:dispatch(GodGemAccConsumeAgent.PM_GGACGetRankInfoRes, status, msg)
end

function GodGemAccConsumeAgent:sendPM_GGACGetCostRankInfoReq(activityId)
	local req = GodGemAccConsumeExtension_pb.PM_GGACGetCostRankInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function GodGemAccConsumeAgent:handlePM_GGACGetCostRankInfoRes(status, msg)
	if status == 0 then
		AccumulateChargeController.instance:handleGetRankInfo(msg)
	end
end

GodGemAccConsumeAgent.instance = GodGemAccConsumeAgent.New()

return GodGemAccConsumeAgent
