-- chunkname: @modules/logic/versionactivity3_7/anniversary3/rpc/Activity233Rpc.lua

module("modules.logic.versionactivity3_7.anniversary3.rpc.Activity233Rpc", package.seeall)

local Activity233Rpc = class("Activity233Rpc", BaseRpc)

function Activity233Rpc:onInit()
	self:reInit()
end

function Activity233Rpc:reInit()
	return
end

function Activity233Rpc:sendGetAct233BpInfoRequest(getTask, activityId, callback, callbackObj)
	local req = Activity233Module_pb.GetAct233BpInfoRequest()

	req.getTask = getTask
	req.activityId = activityId

	return self:sendMsg(req, callback, callbackObj)
end

function Activity233Rpc:onReceiveGetAct233BpInfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Anniversary3ActBpModel.instance:setActBpInfo(msg)
	Anniversary3ActBpController.instance:dispatchEvent(Anniversary3ActBpEvent.OnGetInfo)
end

function Activity233Rpc:sendGetAct233BpBonusRequest(actId, level, payBonus, callback, callbackobj)
	local req = Activity233Module_pb.GetAct233BpBonusRequest()

	req.activityId = actId
	req.level = level
	req.payBonus = payBonus
	self._selectLv = level

	return self:sendMsg(req, callback, callbackobj)
end

function Activity233Rpc:onReceiveGetAct233BpBonusReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local waitShowRewards = Anniversary3ActBpModel.instance:getWaitShowRewards()

	if not self._selectLv or self._selectLv <= 0 then
		local lastLv = Anniversary3ActBpModel.instance:getActBpMinUngetRewardLevel(msg.bpId, msg.activityId)
		local curLv = Anniversary3ActBpModel.instance:getActBpLevel(msg.bpId, msg.activityId)
		local hasKey = Anniversary3ActBpModel.instance:hasKeyBonusBetweenLvs(lastLv, curLv, msg.bpId, msg.activityId)

		Anniversary3ActBpController.instance:showCommonPropView(waitShowRewards, hasKey)
	else
		local bonusCo = Activity233Config.instance:getBonusCo(self._selectLv, msg.bpId)
		local isKeyLv = bonusCo and bonusCo.keyBonus >= 1

		Anniversary3ActBpController.instance:showCommonPropView(waitShowRewards, isKeyLv)
	end

	Anniversary3ActBpModel.instance:updateActBpBonusInfo(msg.scoreBonusInfo, msg.bpId, msg.activityId)
	Anniversary3ActBpController.instance:dispatchEvent(Anniversary3ActBpEvent.OnGetBonus)
	Anniversary3ActBpModel.instance:setWaitShowRewards()
end

function Activity233Rpc:onReceiveAct233BpScoreUpdatePush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Anniversary3ActBpModel.instance:updateScore(msg.score, msg.bpId, msg.activityId)
	Anniversary3ActBpController.instance:dispatchEvent(Anniversary3ActBpEvent.OnUpdateScore)
end

function Activity233Rpc:sendAct233BpPayRequest(actId, callback, callbackObj)
	local req = Activity233Module_pb.Act233BpPayRequest()

	req.activityId = actId

	return self:sendMsg(req, callback, callbackObj)
end

function Activity233Rpc:onReceiveAct233BpPayReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Anniversary3ActBpModel.instance:updatePayStatus(Anniversary3ActBpEnum.PayStatus.Payed, msg.bpId, msg.activityId)
	Anniversary3ActBpModel.instance:updateActBpBonusInfo(msg.scoreBonusInfo, msg.bpId, msg.activityId)

	local waitShowRewards = Anniversary3ActBpModel.instance:getWaitShowRewards()

	Anniversary3ActBpController.instance:showCommonPropView(waitShowRewards, false)
	Anniversary3ActBpModel.instance:setWaitShowRewards()
	Anniversary3ActBpController.instance:dispatchEvent(Anniversary3ActBpEvent.OnBuySuccess)
end

Activity233Rpc.instance = Activity233Rpc.New()

return Activity233Rpc
