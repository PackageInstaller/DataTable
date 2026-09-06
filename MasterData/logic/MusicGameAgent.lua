-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/musicgame/agent/MusicGameAgent.lua

module("logic.extensions.musicgame.agent.MusicGameAgent", package.seeall)

local MusicGameAgent = class("MusicGameAgent", BaseAgent)

function MusicGameAgent:sendPM_MusicGameInfoReq(activityId)
	local req = MusicGameExtension_pb.PM_MusicGameInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function MusicGameAgent:handlePM_MusicGameInfoRes(status, msg)
	if status == 0 then
		MusicGameController.instance:handlePM_MusicGameInfoRes(msg)
	end
end

function MusicGameAgent:sendPM_MusicGameStartReq(activityId, gameTypeId, clientKey)
	local req = MusicGameExtension_pb.PM_MusicGameStartReq()

	req.activityId = activityId
	req.gameTypeId = gameTypeId
	req.clientKey = clientKey

	self:sendMsg(req)
end

function MusicGameAgent:handlePM_MusicGameStartRes(status, msg)
	MusicGameController.instance:handlePM_MusicGameStartRes(status, msg)
end

function MusicGameAgent:sendPM_MusicGameEndReq(activityId, isPass, num, encryptedKey)
	local req = MusicGameExtension_pb.PM_MusicGameEndReq()

	req.activityId = activityId
	req.isPass = isPass
	req.num = num
	req.encryptedKey = encryptedKey

	self:sendMsg(req)
end

function MusicGameAgent:handlePM_MusicGameEndRes(status, msg)
	if status == 0 then
		MusicGameController.instance:handlePM_MusicGameEndRes(msg)
	end
end

function MusicGameAgent:sendPM_MusicGameGainPrizeReq(activityId, prizeId)
	local req = MusicGameExtension_pb.PM_MusicGameGainPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function MusicGameAgent:handlePM_MusicGameGainPrizeRes(status, msg)
	if status == 0 then
		MusicGameController.instance:handlePM_MusicGameGainPrizeRes(msg)
	end
end

function MusicGameAgent:sendPM_MusicGameSweepReq(activityId, gameTypeId, times)
	local req = MusicGameExtension_pb.PM_MusicGameSweepReq()

	req.activityId = activityId
	req.gameTypeId = gameTypeId
	req.times = times

	self:sendMsg(req)
end

function MusicGameAgent:handlePM_MusicGameSweepRes(status, msg)
	if status == 0 then
		MusicGameController.instance:handlePM_MusicGameSweepRes(msg)
	end
end

MusicGameAgent.instance = MusicGameAgent.New()

return MusicGameAgent
