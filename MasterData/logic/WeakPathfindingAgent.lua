-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/weakpathfinding/agent/WeakPathfindingAgent.lua

module("logic.extensions.weakpathfinding.agent.WeakPathfindingAgent", package.seeall)

local WeakPathfindingAgent = class("WeakPathfindingAgent", BaseAgent)

function WeakPathfindingAgent:sendPM_WeakPathfindingInfoReq()
	local req = WeakPathfindingExtension_pb.PM_WeakPathfindingInfoReq()

	self:sendMsg(req)
end

function WeakPathfindingAgent:handlePM_WeakPathfindingInfoRes(status, msg)
	if status == 0 then
		WeakPathFindingController.instance:handleGetInfo(msg)
	end
end

function WeakPathfindingAgent:sendPM_WeakPathFindingStartFindReq()
	local req = WeakPathfindingExtension_pb.PM_WeakPathFindingStartFindReq()

	self:sendMsg(req)
end

function WeakPathfindingAgent:handlePM_WeakPathFindingStartFindRes(status, msg)
	if status == 0 then
		WeakPathFindingController.instance:handleStartFinding(msg)
	end
end

function WeakPathfindingAgent:sendPM_WeakPathFindingStartGameReq()
	local req = WeakPathfindingExtension_pb.PM_WeakPathFindingStartGameReq()

	self:sendMsg(req)
end

function WeakPathfindingAgent:handlePM_WeakPathFindingStartGameRes(status, msg)
	if status == 0 then
		WeakPathFindingController.instance:handleStartGame(msg)
	end
end

function WeakPathfindingAgent:sendPM_WeakPathFindingEndGameReq(countdownId, isWin)
	local req = WeakPathfindingExtension_pb.PM_WeakPathFindingEndGameReq()

	for i, id in ipairs(countdownId) do
		req.countdownId:append(id)
	end

	req.isWin = isWin

	self:sendMsg(req)
end

function WeakPathfindingAgent:handlePM_WeakPathFindingEndGameRes(status, msg)
	if status == 0 then
		WeakPathFindingController.instance:handleEndGame(msg)
	end
end

function WeakPathfindingAgent:sendPM_WeakPathFindingGainPrizeReq(prizeId)
	local req = WeakPathfindingExtension_pb.PM_WeakPathFindingGainPrizeReq()

	req.prizeId = prizeId

	self:sendMsg(req)
end

function WeakPathfindingAgent:handlePM_WeakPathFindingGainPrizeRes(status, msg)
	if status == 0 then
		WeakPathFindingController.instance:handleGainPrize(msg)
	end
end

WeakPathfindingAgent.instance = WeakPathfindingAgent.New()

return WeakPathfindingAgent
