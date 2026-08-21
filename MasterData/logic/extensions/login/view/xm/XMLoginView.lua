-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/login/view/xm/XMLoginView.lua

module("logic.extensions.login.view.xm.XMLoginView", package.seeall)

local M = class("XMLoginView")

function M.replace()
	M._buildUI = LoginView.buildUI

	function LoginView:buildUI()
		M._buildUI(self)

		self._goUserProtocal = self:getGo("login_start_view_copy_-1374067778")

		goutil.setActive(self._goUserProtocal, false)
		Astral.LocalStorage.Instance:SetInt("kAgreeKey", 1)
	end
end

return M
