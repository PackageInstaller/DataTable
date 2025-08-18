-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Battle\\BattleResultKnockOutDlg.lua

local SeniorFormation = require("UI/PVPMode/SeniorPVP/SeniorFormation")
local PVPCommon = require("Logic/PVP/PVPCommon")
local BattleConst = require("Common/FrameBattle/BattleConst")
local BattleResultSeniorPvpFailDlg = require("UI/Battle/BattleResultSeniorPvpFailDlg")
local BattleAwardMixin = require("UI/Battle/BattleAwardMixin")
local strClassName = "BattleResultKnockOutDlg"
local BattleResultKnockOutDlg = Class(strClassName, BattleResultSeniorPvpFailDlg)

function BattleResultKnockOutDlg:ctor(...)
	return
end

function BattleResultKnockOutDlg:initUI(...)
	BattleResultKnockOutDlg.super.initUI(self)

	self.imgResult = UIControls.Image(self, "ResultPanel/ImgResult")
	self.aniResult = UIControls.Panel(self, "ResultPanel")
	self.aniSelf = UIControls.UIAni(self, "")

	self.aniSelf:addEventAnimateCue(self.onAnimateCue)

	self.imgLeftWin = UIControls.Image(self, "BgPanel/PlayerInfoPanel/SelfInfoPanel/TextName/ImgWin")
	self.imgRightWin = UIControls.Image(self, "BgPanel/PlayerInfoPanel/EnemyInfoPanel/TextName/ImgWin")
end

function BattleResultKnockOutDlg:onOpen(...)
	BattleResultSeniorPvpFailDlg.super.onOpen(self)

	self.battleState = GameFsm.getCurState()

	local winNum, loseNum, playerWin = self.battleState:getRoundScore()
	local selfResult

	if CurAvatar.cachedKnockOutData and CurAvatar.cachedKnockOutData.comm then
		local leftPlayer = CurAvatar.cachedKnockOutData.comm[1]

		self.btnHeadMine:setCommInfo(leftPlayer)

		local name = utils.GetPlayerName(leftPlayer.name)

		self.txtMyName:setText(name)

		local rightPlayer = CurAvatar.cachedKnockOutData.comm[2]

		self.btnHeadOther:setCommInfo(rightPlayer)

		name = utils.GetPlayerName(rightPlayer.name)

		self.txtOtherName:setText(name)

		if CurAvatar.uid == leftPlayer.uid then
			selfResult = playerWin
		elseif CurAvatar.uid == rightPlayer.uid then
			selfResult = not playerWin
		end
	end

	self.txtScore2:setText(winNum .. ":" .. loseNum)

	self.isFightAll = winNum == 2 or loseNum == 2
	self.lastWin = playerWin

	if selfResult == true then
		self.aniResult:playStateAnimator("MyWin")
	elseif selfResult == false then
		self.aniResult:playStateAnimator("MyFail")
	elseif playerWin then
		self.aniResult:playStateAnimator("BlueWin")

		if winNum == 2 then
			self.imgResult:setImage("Atlas/OtherBattleAtlas/TopPVPAtlas10", "TxtBlueWin02")
		else
			self.imgResult:setImage("Atlas/OtherBattleAtlas/TopPVPAtlas10", "TxtBlueWin01")
		end
	else
		self.aniResult:playStateAnimator("RedWin")

		if loseNum == 2 then
			self.imgResult:setImage("Atlas/OtherBattleAtlas/TopPVPAtlas10", "TxtRedWin02")
		else
			self.imgResult:setImage("Atlas/OtherBattleAtlas/TopPVPAtlas10", "TxtRedWin01")
		end
	end
end

function BattleResultKnockOutDlg:onAnimateCue(...)
	local winNum, loseNum, playerWin = self.battleState:getRoundScore()

	if playerWin then
		self.imgLeftWin:setVisible(true)
		self.imgRightWin:setVisible(false)
	else
		self.imgLeftWin:setVisible(false)
		self.imgRightWin:setVisible(true)
	end
end

function BattleResultKnockOutDlg:playNextAni()
	if self.isFightAll == true then
		self:playAni("ChangeBattleResultTopPVPWin", nil, true)
	else
		self:playAni("HideBattleResultSeniorPVPWinS", Functor(self._nextFight, self, false), true)
	end
end

function BattleResultKnockOutDlg:onBtnBattleDataClick(sender)
	local index = sender.index

	if self.teamResult[index] and self.teamResult[index][2] then
		local objMgr = self.teamResult[index][2]

		UIManager.getUI("battleRecordDlg", true):onShow(false, objMgr)
	else
		MsgManager.notice(Lang.get(80802))
	end
end

function BattleResultKnockOutDlg:onBtnCloseClick(...)
	self:playAni("HideBattleResultTopPVPWin", Functor(self._close, self, true), true)
end

return BattleResultKnockOutDlg
