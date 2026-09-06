-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/login/view/LoginAgeTipsView.lua

module("logic.extensions.login.view.LoginAgeTipsView", package.seeall)

local LoginAgeTipsView = class("LoginAgeTipsView", ViewComponent)

function LoginAgeTipsView:buildUI()
	self._closeBtn = self:getBtn("middleView/btnClose")
	self._sureBtn = self:getBtn("middleView/btnEnsure")
end

function LoginAgeTipsView:bindEvents()
	self._closeBtn:AddClickListener(self._onClickClose, self)
	self._sureBtn:AddClickListener(self._onClickClose, self)
end

function LoginAgeTipsView:unbindEvents()
	self._closeBtn:RemoveClickListener()
	self._sureBtn:RemoveClickListener()
end

function LoginAgeTipsView:_onClickClose()
	self:close()
end

return LoginAgeTipsView
