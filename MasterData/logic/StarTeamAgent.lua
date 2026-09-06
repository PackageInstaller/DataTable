-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/starteam/agent/StarTeamAgent.lua

module("logic.extensions.starteam.agent.StarTeamAgent", package.seeall)

local StarTeamAgent = class("StarTeamAgent", BaseAgent)

StarTeamAgent.ST_GetMyStarTeamInfoRes = "StarTeamAgent_ST_GetMyStarTeamInfoRes"
StarTeamAgent.ST_GainPrizeRes = "StarTeamAgent_ST_GainPrizeRes"

function StarTeamAgent:ctor()
	return
end

function StarTeamAgent:setExtId(extId)
	StarTeamAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function StarTeamAgent:sendST_GetMyStarTeamInfoReq(handler, handlerObj, errHandler)
	local req = StarTeamExtension_pb.ST_GetMyStarTeamInfoReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(StarTeamAgent.ST_GetMyStarTeamInfoRes, handler, handlerObj, errHandler)
	end

	self:sendMsg(req)
end

function StarTeamAgent:handleST_GetMyStarTeamInfoRes(status, msg)
	self:dispatch(StarTeamAgent.ST_GetMyStarTeamInfoRes, status, msg)
end

function StarTeamAgent:sendST_GainPrizeReq(index, handler, handlerObj, errHandler)
	local req = StarTeamExtension_pb.ST_GainPrizeReq()

	req.index = index

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(StarTeamAgent.ST_GainPrizeRes, handler, handlerObj, errHandler)
	end

	self:sendMsg(req)
end

function StarTeamAgent:handleST_GainPrizeRes(status, msg)
	self:dispatch(StarTeamAgent.ST_GainPrizeRes, status, msg)
end

StarTeamAgent.instance = StarTeamAgent.New()

return StarTeamAgent
