-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/worldboss/agent/WorldBossAgent.lua

module("logic.extensions.worldboss.agent.WorldBossAgent", package.seeall)

local WorldBossAgent = class("WorldBossAgent", BaseAgent)

WorldBossAgent.PM_WorldBossInfoRes = "WorldBossAgent_PM_WorldBossInfoRes"
WorldBossAgent.PM_WorldBossSimulateChallengeRes = "WorldBossAgent_PM_WorldBossSimulateChallengeRes"
WorldBossAgent.PM_WorldBossChallengeRes = "WorldBossAgent_PM_WorldBossChallengeRes"
WorldBossAgent.PM_WorldBossBuyTimesRes = "WorldBossAgent_PM_WorldBossBuyTimesRes"
WorldBossAgent.PM_WorldBossRankInfoRes = "WorldBossAgent_PM_WorldBossRankInfoRes"
WorldBossAgent.PM_WorldBossClearLockRes = "WorldBossAgent_PM_WorldBossClearLockRes"
WorldBossAgent.PM_WorldBossHisotryRes = "WorldBossAgent_PM_WorldBossHisotryRes"
WorldBossAgent.PM_NotifyAfterChallengeRes = "WorldBossAgent_PM_NotifyAfterChallengeRes"

function WorldBossAgent:ctor()
	return
end

function WorldBossAgent:setExtId(extId)
	WorldBossAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function WorldBossAgent:sendPM_WorldBossInfoReq(handler, handlerObj, errHandler)
	local req = WorldBossExtension_pb.PM_WorldBossInfoReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(WorldBossAgent.PM_WorldBossInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function WorldBossAgent:handlePM_WorldBossInfoRes(status, msg)
	self:dispatch(WorldBossAgent.PM_WorldBossInfoRes, status, msg)
end

function WorldBossAgent:sendPM_WorldBossSimulateChallengeReq(handler, handlerObj, errHandler)
	local req = WorldBossExtension_pb.PM_WorldBossSimulateChallengeReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(WorldBossAgent.PM_WorldBossSimulateChallengeRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function WorldBossAgent:handlePM_WorldBossSimulateChallengeRes(status, msg)
	self:dispatch(WorldBossAgent.PM_WorldBossSimulateChallengeRes, status, msg)
end

function WorldBossAgent:sendPM_WorldBossChallengeReq(handler, handlerObj, errHandler)
	local req = WorldBossExtension_pb.PM_WorldBossChallengeReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(WorldBossAgent.PM_WorldBossChallengeRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function WorldBossAgent:handlePM_WorldBossChallengeRes(status, msg)
	self:dispatch(WorldBossAgent.PM_WorldBossChallengeRes, status, msg)
end

function WorldBossAgent:sendPM_WorldBossBuyTimesReq(handler, handlerObj, errHandler)
	local req = WorldBossExtension_pb.PM_WorldBossBuyTimesReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(WorldBossAgent.PM_WorldBossBuyTimesRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function WorldBossAgent:handlePM_WorldBossBuyTimesRes(status, msg)
	self:dispatch(WorldBossAgent.PM_WorldBossBuyTimesRes, status, msg)
end

function WorldBossAgent:sendPM_WorldBossRankInfoReq(handler, handlerObj, errHandler)
	local req = WorldBossExtension_pb.PM_WorldBossRankInfoReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(WorldBossAgent.PM_WorldBossRankInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function WorldBossAgent:handlePM_WorldBossRankInfoRes(status, msg)
	self:dispatch(WorldBossAgent.PM_WorldBossRankInfoRes, status, msg)
end

function WorldBossAgent:sendPM_WorldBossClearLockReq(handler, handlerObj, errHandler)
	local req = WorldBossExtension_pb.PM_WorldBossClearLockReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(WorldBossAgent.PM_WorldBossClearLockRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function WorldBossAgent:handlePM_WorldBossClearLockRes(status, msg)
	self:dispatch(WorldBossAgent.PM_WorldBossClearLockRes, status, msg)
end

function WorldBossAgent:sendPM_WorldBossHisotryReq(handler, handlerObj, errHandler)
	local req = WorldBossExtension_pb.PM_WorldBossHisotryReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(WorldBossAgent.PM_WorldBossHisotryRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function WorldBossAgent:handlePM_WorldBossHisotryRes(status, msg)
	self:dispatch(WorldBossAgent.PM_WorldBossHisotryRes, status, msg)
end

function WorldBossAgent:handlePM_NotifyAfterChallengeRes(status, msg)
	self:dispatch(WorldBossAgent.PM_NotifyAfterChallengeRes, status, msg)
end

WorldBossAgent.instance = WorldBossAgent.New()

return WorldBossAgent
