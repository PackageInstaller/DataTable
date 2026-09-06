-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nailonglottery/agent/ShareLotteryAgent.lua

module("logic.extensions.nailonglottery.agent.ShareLotteryAgent", package.seeall)

local ShareLotteryAgent = class("ShareLotteryAgent", BaseAgent)

function ShareLotteryAgent:sendPM_ShareLotteryGetInfoReq(activityId)
	local req = ShareLotteryExtension_pb.PM_ShareLotteryGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ShareLotteryAgent:handlePM_ShareLotteryGetInfoRes(status, msg)
	if status == 0 then
		NaiLongLotteryController.instance:handlePM_ShareLotteryGetInfoRes(msg)
	end
end

function ShareLotteryAgent:sendPM_ShareLotteryLotteryReq(activityId)
	local req = ShareLotteryExtension_pb.PM_ShareLotteryLotteryReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ShareLotteryAgent:handlePM_ShareLotteryLotteryRes(status, msg)
	NaiLongLotteryController.instance:handlePM_ShareLotteryLotteryRes(status, msg)
end

function ShareLotteryAgent:sendPM_ShareLotteryShareReq(activityId)
	local req = ShareLotteryExtension_pb.PM_ShareLotteryShareReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ShareLotteryAgent:handlePM_ShareLotteryShareRes(status, msg)
	if status == 0 then
		NaiLongLotteryController.instance:handlePM_ShareLotteryShareRes(msg)
	end
end

function ShareLotteryAgent:sendPM_ShareLotteryGainPrizeReq(activityId, prizeIds)
	local req = ShareLotteryExtension_pb.PM_ShareLotteryGainPrizeReq()

	req.activityId = activityId

	for _, v in ipairs(prizeIds) do
		req.prizeIds:append(v)
	end

	self:sendMsg(req)
end

function ShareLotteryAgent:handlePM_ShareLotteryGainPrizeRes(status, msg)
	if status == 0 then
		NaiLongLotteryController.instance:handlePM_ShareLotteryGainPrizeRes(msg)
	end
end

ShareLotteryAgent.instance = ShareLotteryAgent.New()

return ShareLotteryAgent
