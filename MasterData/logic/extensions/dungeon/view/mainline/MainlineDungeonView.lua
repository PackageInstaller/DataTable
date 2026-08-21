-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/mainline/MainlineDungeonView.lua

module("logic.extensions.dungeon.view.mainline.MainlineDungeonView", package.seeall)

local M = class("MainlineDungeonView", ViewComponent)
local kAnimNamePanelOpen = "right_panel_open"
local kAnimNamePanelClose = "right_panel_close"
local MainLinePartImg = {
	"fbzx_text_parta_01",
	"fbzx_text_partb_01"
}
local Difficulty = DungeonEnum.Difficulty
local coinId = CommEnum.CurrencyCodeEnum.TlCode

function M:buildUI()
	self._screenWidth = ViewMgr.instance:getUIWidth()
	self._btnReturn = self:getBtn("1&title_view_-878360263")
	self._btnHome = self:getBtn("1&title_view_1398742689")
	self._scrollRect = goutil.findChild(self.mainGO, "worldMapScroll"):GetComponent(UIComponentType.ScrollRect)
	self._normalBgGo = goutil.findChild(self.mainGO, "bg/bg1")
	self._difficultBgGo = goutil.findChild(self.mainGO, "bg/bg2")
	self._difficultToggleGroup = goutil.findChild(self.mainGO, "content/difficultySelect"):GetComponent(UIComponentType.SpaceXToggleGroup)
	self._normalToggle = goutil.findChild(self.mainGO, "content/difficultySelect/togNormal"):GetComponent(UIComponentType.SpaceXToggle)
	self._difficultToggle = goutil.findChild(self.mainGO, "content/difficultySelect/togDifficulty"):GetComponent(UIComponentType.SpaceXToggle)
	self._difficultLockGo = goutil.findChild(self.mainGO, "content/difficultySelect/togDifficulty/normal/lock")
	self._difficultToggleTxt = goutil.findChildTextComponent(self._difficultToggle.gameObject, "normal/TextLocalization")
	self._txtProgressNormal = goutil.findChildTextComponent(self.mainGO, "content/difficultySelect/togNormal/txtProgress")
	self._txtProgressDifficulty = goutil.findChildTextComponent(self.mainGO, "content/difficultySelect/togDifficulty/txtProgress")
	self._starBonusBtn = self:getBtn("branch_line_view_512892577")
	self._normalStarReward = DungeonStarRewardSign.New(self:getGoByPath("content/btnBounty/imgNormal"))
	self._hardStarReward = DungeonStarRewardSign.New(self:getGoByPath("content/btnBounty/imgHard"))
	self._canReciveEffNormal = self:getGoByPath("content/btnBounty/imgNormal/effect")
	self._canReciveEffHard = self:getGoByPath("content/btnBounty/imgHard/effect")
	self._starTxt = self:getText("instance_view_copy_-769655701")
	self._imgTitle = goutil.addComponentOnce(goutil.findChild(self.mainGO, "content/chapterNum/ImageLocalization"), ComponentType.ImageLocalization)
	self._imgPart = goutil.findChildImageComponent(self.mainGO, "content/chapterNum/ImagePart")
	self._txtNum = goutil.findChildTextComponent(self.mainGO, "content/chapterNum/txtNum")
	self._goHardBonusRedDot = self:getGo("16&red_point_-1414002736")
	self._dungeonPanelGo = self:getGo("branch_line_view_1973018685")
	self._dungeonPanelAnim = goutil.addComponentOnce(self._dungeonPanelGo, typeof(Astral.GUITimelineAniLua))
	self._dungeonIndexTxt = self:getText("branch_line_view_1329177415")
	self._dungeonNameTxt = self:getText("branch_line_view_1640393073")
	self._dungeonDi = self:getGo("branch_line_view_449896386")
	self._dungeonContent = self:getGoByPath("levelDetailsPanel/neirong")
	self._dungeonScoreRateGo = self:getGo("4&instance_danger_-1654566369")
	self._moreRewardBtn = self:getBtn("instance_view_copy_1174224290")
	self._star1FinishSignGo = self:getGo("instance_view_copy_-1229522008")
	self._star1DescTxt = self:getText("branch_line_view_2081318875")
	self._star2FinishSignGo = self:getGo("instance_view_copy_-262734455")
	self._star2DescTxt = self:getText("instance_view_copy_-145421265")
	self._star3FinishSignGo = self:getGo("instance_view_copy_-580513770")
	self._star3DescTxt = self:getText("instance_view_copy_-1850904072")
	self._clickGo = self:getGo("instance_view_511724902")
	self._bottomInfo = self:getGo("instance_view_1976541892")
	self._btnPlot = self:getBtnByPath("levelDetailsPanel/neirong/bottomInfo/btnPlot")
	self._quickFightBtn = self:getBtnByPath("levelDetailsPanel/neirong/bottomInfo/btnQuickFight")
	self._btnFight = self:getBtnByPath("levelDetailsPanel/neirong/bottomInfo/Fight/btnFight")
	self.go_com_priceShot = self:getGo("18&com_price_1317146225")
	self._costCellShot = PrefabReferenceUtil.createCurrencyCostLuaCell(self.go_com_priceShot)
	self._textFight = self:getText("13&btn_left_423343501")
	self._bottomInfoLong = self:getGo("instance_view_-2005728360")
	self._fightBtnLong = self:getBtnByPath("levelDetailsPanel/neirong/bottomInfo2/btnFight")
	self.go_com_priceLong = self:getGo("19&com_price_1317146225")
	self._costCellLong = PrefabReferenceUtil.createCurrencyCostLuaCell(self.go_com_priceLong)
	self._dungeonPanelCloseBtn = self:getBtn("branch_line_view_1534753572")
	self._bossListGo = self:getGo("instance_view_1171353157")
	self._btnEnemy = self:getBtn("instance_view_-451278171")
	self._rewardListGo = self:getGo("branch_line_view_1963544490")
	self._btnDifficultLock = self:getBtnByPath("content/difficultySelect/togDifficulty/normal/lock")
	self._starFinishSignGoList = {
		self._star1FinishSignGo,
		self._star2FinishSignGo,
		self._star3FinishSignGo
	}
	self._starDescTxtList = {
		self._star1DescTxt,
		self._star2DescTxt,
		self._star3DescTxt
	}
	self._mapPanelGo = goutil.findChild(self.mainGO, "worldMapScroll/drag/world_map")
	self._goPlotPicture = self:getGoByPath("levelDetailsPanel/neirong/infoContent/storyInfo")
	self._goConditionInfo = self:getGoByPath("levelDetailsPanel/neirong/conditionInfo")
	self._goEnemyInfo = self:getGoByPath("levelDetailsPanel/neirong/bossInfo")
	self._goRewardInfo = self:getGoByPath("levelDetailsPanel/neirong/rewardInfo")
	self._goCostLong = self:getGoByPath("levelDetailsPanel/neirong/bottomInfo2/com_price")
	self._goBossSign = goutil.findChild(self._dungeonPanelGo, "boosSign")
	self._imgPlotPicture = goutil.findChildImageComponent(self._goPlotPicture, "imgPicture")
	self._txtPlotDesc = self:getText("instance_view_-817005632")
	self._resLoader = MultiResLoader.New()
	self._mapViewList = {}
	self._heroTemplate = goutil.findChild(self._goEnemyInfo, "hero_item")

	local btn_skill_bonusGo = goutil.findChild(self._goRewardInfo, "btn_skill_bonus")

	self._btnSkillUp = UIComponentType.ButtonAdapter(goutil.findChild(btn_skill_bonusGo, "btnUp"))
	self._btnSkillDown = UIComponentType.ButtonAdapter(goutil.findChild(btn_skill_bonusGo, "btnDown"))

	goutil.setActive(self._btnSkillUp.gameObject, AchievementModel.instance:isGetSkill(CommEnum.CharacterSkillType.Type3))
	goutil.setActive(self._btnSkillDown.gameObject, false)

	self._txtInfo = self:getText("instance_view_407066031")
	self._btnInfo = self:getBtn("instance_view_1920059968")
	self._imgInfo = self:getGo("instance_view_-1577409599")
	self._rewardScroll = goutil.findChild(self._goRewardInfo, "scroll"):GetComponent(UIComponentType.ScrollRect)

	local jumpGo = self:getGo("instance_view_copy_-1272281782")

	goutil.setActive(jumpGo, false)

	self._activity = Astral.LuaComponentContainer.Add(jumpGo, MainlineActivityView)
	self._doubleHintGo = self:getGo("17&com_multiple_rewards_right_hint_1207926246")
	self._txtNumberMultiple = self:getText("17&com_multiple_rewards_right_hint_1142272974")
	self._txtTimesMultiple = self:getText("17&com_multiple_rewards_right_hint_490855671")
end

function M:destroyUI()
	self._activity:destroyUI()
	self:clearMap()
	self._resLoader:clear()
end

function M:bindEvents()
	self._btnReturn:AddClickListener(self._onClickReturn, self)
	self._btnHome:AddClickListener(self._onClickHome, self)
	self._starBonusBtn:AddClickListener(self._onClickStarBonusBtn, self)
	self._btnEnemy:AddClickListener(self._onClickBtnEnemy, self)
	self._btnDifficultLock:AddClickListener(self._onClickDifficultLock, self)
	self._moreRewardBtn:AddClickListener(self._onClickMoreReward, self)
	self._btnFight:AddClickListener(self._onClickStartFight, self)
	self._fightBtnLong:AddClickListener(self._onClickStartFight, self)
	self._quickFightBtn:AddClickListener(self._onClickQuickFight, self)
	self._dungeonPanelCloseBtn:AddClickListener(self._onClickCloseDungeonDetailPanel, self)
	self._normalToggle:AddListener(self._onNormalToggleUpdate, self)
	self._dungeonPanelAnim:AddListener(self._onDungeonPanelAnimDone, self)
	self._btnSkillUp:AddClickListener(self._onOpenSkillSmallTips, self)
	self._btnPlot:AddClickListener(self._onClickPlot, self)
	self._btnInfo:AddClickListener(self._onClickTipsInfo, self)
end

function M:unbindEvents()
	self._btnReturn:RemoveClickListener()
	self._btnHome:RemoveClickListener()
	self._starBonusBtn:RemoveClickListener()
	self._btnEnemy:RemoveClickListener()
	self._btnDifficultLock:RemoveClickListener()
	self._moreRewardBtn:RemoveClickListener()
	self._btnFight:RemoveClickListener()
	self._fightBtnLong:RemoveClickListener()
	self._quickFightBtn:RemoveClickListener()
	self._dungeonPanelCloseBtn:RemoveClickListener()
	self._normalToggle:RemoveListener()
	self._dungeonPanelAnim:RemoveListener()
	self._btnSkillUp:RemoveClickListener()
	self._btnPlot:RemoveClickListener()
	self._btnInfo:RemoveClickListener()
end

function M:_bindEvents()
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_Language)
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_Dungeon)
	DungeonDispatcher:addEventListener(DungeonEventType.ON_PICK_Dungeon_Node, self._onPickDungeonNode, self)
	GlobalDispatcher:addEventListener(EventType.ON_MULTI_FIGHT_TIPS_CONFIRM, self._handleMultiFightTipsConfirm, self)
	GlobalDispatcher:addEventListener(EventType.ON_DUNGEON_DANGER_TIPS_CONFIRM, self._goFight, self)
	GlobalDispatcher:addEventListener(EventType.DUNGEON_STAR_REWARD_UPDATE, self._handleStarRewardGot, self)
	GlobalDispatcher:addEventListener(EventType.ON_SET_PLOT_ANSWERS_REPLY, self._handleSetPlotAnswerReply, self)
end

function M:_unbindEvents()
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_Dungeon)
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_Language)
	DungeonDispatcher:removeEventListener(DungeonEventType.ON_PICK_Dungeon_Node, self._onPickDungeonNode, self)
	GlobalDispatcher:removeEventListener(EventType.ON_MULTI_FIGHT_TIPS_CONFIRM, self._handleMultiFightTipsConfirm, self)
	GlobalDispatcher:removeEventListener(EventType.ON_DUNGEON_DANGER_TIPS_CONFIRM, self._goFight, self)
	GlobalDispatcher:removeEventListener(EventType.DUNGEON_STAR_REWARD_UPDATE, self._handleStarRewardGot, self)
	GlobalDispatcher:removeEventListener(EventType.ON_SET_PLOT_ANSWERS_REPLY, self._handleSetPlotAnswerReply, self)
end

function M:onEnter()
	self._hasLoadRes = false
	self._gamePlay = BattleEnum.GamePlayType.RECORD

	self:clearMap()
	self:_bindEvents()
	self:_initView()
	self._costCellShot:updateData(coinId)
	self._costCellLong:updateData(coinId)
	ViewMgr.instance:preCreate(ViewName.MainlineChapterSelectView)
end

function M:onEnterFinished()
	PlayerAttributeGainTipsController.instance:unfreeze("dungeon")
end

function M:onExit()
	self:_unbindEvents()
	self._resLoader:clear()

	if self._mapView then
		self._mapView:setSelectedDungeon(-1)
	end
end

function M:onExitFinished()
	self:clearMap()
end

function M:clearMap()
	if self._mapViewList then
		for i, mapView in pairs(self._mapViewList) do
			mapView:clear()
		end

		BattleTableUtil.clearTable(self._mapViewList)
	end
end

function M:_initView()
	self._dungeonDetailPanelOpen = false
	self._curMultiCount = 1

	local chapterInfo = DungeonMainLineChapterModel.instance:getDungeonSceneChpaterInfo()

	self._needChapterSelect = chapterInfo.needShowChapterSelect
	self._curChapterId = chapterInfo.chapterId
	self._curDifficultyIndex = chapterInfo.difficulty

	if enableWarnLog then
		printWarn(string.format("当前正在进行的章节:%s难度:%s", self._curChapterId, self._curDifficultyIndex))
	end

	self._chapterMoList = DungeonMainLineChapterModel.instance:getAllUnlockChapterList()
	self._curClickDungeonId = nil

	if self._curChapterId > #self._chapterMoList then
		self._curChapterId = 1
		self._curDifficultyIndex = Difficulty.Easy
		chapterInfo.clickDungeon = false
		chapterInfo.dungeonIndex = 1
	end

	if self._curDifficultyIndex == Difficulty.Normal and not self._chapterMoList[self._curChapterId][Difficulty.Normal]:getIsChapterUnlock() then
		self._curDifficultyIndex = Difficulty.Easy
	end

	self._curChapterMo = self._chapterMoList[self._curChapterId][self._curDifficultyIndex]

	goutil.setActive(self._dungeonPanelCloseBtn.gameObject, false)
	self:_setDungeonPanelRaycastActive(false)
	self:_refreshView()
	table.clear(self._mapViewList)

	self._resPathDic = {}
	self._resPathDic[1] = GameUrl.getNormalChapterUrl(self._curChapterId)

	self._resLoader:addResPath(self._resPathDic[1])

	if self._chapterMoList[self._curChapterId][Difficulty.Normal]:getIsChapterUnlock() then
		self._resPathDic[2] = GameUrl.getHardChapterUrl(self._curChapterId)

		self._resLoader:addResPath(self._resPathDic[2])
	end

	self._resLoader:load(self._onMapNodeLoaded, false, self)
	self._difficultToggleGroup:TryActiveChildOn(self._difficultToggle, self._curDifficultyIndex == Difficulty.Normal)

	local normalMo = self._chapterMoList[self._curChapterId][Difficulty.Easy]
	local hardMo = self._chapterMoList[self._curChapterId][Difficulty.Normal]

	self._txtProgressNormal.text = ""
	self._txtProgressDifficulty.text = ""

	if normalMo then
		self._txtProgressNormal.text = normalMo:getUnlockDungeonCount() .. "/" .. TableUtil.getLen(normalMo:getDungeonIds())
	end

	if hardMo then
		self._txtProgressDifficulty.text = hardMo:getUnlockDungeonCount() .. "/" .. TableUtil.getLen(hardMo:getDungeonIds())
	end

	self._activity:refresh(self._curChapterId)
end

function M:_onMapNodeLoaded()
	self._hasLoadRes = true

	self:_onSwitchDifficulty()

	local chapterInfo = DungeonMainLineChapterModel.instance:getDungeonSceneChpaterInfo()

	if chapterInfo.dungeonIndex and chapterInfo.dungeonIndex > 0 then
		if chapterInfo.clickDungeon then
			local dungeonIds = self._curChapterMo:getDungeonIds()

			if dungeonIds and dungeonIds[chapterInfo.dungeonIndex] then
				local dungeonMo = DungeonMainLineChapterModel.instance:getDungeonMoById(dungeonIds[chapterInfo.dungeonIndex])

				if not dungeonMo:getIsUnlock() then
					chapterInfo.dungeonIndex = 1
				end
			end

			self._curDungeonIndex = chapterInfo.dungeonIndex

			self:_onPickDungeonNode(false, self._curDungeonIndex, true)
		else
			self:_focusPos(chapterInfo.dungeonIndex, true)
		end
	end
end

function M:_onSwitchDifficulty()
	if not self._hasLoadRes then
		return
	end

	for i, mapView in pairs(self._mapViewList) do
		mapView:setVisible(false)
	end

	if self._mapViewList[self._curDifficultyIndex] then
		self._mapView = self._mapViewList[self._curDifficultyIndex]

		self._mapView:setVisible(true)
	else
		local res = self._resLoader:getResource(self._resPathDic[self._curDifficultyIndex])
		local nodeMapGo = goutil.clone(res:GetMainAsset())

		goutil.addChildToParent(nodeMapGo, self._mapPanelGo)

		self._mapView = Astral.LuaComponentContainer.Add(nodeMapGo, MainlineDungeonMap)
		self._mapViewList[self._curDifficultyIndex] = self._mapView
	end

	self:_refreshLevelCell()
end

function M:_refreshView()
	self:_refreshDifficultyPanel()
	self:_refreshRedDot()
	self:_refreshBonusView()
	self:_refreshTitle()
	self:_refreshDungeonDetailPanel()
end

function M:_refreshDifficultyPanel()
	local chapter2MO = self._chapterMoList[self._curChapterId][Difficulty.Normal]
	local lock = not chapter2MO:getIsChapterUnlock()

	goutil.setActive(self._difficultLockGo, lock)

	local colorStr = lock and "#C1C3C333" or "#C1C3C3FF"

	self._difficultToggleTxt.color = parsecolor(colorStr)

	goutil.setActive(self._normalBgGo, self._curDifficultyIndex == Difficulty.Easy)
	goutil.setActive(self._difficultBgGo, self._curDifficultyIndex ~= Difficulty.Easy)
end

function M:_refreshLevelCell()
	if not self._hasLoadRes then
		return
	end

	local dungeonIds = self._curChapterMo:getDungeonIds()
	local maxPosX = self._mapView:_refreshView(dungeonIds)

	self._mapView:setDifficulty(self._curDifficultyIndex)

	self._canScroll = false

	if maxPosX <= 0.5 * self._screenWidth then
		self._canScroll = false
		self._scrollRect.horizontal = false

		RectTransformUtils.SetAnchoredPosition(self._mapPanelGo.transform, 0, 0)
	else
		self._canScroll = true
		self._scrollRect.horizontal = true
	end

	self._maxWidth = maxPosX + self._screenWidth / 2 + 100

	goutil.setWidth(self._mapPanelGo.transform, self._maxWidth)
end

function M:_onPickDungeonNode(_, index, isUnlock)
	local isSelect = isUnlock

	self:_pickDungeon(index, isSelect)
end

function M:_pickDungeon(index, isSelect)
	self._curDungeonIndex = index

	local dungeonIds = self._curChapterMo:getDungeonIds()

	self._curClickDungeonId = dungeonIds[self._curDungeonIndex]

	if isSelect then
		self:_selectDungeon()
	end
end

function M:_selectDungeon()
	self._mapView:setSelectedDungeon(self._curClickDungeonId)
	self:_refreshDungeonDetailPanel()
	self:_openDungeonDetailPanel()
	self:_focusPos(self._curDungeonIndex)
end

function M:_handleStarRewardGot()
	self:_refreshRedDot()
	self:_refreshBonusView()
end

function M:_handleSetPlotAnswerReply(e)
	self:_refreshLevelCell()
	self:_refreshView()

	local dungeonMo = DungeonMainLineChapterModel.instance:getDungeonMoById(self._curClickDungeonId)

	if dungeonMo ~= nil and dungeonMo:getType() == CommEnum.DungeonType.Branchline then
		self:_selectDungeon()
	end
end

function M:_handleMultiFightTipsConfirm(e, tipsInfo)
	local dungeonMo = self._dungeonMo

	if dungeonMo:getId() ~= tipsInfo.dungeonId then
		return
	end

	local dungeonId = tipsInfo.dungeonId
	local multiCount = tipsInfo.multiCount
	local pointCost = dungeonMo:getPointCost()
	local isQuickFight = tipsInfo.quickFight
	local gamePlay = tipsInfo.gamePlay

	BattleCalculateModel.instance:setDefaultItemMoList(pointCost * multiCount)

	local info = {}

	info.dungeonCode = dungeonId
	info.afflatusBuff = false
	info.isShowPlot = false
	info.multiCount = multiCount
	info.dungeonIndex = self._curDungeonIndex
	info.gamePlay = gamePlay

	self:_startFight(info, false)
end

function M:_onClickQuickFight()
	local chapterId = self._curChapterMo:getChapterId()
	local dungeonId = self._dungeonMo:getId()
	local starCount = self._dungeonMo:getStarCount()
	local hasPassed = self._dungeonMo:hasPassed()
	local canQuickFight = SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.MainLineQuickBattle, false)
	local canProxy = self._curChapterMo:canProxy()
	local maxCount = 0

	if self._gamePlay == BattleEnum.GamePlayType.RECORD then
		maxCount = self._curChapterMo:getMultiMaxCount()

		if not SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.DungeonMultipleBattle, false) or not self._curChapterMo:getCanOpenMulti() or not self._dungeonMo:hasPassed() then
			FloatWordMgr.instance:show(lang("tip_pass_open_multiple"))

			return
		end
	elseif self._gamePlay == BattleEnum.GamePlayType.CONSECUTIVE then
		maxCount = self._curChapterMo:getConsecutiveLimit()

		if not SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.DungeonConsecutiveBattle, false) or not hasPassed then
			return
		end

		if maxCount <= 0 then
			return
		end
	else
		return
	end

	local chapterInfo = {}

	chapterInfo.chapterId = self._curChapterId
	chapterInfo.dungeonIndex = self._curDungeonIndex
	chapterInfo.difficulty = self._curDifficultyIndex
	chapterInfo.needShowChapterSelect = self._needChapterSelect

	DungeonMainLineChapterModel.instance:recordDungeonSceneChpaterInfo(chapterInfo)
	ToolTipsMgr.showMultiFightTipsView(dungeonId, maxCount, canQuickFight, canProxy, self._gamePlay)
end

function M:_onClickCloseDungeonDetailPanel()
	self:_closeDungeonDetailPanel()
	self._mapView:setSelectedDungeon(-1)
end

function M:_openDungeonDetailPanel()
	self._dungeonPanelAnim:StopTimelineAni()
	self._dungeonPanelAnim:SetAniTime(0)
	self._dungeonPanelAnim:PlayAniByName(kAnimNamePanelOpen)
	self:_setDungeonPanelRaycastActive(true)
end

function M:_closeDungeonDetailPanel()
	self._dungeonPanelAnim:StopTimelineAni()
	self._dungeonPanelAnim:SetAniTime(0)
	self._dungeonPanelAnim:PlayAniByName(kAnimNamePanelClose)
	goutil.setActive(self._dungeonPanelCloseBtn.gameObject, false)
end

function M:_onDungeonPanelAnimDone(name)
	if name == kAnimNamePanelOpen then
		self._dungeonPanelAnim:StopTimelineAni()
		goutil.setActive(self._dungeonPanelCloseBtn.gameObject, true)
	elseif name == kAnimNamePanelClose then
		self._dungeonPanelAnim:StopTimelineAni()
		self:_setDungeonPanelRaycastActive(false)
	end
end

function M:_setDungeonPanelRaycastActive(active)
	goutil.setActive(self._dungeonDi, active)
	goutil.setActive(self._dungeonContent, active)
	goutil.setActive(self._clickGo, active)
end

function M:_onNormalToggleUpdate(_, isOn)
	self._curDifficultyIndex = isOn and Difficulty.Easy or Difficulty.Normal
	self._curChapterMo = self._chapterMoList[self._curChapterId][self._curDifficultyIndex]

	self:_onSwitchDifficulty()
	self:_refreshView()
end

function M:_refreshDungeonDetailPanel()
	if not self._curClickDungeonId then
		goutil.setActive(self._goBossSign, false)

		return
	end

	self._dungeonMo = DungeonMainLineChapterModel.instance:getDungeonMoById(self._curClickDungeonId)

	local fontSize = 18

	if self._dungeonMo:getIsPlotNode() then
		fontSize = 20

		goutil.setActive(self._goPlotPicture, true)
		goutil.setActive(self._dungeonScoreRateGo, false)
		goutil.setActive(self._goConditionInfo, false)
		goutil.setActive(self._goEnemyInfo, false)
		goutil.setActive(self._goCostLong, false)
		goutil.setActive(self._goBossSign, false)
		goutil.setActive(self._txtInfo.gameObject, false)
		goutil.setActive(self._imgInfo.gameObject, false)
		goutil.setActive(self._txtPlotDesc.gameObject, true)

		local dungeonCo = DungeonConfig.instance:getMainlinePlotDungeonCOByDungeonId(self._curClickDungeonId)

		IconLoader.setSprite(self._imgPlotPicture, IconType.Mainline, dungeonCo.imgbigName)

		self._txtPlotDesc.text = dungeonCo.desc

		self:_refreshRewardPanel()
	else
		goutil.setActive(self._goPlotPicture, false)
		goutil.setActive(self._dungeonScoreRateGo, true)
		goutil.setActive(self._goConditionInfo, true)
		goutil.setActive(self._goEnemyInfo, true)
		goutil.setActive(self._goRewardInfo, true)
		goutil.setActive(self._goCostLong, true)
		goutil.setActive(self._txtInfo.gameObject, true)
		goutil.setActive(self._imgInfo.gameObject, true)
		goutil.setActive(self._txtPlotDesc.gameObject, false)
		goutil.setActive(self._goBossSign, DungeonMainLineChapterModel.instance:isBossDungeon(self._dungeonMo:getId()))

		local scoreRate = DungeonModel.instance:getDungeonScoreRate(self._curClickDungeonId, DungeonExtension_pb.BattleTeamType.TEAM_MAINLINE) * 1000
		local scoreCO = DungeonConfig.instance:getDungeonScoreCOByScore(scoreRate, self._dungeonMo:getScoreGroup())

		DifficultyUtil.setDifficultyFlag(self._dungeonScoreRateGo, scoreCO)
		self._costCellShot:setCostCount(self._dungeonMo:getPointCost())
		self._costCellLong:setCostCount(self._dungeonMo:getPointCost())
		self:_refreshRewardPanel()
		self:_refreshEnemyPanel()
		self:_refreshStarPanel()
		self:_refreshMultipleDrop()
	end

	local prefixStr = self._curDifficultyIndex == Difficulty.Easy and lang("tip_mainline_normal") or lang("tip_mainline_hard")
	local indexStr = string.format("%s %s", prefixStr, self._dungeonMo:getIndex())

	self._dungeonIndexTxt.text = indexStr
	self._dungeonNameTxt.text = self._dungeonMo:getName()
	self._textFight.text = lang("multi_fight_title")

	local desc = self._dungeonMo:getDesc()

	self:_refreshBottomPanel()
end

function M:_refreshMultipleDrop()
	local type = self._dungeonMo:getType()
	local isShow = false
	local redPointMultiple = RedDotModel.instance:getRedDotDetailList(GameEnum.RedPointEnum.DungeonRewardUp) or {}

	for k, v in ipairs(redPointMultiple) do
		if tonumber(v) == type then
			isShow = true
		end
	end

	if isShow then
		local tabelT = MultipleDropController.instance:getLeftNumberByType(type)

		if tabelT.times == "" then
			isShow = false
		else
			self._txtNumberMultiple.text = tabelT.left
			self._txtTimesMultiple.text = tabelT.times
		end
	end

	goutil.setActive(self._doubleHintGo.gameObject, isShow)
end

function M:_refreshRedDot()
	local isActive = self._curChapterMo:hasRedDot()
	local redDotGO = goutil.findChild(self._starBonusBtn.gameObject, "red_point")

	goutil.setActive(redDotGO, false)
	goutil.setActive(self._canReciveEffNormal, self._curDifficultyIndex == Difficulty.Easy and isActive)
	goutil.setActive(self._canReciveEffHard, self._curDifficultyIndex == Difficulty.Normal and isActive)

	local hardChapterMo = self._chapterMoList[self._curChapterId][Difficulty.Normal]
	local hasHardBonusRedDot = hardChapterMo and hardChapterMo:hasRedDot() or false

	goutil.setActive(self._goHardBonusRedDot, hasHardBonusRedDot)
end

function M:_refreshBonusView()
	local starCount = self._curChapterMo:getStarCount()
	local totalStarCount = self._curChapterMo:getTotalStarCount()
	local fillAmount = starCount / totalStarCount

	if self._curDifficultyIndex == Difficulty.Easy then
		goutil.setActive(self._normalStarReward.mainGO, true)
		goutil.setActive(self._hardStarReward.mainGO, false)
		self._normalStarReward:setChapterMO(self._curChapterMo)
	else
		goutil.setActive(self._normalStarReward.mainGO, false)
		goutil.setActive(self._hardStarReward.mainGO, true)
		self._hardStarReward:setChapterMO(self._curChapterMo)
	end

	if totalStarCount < starCount then
		starCount = totalStarCount
	end

	self._starTxt.text = string.format("%d/%d", starCount, totalStarCount)
end

function M:_refreshTitle()
	local chapterCO = self._curChapterMo:getChapterCO()

	self._txtNum.text = chapterCO.chapterHint

	self._imgTitle:SetSprite(chapterCO.titleInChapter)

	local partImgName = MainLinePartImg[chapterCO.chapterId]

	goutil.setActive(self._imgPart.gameObject, partImgName)

	if partImgName then
		IconLoader.setSprite(self._imgPart, IconType.DynSpriteAtlas_Dungeon, partImgName)
	end
end

function M:_refreshEnemyPanel()
	goutil.clearChildren(self._bossListGo)

	local hasEnterDungeon = DungeonModel.instance:getIfDungeonEntered(self._dungeonMo:getId())

	if self._dungeonMo:hasPassed() then
		hasEnterDungeon = true
	end

	local monsterConf = BattleConfig.instance:getBattleLevelCO(self._dungeonMo:getDungeonBattleCode())

	if not monsterConf then
		return
	end

	local showMonsters = {}

	for _, group in pairs(monsterConf.monsterGroupList) do
		if group.refreshType ~= 4 then
			for _, monster in pairs(group.monsterList) do
				local monsterCO = monsterConf.monsters[monster.monsterId]

				if (monsterCO.battleCamp == BattleEnum.MonsterCampType.NORMAL or monsterCO.battleCamp == BattleEnum.MonsterCampType.FRIEND) and not TableUtil.contains(showMonsters, monsterCO) then
					table.insert(showMonsters, monsterCO)
				end
			end
		end
	end

	table.sort(showMonsters, MainlineDungeonUtil.sortMonster)

	for i, v in ipairs(showMonsters) do
		local obj = goutil.clone(self._heroTemplate)

		obj:SetActive(true)

		local objBeh = Astral.LuaComponentContainer.Add(obj, MainlineMonsterHeadCell)

		goutil.addChildToParent(obj, self._bossListGo)
		objBeh:setShowMonsterStatus(hasEnterDungeon)
		objBeh:setMonsterCode(v)
	end
end

function M:_formatFirstReward(rewardList)
	local lst = {}

	for i, v in ipairs(rewardList or {}) do
		if v.code ~= GameEnum.CurrencyCodeEnum.EXP then
			local itemData = ItemUtil.createItemData({
				itemId = v.code
			})

			itemData:setCount(v.num)
			table.insert(lst, itemData)
		end
	end

	return lst
end

function M:_refreshRewardPanel()
	goutil.clearChildren(self._rewardListGo)

	self._rewardScroll.horizontalNormalizedPosition = 0

	if self:_refreshPlotReward() then
		return
	end

	local count = 0

	if not self._dungeonMo:hasPassed() then
		local rewardCode = self._dungeonMo:getFristPassReward()
		local rewardCO = {}

		if rewardCode > 0 then
			rewardCO = RewardConfig.instance:getRewardCfgByCode(rewardCode) or {}
		end

		local firstReward = self:_formatFirstReward(rewardCO.reward)

		table.sort(firstReward, ItemUtil.commonSortFunc)

		for i, reward in ipairs(firstReward) do
			local obj = self:getResInstance(ResName.Common_Backpack_Item)

			obj:SetActive(true)
			goutil.addChildToParent(obj, self._rewardListGo)

			local objBeh = Astral.LuaComponentContainer.Add(obj, RewardCell)
			local rewardData = RewardData.New({
				code = reward:getItemId(),
				count = reward:getCount(),
				rewardStatus = self._dungeonMo:hasPassed() and CommEnum.RewardEnum.HasGot or CommEnum.RewardEnum.CanNotGot,
				itemSign = CommEnum.BackPackItemSignTyp.First,
				clickCallBack = self._onClickMoreReward,
				clickCallBackObj = self
			})

			objBeh:updateData(rewardData)

			count = count + 1
		end
	end

	local fixReward = DungeonUtil.getRewardLstNormal(self._dungeonMo)

	if #fixReward > 0 then
		table.sort(fixReward, ItemUtil.commonSortFunc)
	end

	for i, itemData in ipairs(fixReward) do
		local obj = self:getResInstance(ResName.Common_Backpack_Item)

		obj:SetActive(true)
		goutil.addChildToParent(obj, self._rewardListGo)

		local objBeh = Astral.LuaComponentContainer.Add(obj, RewardCell)
		local rewardData = RewardData.New({
			code = itemData:getPrefabId() or itemData:getItemId(),
			rewardStatus = CommEnum.RewardEnum.CanNotGot,
			itemSign = itemData.itemSign,
			clickCallBack = self._onClickMoreReward,
			clickCallBackObj = self
		})

		objBeh:updateData(rewardData)

		count = count + 1
	end

	local randomReward = DungeonUtil.getRewardLstRandom(self._dungeonMo)

	if #randomReward > 0 then
		table.sort(fixReward, ItemUtil.commonSortFunc)
	end

	for i, itemData in ipairs(randomReward) do
		local obj = self:getResInstance(ResName.Common_Backpack_Item)

		obj:SetActive(true)
		goutil.addChildToParent(obj, self._rewardListGo)

		local objBeh = Astral.LuaComponentContainer.Add(obj, RewardCell)
		local rewardData = RewardData.New({
			code = itemData:getPrefabId() or itemData:getItemId(),
			rewardStatus = CommEnum.RewardEnum.CanNotGot,
			itemSign = CommEnum.BackPackItemSignTyp.Probability,
			clickCallBack = self._onClickMoreReward,
			clickCallBackObj = self
		})

		objBeh:updateData(rewardData)

		count = count + 1
	end

	if self._dungeonMo:hasPassed() and count == 0 then
		local _tmpTable = {}

		for i, reward in ipairs(self._dungeonMo:getAllFirstPassReward()) do
			table.insert(_tmpTable, ItemUtil.createItemData({
				itemId = reward.code,
				count = reward.num
			}))

			count = count + 1
		end

		if #_tmpTable > 0 then
			table.sort(_tmpTable, ItemUtil.commonSortFunc)

			for _, _itemData in ipairs(_tmpTable) do
				local obj = self:getResInstance(ResName.Common_Backpack_Item)

				obj:SetActive(true)
				goutil.addChildToParent(obj, self._rewardListGo)

				local objBeh = Astral.LuaComponentContainer.Add(obj, RewardCell)
				local rewardData = RewardData.New({
					code = _itemData:getItemId(),
					count = _itemData:getCount(),
					rewardStatus = self._dungeonMo:hasPassed() and CommEnum.RewardEnum.HasGot or CommEnum.RewardEnum.CanNotGot,
					itemSign = CommEnum.BackPackItemSignTyp.Get,
					clickCallBack = self._onClickMoreReward,
					clickCallBackObj = self
				})

				objBeh:updateData(rewardData)
			end
		end
	end
end

function M:_refreshPlotReward()
	if self._dungeonMo:getIsPlotNode() then
		self:_createFirstPassReward()

		return true
	end

	return false
end

function M:_createFirstPassReward()
	local rewardCode = self._dungeonMo:getFristPassReward()
	local rewardCO = rewardCode > 0 and RewardConfig.instance:getRewardCfgByCode(rewardCode) or {}
	local firstReward = self:_formatFirstReward(rewardCO.reward)

	table.sort(firstReward, ItemUtil.commonSortFunc)

	for _, reward in ipairs(firstReward) do
		local obj = self:getResInstance(ResName.Common_Backpack_Item)

		obj:SetActive(true)
		goutil.addChildToParent(obj, self._rewardListGo)

		local objBeh = Astral.LuaComponentContainer.Add(obj, RewardCell)
		local rewardData = RewardData.New({
			code = reward:getItemId(),
			count = reward:getCount(),
			rewardStatus = self._dungeonMo:hasPassed() and CommEnum.RewardEnum.HasGot or CommEnum.RewardEnum.CanNotGot,
			itemSign = self._dungeonMo:hasPassed() and CommEnum.BackPackItemSignTyp.Get or CommEnum.BackPackItemSignTyp.First,
			clickCallBack = self._onClickMoreReward,
			clickCallBackObj = self
		})

		objBeh:updateData(rewardData)
	end

	goutil.setActive(self._goRewardInfo, #firstReward > 0)
	goutil.setActive(self._doubleHintGo, false)

	return true
end

function M:_refreshStarPanel()
	local star = self._dungeonMo:getStar()
	local starRequire = self._dungeonMo:getStarRequire()

	for i = 1, 3 do
		goutil.setActive(self._starFinishSignGoList[i], star[i])

		self._starDescTxtList[i].color = star[i] and Astral.ColorUtil.ParseColor("#E8E7E7") or Astral.ColorUtil.ParseColor("#858585")
	end

	for i = 1, 3 do
		local dungeonStarCOWrapper = DungeonConfig.instance:getDungeonStarCOWrapper(starRequire[i])

		self._starDescTxtList[i].text = dungeonStarCOWrapper:getDescription()
	end
end

function M:_refreshBottomPanel()
	local isTeachDungeon = DungeonMainLineChapterModel.instance:isTeachDungeon(self._dungeonMo:getId())
	local showBtn = true

	if self._gamePlay == BattleEnum.GamePlayType.RECORD then
		if not SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.DungeonMultipleBattle, false) or isTeachDungeon or self._dungeonMo:getIsPlotNode() or not self._curChapterMo:getCanOpenMulti() or not self._dungeonMo:hasPassed() then
			showBtn = false
		end
	elseif self._gamePlay == BattleEnum.GamePlayType.CONSECUTIVE then
		local maxCount = self._curChapterMo:getConsecutiveLimit()

		showBtn = self._dungeonMo:hasPassed() and not isTeachDungeon and maxCount and maxCount > 0 and SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.DungeonConsecutiveBattle, false)
	end

	goutil.setActive(self._quickFightBtn.gameObject, showBtn)

	local before = self._dungeonMo:getPlotBeforeBattle()
	local after = self._dungeonMo:getPlotAfterBattle()
	local hasPlot = before and before ~= 0 and not self._dungeonMo:getIsPlotNode() or after and after ~= 0
	local showPlot = true

	showPlot = self._dungeonMo:hasPassed() and hasPlot

	goutil.setActive(self._btnPlot.gameObject, showPlot)

	self._txtInfo.text = self._dungeonMo:getTips()

	goutil.setActive(self._btnInfo.gameObject, self._txtInfo.text ~= "")

	if self._dungeonMo:getIsPlotNode() then
		self:_setLongBtnStatus(false)

		return
	elseif not self._dungeonMo:hasPassed() then
		self:_setLongBtnStatus(true)

		return
	end

	goutil.setActive(self._bottomInfo, true)
	goutil.setActive(self._bottomInfoLong, false)
end

function M:_setLongBtnStatus(hasShowCost)
	goutil.setActive(self._bottomInfo, false)
	goutil.setActive(self._bottomInfoLong, true)
	goutil.setActive(self._goCostLong, hasShowCost)
	goutil.setActive(self._fightBtnLong.gameObject, true)
end

function M:_focusPos(index, isSet)
	if not self._canScroll then
		return
	end

	local posX = self._mapView:getNodeAnchoredPosX(index)

	if posX then
		local targetX = -posX + 0.25 * self._screenWidth

		targetX = self:_formatPosX(targetX)

		if isSet then
			RectTransformUtils.SetAnchoredPosition(self._mapPanelGo.transform, targetX, self._mapPanelGo.transform.anchoredPosition.y)
		else
			self._mapPanelGo.transform:DOKill(false)
			self._mapPanelGo.transform:DOAnchorPosX(targetX, 0.5)
		end
	end
end

function M:_formatPosX(x)
	if x < self._screenWidth - self._maxWidth then
		return self._screenWidth - self._maxWidth
	end

	if x > 0 then
		return 0
	end

	return x
end

function M:_onClickHome()
	GlobalDispatcher:dispatchEvent(EventType.JUMP_VIEW_TO_MAIN)
end

function M:_onClickReturn()
	if self._needChapterSelect then
		-- block empty
	end

	self:back()
	ViewMgr.instance:close(ViewName.DungeonEntranceView, false, WindowType.WindowCloseReasonType.QuickCloseType, true)
end

function M:_onClickStarBonusBtn()
	ViewMgr.instance:open(ViewName.DungeonStarRewardView, self._curChapterMo)
end

function M:_onClickMoreReward()
	self._canCloseDungeon = false

	CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_generic_click, nil, nil, nil)
	ViewMgr.instance:open(ViewName.DungeonRewardDetailView, self._curClickDungeonId)

	return false
end

function M:_onClickDifficultLock()
	local chapterMo = self._chapterMoList[self._curChapterId][Difficulty.Normal]

	FloatWordMgr.instance:show(chapterMo:getChapterLockString())
end

function M:_onClickBtnEnemy()
	return
end

function M:_checkIsCanAddBackPack()
	local rewards = self._dungeonMo:getNormalReward() or {}

	for i = 1, #rewards do
		local isCanAdd, tips = MainBackpackModel.instance:isCanAddToBackPackById(rewards[i])

		if not isCanAdd then
			FloatWordMgr.instance:show(tips)

			return false
		end
	end

	return true
end

function M:_onClickStartFight()
	if not self._dungeonMo:getIsPlotNode() then
		if self._curMultiCount * self._dungeonMo:getPointCost() > ItemModel.instance:getItemCountByItemId(GameEnum.CurrencyCodeEnum.TlCode) then
			ToolTipsMgr.showHealthExchangeTips()

			return
		end

		BattleCalculateModel.instance:setDefaultItemMoList(self._dungeonMo:getPointCost())
	end

	if not self:_checkIsCanAddBackPack() then
		return
	end

	local chapterInfo = {}
	local chapterMo = self._chapterMoList[self._curChapterId][self._curDifficultyIndex]

	chapterInfo.chapterId = self._curChapterId
	chapterInfo.dungeonIndex = self._curDungeonIndex
	chapterInfo.difficulty = self._curDifficultyIndex
	chapterInfo.needShowChapterSelect = self._needChapterSelect

	DungeonMainLineChapterModel.instance:recordDungeonSceneChpaterInfo(chapterInfo)

	local info = {}

	info.dungeonCode = self._dungeonMo:getId()
	info.afflatusBuff = false
	info.isShowPlot = true
	info.multiCount = self._curMultiCount
	info.dungeonIndex = self._curDungeonIndex
	info.gamePlay = BattleEnum.GamePlayType.NORMAL

	self:_startFight(info)
end

function M:_startFight(info, checkDanger)
	if checkDanger == nil then
		checkDanger = true
	end

	if not checkDanger then
		self:_goFight(false, info)

		return
	end

	if not self._dungeonMo:getIsPlotNode() then
		local scoreRate = DungeonModel.instance:getDungeonScoreRate(self._curClickDungeonId) * 1000
		local scoreCO = DungeonConfig.instance:getDungeonScoreCOByScore(scoreRate, self._dungeonMo:getScoreGroup())

		if not DungeonController.instance:tryOpenDangerTips(scoreCO, info) then
			self:_goFight(false, info)
		end
	else
		self:_goFight(false, info)
	end
end

function M:_goFight(_, info)
	Astral.LocalStorage.Instance:SetString("dungeon_latest_type", string.format("1,%d,%s", self._dungeonMo:getId(), self._dungeonMo:getIndex()))
	Astral.LocalStorage.Instance:SetString("dungeon_latest_info", string.format("%d,%d,%d", self._curChapterId, self._curDungeonIndex, self._curDifficultyIndex))
	Astral.LocalStorage.Instance:SetString("dungeon_latest_id", PlayerModel.instance:getId())
	Astral.LocalStorage.Instance:SetString("mainline_record", string.format("%d,%d,%d", self._curChapterId, self._curDungeonIndex, self._curDifficultyIndex))
	DungeonController.instance:startDungeonBattle(info)
	PlayerAttributeGainTipsController.instance:freeze("dungeon")
end

function M:_checkAnyTouch()
	if GuideController.instance:isGuiding() then
		return
	end

	self._longTimeTipsInfo = ConstConfig.instance:getNumValuesByKey("ShowBattleGuideTips")

	local hasPass = DungeonMainLineChapterModel.instance:hasDungeonPassed(self._longTimeTipsInfo[1])

	if not hasPass then
		self._mapIndex = DungeonMainLineChapterModel.instance:getChapter1FirstUnlockDungeonIndex()

		self:_showLongTimeTips()
	end
end

function M:_showLongTimeTips()
	local node = self._mapView:getNodeInfoByIndex(self._mapIndex)

	if node then
		node:setGuideTips(true)
	end
end

function M:_hideLongTimeTips()
	local node = self._mapView:getNodeInfoByIndex(self._mapIndex)

	if node then
		node:setGuideTips(false)
	end
end

function M:_onOpenSkillSmallTips()
	local param = {}

	param.obj = self._btnSkillUp.transform.parent.gameObject
	param.skillType = CommEnum.CharacterSkillType.Type3

	ViewMgr.instance:open(ViewName.AchievementSkillSmallTips, param)
end

function M:_onClickPlot()
	local chapterInfo = {}
	local chapterMo = self._chapterMoList[self._curChapterId][self._curDifficultyIndex]

	chapterInfo.chapterId = self._curChapterId
	chapterInfo.dungeonIndex = self._curDungeonIndex
	chapterInfo.difficulty = self._curDifficultyIndex
	chapterInfo.clickDungeon = true
	chapterInfo.needShowChapterSelect = self._needChapterSelect

	DungeonMainLineChapterModel.instance:recordDungeonSceneChpaterInfo(chapterInfo)

	local before = self._dungeonMo:getPlotBeforeBattle()
	local after = self._dungeonMo:getPlotAfterBattle()

	if before and before ~= 0 then
		StoryMgr.instance:startSingle(before)
	end

	if after and after ~= 0 then
		StoryMgr.instance:startSingle(after)
	end
end

function M:_onClickTipsInfo()
	local curActive = self._txtInfo.gameObject.activeSelf

	goutil.setActive(self._txtInfo.gameObject, not curActive)
	goutil.setActive(self._imgInfo.gameObject, not curActive)
end

return M
