-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Login\\AccountChooseDlg.lua

local UIControls = require("UI/UIControls")
local strClassName = "AccountChooseDlg"
local AccountChooseDlg = Class(strClassName, UIControls.Window)

function AccountChooseDlg:ctor()
	self.btnBind = UIControls.Button(self, "BgPanel/WayPanel/BtnBind")

	self.btnBind:addEventClick(Functor(self.OnOpenAccount, self, true))

	self.btnSignIn = UIControls.Button(self, "BgPanel/WayPanel/BtnSignIn")

	self.btnSignIn:addEventClick(Functor(self.OnOpenAccount, self, false))

	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onCloseClick)
end

function AccountChooseDlg:OnOpenAccount(isBind)
	local bindDlg = UIManager.getUI("accountBindAndSingDlg", true)

	if bindDlg then
		bindDlg:openForBind(isBind)
	end
end

function AccountChooseDlg:onCloseClick()
	self:setVisible(false)
end

return AccountChooseDlg
