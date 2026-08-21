-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Battle\\BattleCircleFailDlg.lua

local BattleAwardMixin = require("UI/Battle/BattleAwardMixin")
local strClassName = "BattleCircleFailDlg"
local ICON_PATH = "Atlas/BattleAtlas/BattleResultAtlas/BattleResultAtlasNew"
local ICON_PATH1 = "Atlas/BattleAtlas/BattleResultAtlas/BattleResultAtlasNew1"
local BattleCircleFailDlg = Class(strClassName, UIControls.Window)

MixinClass(BattleCircleFailDlg, BattleAwardMixin, true)

function BattleCircleFailDlg:ctor(...)
	self:ctorMixin()
	self:initUI()
end

function BattleCircleFailDlg:initUI(...)
	self.textTime = UIControls.Label(self, "BgPanel/InfoPanel/TextBattleTime")
	self.imgResult = UIControls.Image(self, "BgPanel/InfoPanel/ImgVictory")
	self.btnRecord = UIControls.Button(self, "BgPanel/BtnPanel/BtnBattleData")
	self.imgBgVictory = UIControls.Image(self, "BgPanel/InfoPanel/BgVictory")

	self.btnRecord:addEventClick(self.onBtnRecord)

	self.btnNext = UIControls.Button(self, "BgPanel/BtnPanel/BtnConfirm", "Text")

	self.btnNext:addEventClick(self.onBtnNext)

	self.panelTips = UIControls.Panel(self, "BgPanel/TipsPanel")
	self.textTips = UIControls.Label(self, "BgPanel/TipsPanel/Text")
	self.panelAttackAward = UIControls.Panel(self, "ResultPanel/AttackAwardPanel")
	self.txtAttackRatio = UIControls.Label(self, "ResultPanel/AttackAwardPanel/Text")
end

function BattleCircleFailDlg:show(battleType, finish, result, itemBonus)
	local battleState = GameFsm.getCurState()

	self.battleType = battleType
	self.finish = finish
	self.itemBonus = itemBonus

	self:_startStageBattle(battleState:getBattleObjMgr())

	if result == BattleConst.BATTLE_RESULT_SURRENDER or result == BattleConst.BATTLE_RESULT_LOSE then
		self:playAni("BattleResultFail", nil, true)
	else
		self:playAni("BattleResultFailTimeOut", nil, true)
	end

	local tips

	if self.battleType == BattleConst.BATTLE_TYPE_CIRCLE then
		if finish.spec.clan_battle.isboss == 1 then
			tips = CurAvatar:getNoticeTips(10)
		else
			tips = CurAvatar:getNoticeTips(9)
		end
	end

	if tips then
		self.panelTips:setVisible(true)
		self.textTips:setText(tips.tips_desc or "")
	else
		self.panelTips:setVisible(false)
	end

	if battleState and battleState.battlePreInfo and battleState.battlePreInfo.circleBattleData then
		local isBoss = battleState.battlePreInfo.circleBattleData.isBoss

		self.panelAttackAward:setVisible(isBoss)

		local desc = ClientUtils.getClientNotice(541)
		local s = utils.format(desc .. "%1:0.2f%%", (self.finish.spec.clan_battle.boss_lose_hp or 0) * 0.01)

		self.txtAttackRatio:setText(s)
	end
end

function BattleCircleFailDlg:_startStageBattle(battleInfo)
	local time = 0

	if battleInfo then
		time = battleInfo:getBattleTime()
	end

	local timeSec = math.floor(time)

	self.textTime:setText(utils.calcTimeTxt(timeSec))
end

function BattleCircleFailDlg:onBtnRecord()
	UIManager.getUI("battleRecordDlg", true):onShow(false)
end

function BattleCircleFailDlg:onBtnNext()
	self:setVisible(false)
	UIManager.getUI("pvpResultAwardDlg", true):show(self.itemBonus, self.battleType, self.finish)
end

function BattleCircleFailDlg:playNextAni()
	self:playAni("ChangeBattleResultCircleFail", nil)
end

function BattleCircleFailDlg:destroy()
	BattleCircleFailDlg.super.destroy(self)

	if (GameFsm.isInState(Const.STATE_BATTLE) or GameFsm.isInState(Const.STATE_BATTLE_REPLAY)) and self.enterMain then
		self:checkExitBattle()
	end
end

function BattleCircleFailDlg:onBtnPower3()
	local battleState = GameFsm.getState(Const.STATE_BATTLE)

	if battleState.battlePreInfo then
		CurAvatar:enterFormation(battleState.battleNo, self.battleType, battleState.battlePreInfo, 1)
		self:setVisible(false)
	end
end

return BattleCircleFailDlg
