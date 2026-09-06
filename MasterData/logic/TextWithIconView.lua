-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tips/view/TextWithIconView.lua

module("logic.extensions.tips.view.TextWithIconView", package.seeall)

local TextWithIconView = class("TextWithIconView", ViewComponent)

function TextWithIconView:ctor()
	TextWithIconView.super.ctor(self)
end

function TextWithIconView:destroyUI()
	TextWithIconView.super.destroyUI(self)
end

function TextWithIconView:onExitFinished()
	TextWithIconView.super.onExitFinished(self)
end

function TextWithIconView:onEnterFinished()
	TextWithIconView.super.onEnterFinished(self)
end

function TextWithIconView:unbindEvents()
	TextWithIconView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._btnToggle:RemoveClickListener()
end

function TextWithIconView:bindEvents()
	TextWithIconView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self._onClickClose, self)
	self._okBtn:AddClickListener(self._onClickOkBtn, self)
	self._cancelBtn:AddClickListener(self._onClickCancelBtn, self)
	self._btnToggle:AddClickListener(self._onClickToggle, self)
end

function TextWithIconView:onExit()
	TextWithIconView.super.onExit(self)

	self._toggleCall = nil
end

function TextWithIconView:buildUI()
	TextWithIconView.super.buildUI(self)

	self._closeBtn = self:getBtn("Nego_Main/Btn_Close")
	self._txt = goutil.findChild(self.mainGO, "Nego_Main/Txt_Msg"):GetComponent("UIGraphicTextNew")
	self._titleTxt = goutil.findChild(self.mainGO, "Nego_Main/Txt_Title"):GetComponent("Text")
	self._btns = {}
	self._btnTexts = {}
	self._defaultBtnTexts = {
		"确定",
		"取消"
	}
	self._okBtn = Framework.ButtonAdapter.GetFrom(self.mainGO, "Nego_Main/Btns/Btn1")
	self._cancelBtn = Framework.ButtonAdapter.GetFrom(self.mainGO, "Nego_Main/Btns/Btn2")
	self._okBtnText = goutil.findChild(self._okBtn.gameObject, "Text"):GetComponent("Text")
	self._cancelBtnText = goutil.findChild(self._cancelBtn.gameObject, "Text"):GetComponent("Text")
	self._goToggle = self:getGo("Nego_Main/toggle")
	self._btnToggle = self:getBtn("Nego_Main/toggle/btnToggle")
	self._imgGou = goutil.findChild(self._btnToggle.btn.gameObject, "imgGou")
end

function TextWithIconView:onEnter()
	TextWithIconView.super.onEnter(self)

	local param = self:getFirstParam()

	self._txt:SetLuaCallBack(function(go, spriteName, size)
		local arr = string.split(spriteName, "|")

		uGuiUtil.setSpriteToImage(go.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(arr[1]))
	end, nil)

	if param then
		self.okFuncCall = param.okFunc
		self.cancelFuncCall = param.cancelFunc
		self._toggleCall = param.toggleFunc

		if param.okBtnText then
			self._okBtnText.text = param.okBtnText
		end

		if param.cancelBtnText then
			self._cancelBtnText.text = param.cancelBtnText
		end

		self._txt.text = param.text or ""
		self._titleTxt.text = param.title or "提示"
	end

	goutil.setActive(self._goToggle, self._toggleCall ~= nil)
	goutil.setActive(self._imgGou, false)
end

function TextWithIconView:_onClickClose()
	self:close()
end

function TextWithIconView:_onClickOkBtn()
	self:close()

	if self.okFuncCall then
		self.okFuncCall()
	end
end

function TextWithIconView:_onClickCancelBtn()
	self:close()

	if self.cancelFuncCall then
		self.cancelFuncCall()
	end
end

function TextWithIconView:_onClickToggle()
	goutil.setActive(self._imgGou, not self._imgGou.activeSelf)

	if self._toggleCall then
		self._toggleCall(not self._imgGou.activeSelf)
	end
end

return TextWithIconView
