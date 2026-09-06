-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recalltask/view/RecallCodeView.lua

module("logic.extensions.recalltask.view.RecallCodeView", package.seeall)

local RecallCodeView = class("RecallCodeView", ViewComponent)

function RecallCodeView:ctor()
	RecallCodeView.super.ctor(self)
end

function RecallCodeView:bindEvents()
	RecallCodeView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._exchangeBtn:AddClickListener(self._onClickExchange, self)
end

function RecallCodeView:unbindEvents()
	RecallCodeView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._exchangeBtn:RemoveClickListener()
end

function RecallCodeView:buildUI()
	RecallCodeView.super.buildUI(self)

	self._closeBtn = self:getBtn("btnClose")
	self._inputTxt = self:getInput("input/IptItem")
	self._exchangeBtn = self:getBtn("input/btnExchange")
	self._titleTxt = goutil.findChildTextComponent(self.mainGO, "input/txtTitle")
	self._descTxt = goutil.findChildTextComponent(self.mainGO, "input/txtTip")
end

function RecallCodeView:onExit()
	RecallCodeView.super.onExit(self)
end

function RecallCodeView:destroyUI()
	RecallCodeView.super.destroyUI(self)
end

function RecallCodeView:onEnter()
	RecallCodeView.super.onEnter(self)

	self._titleTxt.text = lang("text_recall_code")
	self._descTxt.text = lang("text_recall_desc_1")
end

function RecallCodeView:_onClickExchange()
	local str = self._inputTxt:GetText()

	if string.nilorempty(str) then
		FloatWordMgr.instance:show(lang("text_recall_desc_1"))

		return
	end

	RecallTaskController.instance:csGetWriteUseCodeReq(str)
	self:close()
end

return RecallCodeView
