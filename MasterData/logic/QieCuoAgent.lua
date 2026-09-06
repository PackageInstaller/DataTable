-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pk/agent/QieCuoAgent.lua

module("logic.extensions.qiecuo.agent.QieCuoAgent", package.seeall)

local QieCuoAgent = class("QieCuoAgent", BaseAgent)

QieCuoAgent.PM_AskFightRes = "QieCuoAgent_PM_AskFightRes"
QieCuoAgent.PM_CancelFightRes = "QieCuoAgent_PM_CancelFightRes"
QieCuoAgent.PM_GetRequestFightInfoRes = "QieCuoAgent_PM_GetRequestFightInfoRes"
QieCuoAgent.PM_RefuseFightRes = "QieCuoAgent_PM_RefuseFightRes"
QieCuoAgent.PM_AcceptFightRes = "QieCuoAgent_PM_AcceptFightRes"
QieCuoAgent.PM_SetDefenseFormRes = "QieCuoAgent_PM_SetDefenseFormRes"
QieCuoAgent.PM_ReadyFightRes = "QieCuoAgent_PM_ReadyFightRes"
QieCuoAgent.PM_LeaveGameRes = "QieCuoAgent_PM_LeaveGameRes"
QieCuoAgent.PM_GetBattleRecordRes = "QieCuoAgent_PM_GetBattleRecordRes"
QieCuoAgent.PM_GetBattleVideoRes = "QieCuoAgent_PM_GetBattleVideoRes"
QieCuoAgent.PM_GetShareBattleResultRes = "QieCuoAgent_PM_GetShareBattleResultRes"
QieCuoAgent.PM_FightSwitchInfoRes = "QieCuoAgent_PM_FightSwitchInfoRes"
QieCuoAgent.PM_SetSwitchRes = "QieCuoAgent_PM_SetSwitchRes"
QieCuoAgent.PM_RefuseAllFightRes = "QieCuoAgent_PM_RefuseAllFightRes"
QieCuoAgent.PM_NotifyReceiveFightAskRes = "QieCuoAgent_PM_NotifyReceiveFightAskRes"
QieCuoAgent.PM_NotifyCancelFightRes = "QieCuoAgent_PM_NotifyCancelFightRes"
QieCuoAgent.PM_NotifyFightRefusedRes = "QieCuoAgent_PM_NotifyFightRefusedRes"
QieCuoAgent.PM_NotifyFightStartRes = "QieCuoAgent_PM_NotifyFightStartRes"
QieCuoAgent.PM_NotifyOpDefenseReadyRes = "QieCuoAgent_PM_NotifyOpDefenseReadyRes"
QieCuoAgent.PM_NotifyChangeToAttackRes = "QieCuoAgent_PM_NotifyChangeToAttackRes"
QieCuoAgent.PM_NotifyOpReadyFightRes = "QieCuoAgent_PM_NotifyOpReadyFightRes"
QieCuoAgent.PM_NotifyGameResultRes = "QieCuoAgent_PM_NotifyGameResultRes"
QieCuoAgent.PM_NotifyFightAskFail = "QieCuoAgent_PM_NotifyFightAskFail"
QieCuoAgent.PM_NotifyFightAcceptFail = "QieCuoAgent_PM_NotifyFightAcceptFail"

function QieCuoAgent:ctor()
	return
end

function QieCuoAgent:setExtId(extId)
	QieCuoAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function QieCuoAgent:sendPM_AskFightReq(userId, handler, handlerObj, errHandler)
	local req = QieCuoExtension_pb.PM_AskFightReq()

	req.userId = userId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(QieCuoAgent.PM_AskFightRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function QieCuoAgent:handlePM_AskFightRes(status, msg)
	self:dispatch(QieCuoAgent.PM_AskFightRes, status, msg)
end

function QieCuoAgent:sendPM_CancelFightReq(handler, handlerObj, errHandler)
	local req = QieCuoExtension_pb.PM_CancelFightReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(QieCuoAgent.PM_CancelFightRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function QieCuoAgent:handlePM_CancelFightRes(status, msg)
	self:dispatch(QieCuoAgent.PM_CancelFightRes, status, msg)
end

function QieCuoAgent:sendPM_GetRequestFightInfoReq(handler, handlerObj, errHandler)
	local req = QieCuoExtension_pb.PM_GetRequestFightInfoReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(QieCuoAgent.PM_GetRequestFightInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function QieCuoAgent:handlePM_GetRequestFightInfoRes(status, msg)
	self:dispatch(QieCuoAgent.PM_GetRequestFightInfoRes, status, msg)
end

function QieCuoAgent:sendPM_RefuseFightReq(userId, handler, handlerObj, errHandler)
	local req = QieCuoExtension_pb.PM_RefuseFightReq()

	req.userId = userId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(QieCuoAgent.PM_RefuseFightRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function QieCuoAgent:handlePM_RefuseFightRes(status, msg)
	self:dispatch(QieCuoAgent.PM_RefuseFightRes, status, msg)
end

function QieCuoAgent:sendPM_AcceptFightReq(userId, handler, handlerObj, errHandler)
	local req = QieCuoExtension_pb.PM_AcceptFightReq()

	req.userId = userId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(QieCuoAgent.PM_AcceptFightRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function QieCuoAgent:handlePM_AcceptFightRes(status, msg)
	self:dispatch(QieCuoAgent.PM_AcceptFightRes, status, msg)
end

function QieCuoAgent:sendPM_SetDefenseFormReq(form_pb, handler, handlerObj, errHandler)
	local req = QieCuoExtension_pb.PM_SetDefenseFormReq()

	if form_pb ~= nil then
		req.form:ParseFromString(form_pb:SerializeToString())
	end

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(QieCuoAgent.PM_SetDefenseFormRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function QieCuoAgent:handlePM_SetDefenseFormRes(status, msg)
	self:dispatch(QieCuoAgent.PM_SetDefenseFormRes, status, msg)
end

function QieCuoAgent:sendPM_ReadyFightReq(handler, handlerObj, errHandler)
	local req = QieCuoExtension_pb.PM_ReadyFightReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(QieCuoAgent.PM_ReadyFightRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function QieCuoAgent:handlePM_ReadyFightRes(status, msg)
	self:dispatch(QieCuoAgent.PM_ReadyFightRes, status, msg)
end

function QieCuoAgent:sendPM_LeaveGameReq(handler, handlerObj, errHandler)
	local req = QieCuoExtension_pb.PM_LeaveGameReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(QieCuoAgent.PM_LeaveGameRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function QieCuoAgent:handlePM_LeaveGameRes(status, msg)
	self:dispatch(QieCuoAgent.PM_LeaveGameRes, status, msg)
end

function QieCuoAgent:sendPM_GetBattleRecordReq(handler, handlerObj, errHandler)
	local req = QieCuoExtension_pb.PM_GetBattleRecordReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(QieCuoAgent.PM_GetBattleRecordRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function QieCuoAgent:handlePM_GetBattleRecordRes(status, msg)
	self:dispatch(QieCuoAgent.PM_GetBattleRecordRes, status, msg)
end

function QieCuoAgent:sendPM_GetBattleVideoReq(myAttackBattleId, opAttackBattleId, handler, handlerObj, errHandler)
	local req = QieCuoExtension_pb.PM_GetBattleVideoReq()

	req.myAttackBattleId = myAttackBattleId
	req.opAttackBattleId = opAttackBattleId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(QieCuoAgent.PM_GetBattleVideoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function QieCuoAgent:handlePM_GetBattleVideoRes(status, msg)
	self:dispatch(QieCuoAgent.PM_GetBattleVideoRes, status, msg)
end

function QieCuoAgent:sendPM_GetShareBattleResultReq(recordOwnerId, recordId, handler, handlerObj, errHandler)
	local req = QieCuoExtension_pb.PM_GetShareBattleResultReq()

	req.recordOwnerId = recordOwnerId
	req.recordId = recordId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(QieCuoAgent.PM_GetShareBattleResultRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function QieCuoAgent:handlePM_GetShareBattleResultRes(status, msg)
	self:dispatch(QieCuoAgent.PM_GetShareBattleResultRes, status, msg)
end

function QieCuoAgent:sendPM_FightSwitchInfoReq(handler, handlerObj, errHandler)
	local req = QieCuoExtension_pb.PM_FightSwitchInfoReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(QieCuoAgent.PM_FightSwitchInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function QieCuoAgent:handlePM_FightSwitchInfoRes(status, msg)
	self:dispatch(QieCuoAgent.PM_FightSwitchInfoRes, status, msg)
end

function QieCuoAgent:sendPM_SetSwitchReq(all, stranger, handler, handlerObj, errHandler)
	local req = QieCuoExtension_pb.PM_SetSwitchReq()

	req.all = all
	req.stranger = stranger

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(QieCuoAgent.PM_SetSwitchRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function QieCuoAgent:handlePM_SetSwitchRes(status, msg)
	self:dispatch(QieCuoAgent.PM_SetSwitchRes, status, msg)
end

function QieCuoAgent:sendPM_RefuseAllFightReq(handler, handlerObj, errHandler)
	local req = QieCuoExtension_pb.PM_RefuseAllFightReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(QieCuoAgent.PM_RefuseAllFightRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function QieCuoAgent:handlePM_RefuseAllFightRes(status, msg)
	self:dispatch(QieCuoAgent.PM_RefuseAllFightRes, status, msg)
end

function QieCuoAgent:handlePM_NotifyReceiveFightAskRes(status, msg)
	self:dispatch(QieCuoAgent.PM_NotifyReceiveFightAskRes, status, msg)
end

function QieCuoAgent:handlePM_NotifyCancelFightRes(status, msg)
	self:dispatch(QieCuoAgent.PM_NotifyCancelFightRes, status, msg)
end

function QieCuoAgent:handlePM_NotifyFightRefusedRes(status, msg)
	self:dispatch(QieCuoAgent.PM_NotifyFightRefusedRes, status, msg)
end

function QieCuoAgent:handlePM_NotifyFightStartRes(status, msg)
	self:dispatch(QieCuoAgent.PM_NotifyFightStartRes, status, msg)
end

function QieCuoAgent:handlePM_NotifyOpDefenseReadyRes(status, msg)
	self:dispatch(QieCuoAgent.PM_NotifyOpDefenseReadyRes, status, msg)
end

function QieCuoAgent:handlePM_NotifyChangeToAttackRes(status, msg)
	self:dispatch(QieCuoAgent.PM_NotifyChangeToAttackRes, status, msg)
end

function QieCuoAgent:handlePM_NotifyOpReadyFightRes(status, msg)
	self:dispatch(QieCuoAgent.PM_NotifyOpReadyFightRes, status, msg)
end

function QieCuoAgent:handlePM_NotifyGameResultRes(status, msg)
	self:dispatch(QieCuoAgent.PM_NotifyGameResultRes, status, msg)
end

function QieCuoAgent:handlePM_NotifyFightAskFail(status, msg)
	self:dispatch(QieCuoAgent.PM_NotifyFightAskFail, status, msg)
end

function QieCuoAgent:handlePM_NotifyFightAcceptFail(status, msg)
	self:dispatch(QieCuoAgent.PM_NotifyFightAcceptFail, status, msg)
end

QieCuoAgent.instance = QieCuoAgent.New()

return QieCuoAgent
