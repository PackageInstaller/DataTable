-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bricksxgame/agent/XiaoXiaoLeGameAgent.lua

module("logic.extensions.xiaoxiaolegame.agent.XiaoXiaoLeGameAgent", package.seeall)

local XiaoXiaoLeGameAgent = class("XiaoXiaoLeGameAgent", BaseAgent)

function XiaoXiaoLeGameAgent:sendPM_XiaoXiaoLeGameInfoReq(activityId)
	local req = XiaoXiaoLeGameExtension_pb.PM_XiaoXiaoLeGameInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function XiaoXiaoLeGameAgent:handlePM_XiaoXiaoLeGameInfoRes(status, msg)
	if status == 0 then
		BricksxgameController.instance:onGetInfo(msg)
	end
end

function XiaoXiaoLeGameAgent:sendPM_XiaoXiaoLeGameStartGameReq(activityId, clientKey)
	local req = XiaoXiaoLeGameExtension_pb.PM_XiaoXiaoLeGameStartGameReq()

	req.activityId = activityId
	req.clientKey = clientKey

	self:sendMsg(req)
end

function XiaoXiaoLeGameAgent:handlePM_XiaoXiaoLeGameStartGameRes(status, msg)
	if status == 0 then
		BricksxgameController.instance:onStartGame(msg)
	end
end

function XiaoXiaoLeGameAgent:sendPM_XiaoXiaoLeGameEndGameReq(activityId, isPass, score, encryptedKey)
	local req = XiaoXiaoLeGameExtension_pb.PM_XiaoXiaoLeGameEndGameReq()

	req.activityId = activityId
	req.isPass = isPass
	req.score = score
	req.encryptedKey = encryptedKey

	self:sendMsg(req)
end

function XiaoXiaoLeGameAgent:handlePM_XiaoXiaoLeGameEndGameRes(status, msg)
	if status == 0 then
		BricksxgameController.instance:onEndGame(msg)
	end
end

function XiaoXiaoLeGameAgent:sendPM_XiaoXiaoLeGameOneKeyGainPrizeReq(activityId)
	local req = XiaoXiaoLeGameExtension_pb.PM_XiaoXiaoLeGameOneKeyGainPrizeReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function XiaoXiaoLeGameAgent:handlePM_XiaoXiaoLeGameOneKeyGainPrizeRes(status, msg)
	if status == 0 then
		BricksxgameController.instance:onGetPrize(msg)
	end
end

function XiaoXiaoLeGameAgent:sendPM_XiaoXiaoLeGameRankReq(activityId)
	local req = XiaoXiaoLeGameExtension_pb.PM_XiaoXiaoLeGameRankReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function XiaoXiaoLeGameAgent:handlePM_XiaoXiaoLeGameRankRes(status, msg)
	if status == 0 then
		BricksxgameController.instance:onGetRank(msg)
	end
end

function XiaoXiaoLeGameAgent:sendPM_XiaoXiaoLeGameSweepReq(activityId, score, times)
	local req = XiaoXiaoLeGameExtension_pb.PM_XiaoXiaoLeGameSweepReq()

	req.activityId = activityId
	req.score = score
	req.times = times

	self:sendMsg(req)
end

function XiaoXiaoLeGameAgent:handlePM_XiaoXiaoLeGameSweepRes(status, msg)
	if status == 0 then
		BricksxgameController.instance:handlePM_XiaoXiaoLeGameSweepRes(msg)
	end
end

XiaoXiaoLeGameAgent.instance = XiaoXiaoLeGameAgent.New()

return XiaoXiaoLeGameAgent
