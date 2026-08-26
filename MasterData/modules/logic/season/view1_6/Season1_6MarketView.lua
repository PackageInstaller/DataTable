-- chunkname: @modules/logic/season/view1_6/Season1_6MarketView.lua

module("modules.logic.season.view1_6.Season1_6MarketView", package.seeall)

local Season1_6MarketView = class("Season1_6MarketView", BaseView)

function Season1_6MarketView:onInitView()
	self._goinfo = gohelper.findChild(self.viewGO, "#go_info")
	self._simagepage = gohelper.findChildSingleImage(self.viewGO, "#go_info/left/#simage_page")
	self._simagestageicon = gohelper.findChildSingleImage(self.viewGO, "#go_info/left/#simage_stageicon")
	self._animatorRight = gohelper.findChildComponent(self.viewGO, "#go_info/right", typeof(UnityEngine.Animator))
	self._txtlevelnamecn = gohelper.findChildText(self.viewGO, "#go_info/left/#txt_levelnamecn")
	self._txtlevelnameen = gohelper.findChildText(self.viewGO, "#go_info/left/#txt_levelnamecn/#txt_levelnameen")
	self._gostageinfoitem1 = gohelper.findChild(self.viewGO, "#go_info/left/#txt_levelnamecn/stage/#go_stageinfoitem1")
	self._gostageinfoitem2 = gohelper.findChild(self.viewGO, "#go_info/left/#txt_levelnamecn/stage/#go_stageinfoitem2")
	self._gostageinfoitem3 = gohelper.findChild(self.viewGO, "#go_info/left/#txt_levelnamecn/stage/#go_stageinfoitem3")
	self._gostageinfoitem4 = gohelper.findChild(self.viewGO, "#go_info/left/#txt_levelnamecn/stage/#go_stageinfoitem4")
	self._gostageinfoitem5 = gohelper.findChild(self.viewGO, "#go_info/left/#txt_levelnamecn/stage/#go_stageinfoitem5")
	self._gostageinfoitem6 = gohelper.findChild(self.viewGO, "#go_info/left/#txt_levelnamecn/stage/#go_stageinfoitem6")
	self._gostageinfoitem7 = gohelper.findChild(self.viewGO, "#go_info/left/#txt_levelnamecn/stage/#go_stageinfoitem7")
	self._descScroll = gohelper.findChild(self.viewGO, "#go_info/left/Scroll View")
	self._animScroll = self._descScroll:GetComponent(typeof(UnityEngine.Animator))
	self._descContent = gohelper.findChild(self.viewGO, "#go_info/left/Scroll View/Viewport/Content")
	self._goDescItem = gohelper.findChild(self.viewGO, "#go_info/left/Scroll View/Viewport/Content/#go_descitem")
	self._txtcurindex = gohelper.findChildText(self.viewGO, "#go_info/right/position/center/#txt_curindex")
	self._txtmaxindex = gohelper.findChildText(self.viewGO, "#go_info/right/position/center/#txt_maxindex")
	self._btnlast = gohelper.findChildButtonWithAudio(self.viewGO, "#go_info/right/position/#btn_last")
	self._btnnext = gohelper.findChildButtonWithAudio(self.viewGO, "#go_info/right/position/#btn_next")
	self._txtdesc = gohelper.findChildText(self.viewGO, "#go_info/right/#txt_desc")
	self._txtenemylv = gohelper.findChildText(self.viewGO, "#go_info/right/enemylv/enemylv/#txt_enemylv")
	self._btnstart = gohelper.findChildButtonWithAudio(self.viewGO, "#go_info/right/btns/#btn_start")
	self._btnReplay = gohelper.findChildButtonWithAudio(self.viewGO, "#go_info/right/btns/#btn_storyreplay")
	self._gopart = gohelper.findChild(self.viewGO, "#go_info/right/layout/#go_part")
	self._gostage = gohelper.findChild(self.viewGO, "#go_info/right/layout/#go_part/#go_stage")
	self._gostagelvlitem = gohelper.findChild(self.viewGO, "#go_info/right/layout/#go_part/#go_stage/list/#go_stagelvlitem")

	gohelper.setActive(self._gostagelvlitem, false)

	self._gounlocktype1 = gohelper.findChild(self.viewGO, "#go_info/right/layout/root/mask/#scroll_rewards/Viewport/Content/#go_unlocktype1")
	self._gounlocktype2 = gohelper.findChild(self.viewGO, "#go_info/right/layout/root/mask/#scroll_rewards/Viewport/Content/#go_unlocktype2")
	self._gounlocktype3 = gohelper.findChild(self.viewGO, "#go_info/right/layout/root/mask/#scroll_rewards/Viewport/Content/#go_unlocktype3")
	self._scrollrewards = gohelper.findChildScrollRect(self.viewGO, "#go_info/right/layout/root/mask/#scroll_rewards")
	self._gorewarditem = gohelper.findChild(self.viewGO, "#go_info/right/layout/root/mask/#scroll_rewards/Viewport/Content/#go_rewarditem")
	self._godecorate = gohelper.findChild(self.viewGO, "#go_info/right/decorate")
	self._gocenter = gohelper.findChild(self.viewGO, "#go_info/right/position/center")
	self._golevel = gohelper.findChild(self.viewGO, "#go_level")
	self._anilevel = self._golevel:GetComponent(typeof(UnityEngine.Animator))
	self._simagelvbg = gohelper.findChildSingleImage(self.viewGO, "#go_level/#simage_lvbg")
	self._goScrollContent = gohelper.findChild(self.viewGO, "#go_level/#go_scrollRoot/#go_scrolllv/Viewport/Content")
	self._golvitem = gohelper.findChild(self.viewGO, "#go_level/#go_scrollRoot/#go_scrolllv/Viewport/Content/#go_lvitem")
	self._simagedecorate = gohelper.findChildSingleImage(self.viewGO, "#go_level/center/backgrounds/#simage_decorate4")
	self._txtcurlevelnamecn = gohelper.findChildText(self.viewGO, "#go_level/center/#txt_curlevelnamecn")
	self._txtcurlevelnameen = gohelper.findChildText(self.viewGO, "#go_level/center/#txt_curlevelnamecn/#txt_curlevelnameen")
	self._gostagelvitem1 = gohelper.findChild(self.viewGO, "#go_level/center/#txt_curlevelnamecn/stage/#go_stagelvitem1")
	self._gostagelvitem2 = gohelper.findChild(self.viewGO, "#go_level/center/#txt_curlevelnamecn/stage/#go_stagelvitem2")
	self._gostagelvitem3 = gohelper.findChild(self.viewGO, "#go_level/center/#txt_curlevelnamecn/stage/#go_stagelvitem3")
	self._gostagelvitem4 = gohelper.findChild(self.viewGO, "#go_level/center/#txt_curlevelnamecn/stage/#go_stagelvitem4")
	self._gostagelvitem5 = gohelper.findChild(self.viewGO, "#go_level/center/#txt_curlevelnamecn/stage/#go_stagelvitem5")
	self._gostagelvitem6 = gohelper.findChild(self.viewGO, "#go_level/center/#txt_curlevelnamecn/stage/#go_stagelvitem6")
	self._gostagelvitem7 = gohelper.findChild(self.viewGO, "#go_level/center/#txt_curlevelnamecn/stage/#go_stagelvitem7")
	self._simageuttu = gohelper.findChildSingleImage(self.viewGO, "#go_level/bottom/#simage_uttu")
	self._simageleftinfobg = gohelper.findChildSingleImage(self.viewGO, "#go_level/#simage_leftinfobg")
	self._simagerightinfobg = gohelper.findChildSingleImage(self.viewGO, "#go_level/#simage_rightinfobg")
	self._gopartempty = gohelper.findChild(self.viewGO, "#go_info/right/layout/#go_partempty")
	self._simageempty = gohelper.findChildSingleImage(self.viewGO, "#go_info/right/layout/#go_partempty/#simage_empty")
	self._goleftscrolltopmask = gohelper.findChild(self.viewGO, "#go_info/left/Scroll View/mask2")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season1_6MarketView:addEvents()
	self._btnlast:AddClickListener(self._btnlastOnClick, self)
	self._btnnext:AddClickListener(self._btnnextOnClick, self)
	self._btnstart:AddClickListener(self._btnstartOnClick, self)
	self._btnReplay:AddClickListener(self._btnreplayOnClick, self)
end

function Season1_6MarketView:removeEvents()
	self._btnlast:RemoveClickListener()
	self._btnnext:RemoveClickListener()
	self._btnstart:RemoveClickListener()
	self._btnReplay:RemoveClickListener()
end

function Season1_6MarketView:_btnlastOnClick()
	if self._layer < 2 then
		return
	end

	self._animatorRight:Play(UIAnimationName.Switch, 0, 0)
	self._animScroll:Play(UIAnimationName.Switch, 0, 0)

	self._layer = self._layer - 1

	TaskDispatcher.cancelTask(self._delayShowInfo, self)
	TaskDispatcher.runDelay(self._delayShowInfo, self, 0.2)
end

function Season1_6MarketView:_btnnextOnClick()
	local curLayer = Activity104Model.instance:getAct104CurLayer()

	if curLayer <= self._layer then
		return
	end

	self._animatorRight:Play(UIAnimationName.Switch, 0, 0)
	self._animScroll:Play(UIAnimationName.Switch, 0, 0)

	self._layer = self._layer + 1

	TaskDispatcher.cancelTask(self._delayShowInfo, self)
	TaskDispatcher.runDelay(self._delayShowInfo, self, 0.2)
end

function Season1_6MarketView:_delayShowInfo()
	self:_showInfo()
	self:_setStages()
	self:updateLeftDesc()
end

function Season1_6MarketView:_btnstartOnClick()
	local actId = Activity104Model.instance:getCurSeasonId()
	local episodeId = SeasonConfig.instance:getSeasonEpisodeCo(actId, self._layer).episodeId

	Activity104Model.instance:enterAct104Battle(episodeId, self._layer)
end

function Season1_6MarketView:_btnreplayOnClick()
	local actId = Activity104Model.instance:getCurSeasonId()
	local co = SeasonConfig.instance:getSeasonEpisodeCo(actId, self._layer)

	if not co or co.afterStoryId == 0 then
		return
	end

	StoryController.instance:playStory(co.afterStoryId)
end

function Season1_6MarketView:_editableInitView()
	self._simagepage:LoadImage(SeasonViewHelper.getSeasonIcon("shuye.png"))
	self._simageuttu:LoadImage(SeasonViewHelper.getSeasonIcon("uttu_zs.png"))
	self._simageleftinfobg:LoadImage(SeasonViewHelper.getSeasonIcon("msg_xia.png"))
	self._simagerightinfobg:LoadImage(SeasonViewHelper.getSeasonIcon("msg_shang.png"))
	self._simageempty:LoadImage(SeasonViewHelper.getSeasonIcon("kongzhuangtai.png"))
end

function Season1_6MarketView:onUpdateParam()
	return
end

function Season1_6MarketView:onOpen()
	if self.viewParam then
		self._layer = self.viewParam.tarLayer or Activity104Model.instance:getAct104CurLayer()
	end

	self:resetData()
	TaskDispatcher.cancelTask(self._showInfoByOpen, self)

	if self:isShowLevel() then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_chain)
		gohelper.setActive(self._golevel, true)
		gohelper.setActive(self._goinfo, false)

		self._anilevel.speed = 0

		self:_setLevels()
		self:_setStages()
		Activity104Model.instance:setMakertLayerMark(Activity104Model.instance:getCurSeasonId(), self._layer)
		TaskDispatcher.runDelay(self._showInfoByOpen, self, 2)
	else
		self:noAudioShowInfoByOpen()
	end
end

function Season1_6MarketView:resetData()
	self._showLvItems = {}
	self._showStageItems = {}
	self._infoStageItems = {}
	self._equipReward = {}
	self._rewardItems = {}
	self._partStageItems = {}
end

function Season1_6MarketView:isShowLevel()
	return Activity104Model.instance:isCanPlayMakertLayerAnim(Activity104Model.instance:getCurSeasonId(), self._layer)
end

function Season1_6MarketView:noAudioShowInfoByOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_theft_open)
	gohelper.setActive(self._golevel, false)
	gohelper.setActive(self._goinfo, true)
	self:_showInfo()
	self:_setStages()
	self:updateLeftDesc()
end

function Season1_6MarketView:_showInfoByOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_chain_end)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_theft_open)
	gohelper.setActive(self._golevel, false)
	gohelper.setActive(self._goinfo, true)
	self:_showInfo()
	self:_setStages()
	self:updateLeftDesc()
end

function Season1_6MarketView:_setLevels()
	local episodeCo = SeasonConfig.instance:getSeasonEpisodeCo(Activity104Model.instance:getCurSeasonId(), self._layer)

	self._txtcurlevelnamecn.text = episodeCo.stageName
	self._txtcurlevelnameen.text = episodeCo.stageNameEn

	local maxLayer = Activity104Model.instance:getMaxLayer()
	local curLayer = Activity104Model.instance:getAct104CurLayer()

	if self._layer <= 4 then
		for i = 1, 6 do
			local child = gohelper.cloneInPlace(self._golvitem)

			self._showLvItems[i] = Season1_6MarketShowLevelItem.New()

			self._showLvItems[i]:init(child, i, curLayer, maxLayer)
		end
	elseif self._layer >= maxLayer - 3 then
		for i = maxLayer - 5, maxLayer do
			local child = gohelper.cloneInPlace(self._golvitem)

			self._showLvItems[i] = Season1_6MarketShowLevelItem.New()

			self._showLvItems[i]:init(child, i, curLayer, maxLayer)
		end
	else
		for i = self._layer - 4, self._layer + 4 do
			local child = gohelper.cloneInPlace(self._golvitem)

			self._showLvItems[i] = Season1_6MarketShowLevelItem.New()

			self._showLvItems[i]:init(child, i, curLayer, maxLayer)
		end
	end

	TaskDispatcher.runDelay(self._delayShowItem, self, 0.1)
end

function Season1_6MarketView:_delayShowItem()
	local item = self._showLvItems[self._layer]

	if item then
		local posX = recthelper.getAnchorX(item.go.transform) - 105
		local contentPosX = -posX

		recthelper.setAnchorX(self._goScrollContent.transform, contentPosX)
	end

	for _, v in pairs(self._showLvItems) do
		v:show()
	end

	self._anilevel.speed = 1
end

function Season1_6MarketView:_setStages()
	local episodeCo = SeasonConfig.instance:getSeasonEpisodeCo(Activity104Model.instance:getCurSeasonId(), self._layer)
	local stage = episodeCo.stage

	gohelper.setActive(self._gostageinfoitem7, stage == 7)
	gohelper.setActive(self._gostagelvitem7, stage == 7)

	for i = 1, 7 do
		local infoDark = gohelper.findChildImage(self["_gostageinfoitem" .. i], "dark")
		local infoLight = gohelper.findChildImage(self["_gostageinfoitem" .. i], "light")
		local lvDark = gohelper.findChildImage(self["_gostagelvitem" .. i], "dark")
		local lvLight = gohelper.findChildImage(self["_gostagelvitem" .. i], "light")

		gohelper.setActive(infoLight.gameObject, i <= stage)
		gohelper.setActive(infoDark.gameObject, stage < i)
		gohelper.setActive(lvLight.gameObject, i <= stage)
		gohelper.setActive(lvDark.gameObject, stage < i)

		local infocolor = i == 7 and "#B83838" or "#3E3E3D"
		local lvColor = i == 7 and "#B83838" or "#C1C1C2"

		SLFramework.UGUI.GuiHelper.SetColor(infoLight, infocolor)
		SLFramework.UGUI.GuiHelper.SetColor(lvLight, lvColor)
	end

	self._simagedecorate:LoadImage(SeasonViewHelper.getSeasonIcon(string.format("icon/b_chatu_%s.png", episodeCo.stagePicture)))
end

function Season1_6MarketView:_showInfo()
	self:_setInfo()
	self:_setParts()
end

Season1_6MarketView.NomalStageTagPos = Vector2(46.3, 2.7)
Season1_6MarketView.NewStageTagPos = Vector2(4.37, 2.7)

function Season1_6MarketView:_setInfo()
	local episodeCo = SeasonConfig.instance:getSeasonEpisodeCo(Activity104Model.instance:getCurSeasonId(), self._layer)

	if not episodeCo then
		return
	end

	local afterStory = Activity104Model.instance:isEpisodeAfterStory(Activity104Model.instance:getCurSeasonId(), self._layer)

	gohelper.setActive(self._btnReplay, afterStory and episodeCo.afterStoryId ~= 0 or false)

	self._txtlevelnamecn.text = episodeCo.stageName
	self._txtlevelnameen.text = episodeCo.stageNameEn
	self._txtdesc.text = DungeonConfig.instance:getEpisodeCO(episodeCo.episodeId).desc
	self._txtcurindex.text = string.format("%02d", self._layer)

	local maxLayer = Activity104Model.instance:getMaxLayer()

	self._txtmaxindex.text = string.format("%02d", maxLayer)

	local stage = Activity104Model.instance:getAct104CurStage()
	local isNewStage = Activity104Model.instance:isNextLayerNewStage(self._layer)

	gohelper.setActive(self._godecorate, isNewStage)

	if isNewStage then
		if not Season1_6MarketView.NewStageTagPos then
			local targetStageTagPos = Season1_6MarketView.NomalStageTagPos

			recthelper.setAnchor(self._gocenter.transform, targetStageTagPos.x, targetStageTagPos.y)
			self._simagestageicon:LoadImage(SeasonViewHelper.getSeasonIcon(string.format("icon/a_chatu_%s.png", episodeCo.stagePicture)))
			gohelper.setActive(self._gorewarditem, false)

			local rewards = DungeonModel.instance:getEpisodeFirstBonus(episodeCo.episodeId)

			for i = 2, math.max(#self._rewardItems - 1, #rewards) + 1 do
				if not self._rewardItems[i] then
					local item = self:createRewardItem(i)

					self:refreshRewardItem(self._rewardItems[i], rewards[i - 1])
				end
			end

			self:refreshEquipCardItem()

			self._btnlast.button.interactable = self._layer > 1
			self._btnnext.button.interactable = self._layer < Activity104Model.instance:getAct104CurLayer()
		end
	end
end

function Season1_6MarketView:refreshEquipCardItem()
	self._rewardItems[1] = self._rewardItems[1] or self:createRewardItem(1)

	local episodeCo = SeasonConfig.instance:getSeasonEpisodeCo(Activity104Model.instance:getCurSeasonId(), self._layer)

	gohelper.setActive(self._rewardItems[1].go, episodeCo.firstPassEquipId > 0)

	if episodeCo.firstPassEquipId > 0 then
		local hasGetReward = self._layer < Activity104Model.instance:getAct104CurLayer() or Activity104Model.instance:getEpisodeState(self._layer) > 0

		if not self._rewardItems[1].itemIcon then
			self._rewardItems[1].itemIcon = Season1_6CelebrityCardItem.New()

			self._rewardItems[1].itemIcon:setColorDark(hasGetReward)
			self._rewardItems[1].itemIcon:init(self._rewardItems[1].cardParent, episodeCo.firstPassEquipId)
		else
			self._rewardItems[1].itemIcon:setColorDark(hasGetReward)
			self._rewardItems[1].itemIcon:reset(episodeCo.firstPassEquipId)
		end

		gohelper.setActive(self._rewardItems[1].cardParent, true)
		gohelper.setActive(self._rewardItems[1].itemParent, false)
		gohelper.setActive(self._rewardItems[1].receive, hasGetReward)
	end
end

function Season1_6MarketView:createRewardItem(index)
	local item = self:getUserDataTb_()
	local itemGo = gohelper.cloneInPlace(self._gorewarditem, "reward_" .. tostring(index))

	item.go = itemGo
	item.itemParent = gohelper.findChild(itemGo, "go_prop")
	item.cardParent = gohelper.findChild(itemGo, "go_card")
	item.receive = gohelper.findChild(itemGo, "go_receive")
	self._rewardItems[index] = item

	return item
end

function Season1_6MarketView:refreshRewardItem(item, itemInfo)
	if not itemInfo or not next(itemInfo) then
		gohelper.setActive(item.go, false)

		return
	end

	item.itemIcon = item.itemIcon or IconMgr.instance:getCommonPropItemIcon(item.itemParent)

	gohelper.setActive(item.cardParent, false)
	gohelper.setActive(item.itemParent, true)
	item.itemIcon:setMOValue(tonumber(itemInfo[1]), tonumber(itemInfo[2]), tonumber(itemInfo[3]), nil, true)
	item.itemIcon:isShowCount(tonumber(itemInfo[1]) ~= MaterialEnum.MaterialType.Hero)
	item.itemIcon:setCountFontSize(40)
	item.itemIcon:showStackableNum2()
	item.itemIcon:setHideLvAndBreakFlag(true)
	item.itemIcon:hideEquipLvAndBreak(true)
	gohelper.setActive(item.go, true)

	local hasGetReward = self._layer < Activity104Model.instance:getAct104CurLayer() or Activity104Model.instance:getEpisodeState(self._layer) > 0

	gohelper.setActive(item.receive, hasGetReward)

	local color = hasGetReward and "#7b7b7b" or "#ffffff"

	item.itemIcon:setItemColor(color)
end

function Season1_6MarketView:_setParts()
	local episodeCo = SeasonConfig.instance:getSeasonEpisodeCo(Activity104Model.instance:getCurSeasonId(), self._layer)

	self._txtenemylv.text = HeroConfig.instance:getCommonLevelDisplay(episodeCo.level)

	if self._layer < Activity104Model.instance:getAct104CurLayer() or self._layer >= Activity104Model.instance:getMaxLayer() then
		gohelper.setActive(self._gopart, false)
		gohelper.setActive(self._gopartempty, true)
		gohelper.setActive(self._gounlocktype1, false)
		gohelper.setActive(self._gounlocktype2, false)
		gohelper.setActive(self._gounlocktype3, false)
	else
		local isNewStage = Activity104Model.instance:isNextLayerNewStage(self._layer)

		gohelper.setActive(self._gostage, isNewStage)

		if isNewStage then
			local stage = Activity104Model.instance:getAct104CurStage()

			self:_showPartStageItem(stage + 1)
		end

		local newUnlocks = string.splitToNumber(episodeCo.unlockEquipIndex, "#")

		if #newUnlocks > 0 then
			gohelper.setActive(self._gounlocktype1, newUnlocks[1] < 5)
			gohelper.setActive(self._gounlocktype2, newUnlocks[1] > 4 and newUnlocks[1] < 9)
			gohelper.setActive(self._gounlocktype3, newUnlocks[1] == 9)
		else
			gohelper.setActive(self._gounlocktype1, false)
			gohelper.setActive(self._gounlocktype2, false)
			gohelper.setActive(self._gounlocktype3, false)
		end

		gohelper.setActive(self._gopart, isNewStage or #newUnlocks > 0)
		gohelper.setActive(self._gopartempty, not isNewStage and not (#newUnlocks > 0))
	end
end

Season1_6MarketView.UnLockStageItemAlpha = 1
Season1_6MarketView.LockStageItemAlpha = 0.3

function Season1_6MarketView:_showPartStageItem(stage)
	if stage < 7 then
		if self._partStageItems[7] then
			gohelper.setActive(self._partStageItems[7].go, false)
		end

		for i = 1, 6 do
			if not self._partStageItems[i] then
				local item = self:getUserDataTb_()
				local itemGo = gohelper.cloneInPlace(self._gostagelvlitem, "partstageitem_" .. tostring(i))

				item.go = itemGo
				item.current = gohelper.findChild(itemGo, "current")
				item.next = gohelper.findChild(itemGo, "next")
				item.canvasgroup = gohelper.onceAddComponent(itemGo, typeof(UnityEngine.CanvasGroup))
				self._partStageItems[i] = item
			end

			gohelper.setActive(self._partStageItems[i].go, true)
			gohelper.setActive(self._partStageItems[i].next, i == stage)
			gohelper.setActive(self._partStageItems[i].current, i ~= stage)

			if i <= stage then
				self._partStageItems[i].canvasgroup.alpha = Season1_6MarketView.UnLockStageItemAlpha or Season1_6MarketView.LockStageItemAlpha
			end
		end
	else
		for i = 1, 7 do
			if not self._partStageItems[i] then
				local item = self:getUserDataTb_()
				local itemGo = gohelper.cloneInPlace(self._gostagelvlitem, "partstageitem_" .. tostring(i))

				item.go = itemGo
				item.current = gohelper.findChild(itemGo, "current")
				item.next = gohelper.findChild(itemGo, "next")
				item.canvasgroup = gohelper.onceAddComponent(itemGo, typeof(UnityEngine.CanvasGroup))
				self._partStageItems[i] = item
			end

			gohelper.setActive(self._partStageItems[i].go, true)
			gohelper.setActive(self._partStageItems[i].next, i == stage)
			gohelper.setActive(self._partStageItems[i].current, i ~= stage)

			if i <= stage then
				self._partStageItems[i].canvasgroup.alpha = Season1_6MarketView.UnLockStageItemAlpha or Season1_6MarketView.LockStageItemAlpha
			end
		end
	end
end

function Season1_6MarketView:updateLeftDesc()
	self.descItems = self.descItems or {}

	local stage = Activity104Model.instance:getAct104CurStage(Activity104Model.instance:getCurSeasonId(), self._layer)
	local list = Activity104Model.instance:getStageEpisodeList(stage)

	self._curDescItem = nil

	for i = 1, math.max(#list, #self.descItems) do
		local item = self.descItems[i]

		if not item then
			item = self:createLeftDescItem(i)
			self.descItems[i] = item
		end

		self:updateLeftDescItem(item, list[i])
	end

	gohelper.setActive(self._goleftscrolltopmask, self._curDescItem.index ~= 1)
	TaskDispatcher.runDelay(self.moveToCurDesc, self, 0.02)
end

function Season1_6MarketView:createLeftDescItem(index)
	local item = self:getUserDataTb_()

	item.index = index
	item.go = gohelper.cloneInPlace(self._goDescItem, "desc" .. index)
	item.txt = gohelper.findChildTextMesh(item.go, "txt_desc")
	item.goLine = gohelper.findChild(item.go, "go_underline")

	return item
end

function Season1_6MarketView:updateLeftDescItem(item, co)
	if not co then
		gohelper.setActive(item.go, false)

		return
	end

	gohelper.setActive(item.go, true)

	local desc = co.desc

	if co.layer == self._layer then
		gohelper.setActive(item.goLine, true)

		item.txt.text = desc
		item.txt.lineSpacing = 49.75

		ZProj.UGUIHelper.SetColorAlpha(item.txt, 1)

		self._curDescItem = item
	else
		gohelper.setActive(item.goLine, false)

		item.txt.text = desc
		item.txt.lineSpacing = -12.5

		ZProj.UGUIHelper.SetColorAlpha(item.txt, 0.7)
	end
end

function Season1_6MarketView:moveToCurDesc()
	TaskDispatcher.cancelTask(self.moveToCurDesc, self)

	local curItem = self._curDescItem

	if not curItem then
		return
	end

	local txtHeight = curItem.txt.preferredHeight
	local scrollHeight = recthelper.getHeight(self._descScroll.transform)
	local maxPosY = math.max(0, recthelper.getHeight(self._descContent.transform) - scrollHeight)
	local offset = (scrollHeight - txtHeight) * 0.5
	local posY = recthelper.getAnchorY(curItem.go.transform) + offset

	recthelper.setAnchorY(self._descContent.transform, Mathf.Clamp(-posY, 0, -posY))
end

function Season1_6MarketView:onClose()
	TaskDispatcher.cancelTask(self._delayShowInfo, self)
end

function Season1_6MarketView:onDestroyView()
	TaskDispatcher.cancelTask(self._showInfoByOpen, self)
	TaskDispatcher.cancelTask(self.moveToCurDesc, self)
	self._simagestageicon:UnLoadImage()
	self._simagepage:UnLoadImage()
	self._simageuttu:UnLoadImage()
	self._simageleftinfobg:UnLoadImage()
	self._simagerightinfobg:UnLoadImage()

	if self._showLvItems then
		for _, v in pairs(self._showLvItems) do
			v:destroy()
		end

		self._showLvItems = nil
	end
end

return Season1_6MarketView
