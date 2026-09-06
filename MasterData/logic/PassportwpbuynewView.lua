-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/passport/view/PassportwpbuynewView.lua

module("logic.extensions.passport.view.PassportwpbuynewView", package.seeall)

local PassportwpbuynewView = class("PassportwpbuynewView", PassportwpbuyView)

function PassportwpbuynewView:buildUI()
	PassportwpbuynewView.super.buildUI(self)

	self._effPath = "fx_ui_tongxingzheng/fx_ui_tongxingzheng_02_1.prefab"
end

return PassportwpbuynewView
