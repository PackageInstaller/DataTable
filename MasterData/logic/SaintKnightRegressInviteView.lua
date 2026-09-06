-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/saintknightregress/view/SaintKnightRegressInviteView.lua

module("logic.extensions.saintknightregress.view.SaintKnightRegressInviteView", package.seeall)

local SaintKnightRegressInviteView = class("SaintKnightRegressInviteView", ViewComponent)

function SaintKnightRegressInviteView:ctor()
	SaintKnightRegressInviteView.super.ctor(self)
end

function SaintKnightRegressInviteView:unbindEvents()
	SaintKnightRegressInviteView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnCopy)
	GameUtil.rmClickHandler(self._btnSend)
end

function SaintKnightRegressInviteView:bindEvents()
	SaintKnightRegressInviteView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnCopy, self._onClickCopy, self)
	GameUtil.addClickHandler(self._btnSend, self._onClickSend, self)
end

function SaintKnightRegressInviteView:buildUI()
	SaintKnightRegressInviteView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._txtInviteCode = self:getTxt("txtInviteCode")
	self._txtInviteCount = self:getTxt("txtInviteCount")
	self._btnCopy = self:getGo("btnCopy")
	self._btnSend = self:getGo("btnSend")
end

function SaintKnightRegressInviteView:onExit()
	SaintKnightRegressInviteView.super.onExit(self)
	SaintKnightRegressController.instance:endHelp()
end

function SaintKnightRegressInviteView:onEnter()
	SaintKnightRegressInviteView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())
	self._activityCfg = SaintKnightRegressConfig.instance:getActivityCfg(self._activityId)

	local regressPetList = SaintKnightRegressModel.instance:getRegressPlayerList(self._activityId)

	self._txtInviteCode.text = SaintKnightRegressModel.instance:getInviteCode(self._activityId)
	self._txtInviteCount.text = langPara("当前已邀请好友: <color=#EB4642>%d/%d</color>", #regressPetList, self._activityCfg.inviteCountLimit)
end

function SaintKnightRegressInviteView:_onClickCopy()
	local cfg = ChatConfig.instance:getSystemMsgT(self._activityCfg.templateId)
	local content = ""

	if cfg then
		local t = {
			inviteCode = SaintKnightRegressModel.instance:getInviteCode(self._activityId)
		}

		content = StringUtil.parseJsonParams(cfg.template, t)
		content = string.match(content, "(.-)<color.+</color>")
	end

	if Framework.OSDef.isEditor then
		Game.TextUtil.CopyToClipBoard(content)
	else
		Clipboard.copy(content)
	end

	FloatWordMgr.instance:show("邀请码已复制")
end

function SaintKnightRegressInviteView:_onClickSend()
	local sendTime = SaintKnightRegressController.instance:getSendTime()

	if not sendTime or sendTime + 5 < ServerTime.now() then
		ViewMgr.instance:open(ViewName.FriendSelect, 0, 0, lang("请选择好友发送邀请码"))
		SaintKnightRegressController.instance:startHelp(self._activityId)
	else
		FloatWordMgr.instance:show("发送频率太快，请稍后")
	end
end

return SaintKnightRegressInviteView
