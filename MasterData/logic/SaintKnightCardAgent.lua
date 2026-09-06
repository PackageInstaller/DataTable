-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/saintknightcard/agent/SaintKnightCardAgent.lua

module("logic.extensions.saintknightcard.agent.SaintKnightCardAgent", package.seeall)

local SaintKnightCardAgent = class("SaintKnightCardAgent", BaseAgent)

function SaintKnightCardAgent:sendPM_SaintKnightCardGetInfoReq(actId)
	local req = SaintKnightCardExtension_pb.PM_SaintKnightCardGetInfoReq()

	req.actId = actId

	self:sendMsg(req)
end

function SaintKnightCardAgent:handlePM_SaintKnightCardGetInfoRes(status, msg)
	if status == 0 then
		SaintKnightCardController.instance:handleSaintKnightCardGetInfoRes(msg)
	end
end

function SaintKnightCardAgent:sendPM_SaintKnightCardGetRankInfoReq(actId, drawPlanId, groupId)
	local req = SaintKnightCardExtension_pb.PM_SaintKnightCardGetRankInfoReq()

	req.actId = actId
	req.drawPlanId = drawPlanId
	req.groupId = groupId

	self:sendMsg(req)
end

function SaintKnightCardAgent:handlePM_SaintKnightCardGetRankInfoRes(status, msg)
	if status == 0 then
		SaintKnightCardController.instance:handleSaintKnightCardGetRankInfoRes(msg)
	end
end

function SaintKnightCardAgent:sendPM_SaintKnightCardDrawReq(actId, drawPlanId, groupId)
	local req = SaintKnightCardExtension_pb.PM_SaintKnightCardDrawReq()

	req.actId = actId
	req.drawPlanId = drawPlanId
	req.groupId = groupId

	self:sendMsg(req)
end

function SaintKnightCardAgent:handlePM_SaintKnightCardDrawRes(status, msg)
	SaintKnightCardController.instance:handleSaintKnightCardDrawRes(status, msg)
end

function SaintKnightCardAgent:sendPM_SaintKnightCardGetRecordReq(actId)
	local req = SaintKnightCardExtension_pb.PM_SaintKnightCardGetRecordReq()

	req.actId = actId

	self:sendMsg(req)
end

function SaintKnightCardAgent:handlePM_SaintKnightCardGetRecordRes(status, msg)
	if status == 0 then
		SaintKnightCardController.instance:handleSaintKnightCardGetRecordRes(msg)
	end
end

function SaintKnightCardAgent:sendPM_SaintKnightCardGainExPrizeReq(actId, drawPlanId)
	local req = SaintKnightCardExtension_pb.PM_SaintKnightCardGainExPrizeReq()

	req.actId = actId
	req.drawPlanId = drawPlanId

	self:sendMsg(req)
end

function SaintKnightCardAgent:handlePM_SaintKnightCardGainExPrizeRes(status, msg)
	if status == 0 then
		SaintKnightCardController.instance:handleSaintKnightCardGainExPrizeRes(msg)
	end
end

function SaintKnightCardAgent:handlePM_SaintKnightCardNotifyRes(status, msg)
	if status == 0 then
		SaintKnightCardController.instance:handleSaintKnightCardNotifyRes(msg)
	end
end

function SaintKnightCardAgent:sendPM_SaintKnightCardGainBuyReq(actId, drawPlanId)
	local req = SaintKnightCardExtension_pb.PM_SaintKnightCardGainBuyReq()

	req.actId = actId
	req.drawPlanId = drawPlanId

	self:sendMsg(req)
end

function SaintKnightCardAgent:handlePM_SaintKnightCardGainBuyRes(status, msg)
	if status == 0 then
		SaintKnightCardController.instance:handleSaintKnightCardGainBuyRes(msg)
	end
end

SaintKnightCardAgent.instance = SaintKnightCardAgent.New()

return SaintKnightCardAgent
