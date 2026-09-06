-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/gashapon/agent/GashaponAgent.lua

module("logic.extensions.gashapon.agent.GashaponAgent", package.seeall)

local GashaponAgent = class("GashaponAgent", BaseAgent)

GashaponAgent.PM_GashaponGetDiamondNumRes = "GashaponAgent_PM_GashaponGetDiamondNumRes"
GashaponAgent.PM_GashaponGetRankInfosRes = "GashaponAgent_PM_GashaponGetRankInfosRes"
GashaponAgent.PM_GashaponDrawRes = "GashaponAgent_PM_GashaponDrawRes"

function GashaponAgent:ctor()
	return
end

function GashaponAgent:setExtId(extId)
	GashaponAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function GashaponAgent:sendPM_GashaponGetDiamondNumReq(activityId, handler, handlerObj, errHandler)
	local req = GashaponExtension_pb.PM_GashaponGetDiamondNumReq()

	req.activityId = activityId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(GashaponAgent.PM_GashaponGetDiamondNumRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function GashaponAgent:handlePM_GashaponGetDiamondNumRes(status, msg)
	self:dispatch(GashaponAgent.PM_GashaponGetDiamondNumRes, status, msg)
end

function GashaponAgent:sendPM_GashaponGetRankInfosReq(activityId, handler, handlerObj, errHandler)
	local req = GashaponExtension_pb.PM_GashaponGetRankInfosReq()

	req.activityId = activityId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(GashaponAgent.PM_GashaponGetRankInfosRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function GashaponAgent:handlePM_GashaponGetRankInfosRes(status, msg)
	self:dispatch(GashaponAgent.PM_GashaponGetRankInfosRes, status, msg)
end

function GashaponAgent:sendPM_GashaponDrawReq(activityId, drawType, handler, handlerObj, errHandler)
	local req = GashaponExtension_pb.PM_GashaponDrawReq()

	req.activityId = activityId
	req.drawType = drawType

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(GashaponAgent.PM_GashaponDrawRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function GashaponAgent:handlePM_GashaponDrawRes(status, msg)
	self:dispatch(GashaponAgent.PM_GashaponDrawRes, status, msg)
end

GashaponAgent.instance = GashaponAgent.New()

return GashaponAgent
