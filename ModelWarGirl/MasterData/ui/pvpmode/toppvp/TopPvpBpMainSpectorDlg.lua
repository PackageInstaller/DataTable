-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PVPMode\\TopPVP\\TopPvpBpMainSpectorDlg.lua

local strClassName = "TopPvpBpMainSpectorDlg"
local TopPvpBpMainSpectorDlg = Class(strClassName, UIControls.Window)

function TopPvpBpMainSpectorDlg:ctor(...)
	self:initUI()
end

function TopPvpBpMainSpectorDlg:initUI(...)
	self.btnGamble = UIControls.Button(self, "BPPanel/BulletPanel/BtnGamble")

	self.btnGamble:addEventClick(self.onBtnGambleClick)

	self.btnBulletSwitch = UIControls.Button(self, "BPPanel/BulletPanel/BtnBulletSwitch")

	self.btnBulletSwitch:addEventClick(self.onBtnBulletSwitchClick)

	self.btnBullet = UIControls.Button(self, "BPPanel/BulletPanel/BtnBullet")

	self.btnBullet:addEventClick(self.onBtnBulletClick)
	self.btnGamble:setVisible(true)
end
