-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Battle\\BossTowerResultDlg.lua

local ResHero = require("ClientData/ResHero")
local BattleConst = require("Common/FrameBattle/BattleConst")
local ResTower = require("ClientData/ResTower")
local ResColor = require("ClientData/ResColor")
local WorldBossCommon = require("Logic/WorldBoss/WorldBossCommon")
local strClassName = "BossTowerResultDlg"
local BossTowerResultDlg = Class(strClassName, UIControls.Window)

function BossTowerResultDlg:ctor()
	self:initUI()

	local state = GameFsm.getCurState()

	self.isZombie = state.isZombieBattle and state:isZombieBattle() or false

	local bObjMgr = state:getBattleObjMgr()

	self.curZombieWave = 0
	self.wave = 0

	if self.isZombie and bObjMgr then
		self.curZombieWave = bObjMgr.beatedWave or 0
		self.wave = #bObjMgr.waveMonsters or 0
	end
end

function BossTowerResultDlg:initUI()
	self.textTime = UIControls.Label(self, "BgPanel/InfoPanel/TextBattleTime")
	self.hurtTitle = UIControls.Panel(self, "BgPanel/InfoPanel/TextAllHurtTitle")
	self.textHurt = UIControls.Label(self, "BgPanel/InfoPanel/TextAllHurtNum")
	self.textHurtRate = UIControls.Label(self, "BgPanel/InfoPanel/TextAllHurtNum/TextHurt")
	self.panelNewRecord = UIControls.Panel(self, "BgPanel/InfoPanel/ImgNewRecord")
	self.wavePanel = UIControls.Panel(self, "BgPanel/InfoPanel/WavePanel")
	self.textWaveNum = UIControls.Label(self, "BgPanel/InfoPanel/WavePanel/TextNum")
	self.btnRecord = UIControls.Button(self, "BgPanel/BtnPanel/BtnBattleData")

	self.btnRecord:addEventClick(self.onBtnRecord)

	self.btnNext = UIControls.Button(self, "BgPanel/BtnPanel/BtnConfirm")

	self.btnNext:addEventClick(self.onBtnNext)

	self.imgNewRecord = UIControls.Image(self, "ResultPanel/ImgNewRecord")
	self.resultWavePanel = UIControls.Panel(self, "ResultPanel/WavePanel")
	self.txtResultWave = UIControls.Label(self, "ResultPanel/WavePanel/TextNum")
	self.panelAward = UIControls.Panel(self, "BgPanel/AwardPanel")
	self.panelAwardNone = UIControls.Panel(self, "BgPanel/NonePanel")
	self.panelTips = UIControls.Panel(self, "BgPanel/TipsPanel")
	self.textTips = UIControls.Label(self, "BgPanel/TipsPanel/Text")
end

function BossTowerResultDlg:bgmOn()
	local battleState = GameFsm.getCurState()

	if battleState and battleState.relicHero then
		local battleBGM = battleState.relicHero:getRelicBgmIdByType(Const.RELIC_BGM_TYPE_VICTORY)

		if battleBGM then
			CueManager.playUIBGM(battleBGM)
		end
	else
		BossTowerResultDlg.super.bgmOn(self)
	end
end

function BossTowerResultDlg:onShow(battleType, result, finish, itemBonus)
	local battleState = GameFsm.getState(Const.STATE_BATTLE)

	self.battleType = battleState.battleType
	self.bonus = finish.spec.boss_tower
	self.itemBonus = itemBonus

	self:_startStageBattle(battleState:getBattleObjMgr())

	if self.battleType == BattleConst.BATTLE_TYPE_WORLD_BOSS then
		self:setWorldBossData()
	else
		self:setBossTowerData()
	end

	local tips

	if self.battleType == BattleConst.BATTLE_TYPE_BOSSTOWER then
		tips = CurAvatar:getNoticeTips(6)
	end

	if tips then
		self.panelTips:setVisible(true)
		self.textTips:setText(tips.tips_desc or "")
	else
		self.panelTips:setVisible(false)
	end
end

function BossTowerResultDlg:setBossTowerData(...)
	if self.bonus.new_record and self.bonus.new_record > 0 then
		self.panelNewRecord:setVisible(true)
		self.imgNewRecord:setVisible(true)
	else
		self.panelNewRecord:setVisible(false)
		self.imgNewRecord:setVisible(false)
	end

	if self.isZombie then
		self.hurtTitle:setVisible(false)
		self.textHurt:setVisible(false)
		self.wavePanel:setVisible(true)
		self.resultWavePanel:setVisible(true)
		self.textWaveNum:setText(self.curZombieWave .. "/" .. self.wave)
		self.txtResultWave:setText(self.curZombieWave .. "/" .. self.wave)
	else
		self.hurtTitle:setVisible(true)
		self.textHurt:setVisible(true)
		self.wavePanel:setVisible(false)
		self.resultWavePanel:setVisible(false)

		local layer, percent = self:_getBossBattleResult(self.bonus.settle)

		self.textHurt:setText(layer)
		self.textHurtRate:setText(percent)
	end
end

function BossTowerResultDlg:setWorldBossData(...)
	self.textHurt:setVisible(false)
	self.hurtTitle:setVisible(false)

	self.panelWorldBossResult = UIControls.Panel(self, "ResultPanel/WorldBossPointPanel")
	self.panelWorldBossInfo = UIControls.Panel(self, "BgPanel/InfoPanel/WorldBossPointPanel")

	self.panelWorldBossResult:setVisible(true)
	self.panelWorldBossInfo:setVisible(true)

	self.rankUIData1 = {}

	local uiNames = {
		"/IconRankLv",
		"/IconRankLv/BgRankLv",
		"/IconRankLv/BgRankLvS",
		"/IconRankLv/IconRankLvS"
	}
	local path = "ResultPanel/WorldBossPointPanel"

	for i, name in ipairs(uiNames) do
		self.rankUIData1[i] = UIControls.Image(self, path .. name)
	end

	self.rankUIData2 = {}
	path = "BgPanel/InfoPanel/WorldBossPointPanel"

	for i, name in ipairs(uiNames) do
		self.rankUIData2[i] = UIControls.Image(self, path .. name)
	end

	self.txtPointResult = UIControls.Label(self, "ResultPanel/WorldBossPointPanel/TextPoint")
	self.txtPointNextResult = UIControls.Label(self, "ResultPanel/WorldBossPointPanel/TextPointNext")
	self.txtPointChange = UIControls.Label(self, "ResultPanel/WorldBossPointPanel/TextPoint/BgChange/TextPointChange")
	self.txtPointInfo = UIControls.Label(self, "BgPanel/InfoPanel/WorldBossPointPanel/TextPoint")
	self.txtPointNextInfo = UIControls.Label(self, "BgPanel/InfoPanel/WorldBossPointPanel/TextPointNext")
	self.panelEfxRank = UIControls.Panel(self, "ResultPanel/WorldBossPointPanel/IconRankLv/EfxRank")

	local preScore, curScore = ClientUtils.record.cachedWorldBossScore, WorldBossCommon.getSumScore()
	local changeScore = curScore - preScore
	local isNewRecord = changeScore > ClientUtils.record.cachedWorldBossMaxScore

	self.imgNewRecord:setVisible(isNewRecord)
	self.panelNewRecord:setVisible(isNewRecord)

	local rankInfo, preRankInfo = WorldBossCommon.getRankInfo(preScore)

	WorldBossCommon.setRankUI(self.rankUIData1, preRankInfo)
	self.txtPointNextResult:setText(ClientUtils.getNumShortStr(rankInfo.score))
	self.txtPointResult:setText(ClientUtils.getNumShortStr(preScore, true))

	local rankInfo2, preRankInfo2, isOverMax = WorldBossCommon.getRankInfo(curScore)

	WorldBossCommon.setRankUI(self.rankUIData2, preRankInfo2)
	self.txtPointInfo:setText(ClientUtils.getNumShortStr(curScore, true))
	self.txtPointNextInfo:setText(ClientUtils.getNumShortStr(rankInfo2.score))
	self.txtPointNextInfo:setVisible(not isOverMax)
	self.txtPointNextResult:setVisible(not isOverMax)

	local isNewRankPart = preRankInfo.big_rank_idx ~= preRankInfo2.big_rank_idx or preRankInfo.small_rank_idx ~= preRankInfo2.small_rank_idx

	self.panelEfxRank:setVisible(isNewRankPart)

	self.coAni = coroutine.start(function(...)
		coroutine.wait(0.8)
		self.txtPointChange:jumpTo(changeScore, 0, 1)
		coroutine.wait(0.7)
		self.txtPointResult:setText(ClientUtils.getNumShortStr(curScore, true))
		self.txtPointNextResult:setText(ClientUtils.getNumShortStr(rankInfo2.score))
		WorldBossCommon.setRankUI(self.rankUIData1, preRankInfo2)
	end)
end

function BossTowerResultDlg:_getBossBattleResult(settle)
	local percent = settle % 100000 / 100
	local layer = math.floor(settle / 100000)

	return layer, percent .. "%"
end

function BossTowerResultDlg:_startStageBattle(battleInfo)
	local time = 0

	if battleInfo then
		time = battleInfo:getBattleTime()
	end

	local timeSec = math.floor(time)

	self.textTime:setText(utils.calcTimeTxt(timeSec))
end

function BossTowerResultDlg:onBtnRecord()
	UIManager.getUI("battleRecordDlg", true):onShow(self.isZombie or false)
end

function BossTowerResultDlg:onBtnNext()
	UIManager.getUI("zombieResultAwardDlg", true):show(self.itemBonus, nil, self.bonus)
	self:setVisible(false)
end

function BossTowerResultDlg:playNextAni()
	self:playAni("ChangeBattleResultBossWin", nil)
end

function BossTowerResultDlg:destroy()
	BossTowerResultDlg.super.destroy(self)

	if self.coAni then
		coroutine.stop(self.coAni)
	end

	self.coAni = nil
end

return BossTowerResultDlg
