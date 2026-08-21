-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\WorldBoss\\WorldBossEliteUnlockDlg.lua

local strClassName = "WorldBossEliteUnlockDlg"
local WorldBossEliteUnlockDlg = Class(strClassName, UIControls.Window)

function WorldBossEliteUnlockDlg:ctor(...)
	self:initUI()
end

function WorldBossEliteUnlockDlg:initUI(...)
	self.btnClose = UIControls.Button(self, "UIClick")

	self.btnClose:addEventClick(self.onBtnCloseClick)
end

function WorldBossEliteUnlockDlg:onOpen(...)
	WorldBossEliteUnlockDlg.super.onOpen(self)
end

function WorldBossEliteUnlockDlg:destroy(...)
	WorldBossEliteUnlockDlg.super.destroy(self)
end

function WorldBossEliteUnlockDlg:onBtnCloseClick()
	self:setVisible(false)
end

return WorldBossEliteUnlockDlg
