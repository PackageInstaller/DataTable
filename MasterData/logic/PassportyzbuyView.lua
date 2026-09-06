-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/passport/view/PassportyzbuyView.lua

module("logic.extensions.passport.view.PassportyzbuyView", package.seeall)

local PassportyzbuyView = class("PassportyzbuyView", PassportwpbuyView)

function PassportyzbuyView:ctor()
	PassportyzbuyView.super.ctor(self)
end

function PassportyzbuyView:buildUI()
	PassportyzbuyView.super.buildUI(self)

	self._effPath = "fx_ui_shiluoyijitongxingzheng/fx_ui_shiluoyiji_txzgoumai_02.prefab"
end

function PassportyzbuyView:bindEvents()
	PassportyzbuyView.super.bindEvents(self)
end

function PassportyzbuyView:unbindEvents()
	PassportyzbuyView.super.unbindEvents(self)
end

function PassportyzbuyView:destroyUI()
	PassportyzbuyView.super.destroyUI(self)
end

function PassportyzbuyView:onEnter()
	PassportyzbuyView.super.onEnter(self)
end

function PassportyzbuyView:onEnterFinished()
	PassportyzbuyView.super.onEnterFinished(self)
end

function PassportyzbuyView:onExit()
	PassportyzbuyView.super.onExit(self)
end

function PassportyzbuyView:onExitFinished()
	PassportyzbuyView.super.onExitFinished(self)
end

return PassportyzbuyView
