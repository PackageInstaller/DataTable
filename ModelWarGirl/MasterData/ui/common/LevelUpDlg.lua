-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\LevelUpDlg.lua

local strClassName = "LevelUpDlg"
local LevelUpDlg = Class(strClassName, UIControls.Window)

function LevelUpDlg:ctor()
	self.textPreLevel = UIControls.Label(self, "BgPanel/TextLvPre")
	self.textNextLevel = UIControls.Label(self, "BgPanel/TextLvNext")
end

function LevelUpDlg:onLevelUp(perLevel, nextLevel)
	self.textPreLevel:setText(perLevel)
	self.textNextLevel:setText(nextLevel)
	CurAvatar:checkPushGiftTrigger(self.mUIName, Const.ON_WINDOW_OPEN)
end

function LevelUpDlg:onOpenOver()
	LevelUpDlg.super.onOpenOver(self)
	self:setVisible(false)
	CurAvatar:checkPushGiftTrigger(self.mUIName, Const.ON_WINDOW_CLOSE)
end

return LevelUpDlg
