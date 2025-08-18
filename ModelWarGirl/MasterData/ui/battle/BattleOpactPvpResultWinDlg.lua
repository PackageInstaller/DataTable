-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Battle\\BattleOpactPvpResultWinDlg.lua

local SeniorFormation = require("UI/PVPMode/SeniorPVP/SeniorFormation")
local PVPCommon = require("Logic/PVP/PVPCommon")
local BattleConst = require("Common/FrameBattle/BattleConst")
local BattleOpactPvpResultFailDlg = require("UI/Battle/BattleOpactPvpResultFailDlg")
local BattleAwardMixin = require("UI/Battle/BattleAwardMixin")
local strClassName = "BattleOpactPvpResultWinDlg"
local BattleOpactPvpResultWinDlg = Class(strClassName, BattleOpactPvpResultFailDlg)

MixinClass(BattleOpactPvpResultWinDlg, BattleAwardMixin, true)

function BattleOpactPvpResultWinDlg:ctor(...)
	self:ctorMixin()
end

function BattleOpactPvpResultWinDlg:initUI(...)
	BattleOpactPvpResultWinDlg.super.initUI(self)
end

function BattleOpactPvpResultWinDlg:playNextAni()
	if self.isFightAll == true then
		self:playAni("ChangeBattleResultActivityPVPWin", nil, true)
		self:setRankData()
	else
		self:playAni("HideBattleResultSeniorPVPWinS", Functor(self._nextFight, self, false), true)
	end
end

function BattleOpactPvpResultWinDlg:onBtnBattleDataClick(sender)
	local index = sender.index
	local objMgr = self.teamResult[index][2]

	UIManager.getUI("battleRecordDlg", true):onShow(false, objMgr)
end

function BattleOpactPvpResultWinDlg:onBtnCloseClick(...)
	self:playAni("HideBattleResultActivityPVPWin", Functor(self._close, self, true), true)
end

return BattleOpactPvpResultWinDlg
