-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/football/agent/FootballAgent.lua

module("logic.extensions.football.agent.FootballAgent", package.seeall)

local M = class("FootballAgent", BaseAgent)

function M:sendGetRecordListRequest()
	local req = FootballExtension_pb.GetRecordListRequest()

	self:sendMsg(req)
end

function M:handleGetRecordListReply(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatchEvent(EventType.FOOTBALL_RECORD_UPDATE, msg.record)
	end
end

function M:handleBingoPush(status, msg)
	FootballModel.instance:handleBingoPush(msg.point)
	GlobalDispatcher:dispatchEvent(EventType.FOOTBALL_SCORE_UPDATE)
end

function M:handleResetPush(status, msg)
	GlobalDispatcher:dispatchEvent(EventType.FOOTBALL_RESET_POSITION)
end

function M:handleSettleResultPush(status, msg)
	if msg.result == 0 then
		FootballModel.instance:handleSettleResultPush(msg.info)
	else
		FloatWordMgr.instance:show(string.format("活动异常,状态码：%s", msg.result))
	end
end

M.instance = M.New()

return M
