-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/giftbox/agent/GiftBoxAgent.lua

module("logic.extensions.giftbox.agent.GiftBoxAgent", package.seeall)

local GiftBoxAgent = class("GiftBoxAgent", BaseAgent)

function GiftBoxAgent:sendGB_GiftBoxGetInfoReq(actId)
	local req = GiftBoxExtension_pb.GB_GiftBoxGetInfoReq()

	req.actId = actId

	self:sendMsg(req)
end

function GiftBoxAgent:handleGB_GiftBoxGetInfoRes(status, msg)
	if status == 0 then
		GiftBoxController.instance:handleGB_GiftBoxGetInfoRes(status, msg)
	end
end

function GiftBoxAgent:sendGB_GiftBoxOpenBoxReq(actId, poolId, boxId)
	local req = GiftBoxExtension_pb.GB_GiftBoxOpenBoxReq()

	req.actId = actId
	req.poolId = poolId
	req.boxId = boxId

	self:sendMsg(req)
end

function GiftBoxAgent:handleGB_GiftBoxOpenBoxRes(status, msg)
	if status == 0 then
		GiftBoxController.instance:handleGB_GiftBoxOpenBoxRes(status, msg)
	end
end

function GiftBoxAgent:sendGB_GiftBoxShareLuckReq(actId, buddyIds)
	local req = GiftBoxExtension_pb.GB_GiftBoxShareLuckReq()

	req.actId = actId

	if buddyIds then
		for i, v in ipairs(buddyIds) do
			req.buddyIds:append(v)
		end
	end

	self:sendMsg(req)
end

function GiftBoxAgent:handleGB_GiftBoxShareLuckRes(status, msg)
	if status == 0 then
		GiftBoxController.instance:handleGB_GiftBoxShareLuckRes(status, msg)
	end
end

function GiftBoxAgent:sendGB_GiftBoxGainLuckReq(actId, targetId)
	local req = GiftBoxExtension_pb.GB_GiftBoxGainLuckReq()

	req.actId = actId
	req.targetId = targetId

	self:sendMsg(req)
end

function GiftBoxAgent:handleGB_GiftBoxGainLuckRes(status, msg)
	GiftBoxController.instance:handleGB_GiftBoxGainLuckRes(status, msg)
end

function GiftBoxAgent:sendGB_GiftBoxShareListReq(actId)
	local req = GiftBoxExtension_pb.GB_GiftBoxShareListReq()

	req.actId = actId

	self:sendMsg(req)
end

function GiftBoxAgent:handleGB_GiftBoxShareListRes(status, msg)
	if status == 0 then
		GiftBoxController.instance:handleGB_GiftBoxShareListRes(status, msg)
	end
end

function GiftBoxAgent:sendGB_GiftBoxGainSharePrizeReq(actId, prizeId)
	local req = GiftBoxExtension_pb.GB_GiftBoxGainSharePrizeReq()

	req.actId = actId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function GiftBoxAgent:handleGB_GiftBoxGainSharePrizeRes(status, msg)
	if status == 0 then
		GiftBoxController.instance:handleGB_GiftBoxGainSharePrizeRes(status, msg)
	end
end

GiftBoxAgent.instance = GiftBoxAgent.New()

return GiftBoxAgent
