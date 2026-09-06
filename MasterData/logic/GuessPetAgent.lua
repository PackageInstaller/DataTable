-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guesspets/agent/GuessPetAgent.lua

module("logic.extensions.guesspets.agent.GuessPetAgent", package.seeall)

local GuessPetAgent = class("GuessPetAgent", BaseAgent)

function GuessPetAgent:sendPM_GetGuessGameInfoReq(activityId)
	local req = GuessGameExtension_pb.PM_GetGuessGameInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function GuessPetAgent:handlePM_GetGuessGameInfoRes(status, msg)
	if status == 0 then
		GuessPetController.instance:onActivityInfo(msg)
	end
end

function GuessPetAgent:sendPM_GainGuessGamePersonPrizeReq(activityId, prizeId)
	local req = GuessGameExtension_pb.PM_GainGuessGamePersonPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function GuessPetAgent:handlePM_GainGuessGamePersonPrizeRes(status, msg)
	GuessPetController.instance:onGainPersonPrize(status, msg)
end

function GuessPetAgent:sendPM_GainGuessGameGlobalPrizeReq(activityId, prizeId)
	local req = GuessGameExtension_pb.PM_GainGuessGameGlobalPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function GuessPetAgent:handlePM_GainGuessGameGlobalPrizeRes(status, msg)
	GuessPetController.instance:onGainGlobalPrize(status, msg)
end

function GuessPetAgent:sendPM_GuessGameMatchReq(actId)
	local req = GuessGameExtension_pb.PM_GuessGameMatchReq()

	req.actId = actId

	self:sendMsg(req)
end

function GuessPetAgent:handlePM_GuessGameMatchRes(status, msg)
	GuessPetController.instance:onMatchingPlayers(status, msg)
end

function GuessPetAgent:sendPM_GuessGameCancelMatchReq()
	local req = GuessGameExtension_pb.PM_GuessGameCancelMatchReq()

	self:sendMsg(req)
end

function GuessPetAgent:handlePM_GuessGameCancelMatchRes(status, msg)
	if status == 0 then
		GuessPetController.instance:onCancelMatchingPlayers()
	end
end

function GuessPetAgent:sendPM_GuessGameGuessPictureReq(guessId)
	local req = GuessGameExtension_pb.PM_GuessGameGuessPictureReq()

	req.guessId = guessId

	self:sendMsg(req)
end

function GuessPetAgent:handlePM_GuessGameGuessPictureRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function GuessPetAgent:sendPM_GuessGameLeaveGameReq()
	local req = GuessGameExtension_pb.PM_GuessGameLeaveGameReq()

	self:sendMsg(req)
end

function GuessPetAgent:handlePM_GuessGameLeaveGameRes(status, msg)
	if status == 0 then
		GuessPetController.instance:onGuessGameExit()
	end
end

function GuessPetAgent:handlePM_GuessGameAbortRes(status, msg)
	if status == 0 then
		GuessPetController.instance:onGuessGameAbort()
	end
end

function GuessPetAgent:handlePM_GuessGameGameStartRes(status, msg)
	if status == 0 then
		GuessPetController.instance:enterGuessGame(msg)
	end
end

function GuessPetAgent:handlePM_GuessGameNextProblemRes(status, msg)
	if status == 0 then
		GuessPetController.instance:onNextQuestion(msg)
	end
end

function GuessPetAgent:handlePM_GuessGamePlayerGuessRes(status, msg)
	if status == 0 then
		GuessPetController.instance:onGuessGamePlayerGuess(msg)
	end
end

function GuessPetAgent:handlePM_GuessGameNotifyLeaveGameRes(status, msg)
	if status == 0 then
		GuessPetController.instance:onGuessGameNotifyLeaveGame(msg)
	end
end

function GuessPetAgent:handlePM_GuessGameEndRes(status, msg)
	if status == 0 then
		GuessPetController.instance:onGuessGameEnd(msg)
	end
end

function GuessPetAgent:handlePM_GuessGameQueueChangeRes(status, msg)
	if status == 0 then
		GuessPetController.instance:onNotifyGuessGameQueueChange(msg.players)
	end
end

GuessPetAgent.instance = GuessPetAgent.New()

return GuessPetAgent
