-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tianyanmatch/controller/TianYanMatchController.lua

module("logic.extensions.tianyanmatch.controller.TianYanMatchController", package.seeall)

local TianYanMatchController = class("TianYanMatchController", BaseController)

TianYanMatchController.SEND_FRIEND_INVITE_CD = 60

function TianYanMatchController:ctor()
	TianYanMatchController.super.ctor(self)
end

function TianYanMatchController:onInit()
	TianYanMatchController.super.onInit(self)
end

function TianYanMatchController:onReset()
	TianYanMatchController.super.onReset(self)
	removetimer(self._sendInviteMsg, self)
end

function TianYanMatchController:_openClearStarGame(activityId)
	local actCfg = ClearStarGameConfig.instance:getActivityCfgById(activityId)
	local info = ClearStarGameModel.instance:getInfo(activityId)

	if info == nil then
		return
	end

	local times = actCfg.dailyTime - checknumber(info.todayTimes)

	if times <= 0 then
		local text = string.format("今日剩余次数不足")

		TipsFacade.instance:openTipWindow("提示", text, nil, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	UIStateManager.instance:push(ViewName.TianYanMatchGameView, activityId, false)
end

function TianYanMatchController:sendInviteFriend(activityId, ids)
	self._sendInviteFriendTime = ServerTime.now()
	self._tempSendIds = ids
	self._tempSendActivityId = activityId

	TianYanMatchAgent.instance:sendPM_TianYanMatchGenKeyReq(activityId)
end

function TianYanMatchController:getSendInviteFriendTime()
	return self._sendInviteFriendTime or 0
end

function TianYanMatchController:handlePM_TianYanMatchGetInfoRes(msg)
	TianYanMatchModel.instance:saveInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.TianYanMatchGetInfo)

	if self._isNeedSendMatch == true then
		if self._tempToyId ~= TianYanMatchModel.instance:getMyToyId(self._tempSendActivityId) then
			FloatWordMgr.instance:show(lang("玩偶类型不符"))

			self._tempSendActivityId = nil
			self._tempUserIdFromBuddy = nil
			self._tempKey = nil
			self._tempToyId = nil
		elseif self:isCanMatch(self._tempSendActivityId, false) == true then
			TianYanMatchAgent.instance:sendPM_TianYanMatchMatchBuddyReq(self._tempSendActivityId, self._tempUserIdFromBuddy, self._tempKey)
		else
			self._tempSendActivityId = nil
			self._tempUserIdFromBuddy = nil
			self._tempKey = nil
			self._tempToyId = nil
		end

		self._isNeedSendMatch = nil
	end
end

function TianYanMatchController:handlePM_TianYanMatchSelectToyRes(msg)
	TianYanMatchModel.instance:saveMyToyId(msg)
	GlobalDispatcher:dispatch(GlobalNotify.TianYanMatchGetInfo)
end

function TianYanMatchController:handlePM_TianYanMatchUpFriendshipRes(msg)
	TianYanMatchModel.instance:saveUpFriendship(msg)
	GlobalDispatcher:dispatch(GlobalNotify.TianYanMatchGetInfo)
end

function TianYanMatchController:handlePM_TianYanMatchSetWishToyRes(msg)
	TianYanMatchModel.instance:saveMatchToyId(msg)
	GlobalDispatcher:dispatch(GlobalNotify.TianYanMatchGetInfo)
end

function TianYanMatchController:handlePM_TianYanMatchMatchRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.TianYanMatchGetInfo)
end

function TianYanMatchController:handlePM_TianYanMatchCancelMatchRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_TianYanMatchCancelMatchRes)
end

function TianYanMatchController:handlePM_TianYanMatchGenKeyRes(msg)
	self.msgId = 0
	self._tempKey = msg.encryptedKey

	settimer(1, self._sendInviteMsg, self, true)
end

function TianYanMatchController:_sendInviteMsg()
	self.msgId = self.msgId + 1

	if self._tempSendIds and self._tempSendIds[self.msgId] then
		local activityCfg = TianYanMatchConfig.instance:getActivityCfg(self._tempSendActivityId)
		local userId = self._tempSendIds[self.msgId]
		local myToyId = TianYanMatchModel.instance:getMyToyId(self._tempSendActivityId)
		local myToyCfg = TianYanMatchConfig.instance:getToyCfg(self._tempSendActivityId, myToyId)
		local matchToyId = TianYanMatchModel.instance:getMatchToyId(self._tempSendActivityId)
		local matchToyCfg = TianYanMatchConfig.instance:getToyCfg(self._tempSendActivityId, matchToyId)
		local dataT = {
			tpId = activityCfg.template,
			params = {
				activityId = self._tempSendActivityId,
				toyNameA = myToyCfg.desc,
				toyNameB = matchToyCfg.desc,
				matchKey = self._tempKey,
				targetToyId = matchToyId
			}
		}
		local content = GameUtil.jsonToString(dataT)

		ChatAgent.instance:sendSendMsgReq(GameEnum.ChatChannel.Private, GameEnum.ChatType.System, content, userId, nil, nil)
	else
		FloatWordMgr.instance:show("已发送邀请")

		self._tempSendIds = nil
		self._tempSendActivityId = nil
		self._tempKey = nil

		removetimer(self._sendInviteMsg, self)
	end
end

function TianYanMatchController:handlePM_TianYanMatchMatchBuddyRes(msg)
	if msg.code == 0 then
		FloatWordMgr.instance:show(lang("配对成功，前往活动界面领取奖励吧！"))

		local dataT = {
			tpId = 88,
			params = {
				activityId = self._tempSendActivityId
			}
		}
		local content = GameUtil.jsonToString(dataT)

		ChatAgent.instance:sendSendMsgReq(GameEnum.ChatChannel.Private, GameEnum.ChatType.System, content, self._tempUserIdFromBuddy, nil, nil)
	elseif msg.code == 3 then
		FloatWordMgr.instance:show(lang("此配对信息已失效"))
	end

	self._tempUserIdFromBuddy = nil
	self._tempSendActivityId = nil

	GlobalDispatcher:dispatch(GlobalNotify.TianYanMatchGetInfo)
end

function TianYanMatchController:handlePM_TianYanMatchGainMatchPrizeRes(msg)
	TianYanMatchModel.instance:saveGainMatchPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_TianYanMatchGainMatchPrizeRes)
end

function TianYanMatchController:handlePM_TianYanMatchGainManualPrizeRes(msg)
	TianYanMatchModel.instance:saveManualPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.TianYanMatchGetInfo)
end

function TianYanMatchController:handlePM_TianYanMatchRankViewRes(msg)
	TianYanMatchModel.instance:saveRankInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.TianYanMatchGetInfo)
end

function TianYanMatchController:handlePM_TianYanMatchNotifyMatchSucRes(msg)
	TianYanMatchModel.instance:saveMatchResult(msg)
	removetimer(self._sendInviteMsg, self)
	GlobalDispatcher:dispatch(GlobalNotify.PM_TianYanMatchNotifyMatchSucRes)
end

function TianYanMatchController:handlePM_TianYanMatchNotifyMatchFailRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_TianYanMatchNotifyMatchFailRes)
end

function TianYanMatchController:matchFromBuddy(activityId, playId, matchKey, targetToyId)
	if not ActivityDefineController.instance:checkIsInActivityTimeByActivityId(activityId) then
		FloatWordMgr.instance:show(lang("活动已过期"))

		return false
	end

	if RoleModel.instance:getUserId() == playId then
		return
	end

	self._tempSendActivityId = activityId
	self._tempUserIdFromBuddy = playId
	self._tempKey = matchKey
	self._tempToyId = targetToyId
	self._isNeedSendMatch = true

	TianYanMatchAgent.instance:sendPM_TianYanMatchGetInfoReq(activityId)
end

function TianYanMatchController:jumpToActivityView(activityId)
	if ActivityDefineController.instance:checkIsInActivityTimeByActivityId(activityId) == true then
		UIStateManager.instance:push(ViewName.TianYanMatchMainView, activityId)
	else
		FloatWordMgr.instance:show(lang("活动已过期"))
	end
end

function TianYanMatchController:isCanMatch(activityId, isNeedMatchToy)
	if not ActivityDefineController.instance:checkIsInActivityTimeByActivityId(activityId) then
		FloatWordMgr.instance:show(lang("活动已过期"))

		return false
	end

	if TianYanMatchModel.instance:getMatchResultInfo(activityId) ~= nil then
		FloatWordMgr.instance:show(lang("仍有未完成的配对,请前往活动界面领取配对奖励"))

		return false
	end

	local friendship = TianYanMatchModel.instance:getFriendship(activityId)
	local matchToyId = TianYanMatchModel.instance:getMatchToyId(activityId)
	local actCfg = TianYanMatchConfig.instance:getActivityCfg(activityId)

	if friendship < actCfg.friendshipLimit then
		FloatWordMgr.instance:show(lang("尚未达成配对条件，请先培养玩偶"))

		return false
	elseif isNeedMatchToy and matchToyId < 0 then
		FloatWordMgr.instance:show(lang("尚未达成配对条件，请先培养玩偶并选择想要的完成玩偶组合"))

		return false
	end

	local todayMatchTime = TianYanMatchModel.instance:getMatchTime(activityId)

	if todayMatchTime >= actCfg.dailyToyCount then
		FloatWordMgr.instance:show(lang("今日已无配对次数"))

		return false
	end

	return true
end

function TianYanMatchController:hasManualPrize(activityId)
	local manualCfgs = TianYanMatchConfig.instance:getManualCfgs(activityId)

	for i, v in ipairs(manualCfgs) do
		local isActive = TianYanMatchModel.instance:isActiveManual(activityId, v.manualId)
		local isGain = TianYanMatchModel.instance:isGainManualPrize(activityId, v.manualId)

		if isActive and not isGain then
			return true
		end
	end

	return false
end

TianYanMatchController.instance = TianYanMatchController.New()

return TianYanMatchController
