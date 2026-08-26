-- chunkname: @modules/logic/season/view/SeasonMarketView.lua

module("modules.logic.season.view.SeasonMarketView", package.seeall)

local SeasonMarketView = class("SeasonMarketView", BaseView)

function SeasonMarketView:onInitView()
	self._goinfo = gohelper.findChild(self.viewGO, "#go_info")
	self._simagebg1 = gohelper.findChildSingleImage(self.viewGO, "#go_info/bg/#simage_bg1")
	self._simagedecorate1 = gohelper.findChildSingleImage(self.viewGO, "#go_info/right/#simage_decorate1")
	self._simagedecorate2 = gohelper.findChildSingleImage(self.viewGO, "#go_info/right/#simage_decorate2")
	self._simageuttu = gohelper.findChildSingleImage(self.viewGO, "#go_level/bottom/#simage_uttu")
	self._animatorLeft = gohelper.findChildComponent(self.viewGO, "#go_info/left", typeof(UnityEngine.Animator))
	self._txtlevelnamecn = gohelper.findChildText(self.viewGO, "#go_info/left/#txt_levelnamecn")
	self._gostageinfoitem1 = gohelper.findChild(self.viewGO, "#go_info/left/#txt_levelnamecn/stage/#go_stageinfoitem1")
	self._gostageinfoitem2 = gohelper.findChild(self.viewGO, "#go_info/left/#txt_levelnamecn/stage/#go_stageinfoitem2")
	self._gostageinfoitem3 = gohelper.findChild(self.viewGO, "#go_info/left/#txt_levelnamecn/stage/#go_stageinfoitem3")
	self._gostageinfoitem4 = gohelper.findChild(self.viewGO, "#go_info/left/#txt_levelnamecn/stage/#go_stageinfoitem4")
	self._gostageinfoitem5 = gohelper.findChild(self.viewGO, "#go_info/left/#txt_levelnamecn/stage/#go_stageinfoitem5")
	self._gostageinfoitem6 = gohelper.findChild(self.viewGO, "#go_info/left/#txt_levelnamecn/stage/#go_stageinfoitem6")
	self._gostageinfoitem7 = gohelper.findChild(self.viewGO, "#go_info/left/#txt_levelnamecn/stage/#go_stageinfoitem7")
	self._txtcurindex = gohelper.findChildText(self.viewGO, "#go_info/left/position/center/#txt_curindex")
	self._txtmaxindex = gohelper.findChildText(self.viewGO, "#go_info/left/position/center/#txt_maxindex")
	self._btnlast = gohelper.findChildButtonWithAudio(self.viewGO, "#go_info/left/position/#btn_last")
	self._btnnext = gohelper.findChildButtonWithAudio(self.viewGO, "#go_info/left/position/#btn_next")
	self._txtdesc = gohelper.findChildText(self.viewGO, "#go_info/left/#txt_desc")
	self._txtenemylv = gohelper.findChildText(self.viewGO, "#go_info/left/enemylv/#txt_enemylv")
	self._btnstart = gohelper.findChildButtonWithAudio(self.viewGO, "#go_info/left/btns/#btn_start")
	self._btnReplay = gohelper.findChildButtonWithAudio(self.viewGO, "#go_info/left/btns/#btn_storyreplay")
	self._gopart = gohelper.findChild(self.viewGO, "#go_info/left/layout/#go_part")
	self._gostage = gohelper.findChild(self.viewGO, "#go_info/left/layout/#go_part/#go_stage")
	self._gostagelvlitem = gohelper.findChild(self.viewGO, "#go_info/left/layout/#go_part/#go_stage/list/#go_stagelvlitem")
	self._gounlocktype1 = gohelper.findChild(self.viewGO, "#go_info/left/layout/root/mask/#scroll_rewards/Viewport/Content/#go_unlocktype1")
	self._gounlocktype2 = gohelper.findChild(self.viewGO, "#go_info/left/layout/root/mask/#scroll_rewards/Viewport/Content/#go_unlocktype2")
	self._gounlocktype3 = gohelper.findChild(self.viewGO, "#go_info/left/layout/root/mask/#scroll_rewards/Viewport/Content/#go_unlocktype3")
	self._scrollrewards = gohelper.findChildScrollRect(self.viewGO, "#go_info/left/layout/root/mask/#scroll_rewards")
	self._gorewarditem = gohelper.findChild(self.viewGO, "#go_info/left/layout/root/mask/#scroll_rewards/Viewport/Content/#go_rewarditem")
	self._godecorate = gohelper.findChild(self.viewGO, "#go_info/left/decorate")
	self._golevel = gohelper.findChild(self.viewGO, "#go_level")
	self._anilevel = self._golevel:GetComponent(typeof(UnityEngine.Animator))
	self._simagelvbg = gohelper.findChildSingleImage(self.viewGO, "#go_level/#simage_lvbg")
	self._simageleftinfobg = gohelper.findChildSingleImage(self.viewGO, "#go_level/#simage_leftinfobg")
	self._simagerightinfobg = gohelper.findChildSingleImage(self.viewGO, "#go_level/#simage_rightinfobg")
	self._goScrollRoot = gohelper.findChild(self.viewGO, "#go_level/#go_scrollRoot")
	self._goscrolllv = gohelper.findChild(self.viewGO, "#go_level/#go_scrollRoot/#go_scrolllv")
	self._gofront = gohelper.findChild(self.viewGO, "#go_level/#go_scrollRoot/#go_scrolllv/Viewport/Content/#go_front")
	self._golvitem = gohelper.findChild(self.viewGO, "#go_level/#go_scrollRoot/#go_scrolllv/Viewport/Content/#go_lvitem")
	self._goline = gohelper.findChild(self.viewGO, "#go_level/#go_scrollRoot/#go_scrolllv/Viewport/Content/#go_lvitem/#go_line")
	self._goselected = gohelper.findChild(self.viewGO, "#go_level/#go_scrollRoot/#go_scrolllv/Viewport/Content/#go_lvitem/#go_selected")
	self._txtselectindex = gohelper.findChildText(self.viewGO, "#go_level/#go_scrollRoot/#go_scrolllv/Viewport/Content/#go_lvitem/#go_selected/#txt_selectindex")
	self._gopass = gohelper.findChild(self.viewGO, "#go_level/#go_scrollRoot/#go_scrolllv/Viewport/Content/#go_lvitem/#go_pass")
	self._txtpassindex = gohelper.findChildText(self.viewGO, "#go_level/#go_scrollRoot/#go_scrolllv/Viewport/Content/#go_lvitem/#go_pass/#txt_passindex")
	self._gounpass = gohelper.findChild(self.viewGO, "#go_level/#go_scrollRoot/#go_scrolllv/Viewport/Content/#go_lvitem/#go_unpass")
	self._txtunpassindex = gohelper.findChildText(self.viewGO, "#go_level/#go_scrollRoot/#go_scrolllv/Viewport/Content/#go_lvitem/#go_unpass/#txt_unpassindex")
	self._gorear = gohelper.findChild(self.viewGO, "#go_level/#go_scrollRoot/#go_scrolllv/Viewport/Content/#go_rear")
	self._txtcurlevelnamecn = gohelper.findChildText(self.viewGO, "#go_level/center/#txt_curlevelnamecn")
	self._gostagelvitem1 = gohelper.findChild(self.viewGO, "#go_level/center/#txt_curlevelnamecn/stage/#go_stagelvitem1")
	self._gostagelvitem2 = gohelper.findChild(self.viewGO, "#go_level/center/#txt_curlevelnamecn/stage/#go_stagelvitem2")
	self._gostagelvitem3 = gohelper.findChild(self.viewGO, "#go_level/center/#txt_curlevelnamecn/stage/#go_stagelvitem3")
	self._gostagelvitem4 = gohelper.findChild(self.viewGO, "#go_level/center/#txt_curlevelnamecn/stage/#go_stagelvitem4")
	self._gostagelvitem5 = gohelper.findChild(self.viewGO, "#go_level/center/#txt_curlevelnamecn/stage/#go_stagelvitem5")
	self._gostagelvitem6 = gohelper.findChild(self.viewGO, "#go_level/center/#txt_curlevelnamecn/stage/#go_stagelvitem6")
	self._gostagelvitem7 = gohelper.findChild(self.viewGO, "#go_level/center/#txt_curlevelnamecn/stage/#go_stagelvitem7")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SeasonMarketView:addEvents()
	self._btnlast:AddClickListener(self._btnlastOnClick, self)
	self._btnnext:AddClickListener(self._btnnextOnClick, self)
	self._btnstart:AddClickListener(self._btnstartOnClick, self)
	self._btnReplay:AddClickListener(self._btnreplayOnClick, self)
	self.addEventCb(self, Activity104Controller.instance, Activity104Event.StartAct104BattleReply, self._onBattleReply, self)
end

function SeasonMarketView:removeEvents()
	self._btnlast:RemoveClickListener()
	self._btnnext:RemoveClickListener()
	self._btnstart:RemoveClickListener()
	self._btnReplay:RemoveClickListener()
	self.removeEventCb(self, Activity104Controller.instance, Activity104Event.StartAct104BattleReply, self._onBattleReply, self)
end

function SeasonMarketView:_onBattleReply(msg)
	Activity104Model.instance:onStartAct104BattleReply(msg)
end

function SeasonMarketView:_btnlastOnClick()
	if self._layer < 2 then
		return
	end

	self._animatorLeft:Play(UIAnimationName.Switch, 0, 0)

	self._layer = self._layer - 1

	TaskDispatcher.cancelTask(self._delayShowInfo, self)
	TaskDispatcher.runDelay(self._delayShowInfo, self, 0.2)
end

function SeasonMarketView:_btnnextOnClick()
	local curLayer = Activity104Model.instance:getAct104CurLayer()

	if curLayer <= self._layer then
		return
	end

	self._animatorLeft:Play(UIAnimationName.Switch, 0, 0)

	self._layer = self._layer + 1

	TaskDispatcher.cancelTask(self._delayShowInfo, self)
	TaskDispatcher.runDelay(self._delayShowInfo, self, 0.2)
end

function SeasonMarketView:_delayShowInfo()
	self:_showInfo()
	self:_setStages()
end

function SeasonMarketView:_btnstartOnClick()
	local actId = ActivityEnum.Activity.Season
	local episodeId = SeasonConfig.instance:getSeasonEpisodeCo(actId, self._layer).episodeId

	Activity104Rpc.instance:sendBeforeStartAct104BattleRequest(actId, self._layer, episodeId)
end

function SeasonMarketView:_btnreplayOnClick()
	local actId = ActivityEnum.Activity.Season
	local co = SeasonConfig.instance:getSeasonEpisodeCo(actId, self._layer)

	if not co or co.afterStoryId == 0 then
		return
	end

	StoryController.instance:playStory(co.afterStoryId)
end

function SeasonMarketView:_editableInitView()
	self._simagebg1:LoadImage(ResUrl.getSeasonIcon("full/bgyahei.png"))
	self._simagedecorate1:LoadImage(ResUrl.getSeasonIcon("img_circle.png"))
	self._simageleftinfobg:LoadImage(ResUrl.getV1A2SeasonIcon("msg_xia.png"))
	self._simagerightinfobg:LoadImage(ResUrl.getV1A2SeasonIcon("msg_shang.png"))
end

function SeasonMarketView:onUpdateParam()
	return
end

function SeasonMarketView:onOpen()
	if self.viewParam then
		self._layer = self.viewParam.tarLayer or Activity104Model.instance:getAct104CurLayer()
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_chain)
	self:resetData()
	TaskDispatcher.cancelTask(self._showInfoByOpen, self)

	if self:isShowLevel() then
		gohelper.setActive(self._golevel, true)
		gohelper.setActive(self._goinfo, false)

		self._anilevel.speed = 0

		self:_setLevels()
		self:_setStages()
		Activity104Model.instance:setMakertLayerMark(ActivityEnum.Activity.Season, self._layer)
		TaskDispatcher.runDelay(self._showInfoByOpen, self, 2)
	else
		self:_showInfoByOpen()
	end
end

function SeasonMarketView:resetData()
	self._showLvItems = {}
	self._showStageItems = {}
	self._infoStageItems = {}
	self._equipReward = {}
	self._rewardItems = {}
	self._partStageItems = {}
end

function SeasonMarketView:isShowLevel()
	return Activity104Model.instance:isCanPlayMakertLayerAnim(ActivityEnum.Activity.Season, self._layer)
end

function SeasonMarketView:_showInfoByOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_chain_end)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_theft_open)
	gohelper.setActive(self._golevel, false)
	gohelper.setActive(self._goinfo, true)
	self:_showInfo()
	self:_setStages()
end

function SeasonMarketView:_setLevels()
	local episodeCo = SeasonConfig.instance:getSeasonEpisodeCo(ActivityEnum.Activity.Season, self._layer)

	self._txtcurlevelnamecn.text = episodeCo.stageName

	local maxLayer = Activity104Model.instance:getMaxLayer()
	local curLayer = Activity104Model.instance:getAct104CurLayer()

	if self._layer <= 4 then
		gohelper.setActive(self._gofront, true)
		gohelper.setActive(self._gorear, false)

		for i = 1, 6 do
			local child = gohelper.cloneInPlace(self._golvitem)

			self._showLvItems[i] = SeasonMarketShowLevelItem.New()

			self._showLvItems[i]:init(child, i, curLayer, maxLayer)
		end
	elseif self._layer >= maxLayer - 3 then
		gohelper.setActive(self._gofront, false)
		gohelper.setActive(self._gorear, true)

		for i = maxLayer - 5, maxLayer do
			local child = gohelper.cloneInPlace(self._golvitem)

			self._showLvItems[i] = SeasonMarketShowLevelItem.New()

			self._showLvItems[i]:init(child, i, curLayer, maxLayer)
		end
	else
		gohelper.setActive(self._gofront, false)
		gohelper.setActive(self._gorear, maxLayer - self._layer < 2)

		for i = self._layer - 4, self._layer + 4 do
			local child = gohelper.cloneInPlace(self._golvitem)

			self._showLvItems[i] = SeasonMarketShowLevelItem.New()

			self._showLvItems[i]:init(child, i, curLayer, maxLayer)
		end
	end

	TaskDispatcher.runDelay(self._delayShowItem, self, 0.1)
	gohelper.setAsLastSibling(self._gorear)
end

function SeasonMarketView:_delayShowItem()
	local posPointX, posPointY = transformhelper.getPos(self._showLvItems[self._layer].point.transform)

	transformhelper.setPos(self._goScrollRoot.transform, -posPointX, 0, 0)

	local posX = recthelper.getAnchorX(self._goScrollRoot.transform)

	recthelper.setAnchorX(self._goScrollRoot.transform, posX + 115.2)

	for _, v in pairs(self._showLvItems) do
		v:show()
	end

	self._anilevel.speed = 1
end

function SeasonMarketView:_setStages()
	local stage = SeasonConfig.instance:getSeasonEpisodeCo(ActivityEnum.Activity.Season, self._layer).stage

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

		local color = i == 7 and "#B83838" or "#FFFFFF"

		SLFramework.UGUI.GuiHelper.SetColor(infoLight, color)
		SLFramework.UGUI.GuiHelper.SetColor(lvLight, color)
	end
end

function SeasonMarketView:_showInfo()
	self:_setInfo()
	self:_setParts()
end

function SeasonMarketView:_setInfo()
	local episodeCo = SeasonConfig.instance:getSeasonEpisodeCo(ActivityEnum.Activity.Season, self._layer)

	if not episodeCo then
		return
	end

	local afterStory = Activity104Model.instance:isEpisodeAfterStory(ActivityEnum.Activity.Season, self._layer)

	gohelper.setActive(self._btnReplay, afterStory and episodeCo.afterStoryId ~= 0 or false)

	self._txtlevelnamecn.text = episodeCo.stageName
	self._txtdesc.text = DungeonConfig.instance:getEpisodeCO(episodeCo.episodeId).desc
	self._txtcurindex.text = string.format("%02d", self._layer)

	local maxLayer = Activity104Model.instance:getMaxLayer()

	self._txtmaxindex.text = string.format("%02d", maxLayer)

	local stage = Activity104Model.instance:getAct104CurStage()
	local isNewStage = Activity104Model.instance:isNextLayerNewStage(self._layer)

	gohelper.setActive(self._godecorate, isNewStage)
	self._simagedecorate2:LoadImage(ResUrl.getSeasonMarketIcon(episodeCo.stagePicture))
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

function SeasonMarketView:refreshEquipCardItem()
	self._rewardItems[1] = self._rewardItems[1] or self:createRewardItem(1)

	local episodeCo = SeasonConfig.instance:getSeasonEpisodeCo(ActivityEnum.Activity.Season, self._layer)

	gohelper.setActive(self._rewardItems[1].go, episodeCo.firstPassEquipId > 0)

	if episodeCo.firstPassEquipId > 0 then
		local hasGetReward = self._layer < Activity104Model.instance:getAct104CurLayer() or Activity104Model.instance:getEpisodeState(self._layer) > 0

		if not self._rewardItems[1].itemIcon then
			self._rewardItems[1].itemIcon = SeasonCelebrityCardItem.New()

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

function SeasonMarketView:createRewardItem(index)
	local item = self:getUserDataTb_()
	local itemGo = gohelper.cloneInPlace(self._gorewarditem, "reward_" .. tostring(index))

	item.go = itemGo
	item.itemParent = gohelper.findChild(itemGo, "go_prop")
	item.cardParent = gohelper.findChild(itemGo, "go_card")
	item.receive = gohelper.findChild(itemGo, "go_receive")
	self._rewardItems[index] = item

	return item
end

function SeasonMarketView:refreshRewardItem(item, itemInfo)
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

function SeasonMarketView:_setParts()
	local episodeCo = SeasonConfig.instance:getSeasonEpisodeCo(ActivityEnum.Activity.Season, self._layer)

	self._txtenemylv.text = HeroConfig.instance:getCommonLevelDisplay(episodeCo.level)

	if self._layer < Activity104Model.instance:getAct104CurLayer() or self._layer >= Activity104Model.instance:getMaxLayer() then
		gohelper.setActive(self._gopart, false)
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
		end

		gohelper.setActive(self._gopart, isNewStage or #newUnlocks > 0)
	end
end

SeasonMarketView.UnLockStageItemAlpha = 1
SeasonMarketView.LockStageItemAlpha = 0.3

function SeasonMarketView:_showPartStageItem(stage)
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
				self._partStageItems[i].canvasgroup.alpha = SeasonMarketView.UnLockStageItemAlpha or SeasonMarketView.LockStageItemAlpha
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
				self._partStageItems[i].canvasgroup.alpha = SeasonMarketView.UnLockStageItemAlpha or SeasonMarketView.LockStageItemAlpha
			end
		end
	end
end

function SeasonMarketView:onClose()
	TaskDispatcher.cancelTask(self._delayShowInfo, self)
end

function SeasonMarketView:onDestroyView()
	TaskDispatcher.cancelTask(self._showInfoByOpen, self)
	self._simagedecorate1:UnLoadImage()
	self._simagedecorate2:UnLoadImage()
	self._simageleftinfobg:UnLoadImage()
	self._simagerightinfobg:UnLoadImage()
	self._simagebg1:UnLoadImage()

	if self._showLvItems then
		for _, v in pairs(self._showLvItems) do
			v:destroy()
		end

		self._showLvItems = nil
	end
end

return SeasonMarketView
