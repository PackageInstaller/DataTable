-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/passport/view/PassportyzView.lua

module("logic.extensions.passport.view.PassportyzView", package.seeall)

local PassportyzView = class("PassportyzView", PassportwpView)

function PassportyzView:ctor()
	PassportyzView.super.ctor(self)
end

function PassportyzView:buildUI()
	PassportyzView.super.buildUI(self)

	self.effResPath = "fx_ui_shiluoyijitongxingzheng/fx_ui_shiluoyiji_01.prefab"
end

function PassportyzView:bindEvents()
	PassportyzView.super.bindEvents(self)
end

function PassportyzView:unbindEvents()
	PassportyzView.super.unbindEvents(self)
end

function PassportyzView:destroyUI()
	PassportyzView.super.destroyUI(self)
end

function PassportyzView:onEnter()
	self:_resetview()

	self._openparam = 2
	self._buyView = ViewName.PassportyzbuyView
	self._passPortFuncId = self._openparam

	GlobalDispatcher:addListener(GlobalNotify.PassportStateUpdate, self._refreshUI, self)
	PassportController.instance:sendGetInfoReq(self._openparam, self._refreshUI, self)

	self._canGetRewardIndex = 0
end

function PassportyzView:onEnterFinished()
	PassportyzView.super.onEnterFinished(self)
end

function PassportyzView:onExit()
	PassportyzView.super.onExit(self)
end

function PassportyzView:onExitFinished()
	PassportyzView.super.onExitFinished(self)
end

function PassportyzView:_onClickBtnGoTo()
	FuncOpenController.instance:openFunc(52)
end

return PassportyzView
