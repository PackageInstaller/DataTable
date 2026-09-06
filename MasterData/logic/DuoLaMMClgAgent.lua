-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/duolamengmeng/agent/DuoLaMMClgAgent.lua

module("logic.extensions.duolammclg.agent.DuoLaMMClgAgent", package.seeall)

local DuoLaMMClgAgent = class("DuoLaMMClgAgent", BaseAgent)

DuoLaMMClgAgent.PM_DuoLaMMClgGetInfoRes = "DuoLaMMClgAgent_PM_DuoLaMMClgGetInfoRes"
DuoLaMMClgAgent.PM_DuoLaMMClgBuyPieceRes = "DuoLaMMClgAgent_PM_DuoLaMMClgBuyPieceRes"
DuoLaMMClgAgent.PM_DuoLaMMClgBuyGameTimesRes = "DuoLaMMClgAgent_PM_DuoLaMMClgBuyGameTimesRes"
DuoLaMMClgAgent.PM_DuoLaMMClgStartGameRes = "DuoLaMMClgAgent_PM_DuoLaMMClgStartGameRes"
DuoLaMMClgAgent.PM_DuoLaMMClgReliveRes = "DuoLaMMClgAgent_PM_DuoLaMMClgReliveRes"
DuoLaMMClgAgent.PM_DuoLaMMClgEndGameRes = "DuoLaMMClgAgent_PM_DuoLaMMClgEndGameRes"
DuoLaMMClgAgent.PM_DuoLaMMClgOpenEvolveRes = "DuoLaMMClgAgent_PM_DuoLaMMClgOpenEvolveRes"
DuoLaMMClgAgent.PM_DuoLaMMClgEvolveSucRes = "DuoLaMMClgAgent_PM_DuoLaMMClgEvolveSucRes"

function DuoLaMMClgAgent:ctor()
	return
end

function DuoLaMMClgAgent:setExtId(extId)
	DuoLaMMClgAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function DuoLaMMClgAgent:sendPM_DuoLaMMClgGetInfoReq(handler, handlerObj, errHandler)
	local req = DuoLaMMClgExtension_pb.PM_DuoLaMMClgGetInfoReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(DuoLaMMClgAgent.PM_DuoLaMMClgGetInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function DuoLaMMClgAgent:handlePM_DuoLaMMClgGetInfoRes(status, msg)
	self:dispatch(DuoLaMMClgAgent.PM_DuoLaMMClgGetInfoRes, status, msg)
end

function DuoLaMMClgAgent:sendPM_DuoLaMMClgBuyPieceReq(id, count, handler, handlerObj, errHandler)
	local req = DuoLaMMClgExtension_pb.PM_DuoLaMMClgBuyPieceReq()

	req.id = id
	req.count = count

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(DuoLaMMClgAgent.PM_DuoLaMMClgBuyPieceRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function DuoLaMMClgAgent:handlePM_DuoLaMMClgBuyPieceRes(status, msg)
	self:dispatch(DuoLaMMClgAgent.PM_DuoLaMMClgBuyPieceRes, status, msg)
end

function DuoLaMMClgAgent:sendPM_DuoLaMMClgBuyGameTimesReq(handler, handlerObj, errHandler)
	local req = DuoLaMMClgExtension_pb.PM_DuoLaMMClgBuyGameTimesReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(DuoLaMMClgAgent.PM_DuoLaMMClgBuyGameTimesRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function DuoLaMMClgAgent:handlePM_DuoLaMMClgBuyGameTimesRes(status, msg)
	self:dispatch(DuoLaMMClgAgent.PM_DuoLaMMClgBuyGameTimesRes, status, msg)
end

function DuoLaMMClgAgent:sendPM_DuoLaMMClgStartGameReq(clientKey, handler, handlerObj, errHandler)
	local req = DuoLaMMClgExtension_pb.PM_DuoLaMMClgStartGameReq()

	req.clientKey = clientKey

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(DuoLaMMClgAgent.PM_DuoLaMMClgStartGameRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function DuoLaMMClgAgent:handlePM_DuoLaMMClgStartGameRes(status, msg)
	self:dispatch(DuoLaMMClgAgent.PM_DuoLaMMClgStartGameRes, status, msg)
end

function DuoLaMMClgAgent:sendPM_DuoLaMMClgReliveReq(handler, handlerObj, errHandler)
	local req = DuoLaMMClgExtension_pb.PM_DuoLaMMClgReliveReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(DuoLaMMClgAgent.PM_DuoLaMMClgReliveRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function DuoLaMMClgAgent:handlePM_DuoLaMMClgReliveRes(status, msg)
	self:dispatch(DuoLaMMClgAgent.PM_DuoLaMMClgReliveRes, status, msg)
end

function DuoLaMMClgAgent:sendPM_DuoLaMMClgEndGameReq(ids_i32_Ary, encryptedKey, handler, handlerObj, errHandler)
	local req = DuoLaMMClgExtension_pb.PM_DuoLaMMClgEndGameReq()

	for i, v1 in ipairs(ids_i32_Ary) do
		req.ids:append(v1)
	end

	req.encryptedKey = encryptedKey

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(DuoLaMMClgAgent.PM_DuoLaMMClgEndGameRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function DuoLaMMClgAgent:handlePM_DuoLaMMClgEndGameRes(status, msg)
	self:dispatch(DuoLaMMClgAgent.PM_DuoLaMMClgEndGameRes, status, msg)
end

function DuoLaMMClgAgent:sendPM_DuoLaMMClgOpenEvolveReq(handler, handlerObj, errHandler)
	local req = DuoLaMMClgExtension_pb.PM_DuoLaMMClgOpenEvolveReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(DuoLaMMClgAgent.PM_DuoLaMMClgOpenEvolveRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function DuoLaMMClgAgent:handlePM_DuoLaMMClgOpenEvolveRes(status, msg)
	self:dispatch(DuoLaMMClgAgent.PM_DuoLaMMClgOpenEvolveRes, status, msg)
end

function DuoLaMMClgAgent:handlePM_DuoLaMMClgEvolveSucRes(status, msg)
	self:dispatch(DuoLaMMClgAgent.PM_DuoLaMMClgEvolveSucRes, status, msg)
end

DuoLaMMClgAgent.instance = DuoLaMMClgAgent.New()

return DuoLaMMClgAgent
