-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/triplemacthesgame/agent/TripleMatchesGameAgent.lua

module("logic.extensions.triplematchesgame.agent.TripleMatchesGameAgent", package.seeall)

local TripleMatchesGameAgent = class("TripleMatchesGameAgent", BaseAgent)

function TripleMatchesGameAgent:sendPM_TripleMatchesGameGetInfoReq(activityId)
	local req = TripleMatchesGameExtension_pb.PM_TripleMatchesGameGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function TripleMatchesGameAgent:handlePM_TripleMatchesGameGetInfoRes(status, msg)
	if status == 0 then
		TripleMachesGameController.instance:handlePM_TripleMatchesGameGetInfoRes(msg)
	end
end

function TripleMatchesGameAgent:sendPM_TripleMatchesGameStartGameReq(activityId, clientKey)
	local req = TripleMatchesGameExtension_pb.PM_TripleMatchesGameStartGameReq()

	req.activityId = activityId
	req.clientKey = clientKey

	self:sendMsg(req)
end

function TripleMatchesGameAgent:handlePM_TripleMatchesGameStartGameRes(status, msg)
	if status == 0 then
		TripleMachesGameController.instance:handlePM_TripleMatchesGameStartGameRes(msg)
	end
end

function TripleMatchesGameAgent:sendPM_TripleMatchesGameEndGameReq(activityId, stageId, score, save, encryptedKey)
	local req = TripleMatchesGameExtension_pb.PM_TripleMatchesGameEndGameReq()

	req.activityId = activityId
	req.stageId = stageId
	req.score = score
	req.save = save
	req.encryptedKey = encryptedKey

	self:sendMsg(req)
end

function TripleMatchesGameAgent:handlePM_TripleMatchesGameEndGameRes(status, msg)
	if status == 0 then
		TripleMachesGameController.instance:handlePM_TripleMatchesGameEndGameRes(msg)
	end
end

function TripleMatchesGameAgent:sendPM_TripleMatchesGameBuyStepReq(activityId, buyStepCount)
	local req = TripleMatchesGameExtension_pb.PM_TripleMatchesGameBuyStepReq()

	req.activityId = activityId
	req.buyStepCount = buyStepCount

	self:sendMsg(req)
end

function TripleMatchesGameAgent:handlePM_TripleMatchesGameBuyStepRes(status, msg)
	if status == 0 then
		TripleMachesGameController.instance:handlePM_TripleMatchesGameBuyStepRes(msg)
	end
end

function TripleMatchesGameAgent:sendPM_TripleMatchesGameRankViewReq(activityId)
	local req = TripleMatchesGameExtension_pb.PM_TripleMatchesGameRankViewReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function TripleMatchesGameAgent:handlePM_TripleMatchesGameRankViewRes(status, msg)
	if status == 0 then
		TripleMachesGameController.instance:handlePM_TripleMatchesGameRankViewRes(msg)
	end
end

function TripleMatchesGameAgent:sendPM_TripleMatchesGameGainPrizeReq(activityId, prizeId)
	local req = TripleMatchesGameExtension_pb.PM_TripleMatchesGameGainPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function TripleMatchesGameAgent:handlePM_TripleMatchesGameGainPrizeRes(status, msg)
	if status == 0 then
		local activityId = msg.activityId
		local prizeId = msg.prizeId

		TripleMacthesModel.instance:updateGainPrizeId(activityId, prizeId)
		GlobalDispatcher:dispatch(GlobalNotify.TripleMatchesGameGainPrizeRes)
	end
end

function TripleMatchesGameAgent:sendPM_TripleMatchesGameSweepReq(activityId, times)
	local req = TripleMatchesGameExtension_pb.PM_TripleMatchesGameSweepReq()

	req.activityId = activityId
	req.times = times

	self:sendMsg(req)
end

function TripleMatchesGameAgent:handlePM_TripleMatchesGameSweepRes(status, msg)
	if status == 0 then
		TripleMachesGameController.instance:handlePM_TripleMatchesGameSweepRes(msg)
	end
end

TripleMatchesGameAgent.instance = TripleMatchesGameAgent.New()

return TripleMatchesGameAgent
