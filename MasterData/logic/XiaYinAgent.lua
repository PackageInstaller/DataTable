-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiayin/agent/XiaYinAgent.lua

module("logic.extensions.xiayin.agent.XiaYinAgent", package.seeall)

local XiaYinAgent = class("XiaYinAgent", BaseAgent)

function XiaYinAgent:sendPM_XiaYinGetInfoReq(activityId)
	local req = XiaYinExtension_pb.PM_XiaYinGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function XiaYinAgent:handlePM_XiaYinGetInfoRes(status, msg)
	if status == 0 then
		XiaYinModel.instance:onXiaYinGetInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.XiaYinGetInfoRes)
	end
end

function XiaYinAgent:sendPM_XiaYinChallengeReq(activityId, tierId, stageId, form)
	local req = XiaYinExtension_pb.PM_XiaYinChallengeReq()

	req.activityId = activityId
	req.tierId = tierId
	req.stageId = stageId

	req.form:ParseFromString(form:SerializeToString())
	self:sendMsg(req)

	self._challengeActivityId = activityId
	self._tierId = tierId
	self._stageId = stageId
end

function XiaYinAgent:handlePM_XiaYinChallengeRes(status, msg)
	if status == 0 then
		XiaYinModel.instance:onXiaYinChallengeRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.XiaYinChallengeRes)
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function XiaYinAgent:sendPM_XiaYinGainProgressPrizeReq(activityId, prizeId)
	local req = XiaYinExtension_pb.PM_XiaYinGainProgressPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)

	self._prizeActivityId = activityId
	self._prizeId = prizeId
end

function XiaYinAgent:handlePM_XiaYinGainProgressPrizeRes(status, msg)
	if status == 0 then
		XiaYinModel.instance:onXiaYinGainProgressPrizeRes(msg, self._prizeActivityId, self._prizeId)
		GlobalDispatcher:dispatch(GlobalNotify.XiaYinGainProgressPrizeRes)
	end

	self._prizeActivityId = nil
	self._prizeId = nil
end

function XiaYinAgent:handlePM_Notify_XiaYinChallengeRes(status, msg)
	if status == 0 then
		XiaYinModel.instance:onNotifyXiaYinChallengeRes(msg, self._challengeActivityId, self._tierId, self._stageId)
		GlobalDispatcher:dispatch(GlobalNotify.NotifyXiaYinChallengeRes, self._challengeActivityId)
	end

	self._challengeActivityId = nil
	self._tierId = nil
	self._stageId = nil
end

function XiaYinAgent:sendPM_XiaYinUpgradeSignInBuffReq(activityId)
	local req = XiaYinExtension_pb.PM_XiaYinUpgradeSignInBuffReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function XiaYinAgent:handlePM_XiaYinUpgradeSignInBuffRes(status, msg)
	if status == 0 then
		XiaYinModel.instance:upgradeBuffRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.XiaYinUpgradeSignInBuffRes)
	end
end

XiaYinAgent.instance = XiaYinAgent.New()

return XiaYinAgent
