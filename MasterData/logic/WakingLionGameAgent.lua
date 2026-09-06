-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lionculture/agent/WakingLionGameAgent.lua

module("logic.extensions.wakingliongame.agent.WakingLionGameAgent", package.seeall)

local WakingLionGameAgent = class("WakingLionGameAgent", BaseAgent)

WakingLionGameAgent.handlePM_WakingLionGameStartGameRes = "handlePM_WakingLionGameStartGameRes"

function WakingLionGameAgent:sendPM_WakingLionGameGetInfoReq(actId)
	local req = WakingLionGameExtension_pb.PM_WakingLionGameGetInfoReq()

	req.actId = actId

	self:sendMsg(req)
end

function WakingLionGameAgent:handlePM_WakingLionGameGetInfoRes(status, msg)
	if status == 0 then
		local gamelist = msg.gameList

		LioncultureModel.instance:SetGamesData(gamelist)
		GlobalDispatcher:dispatch(GlobalNotify.LionCultureGetInfoRes)
	end
end

function WakingLionGameAgent:sendPM_WakingLionGameStartGameReq(actId, gameId, clientKey)
	local req = WakingLionGameExtension_pb.PM_WakingLionGameStartGameReq()

	req.actId = actId
	req.gameId = gameId
	req.clientKey = clientKey

	self:sendMsg(req)
end

function WakingLionGameAgent:handlePM_WakingLionGameStartGameRes(status, msg)
	if status == 0 then
		local clientkey = msg.clientKey
		local serverkey = msg.serverKey

		GlobalDispatcher:dispatch(WakingLionGameAgent.handlePM_WakingLionGameStartGameRes, clientkey, serverkey)
	end
end

function WakingLionGameAgent:sendPM_WakingLionGameEndGameReq(actId, gameId, param, settleValue, encryptedKey)
	local req = WakingLionGameExtension_pb.PM_WakingLionGameEndGameReq()

	req.actId = actId
	req.gameId = gameId
	req.param = param
	req.settleValue = settleValue
	req.encryptedKey = encryptedKey

	self:sendMsg(req)
end

function WakingLionGameAgent:handlePM_WakingLionGameEndGameRes(status, msg)
	if status == 0 then
		LioncultureModel.instance:SetGamesData({
			msg.gameMsg
		})
		GlobalDispatcher:dispatch(GlobalNotify.LionCultureGetInfoRes)
	end
end

function WakingLionGameAgent:sendPM_WakingLionGameGainPrizeReq(actId, gameId)
	local req = WakingLionGameExtension_pb.PM_WakingLionGameGainPrizeReq()

	req.actId = actId
	req.gameId = gameId

	self:sendMsg(req)
end

function WakingLionGameAgent:handlePM_WakingLionGameGainPrizeRes(status, msg)
	if status == 0 then
		local gameid = msg.gameId

		LioncultureModel.instance:SetGainPrize(gameid)
		GlobalDispatcher:dispatch(GlobalNotify.LionCultureGetInfoRes)
	end
end

function WakingLionGameAgent:sendPM_WakingLionGameChallengeReq(actId, gameId, form)
	local req = WakingLionGameExtension_pb.PM_WakingLionGameChallengeReq()

	req.actId = actId
	req.gameId = gameId

	req.form:ParseFromString(form:SerializeToString())
	self:sendMsg(req)
end

function WakingLionGameAgent:handlePM_WakingLionGameChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

WakingLionGameAgent.instance = WakingLionGameAgent.New()

return WakingLionGameAgent
