-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/qixilinkgame/agent/QiXiLinkGameAgent.lua

module("logic.extensions.qixilinkgame.agent.QiXiLinkGameAgent", package.seeall)

local QiXiLinkGameAgent = class("QiXiLinkGameAgent", BaseAgent)

function QiXiLinkGameAgent:sendPM_LinkendlessGameInfoReq(activityId)
	local req = LinkendlessGameExtension_pb.PM_LinkendlessGameInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function QiXiLinkGameAgent:handlePM_LinkendlessGameInfoRes(status, msg)
	if status == 0 then
		QiXiLinkGameController.instance:handlePM_LinkendlessGameInfoRes(msg)
	end
end

function QiXiLinkGameAgent:sendPM_LinkendlessGameStartGameReq(activityId, clientKey)
	local req = LinkendlessGameExtension_pb.PM_LinkendlessGameStartGameReq()

	req.activityId = activityId
	req.clientKey = clientKey

	self:sendMsg(req)
end

function QiXiLinkGameAgent:handlePM_LinkendlessGameStartGameRes(status, msg)
	if status == 0 then
		QiXiLinkGameController.instance:handlePM_LinkendlessGameStartGameRes(msg)
	end
end

function QiXiLinkGameAgent:sendPM_LinkendlessGameEndGameReq(activityId, score, encryptedKey)
	local req = LinkendlessGameExtension_pb.PM_LinkendlessGameEndGameReq()

	req.activityId = activityId
	req.score = score
	req.encryptedKey = encryptedKey

	self:sendMsg(req)
end

function QiXiLinkGameAgent:handlePM_LinkendlessGameEndGameRes(status, msg)
	if status == 0 then
		QiXiLinkGameController.instance:handlePM_LinkendlessGameEndGameRes(msg)
	end
end

function QiXiLinkGameAgent:sendPM_LinkendlessGameSweepReq(activityId, times)
	local req = LinkendlessGameExtension_pb.PM_LinkendlessGameSweepReq()

	req.activityId = activityId
	req.times = times

	self:sendMsg(req)
end

function QiXiLinkGameAgent:handlePM_LinkendlessGameSweepRes(status, msg)
	if status == 0 then
		QiXiLinkGameController.instance:handlePM_LinkendlessGameSweepRes(msg)
	end
end

function QiXiLinkGameAgent:sendPM_LinkendlessGameGainProgressPrizeReq(activityId, prizeId)
	local req = LinkendlessGameExtension_pb.PM_LinkendlessGameGainProgressPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function QiXiLinkGameAgent:handlePM_LinkendlessGameGainProgressPrizeRes(status, msg)
	if status == 0 then
		QiXiLinkGameController.instance:handlePM_LinkendlessGameGainProgressPrizeRes(msg)
	end
end

QiXiLinkGameAgent.instance = QiXiLinkGameAgent.New()

return QiXiLinkGameAgent
