-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hexlineup/agent/HexLineupAgent.lua

module("logic.extensions.hexlineup.agent.HexLineupAgent", package.seeall)

local HexLineupAgent = class("HexLineupAgent", BaseAgent)

function HexLineupAgent:sendPM_HexLineupGetInfoReq(activityId)
	local req = HexLineupExtension_pb.PM_HexLineupGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function HexLineupAgent:handlePM_HexLineupGetInfoRes(status, msg)
	if status == 0 then
		HexLineupController.instance:handlePM_HexLineupGetInfoRes(msg)
	end
end

function HexLineupAgent:sendPM_HexLineupStartGameReq(activityId, modeId, clientKey)
	local req = HexLineupExtension_pb.PM_HexLineupStartGameReq()

	req.activityId = activityId
	req.modeId = modeId
	req.clientKey = clientKey

	self:sendMsg(req)
end

function HexLineupAgent:handlePM_HexLineupStartGameRes(status, msg)
	HexLineupController.instance:handlePM_HexLineupStartGameRes(status, msg)
end

function HexLineupAgent:sendPM_HexLineupEndGameReq(activityId, modeId, score, encryptedKey)
	local req = HexLineupExtension_pb.PM_HexLineupEndGameReq()

	req.activityId = activityId
	req.modeId = modeId
	req.score = score
	req.encryptedKey = encryptedKey

	self:sendMsg(req)
end

function HexLineupAgent:handlePM_HexLineupEndGameRes(status, msg)
	if status == 0 then
		HexLineupController.instance:handlePM_HexLineupEndGameRes(msg)
	end
end

function HexLineupAgent:sendPM_HexLineupGainPrizeReq(activityId, prizeIds)
	local req = HexLineupExtension_pb.PM_HexLineupGainPrizeReq()

	req.activityId = activityId

	for _, v in ipairs(prizeIds) do
		req.prizeIds:append(v)
	end

	self:sendMsg(req)
end

function HexLineupAgent:handlePM_HexLineupGainPrizeRes(status, msg)
	if status == 0 then
		HexLineupController.instance:handlePM_HexLineupGainPrizeRes(msg)
	end
end

function HexLineupAgent:sendPM_HexLineupSweepReq(activityId, sweepTimes)
	local req = HexLineupExtension_pb.PM_HexLineupSweepReq()

	req.activityId = activityId
	req.sweepTimes = sweepTimes

	self:sendMsg(req)
end

function HexLineupAgent:handlePM_HexLineupSweepRes(status, msg)
	if status == 0 then
		HexLineupController.instance:handlePM_HexLineupSweepRes(msg)
	end
end

function HexLineupAgent:sendPM_HexLineupRankViewReq(activityId)
	local req = HexLineupExtension_pb.PM_HexLineupRankViewReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function HexLineupAgent:handlePM_HexLineupRankViewRes(status, msg)
	if status == 0 then
		HexLineupController.instance:handlePM_HexLineupRankViewRes(msg)
	end
end

HexLineupAgent.instance = HexLineupAgent.New()

return HexLineupAgent
