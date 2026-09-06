-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/escort/agent/ConvoyAgent.lua

module("logic.extensions.escort.agent.ConvoyAgent", package.seeall)

local ConvoyAgent = class("ConvoyAgent", BaseAgent)

ConvoyAgent.PM_ConvoyGetInfoRes = "ConvoyAgent_PM_ConvoyGetInfoRes"
ConvoyAgent.PM_ConvoyUpgradeBoxRes = "ConvoyAgent_PM_ConvoyUpgradeBoxRes"
ConvoyAgent.PM_AcceptConvoyRes = "ConvoyAgent_PM_AcceptConvoyRes"
ConvoyAgent.PM_ConvoyTalkToNPCRes = "ConvoyAgent_PM_ConvoyTalkToNPCRes"
ConvoyAgent.PM_FinishConvoyRes = "ConvoyAgent_PM_FinishConvoyRes"
ConvoyAgent.PM_ConvoyOverTimeRes = "ConvoyAgent_PM_ConvoyOverTimeRes"
ConvoyAgent.PM_GetConvoyListRes = "ConvoyAgent_PM_GetConvoyListRes"
ConvoyAgent.PM_GetOtherConvoyDetailRes = "ConvoyAgent_PM_GetOtherConvoyDetailRes"
ConvoyAgent.PM_ConvoyChallengeRes = "ConvoyAgent_PM_ConvoyChallengeRes"
ConvoyAgent.PM_ConvoyGetChallengeRecordRes = "ConvoyAgent_PM_ConvoyGetChallengeRecordRes"
ConvoyAgent.PM_ConvoyGetChallengeVideoRes = "ConvoyAgent_PM_ConvoyGetChallengeVideoRes"
ConvoyAgent.PM_NotifyConvoyBeChallengedRes = "ConvoyAgent_PM_NotifyConvoyBeChallengedRes"

function ConvoyAgent:ctor()
	return
end

function ConvoyAgent:setExtId(extId)
	ConvoyAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function ConvoyAgent:sendPM_ConvoyGetInfoReq(handler, handlerObj, errHandler)
	local req = ConvoyExtension_pb.PM_ConvoyGetInfoReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(ConvoyAgent.PM_ConvoyGetInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function ConvoyAgent:handlePM_ConvoyGetInfoRes(status, msg)
	self:dispatch(ConvoyAgent.PM_ConvoyGetInfoRes, status, msg)
end

function ConvoyAgent:sendPM_ConvoyUpgradeBoxReq(upgradeTimes, handler, handlerObj, errHandler)
	local req = ConvoyExtension_pb.PM_ConvoyUpgradeBoxReq()

	req.upgradeTimes = upgradeTimes

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(ConvoyAgent.PM_ConvoyUpgradeBoxRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function ConvoyAgent:handlePM_ConvoyUpgradeBoxRes(status, msg)
	self:dispatch(ConvoyAgent.PM_ConvoyUpgradeBoxRes, status, msg)
end

function ConvoyAgent:sendPM_AcceptConvoyReq(isFree, handler, handlerObj, errHandler)
	local req = ConvoyExtension_pb.PM_AcceptConvoyReq()

	req.isFree = isFree

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(ConvoyAgent.PM_AcceptConvoyRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function ConvoyAgent:handlePM_AcceptConvoyRes(status, msg)
	self:dispatch(ConvoyAgent.PM_AcceptConvoyRes, status, msg)
end

function ConvoyAgent:sendPM_ConvoyTalkToNPCReq(npcId, handler, handlerObj, errHandler)
	local req = ConvoyExtension_pb.PM_ConvoyTalkToNPCReq()

	req.npcId = npcId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(ConvoyAgent.PM_ConvoyTalkToNPCRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function ConvoyAgent:handlePM_ConvoyTalkToNPCRes(status, msg)
	self:dispatch(ConvoyAgent.PM_ConvoyTalkToNPCRes, status, msg)
end

function ConvoyAgent:sendPM_FinishConvoyReq(handler, handlerObj, errHandler)
	local req = ConvoyExtension_pb.PM_FinishConvoyReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(ConvoyAgent.PM_FinishConvoyRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function ConvoyAgent:handlePM_FinishConvoyRes(status, msg)
	self:dispatch(ConvoyAgent.PM_FinishConvoyRes, status, msg)
end

function ConvoyAgent:sendPM_ConvoyOverTimeReq(handler, handlerObj, errHandler)
	local req = ConvoyExtension_pb.PM_ConvoyOverTimeReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(ConvoyAgent.PM_ConvoyOverTimeRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function ConvoyAgent:handlePM_ConvoyOverTimeRes(status, msg)
	self:dispatch(ConvoyAgent.PM_ConvoyOverTimeRes, status, msg)
end

function ConvoyAgent:sendPM_GetConvoyListReq(handler, handlerObj, errHandler)
	local req = ConvoyExtension_pb.PM_GetConvoyListReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(ConvoyAgent.PM_GetConvoyListRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function ConvoyAgent:handlePM_GetConvoyListRes(status, msg)
	self:dispatch(ConvoyAgent.PM_GetConvoyListRes, status, msg)
end

function ConvoyAgent:sendPM_GetOtherConvoyDetailReq(otherUserId, handler, handlerObj, errHandler)
	local req = ConvoyExtension_pb.PM_GetOtherConvoyDetailReq()

	req.otherUserId = otherUserId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(ConvoyAgent.PM_GetOtherConvoyDetailRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function ConvoyAgent:handlePM_GetOtherConvoyDetailRes(status, msg)
	self:dispatch(ConvoyAgent.PM_GetOtherConvoyDetailRes, status, msg)
end

function ConvoyAgent:sendPM_ConvoyChallengeReq(beChallengedId, robotName, robotHeadIcon, robotHeadFrame, isFree, robotLv, handler, handlerObj, errHandler)
	local req = ConvoyExtension_pb.PM_ConvoyChallengeReq()

	req.beChallengedId = beChallengedId

	if robotName ~= nil then
		req.robotName = robotName
	end

	if robotHeadIcon ~= nil then
		req.robotHeadIcon = robotHeadIcon
	end

	if robotHeadFrame ~= nil then
		req.robotHeadFrame = robotHeadFrame
	end

	req.isFree = isFree

	if robotLv ~= nil then
		req.robotLv = robotLv
	end

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(ConvoyAgent.PM_ConvoyChallengeRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function ConvoyAgent:handlePM_ConvoyChallengeRes(status, msg)
	self:dispatch(ConvoyAgent.PM_ConvoyChallengeRes, status, msg)
end

function ConvoyAgent:sendPM_ConvoyGetChallengeRecordReq(handler, handlerObj, errHandler)
	local req = ConvoyExtension_pb.PM_ConvoyGetChallengeRecordReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(ConvoyAgent.PM_ConvoyGetChallengeRecordRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function ConvoyAgent:handlePM_ConvoyGetChallengeRecordRes(status, msg)
	self:dispatch(ConvoyAgent.PM_ConvoyGetChallengeRecordRes, status, msg)
end

function ConvoyAgent:sendPM_ConvoyGetChallengeVideoReq(index, handler, handlerObj, errHandler)
	local req = ConvoyExtension_pb.PM_ConvoyGetChallengeVideoReq()

	req.index = index

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(ConvoyAgent.PM_ConvoyGetChallengeVideoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function ConvoyAgent:handlePM_ConvoyGetChallengeVideoRes(status, msg)
	self:dispatch(ConvoyAgent.PM_ConvoyGetChallengeVideoRes, status, msg)
end

function ConvoyAgent:handlePM_NotifyConvoyBeChallengedRes(status, msg)
	self:dispatch(ConvoyAgent.PM_NotifyConvoyBeChallengedRes, status, msg)
end

function ConvoyAgent:sendPM_ConvoyOneKeyFinishReq(useTicket)
	local req = ConvoyExtension_pb.PM_ConvoyOneKeyFinishReq()

	req.useTicket = useTicket

	self:sendMsg(req)
end

function ConvoyAgent:handlePM_ConvoyOneKeyFinishRes(status, msg)
	if status == 0 then
		-- block empty
	end

	EscortController.instance:SCFinishConvoy(msg, status)
end

ConvoyAgent.instance = ConvoyAgent.New()

return ConvoyAgent
