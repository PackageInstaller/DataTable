-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Battle\\BattleResultSeniorPvpWinDlg.lua

local SeniorFormation = require("UI/PVPMode/SeniorPVP/SeniorFormation")
local PVPCommon = require("Logic/PVP/PVPCommon")
local BattleConst = require("Common/FrameBattle/BattleConst")
local BattleResultSeniorPvpFailDlg = require("UI/Battle/BattleResultSeniorPvpFailDlg")
local BattleAwardMixin = require("UI/Battle/BattleAwardMixin")
local strClassName = "BattleResultSeniorPvpWinDlg"
local BattleResultSeniorPvpWinDlg = Class(strClassName, BattleResultSeniorPvpFailDlg)

MixinClass(BattleResultSeniorPvpWinDlg, BattleAwardMixin, true)

function BattleResultSeniorPvpWinDlg:ctor(...)
	self:ctorMixin()
end

function BattleResultSeniorPvpWinDlg:initUI(...)
	BattleResultSeniorPvpWinDlg.super.initUI(self)

	self.imgMoney = UIControls.Image(self, "BgPanel/AwardPanel/AwardSpeedPanel/Icon")
	self.txtMoneyNum = UIControls.Label(self, "BgPanel/AwardPanel/AwardSpeedPanel/TextNum")
	self.imgPoint = UIControls.Image(self, "BgPanel/AwardPanel/PointSpeedPanel/Icon")
	self.txtPointNum = UIControls.Label(self, "BgPanel/AwardPanel/PointSpeedPanel/TextNum")
end

function BattleResultSeniorPvpWinDlg:setRankData(finish)
	BattleResultSeniorPvpWinDlg.super.setRankData(self, finish)

	local path = PVPCommon.getSeniorPvpAwardIcon()

	self.imgMoney:setImage(path[1], path[2])

	path = PVPCommon.getPointIconPath()

	self.imgPoint:setImage(path[1], path[2])

	if CurAvatar.seniorPvpData then
		local awardOffset = self.myInfoNew.award_speed - self.otherInfoNew.award_speed
		local pointOffset = self.myInfoNew.score_speed - self.otherInfoNew.score_speed

		self.txtMoneyNum:setText(PVPCommon.getSpeedStr(awardOffset, true))
		self.txtPointNum:setText(PVPCommon.getSpeedStr(pointOffset, true))
	end
end

function BattleResultSeniorPvpWinDlg:playNextAni()
	if self.isFightAll == true then
		self:playAni("ChangeBattleResultSeniorPVPWin", nil, true)
	else
		self:playAni("HideBattleResultSeniorPVPWinS", Functor(self._nextFight, self, false), true)
	end
end

function BattleResultSeniorPvpWinDlg:onBtnBattleDataClick(sender)
	local index = sender.index
	local objMgr = self.teamResult[index][2]

	UIManager.getUI("battleRecordDlg", true):onShow(false, objMgr)
end

function BattleResultSeniorPvpWinDlg:onBtnCloseClick(...)
	self:playAni("HideBattleResultSeniorPVPWin", Functor(self._close, self, true), true)
end

return BattleResultSeniorPvpWinDlg
