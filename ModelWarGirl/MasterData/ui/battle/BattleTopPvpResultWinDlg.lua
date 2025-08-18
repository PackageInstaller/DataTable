-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Battle\\BattleTopPvpResultWinDlg.lua

local SeniorFormation = require("UI/PVPMode/SeniorPVP/SeniorFormation")
local PVPCommon = require("Logic/PVP/PVPCommon")
local BattleConst = require("Common/FrameBattle/BattleConst")
local BattleTopPvpResultFailDlg = require("UI/Battle/BattleTopPvpResultFailDlg")
local strClassName = "BattleTopPvpResultWinDlg"
local BattleTopPvpResultWinDlg = Class(strClassName, BattleTopPvpResultFailDlg)

function BattleTopPvpResultWinDlg:ctor()
	return
end

function BattleTopPvpResultWinDlg:playNextAni()
	if self.isFightAll == true then
		self:playAni("ChangeBattleResultTopPVPWin", nil, true)
	else
		self:playAni("HideBattleResultSeniorPVPWinS", Functor(self._nextFight, self, false), true)
	end
end

function BattleTopPvpResultWinDlg:onBtnBattleDataClick(sender)
	local index = sender.index
	local objMgr = self.teamResult[index][2]

	UIManager.getUI("battleRecordDlg", true):onShow(false, objMgr)
end

function BattleTopPvpResultWinDlg:onBtnCloseClick(...)
	self:playAni("HideBattleResultTopPVPWin", Functor(self._close, self, true), true)
end

return BattleTopPvpResultWinDlg
