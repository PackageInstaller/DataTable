-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/collectclothes/agent/CollectClothesAgent.lua

module("logic.extensions.collectclothes.agent.CollectClothesAgent", package.seeall)

local CollectClothesAgent = class("CollectClothesAgent", BaseAgent)

function CollectClothesAgent:sendPM_CollectClothesInfoReq(activityId)
	local req = CollectClothesExtension_pb.PM_CollectClothesInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function CollectClothesAgent:handlePM_CollectClothesInfoRes(status, msg)
	CollectClothesController.instance:handleInfoRes(status, msg)
end

function CollectClothesAgent:sendPM_CollectClothesGainPrizeReq(activityId, prizeId)
	local req = CollectClothesExtension_pb.PM_CollectClothesGainPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function CollectClothesAgent:handlePM_CollectClothesGainPrizeRes(status, msg)
	CollectClothesController.instance:handleGainPrizeRes(status, msg)
end

CollectClothesAgent.instance = CollectClothesAgent.New()

return CollectClothesAgent
