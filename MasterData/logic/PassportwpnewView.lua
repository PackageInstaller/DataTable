-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/passport/view/PassportwpnewView.lua

module("logic.extensions.passport.view.PassportwpnewView", package.seeall)

local PassportwpnewView = class("PassportwpnewView", PassportwpView)

function PassportwpnewView:buildUI()
	PassportwpnewView.super.buildUI(self)

	self.effResPath = "fx_ui_tongxingzheng/fx_ui_tongxingzheng_02.prefab"
end

function PassportwpnewView:onEnter()
	PassportwpnewView.super.onEnter(self)

	self._buyView = ViewName.PassportwpbuynewView
end

return PassportwpnewView
