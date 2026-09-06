-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guessbox/agent/GuessBoxAgent.lua

module("logic.extensions.guessbox.agent.GuessBoxAgent", package.seeall)

local GuessBoxAgent = class("GuessBoxAgent", BaseAgent)

function GuessBoxAgent:ctor()
	return
end

function GuessBoxAgent:sendPM_GuessBoxGameGetInfoReq(activityId)
	local req = GuessBoxGameExtension_pb.PM_GuessBoxGameGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function GuessBoxAgent:handlePM_GuessBoxGameGetInfoRes(status, msg)
	if status == 0 then
		GuessBoxController.instance:onHandleGuessBoxGameGetInfoRes(msg)
	end
end

function GuessBoxAgent:sendPM_GuessBoxGameStartGameReq(activityId, clientKey)
	local req = GuessBoxGameExtension_pb.PM_GuessBoxGameStartGameReq()

	req.activityId = activityId
	req.clientKey = clientKey

	self:sendMsg(req)
end

function GuessBoxAgent:handlePM_GuessBoxGameStartGameRes(status, msg)
	if status == 0 then
		GuessBoxController.instance:onHandleGuessBoxGameStartGameRes(msg)
	end
end

function GuessBoxAgent:sendPM_GuessBoxGameEndGameReq(flowerIds, score, encryptedKey)
	local req = GuessBoxGameExtension_pb.PM_GuessBoxGameEndGameReq()

	for _, id in ipairs(flowerIds) do
		req.flowerIds:append(id)
	end

	req.score = score
	req.encryptedKey = encryptedKey

	self:sendMsg(req)
end

function GuessBoxAgent:handlePM_GuessBoxGameEndGameRes(status, msg)
	if status == 0 then
		GuessBoxController.instance:onHandleGuessBoxGameEndGameRes(msg)
	end
end

function GuessBoxAgent:sendPM_GuessBoxGameGainScorePrizeReq(activityId, prizeId)
	local req = GuessBoxGameExtension_pb.PM_GuessBoxGameGainScorePrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function GuessBoxAgent:handlePM_GuessBoxGameGainScorePrizeRes(status, msg)
	if status == 0 then
		GuessBoxController.instance:onHandleGuessBoxGameGainScorePrizeRes(msg)
	end
end

function GuessBoxAgent:sendPM_GuessBoxGameRankInfoReq(activityId)
	local req = GuessBoxGameExtension_pb.PM_GuessBoxGameRankInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function GuessBoxAgent:handlePM_GuessBoxGameRankInfoRes(status, msg)
	if status == 0 then
		GuessBoxController.instance:onHandleGuessBoxGameRankInfoRes(msg)
	end
end

GuessBoxAgent.instance = GuessBoxAgent.New()

return GuessBoxAgent
