-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Replay\\BattleReplayMainDlg.lua

local BattleConst = require("Common/FrameBattle/BattleConst")
local BattleMainBase = require("UI/Battle/BattleMainBase")
local BattleMiscConfig = require("Common/BattleMiscConfig")
local STATE_NORMAL = 0
local STATE_FULL = 1
local STATE_WAIT = 2
local STATE_DEAD = 3
local BattleReplaySyncPlayerChild = Class("BattleReplaySyncPlayerChild", UIControls.Child)

function BattleReplaySyncPlayerChild:ctor()
	self.playerLeft = UIControls.PlayerHeadGridChild(self, "LeftPlayerPanel/GridPlayer", "System/Common/Grid/GridPlayerCommon")
	self.playerRight = UIControls.PlayerHeadGridChild(self, "RightPlayerPanel/GridPlayer", "System/Common/Grid/GridPlayerCommon")
	self.textLeftName = UIControls.Label(self, "LeftPlayerPanel/TextPlayerName")
	self.textRightName = UIControls.Label(self, "RightPlayerPanel/TextPlayerName")
	self.btnLeftHeros = {}

	for index = 1, self.mParent.heroNum do
		local newBtn = self.mParent.heroCellClass(self, "LeftPlayerPanel/BtnHero" .. index)

		table.insert(self.btnLeftHeros, newBtn)
	end

	self.btnRightHeros = {}

	for index = 1, self.mParent.heroNum do
		local newBtn = self.mParent.heroCellClass(self, "RightPlayerPanel/BtnHero" .. index)

		table.insert(self.btnRightHeros, newBtn)
	end
end

function BattleReplaySyncPlayerChild:setData(state)
	local leftPlayers = state:getPlayers()
	local leftOrderPlayers = self.mParent:_getOrderPlayers(leftPlayers)

	for index, btn in ipairs(self.btnLeftHeros) do
		local obj = leftOrderPlayers[index]

		if obj then
			btn:initObj(obj)
			btn:setVisible(true)
		else
			btn:setVisible(false)
		end
	end

	local rightPlayers = state:getPlayers(BattleConst.CAMP_MONSTER)
	local rightOrderPlayers = self.mParent:_getOrderPlayers(rightPlayers)

	for index, btn in ipairs(self.btnRightHeros) do
		local obj = rightOrderPlayers[index]

		if obj then
			btn:initObj(obj)
			btn:setVisible(true)
		else
			btn:setVisible(false)
		end
	end

	if CurAvatar.cachedKnockOutData and CurAvatar.cachedKnockOutData.comm then
		local leftPlayer = CurAvatar.cachedKnockOutData.comm[1]

		self.playerLeft:setCommInfo(leftPlayer)

		local name = utils.GetPlayerName(leftPlayer.name)

		self.textLeftName:setText(name)

		local rightPlayer = CurAvatar.cachedKnockOutData.comm[2]

		self.playerRight:setCommInfo(rightPlayer)

		name = utils.GetPlayerName(rightPlayer.name)

		self.textRightName:setText(name)
	end
end

function BattleReplaySyncPlayerChild:clearCells()
	for _, btn in ipairs(self.btnLeftHeros) do
		btn:clear()
	end

	for _, btn in ipairs(self.btnRightHeros) do
		btn:clear()
	end
end

local BattleReplayHeroCell = Class("BattleReplayHeroCell", BattleMainBase.BattleHeroCellBase)

function BattleReplayHeroCell:ctor()
	self.bgSensor = UIControls.Image(self, self.mPath .. "/Bg")
end

function BattleReplayHeroCell:refreshState()
	BattleReplayHeroCell.super.refreshState(self)

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

local BattleReplayMoreHeroCell = Class("BattleReplayMoreHeroCell", BattleMainBase.BattleHeroCellBase)

function BattleReplayMoreHeroCell:ctor()
	self.bgBloodBlack = UIControls.Image(self, self.mPath .. "/BgBloodBlack")
end

function BattleReplayMoreHeroCell:onClickSensor(sender)
	return
end

function BattleReplayMoreHeroCell:refreshState()
	BattleReplayMoreHeroCell.super.refreshState(self)

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

local MainFuncConfig = {
	onBattleTime = BattleConst.MATRIX_EVENT_BATTLE_TIME
}
local strClassName = "BattleReplayMainDlg"
local BattleReplayMainDlg = Class(strClassName, BattleMainBase)

function BattleReplayMainDlg:ctor()
	return
end

function BattleReplayMainDlg:setDlgConfig()
	self.heroNum = 5
	self.heroCellClass = BattleReplayHeroCell
end

function BattleReplayMainDlg:initUI()
	BattleReplayMainDlg.super.initUI(self)

	self.btnPlaySpeed = UIControls.Button(self, "OtherFuncPanel/BtnPlaySpeed", "Text")

	self.btnPlaySpeed:addEventClick(self.onClickPlaySpeed)

	self.panelBgBottom = UIControls.Panel(self, "BgBottom")
	self.panelFuncBg = UIControls.Panel(self, "OtherFuncPanel/Bg")
	self.panelFuncBg2 = UIControls.Panel(self, "OtherFuncPanel/Text")
	self.panelHero2 = UIControls.Panel(self, "HeroFuncPanel2")
	self.btnQuickPlay = UIControls.Button(self, "OtherFuncPanel/BtnSkip")

	self.btnQuickPlay:addEventClick(self.onClickQuickPlay)
end

function BattleReplayMainDlg:onCreateHeroCell()
	self.btnHeros = {}

	local state = GameFsm.getCurState()

	if state.battleHeroNum and state.battleHeroNum > BattleConst.FORMATION_DEFAULT_NUM then
		self.heroNum = 9
		self.heroCellClass = BattleReplayMoreHeroCell
		self.heroChild = UIControls.Child(self, "HeroFuncPanel", "System/Battle/BattleField/HeroFuncPanel9")
	else
		self.heroNum = 5
		self.heroChild = UIControls.Child(self, "HeroFuncPanel", "System/Battle/BattleField/HeroFuncPanel5")
		self.heroCellClass = BattleReplayHeroCell
	end

	self.heroChild:setVisible(true)

	for index = 1, self.heroNum do
		local newBtn = self.heroCellClass(self.heroChild, "BtnHero" .. index)

		table.insert(self.btnHeros, newBtn)
	end
end

function BattleReplayMainDlg:_initBtnConfig()
	local state = GameFsm.getCurState()

	state:refreshInfoLevel(BattleConst.INFO_LEVEL_MIDDLE)
	self.btnInfo:setImage("Atlas/BattleAtlas/BattleMainAtlas", "BtnMessage2")
	self.btnInfo:setText(Lang.get(30136))
	state:onRaiseMatrixInput(BattleConst.INPUT_EVENT_SET_SHORT, self.inSkillShort and 1 or 0)
	self:onClickPlaySpeed()
	EventCenter.addEventListenerGroup(self, MainFuncConfig)
end

function BattleReplayMainDlg:onClickPlaySpeed()
	if self.speed == 1 then
		self.speed = 2

		self.btnPlaySpeed:setImage("Atlas/BattleAtlas/BattleMainAtlas", "BtnSpeed2")

		UnityEngine.Time.timeScale = 1.55

		CueManager.setSfxSpeed(1.55)
		self.btnPlaySpeed:setText(Lang.get(30131))
	elseif self.speed == 2 then
		self.speed = 4

		self.btnPlaySpeed:setImage("Atlas/BattleAtlas/BattleMainAtlas", "BtnSpeed4On")

		UnityEngine.Time.timeScale = 2.55

		CueManager.setSfxSpeed(2.55)
		self.btnPlaySpeed:setText(Lang.get(30133))
	else
		self.speed = 1

		self.btnPlaySpeed:setImage("Atlas/BattleAtlas/BattleMainAtlas", "BtnSpeed1")

		UnityEngine.Time.timeScale = 1.25

		CueManager.setSfxSpeed(1.25)
		self.btnPlaySpeed:setText(Lang.get(30132))
	end
end

function BattleReplayMainDlg:onClickQuickPlay()
	local state = GameFsm.getCurState()

	if state.replayEndBattle then
		state:replayEndBattle()
	end
end

function BattleReplayMainDlg:onClickQuit()
	if not GameFsm.isInState(Const.STATE_BATTLE_REPLAY) then
		return
	end

	GameFsm.getCurState():onLeaveBattle(false)
end

function BattleReplayMainDlg:_onBattleOver()
	EventCenter.removeEventListenerGroup(self, MainFuncConfig)

	if self.syncHeroList then
		self.syncHeroList:clearCells()
	end
end

function BattleReplayMainDlg:destroy()
	EventCenter.removeEventListenerGroup(self, MainFuncConfig)

	if self.syncHeroList then
		self.syncHeroList:clearCells()
	end

	BattleReplayMainDlg.super.destroy(self)
end

function BattleReplayMainDlg:initPlayers(state)
	if BattleConst.AUTO_SYNC_BATTLE[state.battleType] then
		self:_initSyncBattleMode(state)
		self.btnQuickPlay:setVisible(false)
	else
		self.btnQuickPlay:setVisible(true)

		if self.syncHeroList then
			self.syncHeroList:setVisible(false)
		end

		BattleReplayMainDlg.super.initPlayers(self, state)
	end
end

function BattleReplayMainDlg:_initSyncBattleMode(state)
	self.panelHero:setVisible(false)
	self.panelBgBottom:setVisible(false)
	self.btnPlaySpeed:setVisible(false)
	self.panelFuncBg:setVisible(false)
	self.panelFuncBg2:setVisible(false)
	self.panelFunc:setVisible(false)
	self.panelHero2:setVisible(true)

	self.speed = BattleMiscConfig.SYNC_REPLAY_TIME_SPEED
	UnityEngine.Time.timeScale = BattleMiscConfig.SYNC_REPLAY_TIME_SPEED

	CueManager.setSfxSpeed(BattleMiscConfig.SYNC_REPLAY_TIME_SPEED)

	if not self.syncHeroList then
		self.syncHeroList = BattleReplaySyncPlayerChild(self, "HeroFuncPanel2", "System/TopPVP/TopPVPHeroFuncPanel")
	end

	self.syncHeroList:setVisible(true)
	self.syncHeroList:setData(state)
end

return BattleReplayMainDlg
