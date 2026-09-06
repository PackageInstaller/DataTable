-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yanmobestpartner/agent/CollectSummoningAgent.lua

module("logic.extensions.yanmobestpartner.agent.CollectSummoningAgent", package.seeall)

local CollectSummoningAgent = class("CollectSummoningAgent", BaseAgent)

function CollectSummoningAgent:sendPM_CollectSummoningGetInfoReq(activityId)
	local req = CollectSummoningExtension_pb.PM_CollectSummoningGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function CollectSummoningAgent:handlePM_CollectSummoningGetInfoRes(status, msg)
	if status == 0 then
		YanmoBestPartnerModel.instance:setInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.YanmoBestPartnerGainPrizeRes)
	end
end

function CollectSummoningAgent:sendPM_CollectSummoningGainPrizeReq(activityId, prizeId)
	local req = CollectSummoningExtension_pb.PM_CollectSummoningGainPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function CollectSummoningAgent:handlePM_CollectSummoningGainPrizeRes(status, msg)
	if status == 0 then
		YanmoBestPartnerModel.instance:setGainedPrizeMap(msg)
		GlobalDispatcher:dispatch(GlobalNotify.YanmoBestPartnerGainPrizeRes)
	end
end

CollectSummoningAgent.instance = CollectSummoningAgent.New()

return CollectSummoningAgent
