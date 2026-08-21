-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitactivity/agent/GroupActivityAgent.lua

module("logic.extensions.timelimitactivity.agent.GroupActivityAgent", package.seeall)

local M = class("GroupActivityAgent", BaseAgent)

function M:sendStartMatchRequest(gameId)
	local req = GroupExtension_pb.StartMatchRequest()

	req.gameId = gameId

	self:sendMsg(req)
end

function M:handleStartMatchReply(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatchEvent(EventType.FOOTBALL_START_MATCHING)
	end
end

function M:sendGetMyInfoRequest(gameId)
	local req = GroupExtension_pb.GetMyInfoRequest()

	req.gameId = gameId

	self:sendMsg(req)
end

function M:handleGetMyInfoReply(status, msg)
	if status == 0 then
		FootballModel.instance:initFootballData(msg.info)
		GlobalDispatcher:dispatchEvent(EventType.FOOTBALL_INFO_UPDATE)
	end
end

function M:sendStopMatchRequest(gameId)
	local req = GroupExtension_pb.StopMatchRequest()

	req.gameId = gameId

	self:sendMsg(req)
end

function M:handleStopMatchReply(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatchEvent(EventType.FOOTBALL_STOP_MATCHING)
	end
end

function M:handleMatchCompletePush(status, msg)
	if msg.result == 0 then
		FootballModel.instance:setMatchingResult(msg.teams)
	end

	GlobalDispatcher:dispatchEvent(EventType.FOOTBALL_MATCHING_FINISH, msg)
end

M.instance = M.New()

return M
