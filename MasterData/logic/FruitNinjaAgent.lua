-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fruitninja/agent/FruitNinjaAgent.lua

module("logic.extensions.fruitninja.agent.FruitNinjaAgent", package.seeall)

local FruitNinjaAgent = class("FruitNinjaAgent", BaseAgent)

function FruitNinjaAgent:sendPM_FruitNinjaGetInfoReq(activityId)
	local req = FruitNinjaExtension_pb.PM_FruitNinjaGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function FruitNinjaAgent:handlePM_FruitNinjaGetInfoRes(status, msg)
	if status == 0 then
		FruitNinjaController.instance:handlePM_FruitNinjaGetInfoRes(msg)
	end
end

function FruitNinjaAgent:sendPM_FruitNinjaStartGameReq(activityId, mode, clientKey)
	local req = FruitNinjaExtension_pb.PM_FruitNinjaStartGameReq()

	req.activityId = activityId
	req.mode = mode
	req.clientKey = clientKey

	self:sendMsg(req)
end

function FruitNinjaAgent:handlePM_FruitNinjaStartGameRes(status, msg)
	FruitNinjaController.instance:handlePM_FruitNinjaStartGameRes(status, msg)
end

function FruitNinjaAgent:sendPM_FruitNinjaEndGameReq(activityId, mode, score, encryptedKey)
	local req = FruitNinjaExtension_pb.PM_FruitNinjaEndGameReq()

	req.activityId = activityId
	req.mode = mode
	req.score = score
	req.encryptedKey = encryptedKey

	self:sendMsg(req)
end

function FruitNinjaAgent:handlePM_FruitNinjaEndGameRes(status, msg)
	if status == 0 then
		FruitNinjaController.instance:handlePM_FruitNinjaEndGameRes(msg)
	end
end

function FruitNinjaAgent:sendPM_FruitNinjaGainPrizeReq(activityId, prizeId)
	local req = FruitNinjaExtension_pb.PM_FruitNinjaGainPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function FruitNinjaAgent:handlePM_FruitNinjaGainPrizeRes(status, msg)
	if status == 0 then
		FruitNinjaController.instance:handlePM_FruitNinjaGainPrizeRes(msg)
	end
end

function FruitNinjaAgent:sendPM_FruitNinjaViewRankReq(activityId)
	local req = FruitNinjaExtension_pb.PM_FruitNinjaViewRankReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function FruitNinjaAgent:handlePM_FruitNinjaViewRankRes(status, msg)
	if status == 0 then
		FruitNinjaController.instance:handlePM_FruitNinjaViewRankRes(msg)
	end
end

FruitNinjaAgent.instance = FruitNinjaAgent.New()

return FruitNinjaAgent
