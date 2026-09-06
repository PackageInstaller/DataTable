-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yirenpozhen/agent/TheOutcastChallengeAgent.lua

module("logic.extensions.theoutcastchallenge.agent.TheOutcastChallengeAgent", package.seeall)

local TheOutcastChallengeAgent = class("TheOutcastChallengeAgent", BaseAgent)

function TheOutcastChallengeAgent:sendPM_TheOutcastChallengeInfoReq()
	local req = TheOutcastChallengeExtension_pb.PM_TheOutcastChallengeInfoReq()

	self:sendMsg(req)
end

function TheOutcastChallengeAgent:handlePM_TheOutcastChallengeInfoRes(status, msg)
	if status == 0 then
		YirenPozhenController.instance:handleInfo(msg, status)
	end
end

function TheOutcastChallengeAgent:sendPM_TheOutcastChallengeReq()
	local req = TheOutcastChallengeExtension_pb.PM_TheOutcastChallengeReq()

	self:sendMsg(req)
end

function TheOutcastChallengeAgent:handlePM_TheOutcastChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, -1)
	end
end

function TheOutcastChallengeAgent:sendPM_TheOutcastChallengeGameReq(gameId, clientKey)
	local req = TheOutcastChallengeExtension_pb.PM_TheOutcastChallengeGameReq()

	req.gameId = gameId
	req.clientKey = clientKey

	self:sendMsg(req)
end

function TheOutcastChallengeAgent:handlePM_TheOutcastChallengeGameRes(status, msg)
	if status == 0 then
		local serverkey = msg.serverKey
		local beststepnum = msg.bestStepNum

		YirenPozhenModel.instance:setServerKey(serverkey)
		YirenPozhenModel.instance:setBestStepNum(beststepnum)
		GlobalDispatcher:dispatch(GlobalNotify.HexagramGameStart)
	end
end

function TheOutcastChallengeAgent:sendPM_TheOutcastChallengeEndGameReq(pass, gameId, encryptedKey, stepNum)
	local req = TheOutcastChallengeExtension_pb.PM_TheOutcastChallengeEndGameReq()

	req.pass = pass
	req.gameId = gameId
	req.encryptedKey = encryptedKey
	req.stepNum = stepNum

	self:sendMsg(req)
end

function TheOutcastChallengeAgent:handlePM_TheOutcastChallengeEndGameRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function TheOutcastChallengeAgent:sendPM_TheOutcastChallengeRankInfoReq()
	local req = TheOutcastChallengeExtension_pb.PM_TheOutcastChallengeRankInfoReq()

	self:sendMsg(req)
end

function TheOutcastChallengeAgent:handlePM_TheOutcastChallengeRankInfoRes(status, msg)
	if status == 0 then
		local rank = msg.rank
		local myRank = msg.myRank

		GlobalDispatcher:dispatch(GlobalNotify.HexagramGameRank, rank, myRank)
	end
end

function TheOutcastChallengeAgent:handlePM_NotifyAfterChallengeRes(status, msg)
	if status == 0 then
		YirenPozhenController.instance:onNotifyAfterChallengeRes(status, msg)
	end
end

TheOutcastChallengeAgent.instance = TheOutcastChallengeAgent.New()

return TheOutcastChallengeAgent
