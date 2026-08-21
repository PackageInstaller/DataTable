-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Battle\\BattleZombieMainDlg.lua

local UserData = require("Helper/UserData")
local BattleConst = require("Common/FrameBattle/BattleConst")
local ResBattleConfig = require("ClientData/ResBattleConfig")
local ResClientNotice = require("ClientData/ResClientNotice")
local BattleMainBase = require("UI/Battle/BattleMainBase")
local STATE_NORMAL = 0
local STATE_FULL = 1
local STATE_WAIT = 2
local STATE_DEAD = 3
local BattleZombieHeroCell = Class("BattleZombieHeroCell", BattleMainBase.BattleHeroCellBase)

function BattleZombieHeroCell:ctor()
	self.bgBloodBlack = UIControls.Image(self, self.mPath .. "/BgBloodBlack")
end

function BattleZombieHeroCell:onClickSensor(sender)
	return
end

function BattleZombieHeroCell:refreshState()
	BattleZombieHeroCell.super.refreshState(self)

	if self.state == STATE_FULL then
		self.bgBloodBlack:setImage("Atlas/BattleAtlas/BattleMainAtlas", "BgBossHeroBackSel")
	elseif self.state == STATE_WAIT then
		self.bgBloodBlack:setImage("Atlas/BattleAtlas/BattleMainAtlas", "BgBossHeroBackSel")
	elseif self.state == STATE_DEAD then
		self.bgBloodBlack:setImage("Atlas/BattleAtlas/BattleMainAtlas", "BgBossHeroBackDis")
	else
		self.bgBloodBlack:setImage("Atlas/BattleAtlas/BattleMainAtlas", "BgBossHeroBackNml")
	end
end

local strClassName = "BattleZombieWaveCell"
local BattleZombieWaveCell = Class(strClassName, UIControls.Panel)

function BattleZombieWaveCell:ctor()
	self.imgCell = UIControls.Image(self, self.mPath .. "/ImgWave")
end

local MainFuncConfig = {
	onBattleTime = BattleConst.MATRIX_EVENT_BATTLE_TIME,
	onBattleWave = BattleConst.MATRIX_EVENT_MONSTER_WAVE,
	onWaveMonsterDead = BattleConst.MATRIX_EVENT_MONSTER_WAVE_DEAD,
	onActionEnd = BattleConst.MATRIX_EVENT_ACTION_END
}
local strClassName = "BattleZombieMainDlg"
local BattleZombieMainDlg = Class(strClassName, BattleMainBase)

function BattleZombieMainDlg:ctor()
	return
end

function BattleZombieMainDlg:setDlgConfig()
	self.heroNum = 9
	self.heroCellClass = BattleZombieHeroCell
end

local MAX_WAVE = 6

function BattleZombieMainDlg:initUI()
	BattleZombieMainDlg.super.initUI(self)

	self.waveCells = {}

	for index = 1, MAX_WAVE do
		local newCell = BattleZombieWaveCell(self, "WavePanel/BgWave" .. index)

		table.insert(self.waveCells, newCell)
	end

	self.aniWaveNotice = UIControls.UIAni(self, "WaveNoticePanel")

	self.aniWaveNotice:addEventFinish(self.onWaveAniOver)

	self.aniWaveRun = UIControls.UIAni(self, "WavePanel/ImgWave")
end

function BattleZombieMainDlg:_initBtnConfig()
	BattleZombieMainDlg.super._initBtnConfig(self)

	local state = GameFsm.getCurState()

	self.inManual = false

	state:onRaiseMatrixInput(BattleConst.INPUT_EVENT_SET_AUTO, self.inManual and 1 or 0)
	self:_refreshAutoBtn()
	EventCenter.addEventListenerGroup(self, MainFuncConfig)

	local bObjMgr = state:getBattleObjMgr()

	if state and bObjMgr then
		local waves = bObjMgr.waveMonsters

		if waves then
			for index = 1, MAX_WAVE do
				self.waveCells[index]:setVisible(index <= #waves)
			end
		end
	end
end

function BattleZombieMainDlg:onBattleWave(nowWave)
	for index, cell in ipairs(self.waveCells) do
		if index < nowWave then
			cell.imgCell:setImage("Atlas/BattleAtlas/BattleMainAtlas", "BtnScaleNml")
		elseif index == nowWave then
			cell.imgCell:setImage("Atlas/BattleAtlas/BattleMainAtlas", "BtnScaleSel")
			cell.imgCell:setVisible(true)
		end
	end

	self.aniWaveNotice:setVisible(true)
	self.aniWaveNotice:startAni("ShowWaveNotice", true)

	if nowWave > 0 and nowWave <= MAX_WAVE then
		self.aniWaveRun:startAni("WaveNotice" .. nowWave - 1 .. "To" .. nowWave, true)
	end
end

function BattleZombieMainDlg:onWaveAniOver()
	self.aniWaveNotice:setVisible(false)
end

function BattleZombieMainDlg:onWaveMonsterDead(deadCamp)
	local state = GameFsm.getCurState()
	local bObjMgr = state:getBattleObjMgr()

	if bObjMgr and bObjMgr.curWave then
		self:showBoxGot(bObjMgr.curWave - 1)
	end
end

function BattleZombieMainDlg:onAutoClick()
	MsgManager.clientNotice(168)
end

function BattleZombieMainDlg:onSpeedClick()
	if ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_BATTLE_SPEED) then
		MsgManager.notice(ConditionLimitManager.getLimitUnlockDesc(Const.CONDITION_LIMIT_BATTLE_SPEED))

		return
	end

	if self.speed ~= BattleConst.SPEED_UP1 then
		self.speed = BattleConst.SPEED_UP1
	else
		self.speed = BattleConst.SPEED_NORMAL
	end

	self:_refreshSpeedBtn()
	UserData.saveCommonData(BattleConst.SPEED_KEY, self.speed)

	if self.needExtraSpeed then
		UserData.saveCommonData(BattleConst.EXTRA_SPEED_KEY, BattleConst.SPEED_NORMAL)
	end
end

function BattleZombieMainDlg:onExtraSpeedClick()
	if ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_BATTLE_SPEED) then
		MsgManager.notice(ConditionLimitManager.getLimitUnlockDesc(Const.CONDITION_LIMIT_BATTLE_SPEED))

		return
	end

	local extraSpeed = self:getExtraSpeed()

	if self.speed ~= extraSpeed then
		self.speed = extraSpeed
	else
		self.speed = BattleConst.SPEED_NORMAL
	end

	self:_refreshSpeedBtn()
	UserData.saveCommonData(BattleConst.EXTRA_SPEED_KEY, self.speed)
end

function BattleZombieMainDlg:onShortSkillClick()
	if ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_BATTLE_SKILL_SHORT) then
		MsgManager.notice(ConditionLimitManager.getLimitUnlockDesc(Const.CONDITION_LIMIT_BATTLE_SKILL_SHORT))

		return
	end

	if self.inSkillShort then
		self.inSkillShort = false

		UserData.saveCommonData(BattleConst.SHORT_SKILL_KEY, "0")
	else
		self.inSkillShort = true

		UserData.saveCommonData(BattleConst.SHORT_SKILL_KEY, "1")
	end

	self:_refreshShortSkillBtn()

	local state = GameFsm.getCurState()

	state:onRaiseMatrixInput(BattleConst.INPUT_EVENT_SET_SHORT, self.inSkillShort and 1 or 0)
end

function BattleZombieMainDlg:onInfoClick()
	if self.infoLevel == BattleConst.INFO_LEVEL_MIN then
		self.infoLevel = BattleConst.INFO_LEVEL_MIDDLE
	else
		self.infoLevel = BattleConst.INFO_LEVEL_MIN
	end

	self:_refreshInfoLevelBtn()
	UserData.saveCommonData(BattleConst.INFO_LEVEL_KEY, self.infoLevel)
	GameFsm.getCurState():refreshInfoLevel(self.infoLevel, true)

	if self.panelBossBlood then
		self.panelBossBlood:refreshInfoLevel(self.infoLevel)
	end
end

local function QuitYes()
	if not GameFsm.isInState(Const.STATE_BATTLE) then
		return
	end

	GameFsm.getCurState():onLeaveBattle(true)
end

local function QuitNo()
	if not GameFsm.isInState(Const.STATE_BATTLE) then
		return
	end

	GameFsm.getCurState():onResume()
end

local function QuitRetry()
	if not GameFsm.isInState(Const.STATE_BATTLE) then
		return
	end

	local battleState = GameFsm.getState(Const.STATE_BATTLE)

	if battleState.battlePreInfo then
		CurAvatar:enterFormation(battleState.battleNo, battleState.battleType, battleState.battlePreInfo, true)
	end
end

function BattleZombieMainDlg:onClickQuit()
	if not GameFsm.isInState(Const.STATE_BATTLE) then
		return
	end

	GameFsm.getCurState():onPause()
	UIManager.showConfirm(UIConst.CONFIRM_THREEBTN, "", Lang.get(30141), {
		QuitNo,
		QuitYes,
		QuitRetry
	}, -1, {
		Lang.get(30140),
		Lang.get(3292),
		Lang.get(103)
	})
end

function BattleZombieMainDlg:_onBattleOver()
	EventCenter.removeEventListenerGroup(self, MainFuncConfig)
end

function BattleZombieMainDlg:onActionEnd(actionEnd)
	self.actionEnd = actionEnd

	for _, cell in ipairs(self.btnHeros) do
		if cell.refreshCellMana then
			cell:refreshCellMana()
		end
	end
end

function BattleZombieMainDlg:destroy()
	EventCenter.removeEventListenerGroup(self, MainFuncConfig)
	BattleZombieMainDlg.super.destroy(self)
end

return BattleZombieMainDlg
