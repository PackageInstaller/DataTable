-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Battle\\BattleRecommendDlg.lua

local BattleConst = require("Common/FrameBattle/BattleConst")
local EventConst = require("EventConst")
local OnceTowerRecordCell = require("UI/MainState/OtherBattle/OnceTowerRecordCell")
local AlternateTeamCell = Class("AlternateTeamCell", UIControls.Child)

function AlternateTeamCell:ctor()
	self.gridHeros = {}
	self.txtTitle = UIControls.Label(self, "TextAlternate")
end

function AlternateTeamCell:setData(heroIds)
	for key, value in pairs(heroIds) do
		local hero = UIControls.GridHeroInfoChild(self, "HeroList/Content", "System/Common/Grid/GridHeroInfo")

		hero:setHero(BaseObject.GetObject(value.hero))
		hero:hideHeroLv()
		hero:hideHeroGroup()
		hero:hideHeroStar()
		hero.btnHeroHead:clearEventClick()
		hero.btnHeroHead:addEventClick(Functor(self.onBtnGridHeroClick, self, value.hero))
	end
end

function AlternateTeamCell:onBtnGridHeroClick(heroId)
	UIManager.getUI("heroTips"):showObj(self, BaseObject.GetObject(heroId))
end

local HeroRankCell = Class("HeroRankCell", UIControls.ScrollViewLoopCell)

function HeroRankCell:ctor()
	self.imgRankBg = UIControls.Image(self, "BgPanel/Bg")
	self.imgRank = UIControls.Image(self, "BgPanel/ImgRank")
	self.imgIconCareer = UIControls.Image(self, "BgPanel/IconCareer")
	self.imgIconGroup = UIControls.Image(self, "BgPanel/IconGroup")
	self.txtHeroName = UIControls.Label(self, "BgPanel/TextHeroName")
	self.txtRankNum = UIControls.Label(self, "BgPanel/TextRankNum")
	self.txtHotNum = UIControls.Label(self, "BgPanel/ImageHot/Num")
end

function HeroRankCell:setData(data, idx)
	self.data = data
	self.idx = idx

	local rankBgSprite = idx <= 3 and idx >= 1 and "BgRank" .. idx or "BgRankOther"
	local rankSprite = idx <= 3 and idx >= 1 and "IconRank" .. idx or ""

	self.imgRankBg:setImage("Atlas/MainBattleAtlas/MainBattleRecommendAtlas", rankBgSprite)
	self.imgRank:setImage("Atlas/MainBattleAtlas/MainBattleRecommendAtlas", rankSprite)
	self.imgRank:setVisible(rankSprite ~= "")

	local rankNum = idx > 3 and idx or ""

	self.txtRankNum:setText(rankNum)
	self.txtRankNum:setVisible(rankNum ~= "")
	self.txtHotNum:setText(data.hot)

	if not self.gridHero then
		self.gridHero = UIControls.GridHeroInfoChild(self, "BgPanel/GridHero", "System/Common/Grid/GridHeroInfo")
	end

	local hero = BaseObject.GetObject(self.data.hero)

	self.gridHero:setHero(hero)
	self.txtHeroName:setText(hero.name)

	local careerPath = hero:getCareerPath()

	if careerPath then
		self.imgIconCareer:setImage(careerPath[1], careerPath[2])
	end

	local groupPath = hero:getGroupPath()

	if groupPath then
		self.imgIconGroup:setImage(groupPath[1], groupPath[2])
	end

	self.gridHero:hideHeroLv()
	self.gridHero:hideHeroGroup()
	self.gridHero:hideHeroCareer()
	self.gridHero:hideHeroName()
	self.gridHero:hideHeroStar()
	self.gridHero.btnHeroHead:clearEventClick()
	self.gridHero.btnHeroHead:addEventClick(Functor(self.onBtnGridHeroClick, self, self.data.hero))
end

function HeroRankCell:onBtnGridHeroClick(heroId)
	UIManager.getUI("heroTips"):showObj(self, BaseObject.GetObject(heroId))
end

local BattleRecommendDlg = Class("BattleRecommendDlg", UIControls.Window)

function BattleRecommendDlg:ctor()
	self:initUI()
end

function BattleRecommendDlg:initUI()
	self.txtLevelNum = UIControls.Label(self, "BgPanel/TextTitle/TextTitle2")
	self.scrollViewCareerPanels = {}

	for i = 0, 5 do
		local tabNames = "BgPanel/HeroRankPanel/HeroRankList" .. i
		local scrollView = UIControls.ScrollViewLoopV(self, "BgPanel/HeroRankPanel/HeroRankList" .. i, 0, self.onHeroRankCellChanged)

		scrollView.index = i

		table.insert(self.scrollViewCareerPanels, scrollView)
	end

	local panelNames = {
		"BgPanel/TeamRecPanel",
		"BgPanel/HeroRankPanel",
		"BgPanel/PlayerVideoListNew"
	}

	self.showPanels = {}

	for i = 1, #panelNames do
		local panel = UIControls.Panel(self, panelNames[i])

		table.insert(self.showPanels, panel)
	end

	local tabNames = {
		"BgPanel/TabTeam",
		"BgPanel/TabHero",
		"BgPanel/TabPlayerVideo"
	}

	self.btnTabs = {}

	for i = 1, #tabNames do
		local btnTab = UIControls.Button(self, tabNames[i])

		btnTab.tabIndex = i

		btnTab:addEventClick(self.onClickTab)
		table.insert(self.btnTabs, btnTab)
	end

	self.panelTeamRec = UIControls.Panel(self, "BgPanel/TextTitle/TextTitle2")
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onCloseClick)

	self.btnClose = UIControls.Button(self, "BgPanel/BtnTips")

	self.btnClose:addEventClick(self.onTipsClick)

	self.teamRecData = nil
	self.heroRankData = nil
	self.battleRecordData = nil
	self.recordCells = {}

	for index = 1, 3 do
		local newCell = OnceTowerRecordCell(self, "BgPanel/PlayerVideoListNew/Content", "System/MainBattle/MainBattleRecommend/PlayerLineUpInfoCell")

		table.insert(self.recordCells, newCell)
	end

	self.panelEmpty = UIControls.Panel(self, "BgPanel/NoContent")
end

function BattleRecommendDlg:onOpen()
	BattleRecommendDlg.super.onOpen(self)

	self.curLevelInfo = CurAvatar:getNextMainStageInfo()

	self:refreshUI()

	self.slotOnFormationDataNotify = Slot(self.onFormationDataNotify, self)

	EventCenter.addEventListener(EventConst.FORMATION_DATA_NOTIFY, self.slotOnFormationDataNotify)
end

function BattleRecommendDlg:refreshUI()
	self.bossLevelInfo = CurAvatar:getNextRecStageInfo()

	local levelText = ClientUtils.getMainStageLevelStr(self.bossLevelInfo.season, self.bossLevelInfo.chapter, self.bossLevelInfo.level)

	self.txtLevelNum:setText(levelText)

	local showReplay = self.curLevelInfo.levelBoss == 1

	showReplay = showReplay and not ConditionLimitManager.inLimitState(Const.CONDITION_BATTLE_PASS_REPLAY)

	self.btnTabs[3]:setVisible(showReplay)
end

function BattleRecommendDlg:onClose()
	BattleRecommendDlg.super.onClose(self)
	EventCenter.removeEventListener(EventConst.FORMATION_DATA_NOTIFY, self.slotOnFormationDataNotify)

	CurAvatar.checkJustShowReplayHeroInfo = nil
end

function BattleRecommendDlg:onCloseClick()
	self:setVisible(false)
end

function BattleRecommendDlg:onTipsClick()
	UIManager.getUI("infoNotice", true):showSystemInfo(542)
end

function BattleRecommendDlg:onRefreshUI(level, data, forceIndex)
	self.levelNum = level
	self.recData = data
	self.formationRec = CurAvatar:parseRecHeroByFormation(self.recData.hero, self.recData.formation)

	local index = 1

	if self.recData then
		if forceIndex then
			index = forceIndex
		elseif self.formationRec and #self.formationRec >= 1 then
			index = 1
		elseif self.recData.hero and #self.recData.hero >= 1 then
			index = 2
		elseif self.curLevelInfo.levelBoss == 1 and not ConditionLimitManager.inLimitState(Const.CONDITION_BATTLE_PASS_REPLAY) then
			index = 3
		end
	end

	self:onClickTab(self.btnTabs[index])
end

function BattleRecommendDlg:onClickTab(sender)
	for index, btn in ipairs(self.btnTabs) do
		btn:setEnable(btn ~= sender)
	end

	for index, panel in ipairs(self.showPanels) do
		panel:setVisible(sender.tabIndex == index)
	end

	self.panelEmpty:setVisible(false)

	self.curTabIndex = sender.tabIndex

	if sender.tabIndex == Const.Battle_Recommend_TYPE.LEVEL_RECOMMEND then
		self:refreshLevelRecommend()
	elseif sender.tabIndex == Const.Battle_Recommend_TYPE.HERO_RECOMMEND then
		if not self.careerBtns then
			self.careerBtns = {}

			for i = 0, 5 do
				local btn = UIControls.Button(self, "BgPanel/HeroRankPanel/CareerPanel/Career" .. i)

				btn.index = i

				btn:addEventClick(self.onClickCareerBtn)
				table.insert(self.careerBtns, btn)
			end
		end

		if not self.careerPanels then
			self.careerPanels = {}

			for i = 0, 5 do
				local panel = UIControls.Panel(self, "BgPanel/HeroRankPanel/HeroRankList" .. i)

				panel.index = i

				table.insert(self.careerPanels, panel)
			end
		end

		self:refreshHeroRank()
	elseif sender.tabIndex == Const.Battle_Recommend_TYPE.LEVEL_RECORD then
		local stageInfo = self.bossLevelInfo

		if stageInfo then
			local season = stageInfo.season
			local chapter = stageInfo.chapter
			local level = stageInfo.level

			if not season or not chapter or not level then
				return
			end

			local progress = self.recordData and self.recordData.progress

			if progress and progress.season == season and progress.chapter == chapter and progress.level == level then
				self:onStageRecordResp(season, chapter, level, self.recordData.data)

				return
			end

			RPC.stageRecord(season, chapter, level)
		end
	end
end

function BattleRecommendDlg:onClickCareerBtn(sender)
	for index, btn in ipairs(self.careerBtns) do
		btn:setEnable(btn ~= sender)
	end

	for index, panel in ipairs(self.careerPanels) do
		panel:setVisible(sender.index == panel.index)
	end

	local data = CurAvatar:parseRecHeroWithCareer(self.recData.hero, sender.index)

	if data and #data < 1 then
		-- block empty
	end

	self.curHeroData = data

	self.scrollViewCareerPanels[sender.index + 1]:setTotalCount(#data)
end

function BattleRecommendDlg:refreshLevelRecommend(data)
	self.showPanels[self.curTabIndex]:setVisible(true)

	local data = self.formationRec

	if not data or #data < 1 then
		self.showPanels[self.curTabIndex]:setVisible(false)
		self.panelEmpty:setVisible(true)

		return
	end

	if self.teamRecData then
		return
	end

	self.teamRecData = data
	self.heroInfoGroups = {}

	for key, value in pairs(data[1]) do
		self.heroInfoGroups[key] = UIControls.GridHeroInfoChild(self, "BgPanel/TeamRecPanel/RecommonedPanel/BestTeamRecom/HeroInfoGroup", "System/Common/Grid/GridHeroInfo")

		self.heroInfoGroups[key]:setHero(BaseObject.GetObject(value.hero))
		self.heroInfoGroups[key]:hideHeroLv()
		self.heroInfoGroups[key]:hideHeroGroup()
		self.heroInfoGroups[key]:hideHeroStar()
		self.heroInfoGroups[key].btnHeroHead:clearEventClick()
		self.heroInfoGroups[key].btnHeroHead:addEventClick(Functor(self.onBtnGridHeroClick, self, value.hero))
	end

	self.alternateTeamList = {}

	local otherData = {}

	for i = 2, #data do
		table.insert(otherData, data[i])
	end

	if not otherData then
		return
	end

	for index = 1, #otherData do
		local newCell = AlternateTeamCell(self, "BgPanel/TeamRecPanel/RecommonedPanel/AlternateTeamList/Content", "System/MainBattle/MainBattleRecommend/AlternateTeamCell")

		table.insert(self.alternateTeamList, newCell)
	end

	for index, cell in ipairs(self.alternateTeamList) do
		local heroIds = otherData[index]

		if heroIds then
			cell:setVisible(true)
			cell:setData(heroIds)
		else
			cell:setVisible(false)
		end
	end
end

function BattleRecommendDlg:onBtnGridHeroClick(heroId)
	UIManager.getUI("heroTips"):showObj(self, BaseObject.GetObject(heroId))
end

function BattleRecommendDlg:refreshHeroRank(data)
	if not self.recData or not self.recData.hero or #self.recData.hero < 1 then
		self.showPanels[self.curTabIndex]:setVisible(false)
		self.panelEmpty:setVisible(true)

		return
	end

	self.rankHeros = {}

	self:onClickCareerBtn(self.careerBtns[1])
end

function BattleRecommendDlg:onHeroRankCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = HeroRankCell(sender, "System/MainBattle/MainBattleRecommend/HeroRankCell", newIdx, 0, 0)
	end

	targetCell.mIndex = newIdx

	local data = self.curHeroData[newIdx]

	targetCell:setData(data, newIdx)
end

function BattleRecommendDlg:onStageRecordResp(season, chapter, level, data)
	if not self.recordData then
		self.recordData = {}
	end

	local progress = {}

	progress.season = season
	progress.chapter = chapter
	progress.level = level

	local extra = {
		checkCanEnter = true,
		battleType = BattleConst.BATTLE_TYPE_STAGE,
		onBattleClick = Slot(self.onBattleClick, self)
	}

	self.recordData.progress = progress
	self.recordData.data = data

	self:refreshRecord(Const.BATTLE_REPLAY_PASS, data, progress, extra)
end

function BattleRecommendDlg:refreshRecord(replayType, data, progress, extra)
	self.replayType = replayType
	self.data = data
	self.progress = progress
	self.extra = extra

	if self.extra and type(self.extra) == "table" then
		self.battleType = self.extra.battleType
		self.formationIndex = self:getFormationIndex()
	end

	local count = self.data and #self.data or 0

	if count == 0 then
		self.panelEmpty:setVisible(true)
	else
		self.panelEmpty:setVisible(false)

		for index, cell in ipairs(self.recordCells) do
			local info = data[index]

			if info then
				cell:setVisible(true)
				cell:setData(info.record, info.comm, self.extra, self.formationIndex)
			else
				cell:setVisible(false)
			end
		end
	end
end

function BattleRecommendDlg:onBattleClick(sender)
	if CurAvatar == nil or self.curLevelInfo == nil or self.curLevelInfo.idx ~= CurAvatar.mainStageAtkedIdx + 1 then
		return
	end

	if CurAvatar.realEnergyNum == 0 then
		local hasItem = false
		local items = ResStageMisc[1].recover_item_ids

		for _, itemId in ipairs(items) do
			if CurAvatar:getItemNumById(itemId) > 0 then
				hasItem = true

				break
			end
		end

		if hasItem then
			UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, Lang.get(5), ResClientNotice[192].notice, EnterBuy)
		else
			MsgManager.notice(ResClientNotice[193].notice)
		end

		return
	end

	self:realEnterBattle()
end

function BattleRecommendDlg:onFormationDataNotify(formationIdx)
	for _, cell in ipairs(self.recordCells) do
		if cell.formationIdx == formationIdx then
			if self.extra and self.extra.onBattleClick then
				self.extra.onBattleClick()
			end

			break
		end
	end
end

function BattleRecommendDlg:realEnterBattle()
	local stageInfo = {}

	stageInfo.stageData = {
		self.curLevelInfo.season,
		self.curLevelInfo.chapter,
		self.curLevelInfo.level,
		self.curLevelInfo
	}

	CurAvatar:enterFormation(self.curLevelInfo.pve_id, BattleConst.BATTLE_TYPE_STAGE, stageInfo)

	self.battleWaitCutOver = true

	self:setVisible(false)
end

function BattleRecommendDlg:destroy()
	if self.battleWaitCutOver and GameFsm.isInState(Const.STATE_BATTLE) then
		GameFsm.getCurState():onCutOver()
	end

	BattleRecommendDlg.super.destroy(self)
end

function BattleRecommendDlg:getFormationIndex()
	if not self.extra or not self.battleType then
		return nil
	end

	if self.battleType == BattleConst.FORMATION_TYPE_ASYNC_PVP then
		return Const.FORMATION_ASYNC_DEFEND
	elseif self.battleType == BattleConst.BATTLE_TYPE_MAZE then
		return Const.FORMATION_MAZE
	elseif self.battleType == BattleConst.BATTLE_TYPE_EQUIPTOWER then
		if self.extra.type then
			return Const["FORMATION_EQUIP_TOWER_" .. self.extra.type]
		end
	elseif self.battleType == BattleConst.BATTLE_TYPE_BOSSTOWER then
		if self.extra.type then
			return Const["FORMATION_BOSS_CHOOSE_" .. self.extra.type]
		end
	elseif self.battleType == BattleConst.BATTLE_TYPE_ACTIVITY or self.battleType == BattleConst.BATTLE_TYPE_STEPTOWER then
		return Const.FORMATION_FORCE_EMPTY
	elseif self.battleType == BattleConst.BATTLE_TYPE_WORLD_BOSS then
		if self.extra.type then
			return Const.FORMATION_WORLD_BOSS[self.extra.type]
		end
	elseif self.battleType == BattleConst.BATTLE_TYPE_SEASON_TOWER then
		if self.extra.towerId then
			return Const.SEASON_TOWER_FORMATION_CONFIG[self.extra.towerId]
		end
	elseif self.battleType == BattleConst.BATTLE_TYPE_RENT then
		return Const.FORMATION_RENT
	elseif self.battleType == BattleConst.BATTLE_TYPE_CIRCLE then
		return Const.FORMATION_CIRCLE_BATTLE
	elseif self.battleType == BattleConst.BATTLE_TYPE_BOSSTOWER_EXPAND then
		if self.extra.towerId then
			return Const.FORMATION_BOSS_EXPAND[self.extra.towerId]
		end
	elseif self.battleType == BattleConst.BATTLE_TYPE_NEW_MAZE then
		return Const.FORMATION_NEW_MAZE
	end

	return Const.FORMATION_MAIN_STAGE
end

function BattleRecommendDlg:cacheReplayData(data, isShowHero)
	if data == nil then
		return
	end

	if not self.replayDataDic then
		self.replayDataDic = {}
	end

	local replayId = data.replay_id

	self.replayDataDic[replayId] = data

	if isShowHero then
		for _, cell in pairs(self.recordCells) do
			if cell ~= nil and cell.replayId == replayId then
				cell:refreshHeroScroll(data)
			end
		end
	end
end

function BattleRecommendDlg:getReplayData(replayId)
	return self.replayDataDic and self.replayDataDic[replayId]
end

return BattleRecommendDlg
