-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sharetask/agent/ShareTaskAgent.lua

module("logic.extensions.sharetask.agent.ShareTaskAgent", package.seeall)

local ShareTaskAgent = class("ShareTaskAgent", BaseAgent)

ShareTaskAgent.ShareTaskInfoRes = "ShareTaskAgent_ShareTaskInfoRes"
ShareTaskAgent.ShareTaskRefreshBossInfoRes = "ShareTaskAgent_ShareTaskRefreshBossInfoRes"
ShareTaskAgent.ShareTaskGainDiscoveryRewardRes = "ShareTaskAgent_ShareTaskGainDiscoveryRewardRes"
ShareTaskAgent.ShareTaskChallengeMyBossRes = "ShareTaskAgent_ShareTaskChallengeMyBossRes"
ShareTaskAgent.ShareTaskAssistListRes = "ShareTaskAgent_ShareTaskAssistListRes"
ShareTaskAgent.ShareTaskOtherBossInfoRes = "ShareTaskAgent_ShareTaskOtherBossInfoRes"
ShareTaskAgent.ShareTaskChallengeOtherBossRes = "ShareTaskAgent_ShareTaskChallengeOtherBossRes"
ShareTaskAgent.NotifyTriggerShareTaskRes = "ShareTaskAgent_NotifyTriggerShareTaskRes"

function ShareTaskAgent:ctor()
	return
end

function ShareTaskAgent:setExtId(extId)
	ShareTaskAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function ShareTaskAgent:sendShareTaskInfoReq(handler, handlerObj, errHandler)
	local req = ShareTaskExtension_pb.ShareTaskInfoReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(ShareTaskAgent.ShareTaskInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function ShareTaskAgent:handleShareTaskInfoRes(status, msg)
	forcePrint("=====RoleDataRequestor:_loadRequestShareTask===back")
	self:dispatch(ShareTaskAgent.ShareTaskInfoRes, status, msg)
end

function ShareTaskAgent:sendShareTaskRefreshBossInfoReq(handler, handlerObj, errHandler)
	local req = ShareTaskExtension_pb.ShareTaskRefreshBossInfoReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(ShareTaskAgent.ShareTaskRefreshBossInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function ShareTaskAgent:handleShareTaskRefreshBossInfoRes(status, msg)
	self:dispatch(ShareTaskAgent.ShareTaskRefreshBossInfoRes, status, msg)
end

function ShareTaskAgent:sendShareTaskGainDiscoveryRewardReq(handler, handlerObj, errHandler)
	local req = ShareTaskExtension_pb.ShareTaskGainDiscoveryRewardReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(ShareTaskAgent.ShareTaskGainDiscoveryRewardRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function ShareTaskAgent:handleShareTaskGainDiscoveryRewardRes(status, msg)
	self:dispatch(ShareTaskAgent.ShareTaskGainDiscoveryRewardRes, status, msg)
end

function ShareTaskAgent:sendShareTaskChallengeMyBossReq(handler, handlerObj, errHandler)
	local req = ShareTaskExtension_pb.ShareTaskChallengeMyBossReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(ShareTaskAgent.ShareTaskChallengeMyBossRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function ShareTaskAgent:handleShareTaskChallengeMyBossRes(status, msg)
	self:dispatch(ShareTaskAgent.ShareTaskChallengeMyBossRes, status, msg)
end

function ShareTaskAgent:sendShareTaskAssistListReq(handler, handlerObj, errHandler)
	local req = ShareTaskExtension_pb.ShareTaskAssistListReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(ShareTaskAgent.ShareTaskAssistListRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function ShareTaskAgent:handleShareTaskAssistListRes(status, msg)
	self:dispatch(ShareTaskAgent.ShareTaskAssistListRes, status, msg)
end

function ShareTaskAgent:sendShareTaskOtherBossInfoReq(bossId, handler, handlerObj, errHandler)
	local req = ShareTaskExtension_pb.ShareTaskOtherBossInfoReq()

	req.bossId = bossId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(ShareTaskAgent.ShareTaskOtherBossInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function ShareTaskAgent:handleShareTaskOtherBossInfoRes(status, msg)
	self:dispatch(ShareTaskAgent.ShareTaskOtherBossInfoRes, status, msg)
end

function ShareTaskAgent:sendShareTaskChallengeOtherBossReq(bossId, forFree, handler, handlerObj, errHandler)
	local req = ShareTaskExtension_pb.ShareTaskChallengeOtherBossReq()

	req.bossId = bossId
	req.forFree = forFree

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(ShareTaskAgent.ShareTaskChallengeOtherBossRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function ShareTaskAgent:handleShareTaskChallengeOtherBossRes(status, msg)
	self:dispatch(ShareTaskAgent.ShareTaskChallengeOtherBossRes, status, msg)
end

function ShareTaskAgent:sendShareTaskStopTriggerInfoReq()
	local req = ShareTaskExtension_pb.ShareTaskStopTriggerInfoReq()

	self:sendMsg(req)
end

function ShareTaskAgent:handleShareTaskStopTriggerInfoRes(status, msg)
	if status == 0 then
		ShareTaskController.instance:onGetShareTaskSetting(msg)
	end
end

function ShareTaskAgent:sendShareTaskStopTriggerChangeReq(isStopTrigger)
	local req = ShareTaskExtension_pb.ShareTaskStopTriggerChangeReq()

	req.isStopTrigger = isStopTrigger

	self:sendMsg(req)
end

function ShareTaskAgent:handleShareTaskStopTriggerChangeRes(status, msg)
	if status == 0 then
		ShareTaskController.instance:onGetShareTaskSetting(msg)
	end
end

function ShareTaskAgent:handleNotifyTriggerShareTaskRes(status, msg)
	self:dispatch(ShareTaskAgent.NotifyTriggerShareTaskRes, status, msg)
end

ShareTaskAgent.instance = ShareTaskAgent.New()

return ShareTaskAgent
