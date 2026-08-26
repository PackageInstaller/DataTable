-- chunkname: @modules/logic/versionactivity1_3/versionactivity1_3dungeon/view/VersionActivity_1_3_DungeonMapInteractiveItem16.lua

module("modules.logic.versionactivity1_3.versionactivity1_3dungeon.view.VersionActivity_1_3_DungeonMapInteractiveItem16", package.seeall)

local VersionActivity_1_3_DungeonMapInteractiveItem16 = class("VersionActivity_1_3_DungeonMapInteractiveItem16", BaseViewExtended)

function VersionActivity_1_3_DungeonMapInteractiveItem16:onInitView()
	self._gorewarditem = gohelper.findChild(self.viewGO, "rotate/layout/top/reward/#go_rewarditem")
	self._txttitle = gohelper.findChildText(self.viewGO, "rotate/layout/top/title/#txt_title")
	self._gobg = gohelper.findChild(self.viewGO, "rotate/#go_bg")
	self._gopagelist = gohelper.findChild(self.viewGO, "rotate/#go_pagelist")
	self._simagebgimag = gohelper.findChildSingleImage(self.viewGO, "rotate/#go_bg/bgimag")
	self._txtinfo = gohelper.findChildText(self.viewGO, "rotate/#go_bg/#txt_info")
	self._gomask = gohelper.findChild(self.viewGO, "rotate/#go_bg/#go_mask")
	self._goscroll = gohelper.findChild(self.viewGO, "rotate/#go_bg/#go_mask/#go_scroll")
	self._gochatarea = gohelper.findChild(self.viewGO, "rotate/#go_bg/#go_chatarea")
	self._gochatitem = gohelper.findChild(self.viewGO, "rotate/#go_bg/#go_chatarea/#go_chatitem")
	self._goimportanttips = gohelper.findChild(self.viewGO, "rotate/#go_bg/#go_importanttips")
	self._txttipsinfo = gohelper.findChildText(self.viewGO, "rotate/#go_bg/#go_importanttips/bg/#txt_tipsinfo")
	self._gofighttip = gohelper.findChild(self.viewGO, "rotate/#go_fighttip")
	self._txtfighttip = gohelper.findChildText(self.viewGO, "rotate/#go_fighttip/#txt_fighttip")
	self._btnclosetip = gohelper.findChildButtonWithAudio(self.viewGO, "rotate/#btn_closetip")
	self._txtfightnumdesc = gohelper.findChildText(self.viewGO, "rotate/right/fighttip/fightnum/#txt_fightnumdesc")
	self._btnshowtip = gohelper.findChildButtonWithAudio(self.viewGO, "rotate/right/fighttip/fightnum/#txt_fightnumdesc/#btn_showtip")
	self._gofight = gohelper.findChild(self.viewGO, "rotate/right/#go_fight")
	self._txtcost = gohelper.findChildText(self.viewGO, "rotate/right/#go_fight/cost/#txt_cost")
	self._simagecosticon = gohelper.findChildSingleImage(self.viewGO, "rotate/right/#go_fight/cost/#simage_costicon")
	self._btnfight = gohelper.findChildButtonWithAudio(self.viewGO, "rotate/right/#go_fight/#btn_fight")
	self._gorewardContent = gohelper.findChild(self.viewGO, "rotate/reward/#go_rewardContent")
	self._goactivityrewarditem = gohelper.findChild(self.viewGO, "rotate/reward/#go_rewardContent/#go_activityrewarditem")
	self._gorare1 = gohelper.findChild(self.viewGO, "rotate/reward/#go_rewardContent/#go_activityrewarditem/rare/#go_rare1")
	self._gorare2 = gohelper.findChild(self.viewGO, "rotate/reward/#go_rewardContent/#go_activityrewarditem/rare/#go_rare2")
	self._gorare3 = gohelper.findChild(self.viewGO, "rotate/reward/#go_rewardContent/#go_activityrewarditem/rare/#go_rare3")
	self._gorare4 = gohelper.findChild(self.viewGO, "rotate/reward/#go_rewardContent/#go_activityrewarditem/rare/#go_rare4")
	self._btnright = gohelper.findChildButtonWithAudio(self.viewGO, "rotate/#btn_right")
	self._btnleft = gohelper.findChildButtonWithAudio(self.viewGO, "rotate/#btn_left")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity_1_3_DungeonMapInteractiveItem16:addEvents()
	self._btnclosetip:AddClickListener(self._btnclosetipOnClick, self)
	self._btnshowtip:AddClickListener(self._btnshowtipOnClick, self)
	self._btnfight:AddClickListener(self._btnfightOnClick, self)
	self._btnright:AddClickListener(self._btnrightOnClick, self)
	self._btnleft:AddClickListener(self._btnleftOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function VersionActivity_1_3_DungeonMapInteractiveItem16:removeEvents()
	self._btnclosetip:RemoveClickListener()
	self._btnshowtip:RemoveClickListener()
	self._btnfight:RemoveClickListener()
	self._btnright:RemoveClickListener()
	self._btnleft:RemoveClickListener()
	self._btnclose:RemoveClickListener()
end

function VersionActivity_1_3_DungeonMapInteractiveItem16:_btnclosetipOnClick()
	if self._showFightTips == true then
		gohelper.setActive(self._gofighttip, false)
	end
end

function VersionActivity_1_3_DungeonMapInteractiveItem16:_btnrightOnClick()
	self._curEpisodeIndex = self._curEpisodeIndex + 1

	self:_updateBtns()
end

function VersionActivity_1_3_DungeonMapInteractiveItem16:_btnleftOnClick()
	self._curEpisodeIndex = self._curEpisodeIndex - 1

	self:_updateBtns()
end

function VersionActivity_1_3_DungeonMapInteractiveItem16:_updateBtns()
	local showRight = self._curEpisodeIndex < self._episodeLen

	gohelper.setActive(self._btnright, showRight)

	local showLeft = self._curEpisodeIndex > 1

	gohelper.setActive(self._btnleft, showLeft)
	gohelper.setSibling(self._selectedStar, self._curEpisodeIndex)
	self:_updateEpisodeInfo()
	self:_refreshEpisodeInfo()
end

function VersionActivity_1_3_DungeonMapInteractiveItem16:_btncloseOnClick()
	local animator = SLFramework.AnimatorPlayer.Get(self.viewGO)

	animator:Play("close", self.DESTROYSELF, self)
end

function VersionActivity_1_3_DungeonMapInteractiveItem16:_btnshowtipOnClick()
	self._showFightTips = not self._showFightTips

	gohelper.setActive(self._gofighttip, self._showFightTips)
end

function VersionActivity_1_3_DungeonMapInteractiveItem16:_btnfightOnClick()
	local episodeId = self._episodeConfig.id
	local passNum = Activity126Model.instance:getDailyPassNum()

	if self._episodeMO.todayTotalNum then
		if passNum < self._episodeMO.todayTotalNum then
			local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)

			if episodeConfig then
				DungeonFightController.instance:enterFight(episodeConfig.chapterId, episodeId)
			end
		else
			GameFacade.showToast(ToastEnum.Act114InsufficientChallengeCount)
		end
	end
end

function VersionActivity_1_3_DungeonMapInteractiveItem16:onRefreshViewParam(config)
	self._config = config
end

function VersionActivity_1_3_DungeonMapInteractiveItem16:onOpen()
	self._simagebgimag:LoadImage(ResUrl.getV1A3DungeonIcon("v1a3_dungeoninteractive_panelbg"))
	self._simagecosticon:LoadImage(ResUrl.getCurrencyItemIcon("204"))

	self.rewardItems = self:getUserDataTb_()
	self._episodeList, self._isAll = Activity126Model.instance:getOpenDailyEpisodeList()
	self._episodeLen = #self._episodeList

	local remainNum, totalNum = Activity126Model.instance:getRemainNum()

	if self._isAll and remainNum > 0 and PlayerPrefsHelper.getNumber(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.ActivityDungeon1_3DailyTip), 0) == 0 then
		PlayerPrefsHelper.setNumber(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.ActivityDungeon1_3DailyTip), 1)
		GameFacade.showToast(ToastEnum.Activity126_tip1)
	end

	self:_initPageList()

	local targetMo = DungeonModel.instance:getEpisodeInfo(tonumber(self._config.param))

	self._curEpisodeIndex = tabletool.indexOf(self._episodeList, targetMo) or 1

	self:_updateBtns()
	gohelper.setActive(self._gofighttip, false)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_warnopen)
	VersionActivity1_3DungeonController.instance:dispatchEvent(VersionActivity1_3DungeonEvent.OpenDailyInteractiveItem)
end

function VersionActivity_1_3_DungeonMapInteractiveItem16:_initPageList()
	local showPageList = self._episodeLen > 1

	gohelper.setActive(self._gopagelist, showPageList)

	if showPageList then
		local templateGo = gohelper.findChild(self._gopagelist, "star")

		self._selectedStar = gohelper.findChild(self._gopagelist, "star_select")

		gohelper.setActive(self._selectedStar, true)

		for i = 1, self._episodeLen - 1 do
			local go = gohelper.cloneInPlace(templateGo)

			gohelper.setActive(go, true)
		end
	end
end

function VersionActivity_1_3_DungeonMapInteractiveItem16:_updateEpisodeInfo()
	self._episodeMO = self._episodeList[self._curEpisodeIndex]
	self._episodeId = self._episodeMO.episodeId
	self._episodeConfig = DungeonConfig.instance:getEpisodeCO(self._episodeId)

	Activity126Model.instance:changeShowDailyId(self._episodeId)
	VersionActivity1_3DungeonController.instance:dispatchEvent(VersionActivity1_3DungeonEvent.SelectChangeDaily, self._episodeId)
end

function VersionActivity_1_3_DungeonMapInteractiveItem16:_refreshEpisodeInfo()
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

	local passNum = Activity126Model.instance:getDailyPassNum()

	if self._episodeMO.todayTotalNum then
		self._txtfightnumdesc.text = formatLuaLang("left_challenge_count", self._episodeMO.todayTotalNum - passNum)
		self._txtfighttip.text = luaLang("activity_1_3_daily_refresh_rule")
	else
		self._txtfightnumdesc.text = ""
		self._txtfighttip.text = ""
	end

	if passNum >= self._episodeMO.todayTotalNum then
		SLFramework.UGUI.GuiHelper.SetColor(self._gofight.gameObject:GetComponent(gohelper.Type_Image), "#9c9c9c")
	else
		SLFramework.UGUI.GuiHelper.SetColor(self._gofight.gameObject:GetComponent(gohelper.Type_Image), "#FFFFFF")
	end

	self:refreshReward()

	self._txttitle.text = self._episodeConfig.name
end

function VersionActivity_1_3_DungeonMapInteractiveItem16:refreshReward()
	gohelper.setActive(self._goactivityrewarditem, false)

	local rewardList = {}
	local firstRewardIndex = 0
	local advancedRewardIndex = 0

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
		gohelper.setActive(self._gorewardcontent, false)

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
		rewardItem.iconItem:isShowCount(false)
		rewardItem.iconItem:customOnClickCallback(self._onRewardItemClick, self)
		gohelper.setActive(rewardItem.go, true)
	end

	for i = count + 1, #self.rewardItems do
		gohelper.setActive(self.rewardItems[i].go, false)
	end
end

function VersionActivity_1_3_DungeonMapInteractiveItem16:_onRewardItemClick()
	DungeonController.instance:openDungeonRewardView(self._episodeConfig)
end

function VersionActivity_1_3_DungeonMapInteractiveItem16:_showCurrency()
	self:com_loadAsset(CurrencyView.prefabPath, self._onCurrencyLoaded)
end

function VersionActivity_1_3_DungeonMapInteractiveItem16:_onCurrencyLoaded(loader)
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

function VersionActivity_1_3_DungeonMapInteractiveItem16:onClose()
	return
end

function VersionActivity_1_3_DungeonMapInteractiveItem16:onDestroyView()
	self._simagebgimag:UnLoadImage()
	self._simagecosticon:UnLoadImage()
end

return VersionActivity_1_3_DungeonMapInteractiveItem16
