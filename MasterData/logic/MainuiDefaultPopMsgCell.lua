-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/view/MainuiDefaultPopMsgCell.lua

module("logic.extensions.mainui.view.MainuiDefaultPopMsgView", package.seeall)

local MainuiDefaultPopMsgView = class("MainuiDefaultPopMsgView", MainuiPopMsgCellBase)

function MainuiDefaultPopMsgView:ctor(mainGO, params)
	MainuiDefaultPopMsgView.super.ctor(self, mainGO, params)
end

function MainuiDefaultPopMsgView:_unbindEvents()
	GameUtil.rmClickHandler(self._btnCancel)
	GameUtil.rmClickHandler(self._btnSure)
end

function MainuiDefaultPopMsgView:_bindEvents()
	GameUtil.addClickHandler(self._btnSure, self._OnClickAcceptInvite, self)
	GameUtil.addClickHandler(self._btnCancel, self._OnClickRefuseInvite, self)
end

function MainuiDefaultPopMsgView:_buildUI()
	self._btnCancel = goutil.findChild(self.mainGO, "btnCancel")
	self._btnSure = goutil.findChild(self.mainGO, "btnSure")
	self._head = goutil.findChild(self.mainGO, "head")
	self._txtName = goutil.findChildTextComponent(self.mainGO, "txtName")
	self._txtLevel = goutil.findChildTextComponent(self.mainGO, "txtLevel")
	self._txtDesc = goutil.findChildTextComponent(self.mainGO, "txtDesc")
	self._txrArea = goutil.findChildTextComponent(self.mainGO, "area/txt")
	self._countDownGo = goutil.findChild(self.mainGO, "cutdown")
	self._txtCutdown = goutil.findChildTextComponent(self.mainGO, "cutdown/txt")
	self._bgChange = self.mainGO:GetComponent("UIImageSpriteChange")
end

function MainuiDefaultPopMsgView:_onExit()
	if not goutil.isNil(self._head) then
		HeadItemController.instance:resetHeadCell(self._head)
	end

	removetimer(self._onTeamInviteCountDown, self)
end

function MainuiDefaultPopMsgView:_onEnter()
	self._bgChange:SetState(self._info.bg or 0)
	self:_setTextOrDisable(self._txtCutdown, self._info.cd - ServerTime.now(), self._info.cd > 0)
	self:_setTextOrDisable(self._txtDesc, self._info.desc)

	if not string.nilorempty(self._info.lvReplace) then
		self:_setTextOrDisable(self._txtLevel, self._info.lvReplace)
	else
		self:_setTextOrDisable(self._txtLevel, langPara("等级：<color=#CD7800FF>%s</color>", self._info.headInfo.playerLv), self._info.headInfo.playerLv ~= nil)
	end

	self._txtName.text = not string.nilorempty(self._info.nameReplace) and self._info.nameReplace or self._info.headInfo.userName

	HeadItemController.instance:setHeadCellByInfo(self._head, self._info.headInfo)

	if self._info.cd > 0 then
		settimer(0.5, self._onTeamInviteCountDown, self)
	end

	GameUtil.SetActive(self._btnCancel, self._info.rejectFunc ~= nil)
	GameUtil.SetActive(self._btnSure, self._info.acceptFunc ~= nil)
	GameUtil.SetActive(self._countDownGo, self._info.cd > 0)

	if self._info.cd - ServerTime.now() <= 0 then
		self:_setTextOrDisable(self._txtCutdown, 0, self._info.cd > 0)
	else
		self:_setTextOrDisable(self._txtCutdown, self._info.cd - ServerTime.now(), self._info.cd > 0)
	end
end

function MainuiDefaultPopMsgView:_onTeamInviteCountDown()
	if self._info.cd - ServerTime.now() <= 0 then
		removetimer(self._onTeamInviteCountDown, self)
		self:_setTextOrDisable(self._txtCutdown, 0, self._info.cd > 0)

		if self._info.bTimeOutReject then
			GameUtil.callBack(self._info.rejectFunc, self._info.thisArg, self._params)
		end

		self:_closeSelf()
	else
		self:_setTextOrDisable(self._txtCutdown, self._info.cd - ServerTime.now(), self._info.cd > 0)
	end
end

function MainuiDefaultPopMsgView:_OnClickAcceptInvite()
	local function doIt()
		GameUtil.callBack(self._info.acceptFunc, self._info.thisArg, self._params)
		self:_closeSelf()
	end

	if self._info.askAcceptFunc then
		GameUtil.callBack(self._info.askAcceptFunc, self._info.thisArg, self._params, doIt)
	else
		doIt()
	end
end

function MainuiDefaultPopMsgView:_OnClickRefuseInvite()
	local function doIt()
		GameUtil.callBack(self._info.rejectFunc, self._info.thisArg, self._params)
		self:_closeSelf()
	end

	if self._info.askRejectFunc then
		GameUtil.callBack(self._info.askRejectFunc, self._info.thisArg, self._params, doIt)
	else
		doIt()
	end
end

return MainuiDefaultPopMsgView
