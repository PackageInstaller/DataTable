-- chunkname: @modules/logic/versionactivity2_6/xugouji/view/XugoujiCardInfoView.lua

module("modules.logic.versionactivity2_6.xugouji.view.XugoujiCardInfoView", package.seeall)

local XugoujiCardInfoView = class("XugoujiCardInfoView", BaseView)
local leftAnchorPos = Vector2(-530, -60)
local rightAnchorPos = Vector2(530, -60)
local actId = VersionActivity2_6Enum.ActivityId.Xugouji

function XugoujiCardInfoView:onInitView()
	self._goInfo = gohelper.findChild(self.viewGO, "#go_Tips")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click")
	self._txtDesc = gohelper.findChildText(self._goInfo, "Scroll View/Viewport/#txt_Descr")
	self._txtName = gohelper.findChildText(self._goInfo, "Info/#txt_ChessName")
	self._cardIcon = gohelper.findChildImage(self._goInfo, "Info/#image_Skill")
	self._viewAnimator = ZProj.ProjAnimatorPlayer.Get(self.viewGO)

	self.addEventCb(self, XugoujiController.instance, XugoujiEvent.ManualExitGame, self.closeThis, self)
	self.addEventCb(self, XugoujiController.instance, XugoujiEvent.OnOpenGameResultView, self.closeThis, self)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function XugoujiCardInfoView:addEvents()
	self._btnClose:AddClickListener(self._onCloseClick, self)
	self.addEventCb(self, XugoujiController.instance, XugoujiEvent.GuideCloseCardInfoView, self._closeByGuide, self)
end

function XugoujiCardInfoView:removeEvents()
	self._btnClose:RemoveClickListener()
	self.removeEventCb(self, XugoujiController.instance, XugoujiEvent.GuideCloseCardInfoView, self._closeByGuide, self)
end

function XugoujiCardInfoView:closeThis()
	BaseView.closeThis(self)
end

function XugoujiCardInfoView:_onCloseClick()
	TaskDispatcher.cancelTask(self._onCloseClick, self)
	gohelper.setActive(self._btnClose.gameObject, false)
	self._viewAnimator:Play(UIAnimationName.Close, self.closeThis, self)
end

function XugoujiCardInfoView:_closeByGuide()
	TaskDispatcher.cancelTask(self._onCloseClick, self)
	gohelper.setActive(self._btnClose.gameObject, false)
	self._viewAnimator:Play(UIAnimationName.Close, self.closeThis, self)
end

function XugoujiCardInfoView:_editableInitView()
	return
end

function XugoujiCardInfoView:onOpen()
	local viewParam = self.viewParam
	local cardId = viewParam.cardId
	local isMyTurn = Activity188Model.instance:isMyTurn()
	local trans = self._goInfo.transform

	if isMyTurn then
		if not leftAnchorPos then
			local anchorPos = rightAnchorPos
			local cardCfg = Activity188Config.instance:getCardCfg(actId, cardId)

			recthelper.setAnchor(trans, anchorPos.x, anchorPos.y)

			self._txtDesc.text = cardCfg.desc
			self._txtName.text = cardCfg.name

			local cardIconPath = cardCfg.resource

			if cardIconPath and cardIconPath ~= "" then
				UISpriteSetMgr.instance:setXugoujiSprite(self._cardIcon, cardIconPath)
			end

			if not isMyTurn then
				TaskDispatcher.runDelay(self._onCloseClick, self, 2)
			end

			gohelper.setActive(self._btnClose.gameObject, true)
		end
	end
end

function XugoujiCardInfoView:onClose()
	TaskDispatcher.cancelTask(self._onCloseClick, self)
	XugoujiController.instance:dispatchEvent(XugoujiEvent.CloseCardInfoView)
end

function XugoujiCardInfoView:onDestroyView()
	return
end

return XugoujiCardInfoView
