-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/passport/view/saintknight/PassportSaintKnightBuyView.lua

module("logic.extensions.passport.view.saintknight.PassportSaintKnightBuyView", package.seeall)

local PassportSaintKnightBuyView = class("PassportSaintKnightBuyView", PassportwpbuyView)

function PassportSaintKnightBuyView:buildUI()
	PassportSaintKnightBuyView.super.buildUI(self)

	self._effPath = "fx_ui_tongxingzheng/fx_ui_tongxingzheng_02_1.prefab"
end

function PassportSaintKnightBuyView:onEnter()
	GlobalDispatcher:addListener(GlobalNotify.PassportStateUpdate, self._handlePay, self)
	PassportSaintKnightBuyView.super.onEnter(self)
end

function PassportSaintKnightBuyView:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.PassportStateUpdate, self._handlePay, self)
	PassportSaintKnightBuyView.super.onExit(self)
end

function PassportSaintKnightBuyView:_handlePay()
	self:close()
end

return PassportSaintKnightBuyView
