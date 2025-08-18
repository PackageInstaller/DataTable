-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PVPMode\\TopPVP\\BattleStartTopPvpDlg.lua

local strClassName = "BattleStartTopPvpDlg"
local BattleStartTopPvpDlg = Class(strClassName, UIControls.Window)

function BattleStartTopPvpDlg:ctor(...)
	self:initUI()
end

function BattleStartTopPvpDlg:initUI(...)
	self.aniInfo = UIControls.UIAni(self, "")

	self.aniInfo:startAni("BattleStartTopPVP", true)
	self.aniInfo:addEventFinish(Slot(self.onFinish, self))
end

function BattleStartTopPvpDlg:onFinish(...)
	self.aniInfo:clearEventFinish()
	self:setVisible(false)
end

return BattleStartTopPvpDlg
