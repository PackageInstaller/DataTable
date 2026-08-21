-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/retrieve/view/RetrieveMainViewView.lua

module("logic.extensions.retrieve.view.RetrieveMainViewView", package.seeall)

local M = class("RetrieveMainViewView", ViewComponent)
local RetrieveViewType = {
	Pray = 3,
	PraySelect = 2,
	Main = 1
}
local qualityMaps = {
	[GameEnum.QualityEnum.S] = "js_quality_s",
	[GameEnum.QualityEnum.A] = "js_quality_a",
	[GameEnum.QualityEnum.B] = "js_quality_b",
	[GameEnum.QualityEnum.C] = "js_quality_c"
}

function M:buildUI()
	self._btnReturn = self:getBtn("11&title_view_-878360263")
	self._btnHome = self:getBtn("11&title_view_1398742689")
	self._panelMainGo = self:getGo("retrieve_main_view_587430720")
	self._panelMainTimeline = self._panelMainGo:GetComponent(typeof(Astral.GUITimelineAniLua))
	self._panelMainAnimComp = self._panelMainGo:GetComponent(ComponentType.Animation)
	self._animEventListener = Astral.AnimationEventListener.Get(self._panelMainGo)
	self._imgBanner = self:getImage("retrieve_main_view_1120511116")
	self._imgBanner2 = self:getImage("retrieve_main_view_1889817267")
	self._imgBanner3 = self:getImage("retrieve_main_view_-1489172607")

	local titleGo = self:getGo("retrieve_main_view_-975678998")

	self._imgTitle = UIComponentType.BigBGLocalizationLua(titleGo)
	self._imgQuality = self:getImage("retrieve_main_view_1824308664")
	self._objInfo = self:getGo("retrieve_main_view_779697705")
	self._btnTips = self:getBtn("retrieve_main_view_-1491388396")
	self._imgColorType = self:getImage("14&career_-1600786498")
	self._imgCarrer = self:getImage("14&career_1390243743")
	self._txtTitle = self:getText("retrieve_main_view_-2090232860")
	self._txtTime = self:getText("retrieve_main_view_1971118550")
	self._btnExplain = self:getBtn("retrieve_main_view_-934709956")
	self._txtRightTips = self:getText("retrieve_main_view_-1028183719")
	self._btnLeftWish = self:getBtn("retrieve_main_view_-864240186")
	self._txtWishProcess = self:getText("retrieve_main_view_-1567472257")
	self._txtGuaranteed = self:getText("retrieve_main_view_-1806405079")
	self._leftCardScrollGo = self:getGo("retrieve_main_view_2025077915")
	self._scrollRect = self._leftCardScrollGo:GetComponent(UIComponentType.ScrollRect)
	self._loopList = LoopListHelper.New(self._leftCardScrollGo)

	self._loopList:InitListView(0, self._updateCardCell, self)

	self._btnRecord = self:getBtn("retrieve_main_view_-1880154212")
	self._btnExchange = self:getBtn("retrieve_main_view_86994063")
	self._btnRetrieveOne = self:getBtn("retrieve_main_view_-1019490326")
	self._btnRetrieveTen = self:getBtn("retrieve_main_view_-958688057")
	self._txtCostOne = goutil.findChildTextComponent(self._btnRetrieveOne.gameObject, "txtNum")
	self._txtCostTen = goutil.findChildTextComponent(self._btnRetrieveTen.gameObject, "txtNum")
	self._imgCostOne = goutil.findChildImageComponent(self._btnRetrieveOne.gameObject, "imgIcon")
	self._imgCostTen = goutil.findChildImageComponent(self._btnRetrieveTen.gameObject, "imgIcon")
	self._txtNextGuaranteeA = goutil.findChildTextComponent(self._btnRetrieveTen.gameObject, "txtTips")
	self._btnPray = self:getBtn("retrieve_main_view_1106239968")
	self._btnEcho = self:getBtn("retrieve_main_view_-1717918224")
	self._txtNextGuaranteeA2 = goutil.findChildTextComponent(self._btnPray.gameObject, "txtTips")
	self._panelPrayGo = self:getGo("retrieve_main_view_-1260022511")
	self._panelPrayTimeline = self._panelPrayGo:GetComponent(typeof(Astral.GUITimelineAniLua))
	self._currencyGo = self:getGo("10&top_currency_1050779625")
	self._titleViewGo = self:getGo("11&title_view_-478490097")
	self._itemCellGo = self:getGo("0&rewards_detail_item_2141037416")
	self._itemCell = Astral.LuaComponentContainer.Add(self._itemCellGo, ItemCell)

	self._itemCell:Awake()
	self._itemCell:setShowSelectedEffect(false)
end

function M:destroyUI()
	self._btnReturn = nil
end

function M:bindEvents()
	self._btnReturn:AddClickListener(self._onClickReturn, self)
	self._btnHome:AddClickListener(self._onClickHome, self)
	self._btnExchange:AddClickListener(self._onClickExchange, self)
	self._btnRecord:AddClickListener(self._onClickRecord, self)
	self._btnExplain:AddClickListener(self._onClickExplain, self)
	self._btnLeftWish:AddClickListener(self._onClickLeftWish, self)
	self._btnPray:AddClickListener(self._onClickWish, self)
	self._btnEcho:AddClickListener(self._onClickEcho, self)
	self._btnRetrieveOne:AddClickListener(self._onClickRetrieveOne, self)
	self._btnRetrieveTen:AddClickListener(self._onClickRetrieveTen, self)
	self._btnTips:AddClickListener(self._onClickTips, self)
	GlobalDispatcher:addEventListener(EventType.MAIN_SCENE_HERO_CLICK, self._handleHeroClick, self)
	GlobalDispatcher:addEventListener(EventType.MAIN_SCENE_HERO_ANIM_PLAY_FINISHED, self._handleHeroAnimPlay, self)
	RetrieveDispatcher:addEventListener(RetrieveEventType.LOTTERY_PICK_ITEM, self._onHandlePickItem, self)
	RetrieveDispatcher:addEventListener(RetrieveEventType.DATA_REFRESH, self.refreshLotteryView, self)
	self._panelMainTimeline:AddListener(self._dealMainTimelineListener, self)
	self._panelPrayTimeline:AddListener(self._dealPrayTimelineListener, self)
	self._animEventListener:AddListener(self._onAnimEvent, self)
end

function M:_dealMainTimelineListener(tagName)
	if tagName == "open" then
		if not self._isPlayMainClose then
			goutil.setActive(self._panelMainGo, true)
		end

		self._isPlayMainOpen = false
	elseif tagName == "close" then
		if not self._isPlayPrayOpen then
			goutil.setActive(self._panelMainGo, false)
		end

		self._isPlayMainClose = false
	end
end

function M:_dealPrayTimelineListener(tagName)
	if tagName == "open" then
		if not self._isPlayPrayClose then
			goutil.setActive(self._panelPrayGo, true)
		end

		self._isPlayPrayOpen = false
	elseif tagName == "close" then
		if not self._isPlayPrayOpen then
			goutil.setActive(self._panelPrayGo, false)
		end

		self._isPlayPrayClose = false
	end
end

function M:_onAnimEvent(animEvent)
	if animEvent then
		local curIndex = animEvent.intParameter

		if curIndex == 1 then
			IconLoader.setSprite(self._imgBanner, IconType.RetrieveBanner, self._bannerName1)
		elseif curIndex == 2 then
			IconLoader.setSprite(self._imgBanner2, IconType.RetrieveBanner, self._bannerName2)
			IconLoader.setSprite(self._imgBanner3, IconType.RetrieveBanner, self._bannerName2)
			self._imgTitle:SetImage(self._imgTitleName, nil, self)
		end
	end
end

function M:unbindEvents()
	self._animEventListener:RemoveListener()
	self._panelMainTimeline:RemoveListener()
	self._panelPrayTimeline:RemoveListener()
	self._btnTips:RemoveClickListener()
	self._btnReturn:RemoveClickListener()
	self._btnHome:RemoveClickListener()
	self._btnExchange:RemoveClickListener()
	self._btnRecord:RemoveClickListener()
	self._btnExplain:RemoveClickListener()
	self._btnLeftWish:RemoveClickListener()
	self._btnPray:RemoveClickListener()
	self._btnRetrieveOne:RemoveClickListener()
	self._btnRetrieveTen:RemoveClickListener()
	self._btnEcho:RemoveClickListener()
	GlobalDispatcher:removeEventListener(EventType.MAIN_SCENE_HERO_CLICK, self._handleHeroClick, self)
	GlobalDispatcher:removeEventListener(EventType.MAIN_SCENE_HERO_ANIM_PLAY_FINISHED, self._handleHeroAnimPlay, self)
	RetrieveDispatcher:removeEventListener(RetrieveEventType.LOTTERY_PICK_ITEM, self._onHandlePickItem, self)
	RetrieveDispatcher:removeEventListener(RetrieveEventType.DATA_REFRESH, self.refreshLotteryView, self)
end

function M:_panelMainPlayAnim(isOpen)
	self._panelMainTimeline:StopTimelineAni()
	goutil.setActive(self._panelMainGo, true)

	if isOpen then
		self._panelMainTimeline:PlayAniByName("open")

		self._isPlayMainOpen = true
		self._isPlayMainClose = false
	else
		self._panelMainTimeline:PlayAniByName("close")

		self._isPlayMainClose = true
		self._isPlayMainOpen = false
	end
end

function M:_panelPrayPlayAnim(isOpen)
	self._panelPrayTimeline:StopTimelineAni()
	goutil.setActive(self._panelPrayGo, true)

	if isOpen then
		self._panelPrayTimeline:PlayAniByName("open")

		self._isPlayPrayOpen = true
		self._isPlayPrayClose = false
	else
		self._panelPrayTimeline:PlayAniByName("close")

		self._isPlayPrayOpen = true
		self._isPlayPrayClose = false
	end
end

function M:onEnter()
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_RetrieveMainView)
	CriwareAudioFacade.instance:playBgmInnerById(CriwareAudioEnum.music_main_zhaomu_01)
	RetrieveFacade.instance:registerView(self)

	self._curViewType = RetrieveViewType.Main

	self:switchViewByViewType()
	goutil.setActive(self._panelPrayGo, false)
	self:_panelMainPlayAnim(true)

	self._showerList = {}

	self:_initData()

	local tempLotteryId = false
	local openParam = self:getOpenParam()
	local jumpInfo = RetrieveModel.instance:getJumpInfo()
	local needShowEnter = true

	if jumpInfo then
		tempLotteryId = jumpInfo.lotteryId
		needShowEnter = jumpInfo.needShowEnter
	elseif openParam and openParam[1] then
		tempLotteryId = openParam[1].lotteryId
	end

	if not tempLotteryId then
		if self._lotteryDataList and #self._lotteryDataList > 0 then
			tempLotteryId = self._lotteryDataList[1]:getLotteryId()
		else
			printWarn("当前卡池列表为空")
		end
	end

	if not tempLotteryId then
		printError("无法加载卡池数据")

		return
	end

	RetrieveModel.instance:cacheChoosePool(tempLotteryId)
	self:_refreshLotteryInfo(tempLotteryId, needShowEnter)
	self:_initLotteryList()
end

function M:refreshLotteryView()
	self:_initLotteryList()
end

function M:onEnterFinished()
	return
end

function M:onExit()
	if self._delayTween then
		self._delayTween:Kill(false)
	end

	self._delayTween = nil

	RetrieveFacade.instance:unregisterView()

	self._clickLotteryOne = false

	RetrieveController.instance:clearClickState()
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_RetrieveMainView)
end

function M:_initData()
	self._lotteryDataList = ActivityController.instance:getActivitiesByLogicType(ActivityEnum.LogicType.LOTTERY)

	table.sort(self._lotteryDataList, LotteryUtil.sortlotteryPool)
end

function M:_initLotteryList()
	self._loopList:SetListItemCount(#self._lotteryDataList, true)

	if self._delayTween then
		self._delayTween:Kill(false)
	end

	local index = 1

	for i = 1, #self._lotteryDataList do
		if self._lotteryId == self._lotteryDataList[i]:getLotteryId() then
			index = i

			break
		end
	end

	self._delayTween = DoTweenUtil.DelayedCall(0, function()
		self._loopList:MoveToItemIndex(index - 1)
	end)

	if GuideController.instance:isGuiding() then
		self._scrollRect.enabled = false
	end
end

function M:_bindTopCurrencyInfo()
	if self._lotteryData then
		local showType = CommEnum.MoneyShowType.LotteryHeroShowType

		self:localNotify(EventType.UPDAET_TOP_MONEY_VIEW_SHOW, showType)
	end
end

function M:_refreshCostView()
	local singleCost = self._lotteryData:getLotteryCost(RetrieveEnum.LotteryNum.One)
	local itemCo = BackpackConfig.instance:getItemInfoByItemId(singleCost.item)
	local iconName = tostring(itemCo.icon) .. "0"

	self._txtCostOne.text = singleCost.num

	IconLoader.setSprite(self._imgCostOne, IconType.Skinlib, iconName)
	IconLoader.setSprite(self._imgCostTen, IconType.Skinlib, iconName)

	local tenCost = self._lotteryData:getLotteryCost(RetrieveEnum.LotteryNum.Ten)

	self._txtCostTen.text = tenCost.num
	self._txtNextGuaranteeA.text = langF("lottery_pr_normal", self._lotteryData:nextGuaranteeA(), self._lotteryData:getNextGuaranteeS())
	self._txtNextGuaranteeA2.text = self._txtNextGuaranteeA.text
end

function M:_delayBackScene()
	removetimer(self._delayBackScene, self)
	SceneFace.instance:backScene()
end

function M:_onClickReturn()
	print("Retrieve viewType:", self._curViewType)

	if self._curViewType == RetrieveViewType.Main then
		RetrieveModel.instance:clearJumpInfo()
		self:close()
		ViewMgr.instance:clearSomeViewFromBackStack(ViewName.RetrieveMainViewViewPresentor)
		LoadingFacade.instance:showLoading(true)
		removetimer(self._delayBackScene, self)
		settimer(0.55, self._delayBackScene, self, false)
	else
		ViewMgr.instance:close(ViewName.ToolTipsCharacterSkillDetailViewPresentor)
		ViewMgr.instance:close(ViewName.ToolTipsSkillBuffTagTipsViewPresentor)

		local lastViewType = self._curViewType

		self._curViewType = RetrieveViewType.Main

		RetrieveController.instance:activeWishCamera(0)
		self:switchViewByViewType()
		RetrieveController.instance:setAllHeroState(true)

		if lastViewType == RetrieveViewType.Pray then
			self:_panelPrayPlayAnim(false)
		end

		self:_panelMainPlayAnim(true)
	end
end

function M:switchViewByViewType()
	local showMain = self._curViewType == RetrieveViewType.Main

	goutil.setActive(self._currencyGo, showMain)

	if self._curViewType == RetrieveViewType.Main then
		RetrieveFacade.instance:setPrayState(false)
	elseif self._curViewType == RetrieveViewType.PraySelect then
		RetrieveFacade.instance:setPrayState(true)
	elseif self._curViewType == RetrieveViewType.Pray then
		RetrieveFacade.instance:setPrayState(false)
		RetrieveFacade.instance:showPrayView(self._curPickHeroId, self._lotteryData, self._onSelecTHero, self)
	end
end

function M:_handleHeroClick(evt, tag, pointId, heroId)
	if self._curViewType == RetrieveViewType.PraySelect then
		self._curPickHeroId = heroId
		self._curViewType = RetrieveViewType.Pray

		self:switchViewByViewType()
		self:_panelPrayPlayAnim(true)
		RetrieveController.instance:showHeroByHeroId(heroId)
	elseif self._curViewType == RetrieveViewType.Pray then
		self._curPickHeroId = heroId

		RetrieveController.instance:showHeroByHeroId(heroId)
	elseif self._curViewType == RetrieveViewType.Main then
		CharacterUtil.openCharacterPreviewView(heroId)
	end
end

function M:_onSelecTHero(heroId)
	self._curPickHeroId = heroId
end

function M:_onClickHome()
	RetrieveModel.instance:clearJumpInfo()
	LoadingFacade.instance:showLoading(true)
	removetimer(self._delayJumpScene, self)
	settimer(0.55, self._delayJumpScene, self, false)
end

function M:_delayJumpScene()
	removetimer(self._delayJumpScene, self)
	GlobalDispatcher:dispatchEvent(EventType.JUMP_VIEW_TO_MAIN)
end

function M:_onClickExchange()
	local jumpId = ConstConfig.instance:getNumValueByKey(ConstConfigKeyEnum.LotteryToShopJumpId)

	GlobalDispatcher:dispatchEvent(EventType.JUMP_VIEW_EVENT, tonumber(jumpId))
end

function M:_onClickEcho()
	local jumpId = ConstConfig.instance:getNumValueByKey(ConstConfigKeyEnum.LotteryToEchoShopJumpId)

	GlobalDispatcher:dispatchEvent(EventType.JUMP_VIEW_EVENT, tonumber(jumpId))
end

function M:_onClickRecord()
	ViewMgr.instance:open(ViewName.RetrieveHistoryViewPresentor)
end

function M:_onClickExplain()
	if self._lotteryData then
		ViewMgr.instance:open(ViewName.RetrieveCutlineViewPresentor, self._lotteryData)
	end
end

function M:_onClickLeftWish()
	self:_onClickWish()
end

function M:_onClickWish()
	self._curViewType = RetrieveViewType.PraySelect

	if self._lotteryData then
		local isPicked = self._lotteryData:isPicked()
		local pickedItemId = self._lotteryData:getPicked()

		self._curViewType = isPicked and RetrieveViewType.Pray or RetrieveViewType.PraySelect

		self:_panelMainPlayAnim(false)

		if not isPicked then
			RetrieveController.instance:forceShowIdle()
		else
			RetrieveController.instance:forceEnterWish(pickedItemId)
		end
	end

	self:switchViewByViewType()

	if self._curViewType == RetrieveViewType.Pray then
		self:_panelPrayPlayAnim(true)
	end
end

function M:_updateCardCell(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local item = self._loopList:NewListViewItem("item")
	local lotteryData = self._lotteryDataList[curIndex]
	local curLotteryId = lotteryData:getLotteryId()
	local shower = Astral.LuaComponentContainer.Add(item.gameObject, RetrieveItemView)

	item.gameObject.name = "card_item" .. curIndex

	shower:setCellData(lotteryData, curIndex, curLotteryId == self._lotteryId)
	shower:setClickCallBack(self._onSelectLotteryEvent, self)

	self._showerList[curLotteryId] = shower

	return item
end

function M:_onSelectLotteryEvent(lotteryId, lotteryType, index)
	if not lotteryId then
		return
	end

	local jumpInfo = {
		needShowEnter = true,
		lotteryId = lotteryId
	}

	RetrieveModel.instance:setJumpInfo(jumpInfo)
	self:_refreshLotteryInfo(lotteryId, true)
end

function M:_refreshLotteryInfo(lotteryId, needShowEnter)
	if not lotteryId then
		return
	end

	if self._lotteryId == lotteryId then
		return
	end

	if self._panelMainAnimComp then
		self._panelMainAnimComp:Stop()
		self._panelMainAnimComp:Play("retrieve_item_change_anim")
	end

	self._lotteryId = lotteryId
	self._lotteryData = ActivityController.instance:getActivityById(self._lotteryId)

	PlayerLocalStorageModel.instance:setPoolNewFlag(self._lotteryData:getPoolId(), false)
	self._lotteryData:setNewFlag(false)

	for key, shower in pairs(self._showerList) do
		shower:setSelectState(key == lotteryId)

		if key == lotteryId then
			shower:hideNewFlag()
		end
	end

	self:_bindTopCurrencyInfo()
	self:_initTopLeftInfo()
	self:_refreshWishInfo()
	self:_refreshCostView()

	local leftPos = self._lotteryData:getLeftPos()
	local midPos = self._lotteryData:getMidPos()
	local rightPos = self._lotteryData:getRightPos()

	RetrieveController.instance:updateHeroPosMap(leftPos, midPos, rightPos)
	RetrieveController.instance:removeAllHero()
	RetrieveController.instance:changeHeroByLotteryId(false, needShowEnter)
	RetrieveController.instance:changeSceneBg(self._lotteryData:getSceneBg())
	RetrieveDispatcher:dispatchEvent(RetrieveEventType.Select_Pool, self._lotteryData)
end

function M:_showEnterVideo()
	local videoCode = self._lotteryData:getEneterVideo()
	local hasVideo = videoCode > 0
end

function M:_showEnterShow(heroId, animName)
	MainScenePerformUtil.heroAnimPlay(heroId, animName, isLoop, isForceRestart, mixDuration)
end

function M:_initTopLeftInfo()
	local data = self._lotteryData

	if data then
		self._bannerName1 = data:getPictureName()
		self._bannerName2 = data:getBannerName()
		self._txtTitle.text = data:getSubtitle()

		local showTime = self._lotteryData:getLeftTime() <= 99

		self._txtTime.text = showTime and langF("tip_summon_remday", data:getLeftTime()) or ""
		self._txtRightTips.text = data:getHint()
		self._imgTitleName = GameUrl.getRetrieveImageTitle(data:getPoolTitileName())

		local lotteryPoolType = self._lotteryData:getPoolType()
		local showGuaranteed = lotteryPoolType == 1 and self._lotteryData:getAbsoluteMax() > 0

		goutil.setActive(self._txtGuaranteed.gameObject, showGuaranteed)

		if showGuaranteed then
			self._txtGuaranteed.text = langF("lottery_pr_activity", self._lotteryData:getAbsoluteCout(), self._lotteryData:getAbsoluteMax())
		end

		local showMidRoleInfo = data:getShowMidRoleInfo()

		goutil.setActive(self._objInfo, showMidRoleInfo)
		goutil.setActive(self._btnTips.gameObject, showMidRoleInfo)

		if showMidRoleInfo then
			local showHeroId = false
			local heroCodes = data:getCharacterCode()

			if #heroCodes == 1 then
				showHeroId = heroCodes[1]
			elseif #heroCodes > 1 then
				showHeroId = heroCodes[2]
			end

			if showHeroId then
				local characterCO = CharacterConfig.instance:getCfgInfoByID(showHeroId)

				if characterCO then
					self._midHeroCode = showHeroId

					IconLoader.setSprite(self._imgQuality, IconType.DynSpriteAtlas_RetrieveMainView, qualityMaps[characterCO.quality])
					IconLoader.setSprite(self._imgCarrer, IconType.Skinlib, CharacterCOUtil.career2IconName(characterCO.career))
					IconLoader.setSprite(self._imgColorType, IconType.Skinlib, CharacterCOUtil.colorType2IconName(characterCO.colorType))
				end
			end
		end
	end
end

function M:_initWishState()
	local pickedShowList = self._lotteryData:getPickableItems()

	self._isOpenWish = #pickedShowList > 0
end

function M:_refreshWishInfo()
	self:_initWishState()

	self._curPickHeroId = false

	if self._isOpenWish then
		self:_initPrayInfo()
	else
		goutil.setActive(self._btnLeftWish.gameObject, false)
		self:_swithRightBtn(false, false)
	end
end

function M:_initPrayInfo()
	local pickedItemId = self._lotteryData:getPicked()
	local hasPicked = self._lotteryData:isPicked()
	local wishMax = self._lotteryData:getWishMax()
	local isCard = self._lotteryData:isCard()
	local isNewhandLottery = self._lotteryData:isNewhandLottery()
	local isRandomPick = self._lotteryData:isRandomPick()

	wishMax = wishMax == 0 and 1 or wishMax

	local curNum = self._lotteryData:getStableNum()

	self:_swithRightBtn(not hasPicked, isNewhandLottery)
	goutil.setActive(self._btnLeftWish.gameObject, self._isOpenWish and hasPicked)

	self._curPickHeroId = pickedItemId

	local tempData = ItemUtil.createItemData({
		count = 1,
		itemId = pickedItemId
	})

	self._itemCell:updateData(tempData)

	if wishMax == 1 then
		self._txtWishProcess.text = langF("tip_wish_rate_desc_1st")
	else
		self._txtWishProcess.text = langF("tip_wish_rate_desc", curNum, wishMax)
	end

	goutil.setActive(self._itemCellGo, hasPicked)
end

function M:_swithRightBtn(showWish, isNewhandLottery)
	if isNewhandLottery then
		goutil.setActive(self._btnRetrieveOne.gameObject, false)
	else
		goutil.setActive(self._btnRetrieveOne.gameObject, not showWish)
	end

	goutil.setActive(self._btnRetrieveTen.gameObject, not showWish)
	goutil.setActive(self._btnPray.gameObject, showWish)
end

function M:_onClickRetrieveOne()
	RetrieveController.instance:clearClickState()

	local lotteryId = self._lotteryId

	self._clickLotteryOne = true

	if not RetrieveController.instance:checkCanLottery(lotteryId, RetrieveEnum.LotteryNum.One) then
		return false
	end

	if RetrieveController.instance:checkHasPicked(self._lotteryData) then
		local titleStr = ""
		local lotterySimpleType = self._lotteryData:getLotterySimpleType()

		if lotterySimpleType == RetrieveEnum.LotterySimpleType.Card then
			titleStr = lang("tip_wish_lottery_card")
		elseif lotterySimpleType == RetrieveEnum.LotterySimpleType.Echo then
			titleStr = lang("tip_wish_lottery_echo")
		end

		local luaTable = {}

		luaTable.ensureCallBack = self._oncConfirmSingle
		luaTable.ensureHandler = self
		luaTable.title = lang("tip_title")
		luaTable.content = langF("tip_wish_lottery_tips", titleStr)

		local dialog = Dialog.showDialogDaily(luaTable, "__key_send_lottery_request__")

		if dialog then
			dialog:setConfirmListener(self._oncConfirmSingle, self)
		end
	else
		self:_oncConfirmSingle()
	end
end

function M:_oncConfirmSingle()
	RetrieveController.instance:sendLotteryRequest(RetrieveEnum.LotteryNum.One, self._lotteryId)
end

function M:_onClickRetrieveTen()
	RetrieveController.instance:doRetrieveTen()
end

function M:_onClickTips()
	CharacterUtil.openCharacterPreviewView(self._midHeroCode)
end

function M:_handleGainItemViewClose(evt, targetId, isDailyRefres)
	if self._clickLotteryOne then
		self._clickLotteryOne = false

		self:_oncConfirmSingle()
	end
end

function M:clearLotteryOneFlag()
	self._clickLotteryOne = false
end

function M:forceConfirmBuy()
	if self._clickLotteryOne then
		self._clickLotteryOne = false

		self:_oncConfirmSingle()
	end
end

function M:_handleHeroAnimPlay(evt, pointId, elementId, heroId, animState)
	if animState == MainPerformEnum.AnimFullName.ChangeShow then
		RetrieveController.instance:setAllHeroState(true)
	end
end

function M:_onHandlePickItem(evt, pool, item)
	if self._lotteryData then
		self._lotteryData:setPicked(item)
		self:_initPrayInfo()
	end
end

return M
