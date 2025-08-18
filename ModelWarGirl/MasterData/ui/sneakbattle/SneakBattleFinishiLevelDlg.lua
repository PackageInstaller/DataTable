-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\SneakBattle\\SneakBattleFinishiLevelDlg.lua

local SneakBattleFinishiLevelDlg = Class("SneakBattleFinishiLevelDlg", UIControls.Window)

function SneakBattleFinishiLevelDlg:ctor(...)
	self:initUI()
end

function SneakBattleFinishiLevelDlg:initUI(...)
	self.panel = UIControls.UIAni(self, "")
end

function SneakBattleFinishiLevelDlg:onOpen(...)
	local function onAniFinish(...)
		self:setVisible(false)
	end

	self:playAni("SneakBattleFinishDifficulty", Slot(onAniFinish, self), true)
end

return SneakBattleFinishiLevelDlg
