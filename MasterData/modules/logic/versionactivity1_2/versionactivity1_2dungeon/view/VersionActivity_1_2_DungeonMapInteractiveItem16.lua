-- chunkname: @modules/logic/versionactivity1_2/versionactivity1_2dungeon/view/VersionActivity_1_2_DungeonMapInteractiveItem16.lua

module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity_1_2_DungeonMapInteractiveItem16", package.seeall)

local VersionActivity_1_2_DungeonMapInteractiveItem16 = class("VersionActivity_1_2_DungeonMapInteractiveItem16", BaseViewExtended)

function VersionActivity_1_2_DungeonMapInteractiveItem16:onInitView()
	self._topRight = gohelper.findChild(self.viewGO, "topRight")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._gorewarditem = gohelper.findChild(self.viewGO, "rotate/layout/top/reward/#go_rewarditem")
	self._txttitle = gohelper.findChildText(self.viewGO, "rotate/layout/top/title/#txt_title")
	self._gofighttip = gohelper.findChild(self.viewGO, "rotate/#go_fighttip")
	self._txtfighttip = gohelper.findChildText(self.viewGO, "rotate/#go_fighttip/#txt_fighttip")
	self._gotrap = gohelper.findChild(self.viewGO, "rotate/right/fighttip/#go_trap")
	self._gotraptip = gohelper.findChild(self.viewGO, "rotate/right/fighttip/#go_trap/#go_traptip")
	self._txtfightnumdesc = gohelper.findChildText(self.viewGO, "rotate/right/fighttip/fightnum/#txt_fightnumdesc")
	self._btnshowtip = gohelper.findChildButtonWithAudio(self.viewGO, "rotate/right/fighttip/fightnum/#txt_fightnumdesc/#btn_showtip")
	self._gofight = gohelper.findChild(self.viewGO, "rotate/right/#go_fight")
	self._txtcost = gohelper.findChildText(self.viewGO, "rotate/right/#go_fight/cost/#txt_cost")
	self._simagecosticon = gohelper.findChildSingleImage(self.viewGO, "rotate/right/#go_fight/cost/#simage_costicon")
	self._btnfight = gohelper.findChildButtonWithAudio(self.viewGO, "rotate/right/#go_fight/#btn_fight")
	self._btnclosetip = gohelper.findChildButtonWithAudio(self.viewGO, "rotate/#btn_closetip")
	self._gobg = gohelper.findChild(self.viewGO, "rotate/#go_bg")
	self._txtinfo = gohelper.findChildText(self.viewGO, "rotate/#go_bg/content/#txt_info")
	self._txtrecommendlv = gohelper.findChildText(self.viewGO, "rotate/#go_bg/content/#txt_recommendlv")
	self._gomask = gohelper.findChild(self.viewGO, "rotate/#go_bg/#go_mask")
	self._goscroll = gohelper.findChild(self.viewGO, "rotate/#go_bg/#go_mask/#go_scroll")
	self._gochatarea = gohelper.findChild(self.viewGO, "rotate/#go_bg/#go_chatarea")
	self._gochatitem = gohelper.findChild(self.viewGO, "rotate/#go_bg/#go_chatarea/#go_chatitem")
	self._goimportanttips = gohelper.findChild(self.viewGO, "rotate/#go_bg/#go_importanttips")
	self._txttipsinfo = gohelper.findChildText(self.viewGO, "rotate/#go_bg/#go_importanttips/bg/#txt_tipsinfo")
	self._goreward = gohelper.findChild(self.viewGO, "rotate/reward")
	self._gorewardcontent = gohelper.findChild(self.viewGO, "rotate/reward/#go_rewardContent")
	self._goactivityrewarditem = gohelper.findChild(self.viewGO, "rotate/reward/#go_rewardContent/#go_activityrewarditem")
	self._simagebgimag = gohelper.findChildSingleImage(self.viewGO, "rotate/#go_bg/bgimag")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity_1_2_DungeonMapInteractiveItem16:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnshowtip:AddClickListener(self._btnshowtipOnClick, self)
	self._btnclosetip:AddClickListener(self._btnclsoetipOnClick, self)
	self._btnfight:AddClickListener(self._btnfightOnClick, self)
	self.addEventCb(self, VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.closeChildElementView, self._btncloseOnClick, self)
end

function VersionActivity_1_2_DungeonMapInteractiveItem16:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnshowtip:RemoveClickListener()
	self._btnclosetip:RemoveClickListener()
	self._btnfight:RemoveClickListener()
end

function VersionActivity_1_2_DungeonMapInteractiveItem16:_btncloseOnClick()
	local animator = SLFramework.AnimatorPlayer.Get(self.viewGO)

	animator:Play("close", self.DESTROYSELF, self)
end

function VersionActivity_1_2_DungeonMapInteractiveItem16:_btnshowtipOnClick()
	self._showFightTips = not self._showFightTips

	gohelper.setActive(self._gofighttip, self._showFightTips)
end

function VersionActivity_1_2_DungeonMapInteractiveItem16:_btnclsoetipOnClick()
	if self._showFightTips == true then
		gohelper.setActive(self._gofighttip, false)
	end
end

function VersionActivity_1_2_DungeonMapInteractiveItem16:_btnfightOnClick()
	local episodeId = self._episodeConfig.id
	local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)

	if episodeConfig then
		DungeonFightController.instance:enterFight(episodeConfig.chapterId, episodeId)
	end
end

function VersionActivity_1_2_DungeonMapInteractiveItem16:onRefreshViewParam(config)
	self._config = config
end

function VersionActivity_1_2_DungeonMapInteractiveItem16:_getEpisodeConfig()
	return VersionActivity1_2DungeonModel.instance:getDailyEpisodeConfigByElementId(self._config.id)
end

function VersionActivity_1_2_DungeonMapInteractiveItem16:onOpen()
	self._simagebgimag:LoadImage(ResUrl.getVersionActivityDungeon_1_2("tanchaung_di"))
	self._simagecosticon:LoadImage(ResUrl.getCurrencyItemIcon("204"))
	gohelper.setActive(self._gofighttip, false)

	self._episodeConfig = self:_getEpisodeConfig()
	self._episodeMO = DungeonModel.instance:getEpisodeInfo(self._episodeConfig.id)

	if not self._episodeMO then
		self._episodeMO = UserDungeonMO.New()

		self._episodeMO:initFromManual(self._episodeConfig.chapterId, self._episodeConfig.id, 0, 0)
	end

	local cost = 0

	if not string.nilorempty(self._episodeConfig.cost) then
		cost = string.splitToNumber(self._episodeConfig.cost, "#")[3]
	end

	self._txtcost.text = "-" .. cost

	if cost <= CurrencyModel.instance:getPower() then
		SLFramework.UGUI.GuiHelper.SetColor(self._txtcost, "#070706")
	else
		SLFramework.UGUI.GuiHelper.SetColor(self._txtcost, "#800015")
	end

	self._txtinfo.text = self._episodeConfig.desc
	self._txtfightnumdesc.text = ""
	self._txtfighttip.text = ""

	SLFramework.UGUI.GuiHelper.SetColor(self._gofight.gameObject:GetComponent(gohelper.Type_Image), "#FFFFFF")
	self:refreshReward()
	gohelper.setActive(self._gotrap, VersionActivity1_2DungeonModel.instance:getTrapPutting())

	self._txttitle.text = self._episodeConfig.name

	local recommendLevel = FightHelper.getEpisodeRecommendLevel(self._episodeConfig.id)

	gohelper.setActive(self._txtrecommendlv.gameObject, recommendLevel > 0)

	if recommendLevel > 0 then
		self._txtrecommendlv.text = string.format("<color=#E99B56>%s</color>", luaLang("dungeon_recommend_lv") .. HeroConfig.instance:getCommonLevelDisplay(recommendLevel))
	end
end

function VersionActivity_1_2_DungeonMapInteractiveItem16:onOpenFinish()
	local curTrapId = VersionActivity1_2DungeonModel.instance:getTrapPutting()
	local isTrapPutting = curTrapId and curTrapId ~= 0

	VersionActivity1_2DungeonController.instance:dispatchEvent(VersionActivity1_2DungeonEvent.onDailyEpisodeItemOpen, tostring(isTrapPutting))
end

function VersionActivity_1_2_DungeonMapInteractiveItem16:refreshReward()
	gohelper.setActive(self._goactivityrewarditem, false)

	local rewardList = {}
	local firstRewardIndex = 0
	local advancedRewardIndex = 0

	self.rewardItems = {}

	if self._episodeMO and self._episodeMO.star ~= DungeonEnum.StarType.Advanced then
		tabletool.addValues(rewardList, DungeonModel.instance:getEpisodeAdvancedBonus(self._episodeConfig.id))

		advancedRewardIndex = #rewardList
	end

	if self._episodeMO and self._episodeMO.star == DungeonEnum.StarType.None then
		tabletool.addValues(rewardList, DungeonModel.instance:getEpisodeFirstBonus(self._episodeConfig.id))

		firstRewardIndex = #rewardList
	end

	tabletool.addValues(rewardList, DungeonModel.instance:getEpisodeRewardDisplayList(self._episodeConfig.id))

	local rewardCount = #rewardList

	if rewardCount == 0 then
		gohelper.setActive(self._goreward, false)

		return
	end

	local count = math.min(#rewardList, 3)
	local reward, rewardItem

	for i = 1, count do
		rewardItem = self.rewardItems[i]

		if not self.rewardItems[i] then
			rewardItem = self:getUserDataTb_()
			rewardItem.go = gohelper.cloneInPlace(self._goactivityrewarditem, "item" .. i)
			rewardItem.iconItem = IconMgr.instance:getCommonPropItemIcon(gohelper.findChild(rewardItem.go, "itemicon"))
			rewardItem.gonormal = gohelper.findChild(rewardItem.go, "rare/#go_rare1")
			rewardItem.gofirst = gohelper.findChild(rewardItem.go, "rare/#go_rare2")
			rewardItem.goadvance = gohelper.findChild(rewardItem.go, "rare/#go_rare3")
			rewardItem.gofirsthard = gohelper.findChild(rewardItem.go, "rare/#go_rare4")
			rewardItem.txtnormal = gohelper.findChildText(rewardItem.go, "rare/#go_rare1/txt")
			rewardItem.count = gohelper.findChildText(rewardItem.go, "countbg/count")

			table.insert(self.rewardItems, rewardItem)
		end

		reward = rewardList[i]

		gohelper.setActive(rewardItem.gonormal, false)
		gohelper.setActive(rewardItem.gofirst, false)
		gohelper.setActive(rewardItem.goadvance, false)
		gohelper.setActive(rewardItem.gofirsthard, false)

		local goFirstRare, goAdvanceRare
		local quantity = reward[3]
		local isShowCount = true

		if i <= advancedRewardIndex then
			gohelper.setActive(rewardItem.goadvance, true)
		elseif i <= firstRewardIndex then
			gohelper.setActive(rewardItem.gofirst, true)
		else
			gohelper.setActive(rewardItem.gonormal, true)

			rewardItem.txtnormal.text = luaLang("dungeon_prob_flag" .. reward[3])

			if #reward >= 4 then
				quantity = reward[4]
			else
				isShowCount = false
			end
		end

		rewardItem.iconItem:setMOValue(reward[1], reward[2], quantity, nil, true)
		rewardItem.iconItem:setCountFontSize(0)
		rewardItem.iconItem:setHideLvAndBreakFlag(true)
		rewardItem.iconItem:hideEquipLvAndBreak(true)
		rewardItem.iconItem:isShowCount(isShowCount)
		rewardItem.iconItem:customOnClickCallback(self._onRewardItemClick, self)
		gohelper.setActive(rewardItem.count.gameObject, isShowCount)

		rewardItem.count.text = quantity

		gohelper.setActive(rewardItem.go, true)
	end

	for i = count + 1, #self.rewardItems do
		gohelper.setActive(self.rewardItems[i].go, false)
	end
end

function VersionActivity_1_2_DungeonMapInteractiveItem16:_onRewardItemClick()
	DungeonController.instance:openDungeonRewardView(self._episodeConfig)
end

function VersionActivity_1_2_DungeonMapInteractiveItem16:_showCurrency()
	self:com_loadAsset(CurrencyView.prefabPath, self._onCurrencyLoaded)
end

function VersionActivity_1_2_DungeonMapInteractiveItem16:_onCurrencyLoaded(loader)
	local tarPrefab = loader:GetResource()
	local obj = gohelper.clone(tarPrefab, self._topRight)
	local currencyType = CurrencyEnum.CurrencyType
	local currencyParam = {
		currencyType.Power
	}
	local currencyView = self:openSubView(CurrencyView, obj, nil, currencyParam)

	currencyView.foreShowBtn = true

	currencyView:_hideAddBtn()
end

function VersionActivity_1_2_DungeonMapInteractiveItem16:onClose()
	return
end

function VersionActivity_1_2_DungeonMapInteractiveItem16:onDestroyView()
	self._simagebgimag:UnLoadImage()
	self._simagecosticon:UnLoadImage()
end

return VersionActivity_1_2_DungeonMapInteractiveItem16
