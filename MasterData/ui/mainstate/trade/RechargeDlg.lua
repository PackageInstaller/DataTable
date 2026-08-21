-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\Trade\\RechargeDlg.lua

local strClassName = "RechargeDlg"
local RechargeDlg = Class(strClassName, UIControls.Window)

function RechargeDlg:ctor()
	self.btns = {}

	for i = 1, 6 do
		local btn = UIControls.Button(self, "MainInfoPanel/RechargeList/Btn" .. i)

		btn:addEventClick(self.onRechargeClick)

		self.btns[i] = btn
	end

	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onDlgClose)
end

function RechargeDlg:onOpen()
	RechargeDlg.super.onOpen(self)
end

function RechargeDlg:onRechargeClick(sender)
	MsgManager.notice(Lang.get(30547))
end

function RechargeDlg:onDlgClose(sender)
	self:setVisible(false)
end

return RechargeDlg
