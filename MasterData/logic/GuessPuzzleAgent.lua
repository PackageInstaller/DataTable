-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/crossword/agent/GuessPuzzleAgent.lua

module("logic.extensions.guesspuzzle.agent.GuessPuzzleAgent", package.seeall)

local GuessPuzzleAgent = class("GuessPuzzleAgent", BaseAgent)

function GuessPuzzleAgent:sendPM_GuessPuzzleGetInfoReq(activityId)
	local req = GuessPuzzleExtension_pb.PM_GuessPuzzleGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function GuessPuzzleAgent:handlePM_GuessPuzzleGetInfoRes(status, msg)
	if status == 0 then
		CrossWrodController.instance:onGetInfo(msg)
	end
end

function GuessPuzzleAgent:sendPM_GuessPuzzleFinishGridReq(activityId, gridId)
	local req = GuessPuzzleExtension_pb.PM_GuessPuzzleFinishGridReq()

	req.activityId = activityId
	req.gridId = gridId

	self:sendMsg(req)
end

function GuessPuzzleAgent:handlePM_GuessPuzzleFinishGridRes(status, msg)
	if status == 0 then
		CrossWrodController.instance:onFinishGrid(msg)
	end
end

function GuessPuzzleAgent:sendPM_GuessPuzzleGainPrizeReq(activityId, prizeId)
	local req = GuessPuzzleExtension_pb.PM_GuessPuzzleGainPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function GuessPuzzleAgent:handlePM_GuessPuzzleGainPrizeRes(status, msg)
	if status == 0 then
		CrossWrodController.instance:onGainPrize(msg)
	end
end

GuessPuzzleAgent.instance = GuessPuzzleAgent.New()

return GuessPuzzleAgent
