-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/tlctip/TLChallengeTipView.lua

module("logic.extensions.timelimitedchallenge.TLChallengeTipView", package.seeall)

local TLChallengeTipView = class("TLChallengeTipView", ViewComponent)

function TLChallengeTipView:unbindEvents()
	TLChallengeTipView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._closeButton)
	GameUtil.rmClickHandler(self._btnOk)
	GameUtil.rmClickHandler(self._btnCancel)
end

function TLChallengeTipView:bindEvents()
	TLChallengeTipView.super.bindEvents(self)
	GameUtil.addClickHandler(self._closeButton, self.close, self)
	GameUtil.addClickHandler(self._btnOk, self._onClickOk, self)
	GameUtil.addClickHandler(self._btnCancel, self._onClickCancel, self)
end

function TLChallengeTipView:buildUI()
	TLChallengeTipView.super.buildUI(self)

	self._closeButton = self:getGo("btnClose")
	self._btnOk = self:getGo("btnOk")
	self._btnCancel = self:getGo("btnCancel")
	self._txtTip = MaterialMgr.findGraphicText(self.mainGO, "txtTip")

	if self._txtTip == nil then
		self._txtTip = self:getTxt("txtTip")
	end

	self._txtTitle = self:getTxt("txtTitle")
end

function TLChallengeTipView:onEnter()
	TLChallengeTipView.super.onEnter(self)

	self._params = self:getFirstParam()

	if self._params then
		self._okHandler = self._params.okHandler
		self._okTarget = self._params.okTarget

		if not goutil.isNil(self._txtTip) then
			self._txtTip.text = self._params.text
		end

		if not goutil.isNil(self._txtTitle) then
			self._txtTitle.text = self._params.title or "提 示"
		end
	end
end

function TLChallengeTipView:_onClickOk()
	self:close()
	GameUtil.callBack(self._okHandler, self._okTarget)
end

function TLChallengeTipView:_onClickCancel()
	self:close()
end

return TLChallengeTipView
