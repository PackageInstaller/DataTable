-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originage/controller/OriginAgeController.lua

module("logic.extensions.originage.controller.OriginAgeController", package.seeall)

local OriginAgeController = class("OriginAgeController", BaseController)

function OriginAgeController:onInit()
	GlobalDispatcher:addListener(GlobalNotify.ON_CLICK_ITEM_CHAT, self._onChatItemClick, self)
	self:onReset()
end

function OriginAgeController:onReset()
	self._nextSendTime = nil
	self._temp_activityId = nil
	self._temp_inviteCode = nil
	self._temp_templateId = nil

	removetimer(self._sendInviteMsg, self)
end

function OriginAgeController:getDefaultActivityId()
	return 532001
end

function OriginAgeController:sendGetInfo(activityId)
	OriginAgeLaunchAgent.instance:sendPM_OriginAgeLaunchGetInfoReq(activityId)
end

function OriginAgeController:onGetInfo(msg)
	OriginAgeModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.OriginAgeInfoUpdate)
end

function OriginAgeController:sendGetPrize(activityId, prizeType)
	OriginAgeLaunchAgent.instance:sendPM_OriginAgeLaunchGainPrizeReq(activityId, prizeType)
end

function OriginAgeController:onGetPrize(msg)
	OriginAgeModel.instance:onGetPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.OriginAgeInfoUpdate)
end

function OriginAgeController:sendBindCode(activityId, code)
	OriginAgeLaunchAgent.instance:sendPM_OriginAgeLaunchBindCodeReq(activityId, code)
end

function OriginAgeController:onBindCode(msg)
	OriginAgeModel.instance:onBindCode(msg)

	if msg.resultCode == -1 then
		TipsFacade.instance:openCommonTips("邀请码有误，请检查")
	elseif msg.resultCode == -2 then
		TipsFacade.instance:openCommonTips("对方已经绑定过我的邀请码")
	elseif msg.resultCode == -3 then
		TipsFacade.instance:openCommonTips("找不到用户，请换一个邀请码")
	elseif msg.resultCode == -4 then
		TipsFacade.instance:openCommonTips("不能绑定自己邀请码哦，请重新输入")
	elseif msg.resultCode == -5 then
		TipsFacade.instance:openCommonTips("已经绑定过邀请码了，不需要重新绑定")
	end

	GlobalDispatcher:dispatch(GlobalNotify.OriginAgeBindEnd, msg)
end

function OriginAgeController:_onChatItemClick(tpId, chatMsgMo)
	local activityId = chatMsgMo:getParam("activityId", true)

	if activityId > 0 and tpId > 0 then
		local actCfg = OriginAgeConfig.instance:getActivityCfgById(activityId)

		if actCfg and tpId == checknumber(actCfg.templateId) then
			local inviteCode = chatMsgMo:getParam("inviteCode", false)

			self:openInviteView(activityId, inviteCode, tpId)
		end
	end
end

function OriginAgeController:openInviteView(activityId, inviteCode, templateId)
	if ActivityDefineController.instance:checkIsInActivityTimeByActivityId(activityId) == true then
		local cfg = ChatConfig.instance:getSystemMsgT(templateId)
		local content = ""

		if cfg then
			local t = {
				inviteCode = inviteCode
			}

			content = StringUtil.parseJsonParams(cfg.template, t)
		end

		UIStateManager.instance:push(ViewName.OriginagebindView, activityId, content)
	else
		FloatWordMgr.instance:show(lang("活动已过期"))
	end
end

function OriginAgeController:tryOpenFriendView(activityId, inviteCode, templateId)
	local sendTime = self._nextSendTime

	if not sendTime or sendTime < ServerTime.now() then
		self:startHelp(activityId, inviteCode, templateId)
		ViewMgr.instance:open(ViewName.FriendSelect, 0, 0, lang("请选择好友发送邀请码"))
	else
		FloatWordMgr.instance:show("发送频率太快，请稍后")
	end
end

function OriginAgeController:startHelp(activityId, inviteCode, templateId)
	self._temp_activityId = activityId
	self._temp_inviteCode = inviteCode
	self._temp_templateId = templateId

	GlobalDispatcher:addListener(GlobalNotify.FriendSelectedClose, self.endHelp, self)
	GlobalDispatcher:addListener(GlobalNotify.FriendSelected, self._onSelectFriend, self)
end

function OriginAgeController:endHelp()
	GlobalDispatcher:removeListener(GlobalNotify.FriendSelected, self._onSelectFriend, self)
	GlobalDispatcher:removeListener(GlobalNotify.FriendSelectedClose, self.endHelp, self)
end

function OriginAgeController:_onSelectFriend(ids)
	if self._temp_inviteCode and #ids > 0 then
		self:_friendSelected(ids)
	end

	self:endHelp()
end

function OriginAgeController:_friendSelected(buddyIds)
	self._buddyIds = buddyIds

	local tpId = self._temp_templateId

	self._msgType = GameEnum.ChatType.System

	local cfg = ChatConfig.instance:getSystemMsgT(tpId)
	local params = {}

	params.activityId = self._temp_activityId
	params.inviteCode = self._temp_inviteCode

	local dataT = {
		tpId = tpId,
		params = params
	}

	self._content = GameUtil.jsonToString(dataT)

	local buddyCount = #self._buddyIds

	self.msgId = 0

	if buddyCount > 0 then
		local gap = 0.5

		self._nextSendTime = ServerTime.now() + buddyCount * gap + 1

		settimer(gap, self._sendInviteMsg, self, true)
	end
end

function OriginAgeController:_sendInviteMsg()
	local receiveId = table.remove(self._buddyIds)

	ChatAgent.instance:sendSendMsgReq(GameEnum.ChatChannel.Private, self._msgType, self._content, receiveId, nil, nil)

	if #self._buddyIds == 0 then
		FloatWordMgr.instance:show("已成功发送邀请")
		removetimer(self._sendInviteMsg, self)

		self._temp_activityId = nil
		self._temp_inviteCode = nil
		self._temp_templateId = nil
	end
end

OriginAgeController.instance = OriginAgeController.New()

return OriginAgeController
