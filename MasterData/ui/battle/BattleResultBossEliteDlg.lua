-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Battle\\BattleResultBossEliteDlg.lua

local ResHero = require("ClientData/ResHero")
local BattleConst = require("Common/FrameBattle/BattleConst")
local ResTower = require("ClientData/ResTower")
local ResColor = require("ClientData/ResColor")
local WorldBossCommon = require("Logic/WorldBoss/WorldBossCommon")
local strClassName = "BattleResultBossEliteDlg"
local BattleResultBossEliteDlg = Class(strClassName, UIControls.Window)

function BattleResultBossEliteDlg:ctor()
	self:initUI()
end

function BattleResultBossEliteDlg:initUI()
	self.textTime = UIControls.Label(self, "BgPanel/InfoPanel/TextBattleTime")
	self.panelWorldBossResult = UIControls.Panel(self, "ResultPanel")
	self.panelWorldBossResultElite = UIControls.Panel(self, "ResultPanel1")
	self.panelWorldBossTotalInfo = UIControls.Panel(self, "BgPanel/InfoPanel/WorldBossTotalPointPanel")
	self.panelTotalWorldbossResult = UIControls.Panel(self, "ResultPanel2")
	self.btnRecord = UIControls.Button(self, "BgPanel/BtnPanel/BtnBattleData")

	self.btnRecord:addEventClick(self.onBtnRecord)

	self.btnNext = UIControls.Button(self, "BgPanel/BtnPanel/BtnConfirm")

	self.btnNext:addEventClick(self.onBtnNext)

	self.rootAni = UIControls.UIAni(self, "")

	self.rootAni:addEventFinish(self._onAniFinish)
end

function BattleResultBossEliteDlg:bgmOn()
	local battleState = GameFsm.getCurState()

	if battleState and battleState.relicHero then
		local battleBGM = battleState.relicHero:getRelicBgmIdByType(Const.RELIC_BGM_TYPE_VICTORY)

		if battleBGM then
			CueManager.playUIBGM(battleBGM)
		end
	else
		BattleResultBossEliteDlg.super.bgmOn(self)
	end
end

function BattleResultBossEliteDlg:onShow(results)
	self.curBattleTime = results.curBattleTime or 0
	self.result = results[1]
	self.resultElite = results[2]
	self.curPoint = nil
	self.curElitePoint = tonumber(self.resultElite[3].spec.world_boss.score) or 0
	self.curScore = nil

	self:setWorldBossData()

	local battleState = GameFsm.getState(Const.STATE_BATTLE)

	self.battleType = battleState.battleType

	self:_startStageBattle(battleState:getBattleObjMgr())
end

function BattleResultBossEliteDlg:setWorldBossData(...)
	self.imgNewRecord = UIControls.Image(self, "ResultPanel/ImgNewRecord")

	self.panelWorldBossResult:setVisible(true)
	self.panelWorldBossResultElite:setVisible(false)
	self.panelTotalWorldbossResult:setVisible(false)
	self.btnRecord:setVisible(false)
	self.btnNext:setVisible(false)

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

	self.txtPointResult = UIControls.Label(self, "ResultPanel/WorldBossPointPanel/TextPoint")
	self.txtPointNextResult = UIControls.Label(self, "ResultPanel/WorldBossPointPanel/TextPointNext")
	self.txtPointChange = UIControls.Label(self, "ResultPanel/WorldBossPointPanel/TextPoint/BgChange/TextPointChange")
	self.panelEfxRank = UIControls.Panel(self, "ResultPanel/WorldBossPointPanel/IconRankLv/EfxRank")

	local preScore, curScore = ClientUtils.record.cachedWorldBossScore, WorldBossCommon.getSumScore()
	local changeScore = curScore - preScore

	self.curPoint = changeScore

	local isNewRecord = changeScore > ClientUtils.record.cachedWorldBossMaxScore

	self.imgNewRecord:setVisible(isNewRecord)

	local rankInfo, preRankInfo = WorldBossCommon.getRankInfo(preScore)

	WorldBossCommon.setRankUI(self.rankUIData1, preRankInfo)
	self.txtPointNextResult:setText(ClientUtils.getNumShortStr(rankInfo.score))
	self.txtPointResult:setText(ClientUtils.getNumShortStr(preScore, true))

	local rankInfo2, preRankInfo2, isOverMax = WorldBossCommon.getRankInfo(curScore)

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

function BattleResultBossEliteDlg:setWorldBossEliteData(...)
	self.panelWorldBossResult:setVisible(false)
	self.panelWorldBossResultElite:setVisible(true)
	self.panelTotalWorldbossResult:setVisible(false)
	self.btnRecord:setVisible(true)
	self.btnRecord:addEventClick(self.onBtnRecord)
	self.btnNext:setVisible(true)
	self.btnNext:addEventClick(self.onBtnNext)

	self.imgNewRecordElite = UIControls.Image(self, "ResultPanel1/ImgNewRecord")
	self.txtPointResult = UIControls.Label(self, "ResultPanel1/WorldBossElitePointPanel/TextPoint")
	self.panelElitePointHistory = UIControls.UIAni(self, "ResultPanel1/WorldBossElitePointHistoryPanel")
	self.txtElitePointHistory = UIControls.Label(self, "ResultPanel1/WorldBossElitePointHistoryPanel/TextPoint")
	self.curScore = self.curPoint + self.curElitePoint

	local maxRecord = ClientUtils.record.cachedEliteWorldBossMaxScore

	self.txtPointResult:setText(ClientUtils.getNumShortStr(self.curElitePoint, true))
	self.txtElitePointHistory:setText(ClientUtils.getNumShortStr(maxRecord, true))
end

function BattleResultBossEliteDlg:showTotal(...)
	self.panelWorldBossResult:setVisible(false)
	self.panelWorldBossResultElite:setVisible(false)
	self.panelTotalWorldbossResult:setVisible(true)

	self.imgTotalNewRecord = UIControls.Image(self, "ResultPanel2/ImgNewRecord")
	self.txtTotalPointResult = UIControls.Label(self, "ResultPanel2/WorldBossTotalPointPanel/TextPoint")
	self.panelTotalPointHistory = UIControls.UIAni(self, "ResultPanel2/WorldBossTotalPointHistoryPanel")
	self.txtTotalPointHistory = UIControls.Label(self, "ResultPanel2/WorldBossTotalPointHistoryPanel/TextPoint")
	self.curScore = self.curPoint + self.curElitePoint

	local maxRecord = ClientUtils.record.cachedEliteWorldBossMaxScore

	if maxRecord < self.curScore then
		self.panelElitePointHistory:startAni("ChallengeBossHistoryRenew")
	end

	self.imgTotalNewRecord:setVisible(maxRecord < self.curScore)

	maxRecord = maxRecord < self.curScore and self.curScore or maxRecord

	self.txtTotalPointResult:setText(ClientUtils.getNumShortStr(self.curScore, true))
	self.txtTotalPointHistory:setText(ClientUtils.getNumShortStr(maxRecord, true))
end

function BattleResultBossEliteDlg:showBottom(...)
	self.panelWorldBossTotalInfo = UIControls.Panel(self, "BgPanel/InfoPanel/WorldBossTotalPointPanel")
	self.txtTotalPoint = UIControls.Label(self, "BgPanel/InfoPanel/WorldBossTotalPointPanel/TextPoint")
	self.txtBgPoint1 = UIControls.Label(self, "BgPanel/InfoPanel/WorldBossTotalPointPanel/TextNum1")
	self.txtBgPoint2 = UIControls.Label(self, "BgPanel/InfoPanel/WorldBossTotalPointPanel/TextNum2")
	self.panelNewRecord = UIControls.Panel(self, "BgPanel/InfoPanel/ImgNewRecord")

	local preScore, curScore = ClientUtils.record.cachedWorldBossScore, WorldBossCommon.getSumScore()
	local changeScore = curScore - preScore

	self.txtTotalPoint:setText(ClientUtils.getNumShortStr(self.curScore, true))
	self.txtBgPoint1:setText(ClientUtils.getNumShortStr(changeScore))
	self.txtBgPoint2:setText(ClientUtils.getNumShortStr(self.curScore - changeScore))

	local maxRecord = ClientUtils.record.cachedEliteWorldBossMaxScore

	self.panelNewRecord:setVisible(maxRecord < self.curScore)
end

function BattleResultBossEliteDlg:_getBossBattleResult(settle)
	local percent = settle % 100000 / 100
	local layer = math.floor(settle / 100000)

	return layer, percent .. "%"
end

function BattleResultBossEliteDlg:_startStageBattle(battleInfo)
	local time = 0

	if battleInfo then
		time = battleInfo:getBattleTime() + self.curBattleTime
	end

	local timeSec = math.floor(time)

	self.textTime:setText(utils.calcTimeTxt(timeSec))
end

function BattleResultBossEliteDlg:onBtnRecord()
	UIManager.getUI("battleBossEliteRecordDlg", true):onShowByType(self.battleType, false)
end

function BattleResultBossEliteDlg:onBtnNext()
	local eliteSore = self.curScore or 0

	UIManager.getUI("worldBossResultEliteAwardDlg", true):show(eliteSore)
	self:setVisible(false)
end

function BattleResultBossEliteDlg:_onAniFinish(aniCom, aniName)
	if aniName == "InBattleResultBossWin1" then
		self.rootAni:startAni("ChangeBattleResultBossWin1")
		self:setWorldBossEliteData()
	elseif aniName == "ChangeBattleResultBossWin1" then
		self:showTotal()
		self:playAni("ChangeBattleResultBossWin2", nil)
	elseif aniName == "ChangeBattleResultBossWin2" then
		self:showBottom()
		self:playAni("ChangeBattleResultBossWin3", nil)
	end
end

function BattleResultBossEliteDlg:destroy()
	BattleResultBossEliteDlg.super.destroy(self)

	if self.coAni then
		coroutine.stop(self.coAni)
	end

	self.coAni = nil
end

return BattleResultBossEliteDlg
