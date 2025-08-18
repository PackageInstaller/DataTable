-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\PlayEntry\\Boss\\BossMainDlg.lua

local ResColor = require("ClientData/ResColor")
local DragTwoPages = require("UI/Control/DragTwoPages")
local ResBossTower = require("ClientData/ResBossTower")
local ResBossTowerMisc = require("ClientData/ResBossTowerMisc")
local ResRandClient = require("ClientData/ResRandClient")
local BattleConst = require("Common/FrameBattle/BattleConst")
local ResClientNotice = require("ClientData/ResClientNotice")
local ResBossTowerAward = require("ClientData/ResBossTowerAward")
local ResBattleMonsterWaves = require("ClientData/ResBattleMonsterWaves")
local INFO_NOTICE_MAP = {
	Const.INFO_NOTICE_BOSSTOWER1,
	Const.INFO_NOTICE_BOSSTOWER2,
	Const.INFO_NOTICE_BOSSTOWER34,
	Const.INFO_NOTICE_BOSSTOWER34
}
local BossInfoPage = Class("BossInfoPage", UIControls.Child)

function BossInfoPage:ctor()
	self:initUI()

	self.curRank = 1
	self.curDiff = 1
	self.atkLayer = 0
	self.tgtRank = 1
	self.tgtDiff = 1
end

function BossInfoPage:initUI()
	self.imgRoleBoss = UIControls.Role(self, "GridHeroPortraitPanel")
	self.txtTitle = UIControls.Label(self, "TextTitle")
	self.txtBossDes = UIControls.Label(self, "TextBossDes")
	self.txtPlayerDes = UIControls.Label(self, "TextPlayerDes")
	self.btnsRank = {}

	local lvBasePath = "LvList/LvPanel"

	for i = 1, 5 do
		local path = lvBasePath .. i .. "/BtnLv"
		local btnRank = UIControls.Button(self, path, "TextLv")

		btnRank:addEventClick(self.onRankClick)

		btnRank.dis = UIControls.Image(self, path .. "Dis")
		btnRank.disTxt = UIControls.Label(self, path .. "Dis/TextLv")
		btnRank.idx = i
		self.btnsRank[i] = btnRank
	end

	self.waveAwardGrids = {}
	self.awardPanel = UIControls.Panel(self, "LvInfoPanel/AwardPanel")
	self.btnWaveAwardMore = UIControls.Button(self, "LvInfoPanel/AwardPanel/BtnAll")

	self.btnWaveAwardMore:addEventClick(self.onBtnWaveAwardClick)

	self.passAwardGrids = {}
	self.victoryAwardPanel = UIControls.Panel(self, "LvInfoPanel/VictoryAwardPanel")
	self.btnPassAwardMore = UIControls.Button(self, "LvInfoPanel/VictoryAwardPanel/BtnAll")

	self.btnPassAwardMore:addEventClick(self.onBtnPassAwardClick)

	self.gridsAward = {}
	self.txtTimeUpdate = UIControls.Label(self, "LvInfoPanel/TextNumBreak")
	self.btnBattle = UIControls.Button(self, "LvInfoPanel/BtnBattle", "Text")

	self.btnBattle:addEventClick(self.onBtnBattleClick)

	self.btnClean = UIControls.Button(self, "LvInfoPanel/BtnClean", "Text")

	self.btnClean:addEventClick(self.onBtnCleanClick)

	self.btnCleanPre = UIControls.Button(self, "LvInfoPanel/BtnCleanPre", "Text")

	self.btnCleanPre:addEventClick(self.onCleanPreClick)

	self.btnRanking = UIControls.Button(self, "BtnRanking")

	self.btnRanking:addEventClick(self.onBtnRankingClick)

	self.txtStateDesc = UIControls.Label(self, "LvInfoPanel/TextComplete")
	self.btnCircleBonus = UIControls.Button(self, "BtnAwardCircle")

	self.btnCircleBonus:addEventClick(self.onBtnCircleBonusClick)

	self.btnReplay = UIControls.Button(self, "LvInfoPanel/BtnReplay")

	self.btnReplay:addEventClick(self.onReplayClick)
	self.btnReplay:setVisible(true)

	self.panelRebackBonus = UIControls.Panel(self, "LvInfoPanel/AwardPanel/ReturnUpPanel")
end

function BossInfoPage:onBtnWaveAwardClick(sender)
	UIManager.getUI("bossWaveAwardBox", true):show(self.bType, self.data, self.nowWave)
end

function BossInfoPage:onBtnPassAwardClick(sender)
	UIManager.getUI("bossVictoryAwardBox", true):show(self.bType, self.atkLayer)
end

function BossInfoPage:setData(bossType)
	self.bType = bossType
	self.layersData = ResBossTower[self.bType]
	self.bossInfo = CurAvatar.mBossTowerInfos[bossType] or {}
	self.atkLayer = self.bossInfo.pass_layer or self.atkLayer

	self.btnCircleBonus:setVisible(self.bType == Const.BOSS_TOWER_TYPE_ZOMBIE)

	local defData = ResBossTowerMisc[self.bType]

	self.imgRoleBoss:showRole(defData.role_id)
	self:refreshBtns()

	self.tgtRank = self.atkLayer + 1

	if self.tgtRank > #self.layersData then
		self.tgtRank = #self.layersData
	end

	local startRank = math.min(#self.layersData - 4, math.max(1, self.tgtRank - 2))
	local tgtBtnRankIdx = 1

	for i, btnRank in ipairs(self.btnsRank) do
		local rank = startRank + i - 1
		local layerData = self.layersData[rank]

		btnRank:setVisible(layerData ~= nil)

		if btnRank:getVisible() then
			btnRank.rank = rank

			local isLock = rank > self.tgtRank

			btnRank:setVisible(not isLock)
			btnRank.dis:setVisible(isLock)

			local txtRank = string.format(Lang.get(30171), layerData.layer)

			if isLock then
				btnRank.disTxt:setText(txtRank)
			else
				btnRank:setText(txtRank)
			end

			if rank == self.tgtRank then
				tgtBtnRankIdx = i
			end
		end
	end

	ClientTimerManager.AddSecondFormatTickUI(self.txtTimeUpdate, ClientUtils.getServerTimeNextDay() - ClientUtils.getServerTime(), false, Lang.get(48670))
	self:onRankClick(self.btnsRank[tgtBtnRankIdx])
end

function BossInfoPage:refreshBtns()
	local tgtLayer = 1

	tgtLayer = self.atkLayer + 1

	local nextLayerData = self.layersData[tgtLayer]

	if nextLayerData == nil then
		tgtLayer = self.atkLayer
	end

	local hasLatLayer = true
	local lastLayerData = self.layersData[self.atkLayer]

	if lastLayerData == nil then
		hasLatLayer = false
	end

	local isAtked = tgtLayer == self.atkLayer
	local gotAward = ClientUtils.isTickToday(self.bossInfo.battle_award_tick)
	local hasClean = ClientUtils.isTickToday(self.bossInfo.sweep_tick)

	self:checkCanClean()

	self.hasGotAward = gotAward
	self.hasClean = hasClean
	self.checkCanEnter = not hasClean and not isAtked

	self.btnBattle:setVisible(self.checkCanEnter)
	self.btnClean:setVisible(isAtked)
	self.btnCleanPre:setVisible(self.cleanUnlock and hasLatLayer and not isAtked and not hasClean)
	self.txtStateDesc:setVisible(hasClean and not isAtked)

	if not hasClean then
		if not gotAward then
			self.btnCleanPre:setText(Lang.get(726))
			self.btnCleanPre:setEnable(true)
		else
			self.btnCleanPre:setText(Lang.get(82))
			self.btnCleanPre:setEnable(false)
		end
	end

	if isAtked then
		self.txtStateDesc:setText(Lang.get(724))
	else
		self.txtStateDesc:setText(Lang.get(30515))
	end
end

function BossInfoPage:checkCanClean()
	self.cleanUnlock = true

	local defData = ResBossTowerMisc[self.bType]

	if defData and ClientUtils.openZoneTime >= ClientUtils.getServerTimeByTimeStr(defData.limit_tick) and defData.level_limit and self.atkLayer < defData.level_limit then
		self.cleanUnlock = false
	end
end

function BossInfoPage:_updateInfo()
	self.data = self.layersData[self.curRank]

	if self.data == nil then
		return
	end

	self.txtTitle:setText(self.data.name)
	self.txtBossDes:setText(self.data.desc)
	self.txtPlayerDes:setText("")

	for i, btnRank in ipairs(self.btnsRank) do
		btnRank:setEnable(btnRank.rank ~= self.curRank)
	end

	self.nowWave = self.bossInfo.award or 0

	local allBonus = self.data.wave_award[self.nowWave + 1] or {}

	if not self.layersData[self.atkLayer + 1] then
		allBonus = self.data.wave_award[self.data.wave_num]
	end

	self.waveBonus = allBonus.award

	local gridConfig = {}

	if CurAvatar:hasPrivilegeType(Const.PRIVITY_KEY_EBONUS_WORLD_BOSS) then
		self.panelRebackBonus:setVisible(true)

		gridConfig.PrivilegeId = Const.PRIVITY_KEY_EBONUS_WORLD_BOSS
	else
		self.panelRebackBonus:setVisible(false)
	end

	ClientUtils.CreateBonusGrid(self, self.waveAwardGrids, "LvInfoPanel/AwardPanel/AwardList", self.waveBonus, false, 3, true, nil, nil, gridConfig)
	ClientUtils.CreateBonusGrid(self, self.passAwardGrids, "LvInfoPanel/VictoryAwardPanel/AwardList", self.data.once_award, false, 3, true)

	local gotAward = ClientUtils.isTickToday(self.bossInfo.battle_award_tick)
	local hasClean = ClientUtils.isTickToday(self.bossInfo.sweep_tick)

	if hasClean or gotAward then
		self.btnClean:setEnable(false)
		self.btnClean:setText(Lang.get(150))
	else
		self.btnClean:setEnable(true)
		self.btnClean:setText(Lang.get(82))
	end

	if not self.layersData[self.atkLayer + 1] then
		if hasClean or gotAward then
			self.nowWave = #self.data.wave_award
		else
			self.nowWave = 0
		end
	end

	self:refreshBtns()
end

function BossInfoPage:onRankClick(sender)
	self.curRank = sender.rank

	self:_updateInfo()
end

function BossInfoPage:onDiffClick(sender)
	self.curDiff = sender.idx

	self:_updateInfo()
end

function BossInfoPage:onBtnBattleClick(sender)
	local gotAward = ClientUtils.isTickToday(self.bossInfo.battle_award_tick)

	if not gotAward and self.atkLayer >= 1 and self.cleanUnlock then
		UIManager.showConfirmWithId(1023, Slot(self.onBattle, self), nil, nil, {})
	else
		self:onBattle()
	end
end

function BossInfoPage:onBattle()
	if self.bType == Const.BOSS_TOWER_TYPE_ZOMBIE and not CurAvatar:isInCircle() then
		UIManager.showConfirm(UIConst.CONFIRM_ONEBTN, "", ResClientNotice[191].notice, Slot(self.mParent.onBtnCloseClick, self.mParent))

		return
	end

	local battleData = {}

	battleData.bossTowerData = {}
	battleData.bossTowerData.type = self.bType
	battleData.bossTowerData.layer = self.curRank - 1
	battleData.battleSourceData = self.data

	if CurAvatar:getArtifactRemainBlankNum() <= 0 then
		CurAvatar:confirmBagAdd(Const.BAG_TYPE_ARTIFACT)
	else
		CurAvatar:enterFormation(self.data.pve_id, BattleConst.BATTLE_TYPE_BOSSTOWER, battleData)
	end
end

function BossInfoPage:onBtnCleanClick(sender)
	if CurAvatar:getArtifactRemainBlankNum() <= 0 then
		CurAvatar:confirmBagAdd(Const.BAG_TYPE_ARTIFACT)
	else
		RPC.bossTowerAwardGet({}, self.bType)
	end
end

function BossInfoPage:onCleanPreClick(sender)
	UIManager.showConfirmWithId(1022, Slot(self.onCleanPre, self), nil, nil, {})
end

function BossInfoPage:onCleanPre()
	RPC.bossTowerAwardGet({}, self.bType)
end

function BossInfoPage:onBtnRankingClick()
	if self.bType == Const.BOSS_TOWER_TYPE_ZOMBIE and not CurAvatar:isInCircle() then
		UIManager.showConfirm(UIConst.CONFIRM_ONEBTN, "", ResClientNotice[191].notice, Slot(self.mParent.onBtnCloseClick, self.mParent))

		return
	end

	local rankMainDlg = UIManager.getUI("rankMainDlg", true)

	rankMainDlg:initByRankType(Const["RANK_TYPE_BOSSTOWER" .. self.bType])
end

function BossInfoPage:onBtnCircleBonusClick()
	if self.bType == Const.BOSS_TOWER_TYPE_ZOMBIE and not CurAvatar:isInCircle() then
		UIManager.showConfirm(UIConst.CONFIRM_ONEBTN, "", ResClientNotice[191].notice, Slot(self.mParent.onBtnCloseClick, self.mParent))

		return
	end

	local bossAwardCircleDlg = UIManager.getUI("bossAwardCircleDlg", true)

	if bossAwardCircleDlg then
		if CurAvatar.myCircle then
			local rankData = CurAvatar.myCircle:getBossRankData()

			if #rankData.dataList > 0 then
				bossAwardCircleDlg:setMemberRankData(rankData.dataList[1])
			else
				bossAwardCircleDlg:setEmptyStatus()
			end
		else
			bossAwardCircleDlg:setEmptyStatus()
		end
	end
end

function BossInfoPage:onReplayClick()
	self.mParent:onReplayClick(self.bType, self.tgtRank, self.checkCanEnter, Slot(self.onBtnBattleClick, self))
end

local strClassName = "BossMainDlg"
local BossMainDlg = Class(strClassName, UIControls.Window)

function BossMainDlg:ctor()
	self:initUI()
end

function BossMainDlg:initUI()
	self.btnClose = UIControls.Button(self, "BtnClose", "Text")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnHint = UIControls.Button(self, "BtnTips")

	self.btnHint:addEventClick(self.onBtnHintClick)

	self.dragPages = DragTwoPages(self, "MainInfoPanel/ContentPanel1", "MainInfoPanel/ContentPanel2", "MainInfoPanel/BtnPre", "MainInfoPanel/BtnNext")
	self.dragPages.dragEvent = Slot(self.onDragEvent, self)
	self.pages = {}

	local pagePrefabPath = "System/ChallengeBoss/ChallengeBossLvInfoPanel"

	for i = 1, 2 do
		self.pages[i] = BossInfoPage(self, "MainInfoPanel/ContentPanel" .. i, pagePrefabPath, 0, 0, true)
	end
end

function BossMainDlg:destroy()
	BossMainDlg.super.destroy(self)
end

function BossMainDlg:onOpen()
	BossMainDlg.super.onOpen(self)
	CurAvatar:checkPushGiftTrigger(self.mUIName, Const.ON_WINDOW_OPEN)
end

function BossMainDlg:show(bossType, bossTypes, winResult)
	if bossType then
		self._bType = bossType
	end

	if bossTypes then
		self._bTypes = bossTypes
	else
		self._bTypes = {}

		for bType = 1, #ResBossTowerMisc do
			if bType == Const.BOSS_TOWER_TYPE_ZOMBIE and not CurAvatar:isInCircle() or ConditionLimitManager.inLimitState(ResBossTowerMisc[bType].lock_id) then
				-- block empty
			else
				table.insert(self._bTypes, bType)
			end
		end
	end

	for i, bType in ipairs(self._bTypes) do
		if bType == self._bType then
			self.dragPages:initPage(#self._bTypes, i)
		end
	end
end

function BossMainDlg:onDragEvent(sender, currentPageIndex, panelIndex)
	local bossType = self._bTypes[currentPageIndex]
	local page = self.pages[panelIndex]

	page:setData(bossType)

	self.btnHint.noticeID = INFO_NOTICE_MAP[bossType]

	self.btnClose:setText(page.data.name)
end

function BossMainDlg:onBtnCloseClick(sender)
	self:setVisible(false)
	CurAvatar:checkPushGiftTrigger(self.mUIName, Const.ON_WINDOW_CLOSE)
end

function BossMainDlg:onBtnHintClick(sender)
	UIManager.getUI("infoNotice", true):showSystemInfo(sender.noticeID)
end

function BossMainDlg:onReplayClick(bType, layer, checkCanEnter, onBattleClick)
	self.checkCanEnter = checkCanEnter
	self.onBattleClick = onBattleClick

	if self.recordData and self.recordData[bType] and self.recordData[bType][layer] then
		self:onBossTowerReplayRecordResp(bType, layer, self.recordData[bType][layer])
	else
		RPC.bossTowerReplayRecord(bType, layer)
	end
end

function BossMainDlg:onBossTowerReplayRecordResp(bType, layer, data)
	if not self.recordData then
		self.recordData = {}
	end

	if not self.recordData[bType] then
		self.recordData[bType] = {}
	end

	self.recordData[bType][layer] = data

	local extra = {
		battleType = BattleConst.BATTLE_TYPE_BOSSTOWER,
		checkCanEnter = self.checkCanEnter,
		onBattleClick = self.onBattleClick,
		type = bType
	}

	UIManager.getUI("onceTowerRecordDlg", true):setData(Const.BATTLE_REPLAY_BOSS_TOWER, data, {
		bType,
		layer
	}, extra)
end

return BossMainDlg
