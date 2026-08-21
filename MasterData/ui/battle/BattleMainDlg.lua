-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Battle\\BattleMainDlg.lua

local UserData = require("Helper/UserData")
local BattleConst = require("Common/FrameBattle/BattleConst")
local ResBattleConfig = require("ClientData/ResBattleConfig")
local ResClientNotice = require("ClientData/ResClientNotice")
local BattleMainBase = require("UI/Battle/BattleMainBase")
local NOTICE_ASYNC_PVP_QUIT = ResClientNotice[105].notice
local STATE_NORMAL = 0
local STATE_FULL = 1
local STATE_WAIT = 2
local STATE_DEAD = 3
local BattleMainHeroCell = Class("BattleMainHeroCell", BattleMainBase.BattleHeroCellBase)

function BattleMainHeroCell:ctor()
	self.bgSensor = UIControls.Image(self, self.mPath .. "/Bg")
end

function BattleMainHeroCell:onClickSensor(sender)
	if Const.BEGINNER_LOCK_SKILL then
		return
	end

	if not self.mParent.inManual then
		return
	end

	local state = GameFsm.getCurState()

	state:onRaiseMatrixInput(BattleConst.INPUT_EVENT_USE_SKILL, self.entityId)
	self:setState(STATE_WAIT)
end

function BattleMainHeroCell:refreshState()
	BattleMainHeroCell.super.refreshState(self)

	if self.state == STATE_FULL then
		self.bgSensor:setImage("Atlas/BattleAtlas/BattleMainAtlas", "BgHeroBackSel")
	elseif self.state == STATE_WAIT then
		self.bgSensor:setImage("Atlas/BattleAtlas/BattleMainAtlas", "BgHeroBackNml")
	elseif self.state == STATE_DEAD then
		self.bgSensor:setImage("Atlas/BattleAtlas/BattleMainAtlas", "BgHeroBackDis")
	else
		self.bgSensor:setImage("Atlas/BattleAtlas/BattleMainAtlas", "BgHeroBackNml")
	end
end

local MainFuncConfig = {
	onBattleTime = BattleConst.MATRIX_EVENT_BATTLE_TIME
}
local strClassName = "BattleMainDlg"
local BattleMainDlg = Class(strClassName, BattleMainBase)

function BattleMainDlg:ctor()
	if UIControls.checkControlFunc(self, "BtnSkip") then
		self.btnQuickBattle = UIControls.Button(self, "BtnSkip")

		self.btnQuickBattle:setVisible(false)
	end

	if UIControls.checkControlFunc(self, "SeniorPVPScorePanel") then
		self.panelMultiTeam = UIControls.Panel(self, "SeniorPVPScorePanel")
		self.labelScore = UIControls.Label(self, "SeniorPVPScorePanel/TextScore")
		self.labelRound = UIControls.Label(self, "SeniorPVPScorePanel/TextRoundNum")
	end
end

function BattleMainDlg:setDlgConfig()
	self.heroNum = 5
	self.heroCellClass = BattleMainHeroCell
end

function BattleMainDlg:_initBtnConfig()
	BattleMainDlg.super._initBtnConfig(self)

	local state = GameFsm.getCurState()
	local config = ResBattleConfig[state.battleNo] or {}

	self.noExit = config.no_exit

	if self.noExit then
		self.btnQuit:setVisible(false)
	end

	if BattleConst.THREE_ROUND_BATTLE_TYPE[state.battleType] then
		self.panelMultiTeam:setVisible(true)
		self.labelRound:setText(state.curBattleRound or 1)

		local winNum, loseNum = state:getRoundScore()

		self.labelScore:setText(winNum .. ":" .. loseNum)
	elseif self.panelMultiTeam then
		self.panelMultiTeam:setVisible(false)
	end

	EventCenter.addEventListenerGroup(self, MainFuncConfig)
end

function BattleMainDlg:onAutoClick()
	if ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_BATTLE_AUTO) then
		MsgManager.notice(ConditionLimitManager.getLimitUnlockDesc(Const.CONDITION_LIMIT_BATTLE_AUTO))

		return
	end

	local state = GameFsm.getCurState()

	if state.battleType == BattleConst.BATTLE_TYPE_THREE_TEAM_PVP then
		MsgManager.notice(Lang.get(30138))

		return
	end

	if self.inManual then
		self.inManual = false

		UserData.saveCommonData(BattleConst.MANUAL_KEY, "0")
	else
		self.inManual = true

		UserData.saveCommonData(BattleConst.MANUAL_KEY, "1")
	end

	self:_refreshAutoBtn()
	state:onRaiseMatrixInput(BattleConst.INPUT_EVENT_SET_AUTO, self.inManual and 1 or 0)
end

function BattleMainDlg:onAutoOpen()
	local state = GameFsm.getCurState()

	self.inManual = false

	UserData.saveCommonData(BattleConst.MANUAL_KEY, "0")
	self:_refreshAutoBtn()
	state:onRaiseMatrixInput(BattleConst.INPUT_EVENT_SET_AUTO, self.inManual and 1 or 0)
end

function BattleMainDlg:onSpeedClick()
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

function BattleMainDlg:onExtraSpeedClick()
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

function BattleMainDlg:onSpeedUp()
	if ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_BATTLE_SPEED) then
		MsgManager.notice(ConditionLimitManager.getLimitUnlockDesc(Const.CONDITION_LIMIT_BATTLE_SPEED))

		return
	end

	self.speed = BattleConst.SPEED_UP1

	self:_refreshSpeedBtn()
	UserData.saveCommonData(BattleConst.SPEED_KEY, self.speed)
end

function BattleMainDlg:onShortSkillClick()
	if ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_BATTLE_SKILL_SHORT) then
		MsgManager.notice(ConditionLimitManager.getLimitUnlockDesc(Const.CONDITION_LIMIT_BATTLE_SKILL_SHORT))

		return
	end

	if self.speed == BattleConst.SPEED_UP3 and self.inSkillShort then
		MsgManager.clientNotice(768)

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

function BattleMainDlg:onInfoClick()
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

function BattleMainDlg:onClickQuit()
	if not GameFsm.isInState(Const.STATE_BATTLE) then
		return
	end

	local state = GameFsm.getCurState()

	state:onPause()

	local battleType = state.battleType

	if self.noExit or battleType == BattleConst.BATTLE_TYPE_WORLD_BOSS then
		UIManager.showConfirm(UIConst.CONFIRM_ONEBTN, "", Lang.get(30139), QuitNo)
	elseif battleType == BattleConst.BATTLE_TYPE_ASYNC_PVP then
		UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, "", NOTICE_ASYNC_PVP_QUIT, QuitNo, QuitYes, -1, Lang.get(30140), Lang.get(3292))
		UIManager.setConfirmDefault(1)
	elseif battleType == BattleConst.BATTLE_TYPE_STAGE then
		UIManager.showConfirmWithId(1001, QuitYes, QuitNo, QuitRetry, {
			[3] = {
				Const.MONEY_ID_STAGE_ENERGY
			}
		})
	elseif BattleConst.THREE_ROUND_BATTLE_TYPE[battleType] then
		UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, "", ClientUtils.getClientNotice(266), QuitNo, QuitYes, -1, Lang.get(30140), Lang.get(3292))
		UIManager.setConfirmDefault(1)
	elseif state:isClanBossBattle() then
		UIManager.showConfirmWithId(1047, QuitNo, QuitYes)
	elseif battleType == BattleConst.BATTLE_TYPE_CIRCLE then
		UIManager.showConfirmWithId(1048, QuitNo, QuitYes)
	elseif battleType == BattleConst.BATTLE_TYPE_SEASON_TOWER then
		local opID = state.battlePreInfo.seasonTowerData.opId
		local actObj = CurAvatar:getActivityObjByOpId(opID)

		if actObj then
			local energyConfigFunc = {
				func = Slot(actObj.actData.getEnergyInfo, actObj.actData)
			}

			if state.battlePreInfo.seasonTowerData.multiTeamsIndex then
				UIManager.showConfirmWithId(1025, QuitYes, QuitNo, QuitRetry, {
					[3] = energyConfigFunc
				})
			else
				UIManager.showConfirmWithId(1026, QuitYes, QuitNo, QuitRetry, {
					[3] = energyConfigFunc
				})
			end
		else
			GameFsm.getCurState():onLeaveBattle(true)
		end
	else
		UIManager.showConfirm(UIConst.CONFIRM_THREEBTN, "", Lang.get(30141), {
			QuitNo,
			QuitYes,
			QuitRetry
		}, -1, {
			Lang.get(30140),
			Lang.get(3292),
			Lang.get(103)
		})
		UIManager.setConfirmDefault(1)
	end
end

function BattleMainDlg:onClickQuickBattle()
	if not GameFsm.isInState(Const.STATE_BATTLE) then
		return
	end

	GameFsm.getCurState():onQuickEndGame()
end

function BattleMainDlg:_onBattleOver()
	EventCenter.removeEventListenerGroup(self, MainFuncConfig)
end

function BattleMainDlg:destroy()
	EventCenter.removeEventListenerGroup(self, MainFuncConfig)
	BattleMainDlg.super.destroy(self)
end

return BattleMainDlg
