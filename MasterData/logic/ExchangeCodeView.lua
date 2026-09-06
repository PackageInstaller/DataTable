-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/exchangecode/view/ExchangeCodeView.lua

module("logic.extensions.exchangecode.view.ExchangeCodeView", package.seeall)

local ExchangeCodeView = class("ExchangeCodeView", ViewComponent)

function ExchangeCodeView:ctor()
	ExchangeCodeView.super.ctor(self)
end

function ExchangeCodeView:buildUI()
	ExchangeCodeView.super.buildUI(self)

	self._closeBtn = self:getBtn("btnClose")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "txtError")
	self._inputText = self:getInput("input/IptItem")
	self._exchangeBtn = self:getBtn("input/btnExchange")
end

function ExchangeCodeView:bindEvents()
	ExchangeCodeView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self._onClickClose, self)
	self._exchangeBtn:AddClickListener(self._onClickExchange, self)
end

function ExchangeCodeView:unbindEvents()
	ExchangeCodeView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._exchangeBtn:RemoveClickListener()
end

function ExchangeCodeView:destroyUI()
	ExchangeCodeView.super.destroyUI(self)
end

function ExchangeCodeView:onEnter()
	ExchangeCodeView.super.onEnter(self)
end

function ExchangeCodeView:onEnterFinished()
	ExchangeCodeView.super.onEnterFinished(self)
end

function ExchangeCodeView:onExit()
	ExchangeCodeView.super.onExit(self)
end

function ExchangeCodeView:onExitFinished()
	ExchangeCodeView.super.onExitFinished(self)
end

function ExchangeCodeView:_onClickClose()
	self:close()
end

function ExchangeCodeView:_onClickExchange()
	local str = self._inputText:GetText()

	if string.nilorempty(str) then
		FloatWordMgr.instance:show("请输入兑换码")
	else
		MaterialAgent.instance:sendUseExchangeCodeReq(str, function(msg)
			return
		end)
	end
end

return ExchangeCodeView
