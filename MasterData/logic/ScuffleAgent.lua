-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scuffle/agent/ScuffleAgent.lua

module("logic.extensions.scuffle.agent.ScuffleAgent", package.seeall)

local ScuffleAgent = class("ScuffleAgent", BaseAgent)

ScuffleAgent.SF_ScuffleInfoRes = "ScuffleAgent_SF_ScuffleInfoRes"
ScuffleAgent.SF_StartMatchingRes = "ScuffleAgent_SF_StartMatchingRes"
ScuffleAgent.SF_CancelMatchingRes = "ScuffleAgent_SF_CancelMatchingRes"
ScuffleAgent.SF_LeaveGameRes = "ScuffleAgent_SF_LeaveGameRes"
ScuffleAgent.SF_BanPetRes = "ScuffleAgent_SF_BanPetRes"
ScuffleAgent.SF_SetFormRes = "ScuffleAgent_SF_SetFormRes"
ScuffleAgent.SF_AchievePrizeInfoRes = "ScuffleAgent_SF_AchievePrizeInfoRes"
ScuffleAgent.SF_GainAchievePrizeRes = "ScuffleAgent_SF_GainAchievePrizeRes"
ScuffleAgent.SF_DailyTaskInfoRes = "ScuffleAgent_SF_DailyTaskInfoRes"
ScuffleAgent.SF_GainDailyTaskRes = "ScuffleAgent_SF_GainDailyTaskRes"
ScuffleAgent.SF_GetBattleRecordRes = "ScuffleAgent_SF_GetBattleRecordRes"
ScuffleAgent.SF_GetBattleVideoRes = "ScuffleAgent_SF_GetBattleVideoRes"
ScuffleAgent.SF_GetRankInfoRes = "ScuffleAgent_SF_GetRankInfoRes"
ScuffleAgent.SF_GetAllSeasonInfoRes = "ScuffleAgent_SF_GetAllSeasonInfoRes"
ScuffleAgent.SF_RefreshMyRankRes = "ScuffleAgent_SF_RefreshMyRankRes"
ScuffleAgent.SF_NotifyMatchingOverTimeRes = "ScuffleAgent_SF_NotifyMatchingOverTimeRes"
ScuffleAgent.SF_NotifyMatchFailRes = "ScuffleAgent_SF_NotifyMatchFailRes"
ScuffleAgent.SF_NotifyGameStartRes = "ScuffleAgent_SF_NotifyGameStartRes"
ScuffleAgent.SF_NotifyOpBanFinishRes = "ScuffleAgent_SF_NotifyOpBanFinishRes"
ScuffleAgent.SF_NotfiyStartSetFormRes = "ScuffleAgent_SF_NotfiyStartSetFormRes"
ScuffleAgent.SF_NotifiyOpReadyFightRes = "ScuffleAgent_SF_NotifiyOpReadyFightRes"
ScuffleAgent.SF_NotifyGameEndRes = "ScuffleAgent_SF_NotifyGameEndRes"

function ScuffleAgent:ctor()
	return
end

function ScuffleAgent:setExtId(extId)
	ScuffleAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function ScuffleAgent:sendSF_ScuffleInfoReq(handler, handlerObj, errHandler)
	local req = ScuffleExtension_pb.SF_ScuffleInfoReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(ScuffleAgent.SF_ScuffleInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function ScuffleAgent:handleSF_ScuffleInfoRes(status, msg)
	self:dispatch(ScuffleAgent.SF_ScuffleInfoRes, status, msg)
end

function ScuffleAgent:sendSF_StartMatchingReq(fun, handler, handlerObj, errHandler)
	local req = ScuffleExtension_pb.SF_StartMatchingReq()

	req.fun = fun

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(ScuffleAgent.SF_StartMatchingRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function ScuffleAgent:handleSF_StartMatchingRes(status, msg)
	self:dispatch(ScuffleAgent.SF_StartMatchingRes, status, msg)
end

function ScuffleAgent:sendSF_CancelMatchingReq(handler, handlerObj, errHandler)
	local req = ScuffleExtension_pb.SF_CancelMatchingReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(ScuffleAgent.SF_CancelMatchingRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function ScuffleAgent:handleSF_CancelMatchingRes(status, msg)
	self:dispatch(ScuffleAgent.SF_CancelMatchingRes, status, msg)
end

function ScuffleAgent:sendSF_LeaveGameReq(handler, handlerObj, errHandler)
	local req = ScuffleExtension_pb.SF_LeaveGameReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(ScuffleAgent.SF_LeaveGameRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function ScuffleAgent:handleSF_LeaveGameRes(status, msg)
	self:dispatch(ScuffleAgent.SF_LeaveGameRes, status, msg)
end

function ScuffleAgent:sendSF_BanPetReq(banPetIds_i32_Ary, handler, handlerObj, errHandler)
	local req = ScuffleExtension_pb.SF_BanPetReq()

	for i, v1 in ipairs(banPetIds_i32_Ary) do
		req.banPetIds:append(v1)
	end

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(ScuffleAgent.SF_BanPetRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function ScuffleAgent:handleSF_BanPetRes(status, msg)
	self:dispatch(ScuffleAgent.SF_BanPetRes, status, msg)
end

function ScuffleAgent:sendSF_SetFormReq(form_pb, buffId, handler, handlerObj, errHandler)
	local req = ScuffleExtension_pb.SF_SetFormReq()

	if form_pb ~= nil then
		req.form:ParseFromString(form_pb:SerializeToString())
	end

	req.buffId = buffId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(ScuffleAgent.SF_SetFormRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function ScuffleAgent:handleSF_SetFormRes(status, msg)
	self:dispatch(ScuffleAgent.SF_SetFormRes, status, msg)
end

function ScuffleAgent:sendSF_AchievePrizeInfoReq(handler, handlerObj, errHandler)
	local req = ScuffleExtension_pb.SF_AchievePrizeInfoReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(ScuffleAgent.SF_AchievePrizeInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function ScuffleAgent:handleSF_AchievePrizeInfoRes(status, msg)
	self:dispatch(ScuffleAgent.SF_AchievePrizeInfoRes, status, msg)
end

function ScuffleAgent:sendSF_GainAchievePrizeReq(id, handler, handlerObj, errHandler)
	local req = ScuffleExtension_pb.SF_GainAchievePrizeReq()

	req.id = id

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(ScuffleAgent.SF_GainAchievePrizeRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function ScuffleAgent:handleSF_GainAchievePrizeRes(status, msg)
	self:dispatch(ScuffleAgent.SF_GainAchievePrizeRes, status, msg)
end

function ScuffleAgent:sendSF_DailyTaskInfoReq(handler, handlerObj, errHandler)
	local req = ScuffleExtension_pb.SF_DailyTaskInfoReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(ScuffleAgent.SF_DailyTaskInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function ScuffleAgent:handleSF_DailyTaskInfoRes(status, msg)
	self:dispatch(ScuffleAgent.SF_DailyTaskInfoRes, status, msg)
end

function ScuffleAgent:sendSF_GainDailyTaskReq(taskId, handler, handlerObj, errHandler)
	local req = ScuffleExtension_pb.SF_GainDailyTaskReq()

	req.taskId = taskId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(ScuffleAgent.SF_GainDailyTaskRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function ScuffleAgent:handleSF_GainDailyTaskRes(status, msg)
	self:dispatch(ScuffleAgent.SF_GainDailyTaskRes, status, msg)
end

function ScuffleAgent:sendSF_GetBattleRecordReq(handler, handlerObj, errHandler)
	local req = ScuffleExtension_pb.SF_GetBattleRecordReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(ScuffleAgent.SF_GetBattleRecordRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function ScuffleAgent:handleSF_GetBattleRecordRes(status, msg)
	self:dispatch(ScuffleAgent.SF_GetBattleRecordRes, status, msg)
end

function ScuffleAgent:sendSF_GetBattleVideoReq(battleId, handler, handlerObj, errHandler)
	local req = ScuffleExtension_pb.SF_GetBattleVideoReq()

	req.battleId = battleId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(ScuffleAgent.SF_GetBattleVideoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function ScuffleAgent:handleSF_GetBattleVideoRes(status, msg)
	self:dispatch(ScuffleAgent.SF_GetBattleVideoRes, status, msg)
end

function ScuffleAgent:sendSF_GetRankInfoReq(handler, handlerObj, errHandler)
	local req = ScuffleExtension_pb.SF_GetRankInfoReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(ScuffleAgent.SF_GetRankInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function ScuffleAgent:handleSF_GetRankInfoRes(status, msg)
	self:dispatch(ScuffleAgent.SF_GetRankInfoRes, status, msg)
end

function ScuffleAgent:sendSF_GetAllSeasonInfoReq(handler, handlerObj, errHandler)
	local req = ScuffleExtension_pb.SF_GetAllSeasonInfoReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(ScuffleAgent.SF_GetAllSeasonInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function ScuffleAgent:handleSF_GetAllSeasonInfoRes(status, msg)
	self:dispatch(ScuffleAgent.SF_GetAllSeasonInfoRes, status, msg)
end

function ScuffleAgent:sendSF_RefreshMyRankReq(handler, handlerObj, errHandler)
	local req = ScuffleExtension_pb.SF_RefreshMyRankReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(ScuffleAgent.SF_RefreshMyRankRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function ScuffleAgent:handleSF_RefreshMyRankRes(status, msg)
	self:dispatch(ScuffleAgent.SF_RefreshMyRankRes, status, msg)
end

function ScuffleAgent:handleSF_NotifyMatchingOverTimeRes(status, msg)
	self:dispatch(ScuffleAgent.SF_NotifyMatchingOverTimeRes, status, msg)
end

function ScuffleAgent:handleSF_NotifyMatchFailRes(status, msg)
	self:dispatch(ScuffleAgent.SF_NotifyMatchFailRes, status, msg)
end

function ScuffleAgent:handleSF_NotifyGameStartRes(status, msg)
	self:dispatch(ScuffleAgent.SF_NotifyGameStartRes, status, msg)
end

function ScuffleAgent:handleSF_NotifyOpBanFinishRes(status, msg)
	self:dispatch(ScuffleAgent.SF_NotifyOpBanFinishRes, status, msg)
end

function ScuffleAgent:handleSF_NotfiyStartSetFormRes(status, msg)
	self:dispatch(ScuffleAgent.SF_NotfiyStartSetFormRes, status, msg)
end

function ScuffleAgent:handleSF_NotifiyOpReadyFightRes(status, msg)
	self:dispatch(ScuffleAgent.SF_NotifiyOpReadyFightRes, status, msg)
end

function ScuffleAgent:handleSF_NotifyGameEndRes(status, msg)
	self:dispatch(ScuffleAgent.SF_NotifyGameEndRes, status, msg)
end

ScuffleAgent.instance = ScuffleAgent.New()

return ScuffleAgent
