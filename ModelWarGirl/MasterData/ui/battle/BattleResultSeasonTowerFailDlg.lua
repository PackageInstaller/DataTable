-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Battle\\BattleResultSeasonTowerFailDlg.lua

local strClassName = "BattleResultSeasonTowerFailDlg"
local BattleResultSeasonTowerFailDlg = Class(strClassName, UIControls.Window)

function BattleResultSeasonTowerFailDlg:ctor(...)
	self:initUI()
end

function BattleResultSeasonTowerFailDlg:initUI(...)
	return
end

function BattleResultSeasonTowerFailDlg:onOpenOver(...)
	BattleResultSeasonTowerFailDlg.super.onOpenOver(self)
	self:setVisible(false)
end

return BattleResultSeasonTowerFailDlg
