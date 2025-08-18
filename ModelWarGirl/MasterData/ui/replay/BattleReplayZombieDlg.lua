-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Replay\\BattleReplayZombieDlg.lua

local BattleConst = require("Common/FrameBattle/BattleConst")
local BattleReplayMainDlg = require("UI/Replay/BattleReplayMainDlg")
local BattleMainBase = require("UI/Battle/BattleMainBase")
local strClassName = "BattleReplayZombieWaveCell"
local BattleReplayZombieWaveCell = Class(strClassName, UIControls.Panel)

function BattleReplayZombieWaveCell:ctor()
	self.imgCell = UIControls.Image(self, self.mPath .. "/ImgWave")
end

local STATE_NORMAL = 0
local STATE_FULL = 1
local STATE_WAIT = 2
local STATE_DEAD = 3
local BattleZombieReplayHeroCell = Class("BattleZombieReplayHeroCell", BattleMainBase.BattleHeroCellBase)

function BattleZombieReplayHeroCell:ctor()
	self.bgBloodBlack = UIControls.Image(self, self.mPath .. "/BgBloodBlack")
end

function BattleZombieReplayHeroCell:onClickSensor(sender)
	return
end

function BattleZombieReplayHeroCell:refreshState()
	BattleZombieReplayHeroCell.super.refreshState(self)

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
	onBattleWave = BattleConst.MATRIX_EVENT_MONSTER_WAVE,
	onWaveMonsterDead = BattleConst.MATRIX_EVENT_MONSTER_WAVE_DEAD,
	onActionEnd = BattleConst.MATRIX_EVENT_ACTION_END
}
local strClassName = "BattleReplayZombieDlg"
local BattleReplayZombieDlg = Class(strClassName, BattleReplayMainDlg)

function BattleReplayZombieDlg:ctor()
	return
end

function BattleReplayZombieDlg:setDlgConfig()
	self.heroNum = 9
	self.heroCellClass = BattleZombieReplayHeroCell
end

local MAX_WAVE = 6

function BattleReplayZombieDlg:initUI()
	BattleReplayZombieDlg.super.initUI(self)

	self.waveCells = {}

	for index = 1, MAX_WAVE do
		local newCell = BattleReplayZombieWaveCell(self, "WavePanel/BgWave" .. index)

		table.insert(self.waveCells, newCell)
	end

	self.aniWaveNotice = UIControls.UIAni(self, "WaveNoticePanel")

	self.aniWaveNotice:addEventFinish(self.onWaveAniOver)

	self.aniWaveRun = UIControls.UIAni(self, "WavePanel/ImgWave")
end

function BattleReplayZombieDlg:onCreateHeroCell()
	self.btnHeros = {}

	for index = 1, self.heroNum do
		local newBtn = self.heroCellClass(self, "HeroFuncPanel/BtnHero" .. index)

		table.insert(self.btnHeros, newBtn)
	end
end

function BattleReplayZombieDlg:_initBtnConfig()
	BattleReplayZombieDlg.super._initBtnConfig(self)

	local state = GameFsm.getCurState()

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

function BattleReplayZombieDlg:onBattleWave(nowWave)
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

function BattleReplayZombieDlg:onWaveAniOver()
	self.aniWaveNotice:setVisible(false)
end

function BattleReplayZombieDlg:onWaveMonsterDead(deadCamp)
	local state = GameFsm.getCurState()
	local bObjMgr = state:getBattleObjMgr()

	if bObjMgr and bObjMgr.curWave then
		self:showBoxGot(bObjMgr.curWave - 1)
	end
end

function BattleReplayZombieDlg:_onBattleOver()
	BattleReplayZombieDlg.super._onBattleOver(self)
	EventCenter.removeEventListenerGroup(self, MainFuncConfig)
end

function BattleReplayZombieDlg:onActionEnd(actionEnd)
	self.actionEnd = actionEnd

	for _, cell in ipairs(self.btnHeros) do
		if cell.refreshCellMana then
			cell:refreshCellMana()
		end
	end
end

function BattleReplayZombieDlg:destroy()
	EventCenter.removeEventListenerGroup(self, MainFuncConfig)
	BattleReplayZombieDlg.super.destroy(self)
end

return BattleReplayZombieDlg
