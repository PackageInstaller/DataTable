-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/puzzlegame/agent/PuzzleGameAgent.lua

module("logic.extensions.puzzlegame.agent.PuzzleGameAgent", package.seeall)

local PuzzleGameAgent = class("PuzzleGameAgent", BaseAgent)

function PuzzleGameAgent:sendPM_PuzzleGameGetInfoReq(actId)
	local req = PuzzleGameExtension_pb.PM_PuzzleGameGetInfoReq()

	req.actId = actId

	self:sendMsg(req)
end

function PuzzleGameAgent:handlePM_PuzzleGameGetInfoRes(status, msg)
	if status == 0 then
		PuzzleGameController.instance:handleGetInfo(msg)
	end
end

function PuzzleGameAgent:sendPM_PuzzleGameStartGameReq(actId, jigsawId, clientKey)
	local req = PuzzleGameExtension_pb.PM_PuzzleGameStartGameReq()

	req.actId = actId
	req.jigsawId = jigsawId
	req.clientKey = clientKey

	self:sendMsg(req)
end

function PuzzleGameAgent:handlePM_PuzzleGameStartGameRes(status, msg)
	if status == 0 then
		PuzzleGameController.instance:handleStartGame(msg)
	end
end

function PuzzleGameAgent:sendPM_PuzzleGameEndGameReq(isPass, clientEncryptedKey)
	local req = PuzzleGameExtension_pb.PM_PuzzleGameEndGameReq()

	req.isPass = isPass
	req.clientEncryptedKey = clientEncryptedKey

	self:sendMsg(req)
end

function PuzzleGameAgent:handlePM_PuzzleGameEndGameRes(status, msg)
	if status == 0 then
		PuzzleGameController.instance:handleEndGame(msg)
	end
end

function PuzzleGameAgent:sendPM_PuzzleGameGainJigsawPrizeReq(actId, jigsawId)
	local req = PuzzleGameExtension_pb.PM_PuzzleGameGainJigsawPrizeReq()

	req.actId = actId
	req.jigsawId = jigsawId

	self:sendMsg(req)
end

function PuzzleGameAgent:handlePM_PuzzleGameGainJigsawPrizeRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function PuzzleGameAgent:sendPM_PuzzleGameGainProgressPrizeReq(actId, progressId)
	local req = PuzzleGameExtension_pb.PM_PuzzleGameGainProgressPrizeReq()

	req.actId = actId
	req.progressId = progressId

	self:sendMsg(req)
end

function PuzzleGameAgent:handlePM_PuzzleGameGainProgressPrizeRes(status, msg)
	if status == 0 then
		PuzzleGameController.instance:handleGainProgressPrize(msg)
	end
end

PuzzleGameAgent.instance = PuzzleGameAgent.New()

return PuzzleGameAgent
