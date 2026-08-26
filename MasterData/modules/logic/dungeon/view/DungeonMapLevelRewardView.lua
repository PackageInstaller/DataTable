-- chunkname: @modules/logic/dungeon/view/DungeonMapLevelRewardView.lua

module("modules.logic.dungeon.view.DungeonMapLevelRewardView", package.seeall)

local DungeonMapLevelRewardView = class("DungeonMapLevelRewardView", BaseView)

function DungeonMapLevelRewardView:onInitView()
	self._gorewarditem = gohelper.findChild(self.viewGO, "anim/right/reward_container/#go_rewarditem")
	self._gonoreward = gohelper.findChild(self.viewGO, "anim/right/reward_container/#go_noreward")
	self._goreward = gohelper.findChild(self.viewGO, "anim/right/reward_container/#go_reward")
	self._txtget = gohelper.findChildText(self.viewGO, "anim/right/reward_container/#go_reward/#txt_get")
	self._btnreward = gohelper.findChildButtonWithAudio(self.viewGO, "anim/right/reward_container/#go_reward/#btn_reward")
	self._gonormalrewardbg = gohelper.findChild(self.viewGO, "anim/right/reward_container/#go_reward/#go_normalrewardbg")
	self._gohardrewardbg = gohelper.findChild(self.viewGO, "anim/right/reward_container/#go_reward/#go_hardrewardbg")
	self._goTurnBackAddition = gohelper.findChild(self.viewGO, "anim/right/turnback_tips")
	self._txtTurnBackAdditionTips = gohelper.findChildText(self.viewGO, "anim/right/turnback_tips/#txt_des")
	self._goactreward = gohelper.findChild(self.viewGO, "anim/right/reward_container/#go_act_reward")
	self._goactnormalrewardbg = gohelper.findChild(self.viewGO, "anim/right/reward_container/#go_act_reward/#go_actnormalrewardbg")
	self._goacthardrewardbg = gohelper.findChild(self.viewGO, "anim/right/reward_container/#go_act_reward/#go_acthardrewardbg")
	self._txtacttime = gohelper.findChildText(self.viewGO, "anim/right/reward_container/#go_act_reward/#go_time/#txt_time")
	self._btnactreward = gohelper.findChildButtonWithAudio(self.viewGO, "anim/right/reward_container/#go_act_reward/#btn_actreward")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DungeonMapLevelRewardView:addEvents()
	self._btnreward:AddClickListener(self._btnrewardOnClick, self)
	self._btnactreward:AddClickListener(self._btnrewardOnClick, self)
end

function DungeonMapLevelRewardView:removeEvents()
	self._btnreward:RemoveClickListener()
	self._btnactreward:RemoveClickListener()
end

DungeonMapLevelRewardView.RewardType = {
	Common = 1,
	Act = 5,
	TurnBack = 4,
	OneStar = 2,
	SecondStar = 3
}
DungeonMapLevelRewardView.TagType = DungeonEnum.TagType

function DungeonMapLevelRewardView:_btnrewardOnClick()
	DungeonController.instance:openDungeonRewardView(self.episodeConfig)
end

function DungeonMapLevelRewardView:getRewardItem(parent)
	if #self.rewardItemPool > 0 then
		local rewardItem = table.remove(self.rewardItemPool)

		gohelper.setActive(rewardItem.go, true)
		rewardItem.transform:SetParent(parent)
		table.insert(self.rewardItemList, rewardItem)

		return rewardItem
	end

	local rewardItem = self:getUserDataTb_()

	rewardItem.go = gohelper.cloneInPlace(self._gorewarditem)
	rewardItem.transform = rewardItem.go:GetComponent(gohelper.Type_Transform)

	rewardItem.transform:SetParent(parent)

	rewardItem.txtcount = gohelper.findChildText(rewardItem.go, "countbg/count")
	rewardItem.gofirst = gohelper.findChild(rewardItem.go, "rare/#go_rare2")
	rewardItem.goadvance = gohelper.findChild(rewardItem.go, "rare/#go_rare3")
	rewardItem.gofirsthard = gohelper.findChild(rewardItem.go, "rare/#go_rare4")
	rewardItem.gonormal = gohelper.findChild(rewardItem.go, "rare/#go_rare1")
	rewardItem.txtnormal = gohelper.findChildText(rewardItem.go, "rare/#go_rare1/txt")
	rewardItem.goAddition = gohelper.findChild(rewardItem.go, "turnback")
	rewardItem.gocount = gohelper.findChild(rewardItem.go, "countbg")
	rewardItem.itemIconGO = gohelper.findChild(rewardItem.go, "itemicon")
	rewardItem.finished = gohelper.findChild(rewardItem.go, "finished")
	rewardItem.storyfirst = gohelper.findChild(rewardItem.go, "first")
	rewardItem.itemIcon = IconMgr.instance:getCommonPropItemIcon(rewardItem.itemIconGO)

	gohelper.setActive(rewardItem.go, true)
	table.insert(self.rewardItemList, rewardItem)

	return rewardItem
end

function DungeonMapLevelRewardView:recycleRewardItem(rewardItem)
	if not rewardItem then
		return
	end

	local rewardData = rewardItem.rewardData

	rewardItem.rewardData = nil

	if rewardData.recycleCallback then
		rewardData.recycleCallback(self, rewardItem)
	end

	gohelper.setActive(rewardItem.go, false)
	rewardItem.transform:SetParent(self.trRewardPool)
	table.insert(self.rewardItemPool, rewardItem)
end

function DungeonMapLevelRewardView:recycleAllRewardItem()
	for _, rewardItem in ipairs(self.rewardItemList) do
		self:recycleRewardItem(rewardItem)
	end

	tabletool.clear(self.rewardItemList)
end

function DungeonMapLevelRewardView:_editableInitView()
	self.trRewardPool = gohelper.findChildComponent(self.viewGO, "anim/right/reward_container/#go_rewardpool", gohelper.Type_Transform)
	self.trNormalReward = gohelper.findChildComponent(self.viewGO, "anim/right/reward_container/#go_reward/rewardList", gohelper.Type_Transform)
	self.trActReward = gohelper.findChildComponent(self.viewGO, "anim/right/reward_container/#go_act_reward/#go_act_rewardList", gohelper.Type_Transform)
	self.trActNormalReward = gohelper.findChildComponent(self.viewGO, "anim/right/reward_container/#go_act_reward/#go_normal_rewardList", gohelper.Type_Transform)

	gohelper.setActive(self._gorewarditem, false)

	self.rewardItemPool = {}
	self.rewardItemList = {}
	self.rewardList = {}
	self.actRewardList = {}

	gohelper.addUIClickAudio(self._btnreward.gameObject, AudioEnum.UI.Play_UI_General_OK)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.onRefreshActivityState, self)
	self.addEventCb(self, TurnbackController.instance, TurnbackEvent.RefreshView, self.refreshTurnBack, self)
	self.addEventCb(self, TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, self.onDailyRefresh, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.SwitchHardMode, self.onSwitchHardMode, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshDoubleDropInfo, self.refreshReward, self)
	self.addEventCb(self, Activity217Controller.instance, Activity217Event.OnInfoChanged, self.refreshReward, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
end

function DungeonMapLevelRewardView:_onCloseView(viewName)
	if viewName == ViewName.CommonPropView then
		self:delayRefreshReward()
	end
end

function DungeonMapLevelRewardView:onSwitchHardMode(param)
	if not param.episodeConfig then
		return
	end

	self.episodeConfig = param.episodeConfig

	if param.immediately then
		self.switchInit = true

		self:delayRefreshReward()
	else
		TaskDispatcher.cancelTask(self.delayRefreshReward, self)
		TaskDispatcher.runDelay(self.delayRefreshReward, self, 0.3)
	end
end

function DungeonMapLevelRewardView:delayRefreshReward()
	self:initData()
	self:refreshUI()
end

function DungeonMapLevelRewardView:initData()
	self.episodeId = self.episodeConfig.id
	self.chapterId = self.episodeConfig.chapterId
	self.chapterCo = DungeonConfig.instance:getChapterCO(self.chapterId)
	self.episodeInfo = DungeonModel.instance:getEpisodeInfo(self.episodeConfig.id)
	self.hardMode = self.chapterCo.type == DungeonEnum.ChapterType.Hard
	self.isFree = false

	if self.chapterCo.enterAfterFreeLimit > 0 then
		self.isFree = DungeonModel.instance:getChapterRemainingNum(self.chapterCo.type) > 0
	end

	self:updateActiveActId()
end

function DungeonMapLevelRewardView:updateActiveActId()
	self.activityId = 0
	self.dropCo = nil

	for _, co in ipairs(lua_activity155_drop.configList) do
		if self.chapterId == co.chapterId then
			local actId = co.activityId
			local status = ActivityHelper.getActivityStatus(actId, true)

			if status == ActivityEnum.ActivityStatus.Normal then
				self.activityId = actId
				self.dropCo = co

				break
			end
		end
	end

	self.showActReward = self.activityId ~= 0
end

function DungeonMapLevelRewardView:initEpisodeCo()
	self.episodeConfig = self.viewParam[1]

	local hard = self.viewParam[5]
	local chapterType

	if hard == nil then
		local lastMode, episodeId = DungeonModel.instance:getLastSelectMode()

		if episodeId == self.episodeConfig.id then
			chapterType = lastMode

			local chainEpisode = self.episodeConfig.chainEpisode

			if lastMode == DungeonEnum.ChapterType.Simple and chainEpisode ~= 0 then
				self.episodeConfig = DungeonConfig.instance:getEpisodeCO(chainEpisode)
			end
		end
	elseif hard then
		self.episodeConfig = DungeonConfig.instance:getHardEpisode(self.episodeConfig.id)
	end
end

function DungeonMapLevelRewardView:onUpdateParam()
	if self.switchInit then
		self.switchInit = false

		return
	end

	self:initEpisodeCo()
	self:initData()
	self:refreshUI()
end

function DungeonMapLevelRewardView:onOpen()
	if self.switchInit then
		self.switchInit = false

		return
	end

	self:initEpisodeCo()
	self:initData()
	self:refreshUI()
end

function DungeonMapLevelRewardView:refreshUI()
	self:refreshTxt()
	self:refreshTurnBackAdditionTips()
	self:refreshBG()
	self:refreshReward()
end

function DungeonMapLevelRewardView:refreshBG()
	gohelper.setActive(self._gonormalrewardbg, not self.hardMode)
	gohelper.setActive(self._gohardrewardbg, self.hardMode)
	gohelper.setActive(self._goactnormalrewardbg, not self.hardMode)
	gohelper.setActive(self._goacthardrewardbg, self.hardMode)
end

function DungeonMapLevelRewardView:refreshTxt()
	self._txtget.text = luaLang(self.isFree and "p_dungeonmaplevelview_specialdrop" or "p_dungeonmaplevelview_get")
end

function DungeonMapLevelRewardView:refreshTurnBackAdditionTips()
	local isMultiDrop, limit, total = Activity217Model.instance:getShowTripleByChapter(self.chapterCo.id)
	local multiDropShow = isMultiDrop and limit > 0

	if multiDropShow then
		gohelper.setActive(self._goTurnBackAddition, false)

		return
	end

	local isShowAddition = TurnbackModel.instance:isShowTurnBackAddition(self.episodeConfig.chapterId)

	if isShowAddition then
		local remainCount, totalCount = TurnbackModel.instance:getAdditionCountInfo()
		local strCount = string.format("%s/%s", remainCount, totalCount)

		self._txtTurnBackAdditionTips.text = formatLuaLang("turnback_addition_times", strCount)

		local operationTr = gohelper.findChildComponent(self.viewGO, "anim/right/#go_operation", gohelper.Type_Transform)

		recthelper.setAnchorY(operationTr, -20)
	end

	gohelper.setActive(self._goTurnBackAddition, isShowAddition)
end

function DungeonMapLevelRewardView:refreshReward()
	self:recycleAllRewardItem()
	tabletool.clear(self.rewardList)
	tabletool.clear(self.actRewardList)
	gohelper.setActive(self._gonoreward, false)
	gohelper.setActive(self._goreward, false)
	gohelper.setActive(self._goactreward, false)

	if self.showActReward and not self.isFree and self.episodeConfig and self.episodeConfig.type ~= DungeonEnum.EpisodeType.Story then
		self:refreshActReward()
	else
		self:refreshNormalReward()
	end
end

function DungeonMapLevelRewardView:refreshActReward()
	self:refreshActTime()
	self:addFirstReward()
	self:addAdvanceReward()
	self:addNewReward()
	self:addDoubleDropReward()
	self:addFreeReward()
	self:addCommonRewardList()
	self:addActReward()

	local hasReward = #self.rewardList > 0 or #self.actRewardList > 0

	gohelper.setActive(self._gonoreward, not hasReward)
	gohelper.setActive(self._goactreward, hasReward)

	if hasReward then
		for i = 1, 3 do
			self:refreshOneReward(self.rewardList[i], self.trActNormalReward)
		end

		for i = 1, 3 do
			self:refreshOneReward(self.actRewardList[i], self.trActReward)
		end
	end
end

function DungeonMapLevelRewardView:refreshActTime()
	local actInfo = ActivityModel.instance:getActMO(self.activityId)

	if actInfo then
		local offset = actInfo:getRealEndTimeStamp() - ServerTime.now()
		local time, timeFormat = TimeUtil.secondToRoughTime(offset, true)

		self._txtacttime.text = string.format(time .. timeFormat)
	end
end

function DungeonMapLevelRewardView:refreshNormalReward()
	if self.chapterCo.type == DungeonEnum.ChapterType.Simple or self.episodeConfig.type == DungeonEnum.EpisodeType.Story then
		self:addFirstReward(true)
	else
		self:addFirstReward()
	end

	self:addAdvanceReward()
	self:addNewReward()
	self:addDoubleDropReward()
	self:addFreeReward()
	self:addCommonRewardList()

	local hasReward = #self.rewardList > 0

	gohelper.setActive(self._gonoreward, not hasReward)
	gohelper.setActive(self._goreward, hasReward)

	if hasReward then
		for i = 1, 3 do
			self:refreshOneReward(self.rewardList[i], self.trNormalReward)
		end

		if self.episodeConfig.type == DungeonEnum.EpisodeType.Story or self.chapterCo.type == DungeonEnum.ChapterType.Simple then
			for _, rewardItem in ipairs(self.rewardItemList) do
				local isFinish = self.episodeInfo.star ~= DungeonEnum.StarType.None

				gohelper.setActive(rewardItem.finished, isFinish)
			end
		end
	end
end

function DungeonMapLevelRewardView:_addReward(itemType, id, quantity, tagType, showQuantity, rewardType)
	local reward = {}

	reward.itemType = itemType
	reward.id = id
	reward.quantity = quantity
	reward.tagType = tagType
	reward.showQuantity = showQuantity
	reward.rewardType = rewardType

	table.insert(self.rewardList, reward)
end

function DungeonMapLevelRewardView:_addActReward(itemType, id, quantity, tagType, showQuantity, customBg, customRefreshCallback, recycleCallback)
	local reward = {}

	reward.itemType = itemType
	reward.id = id
	reward.quantity = quantity
	reward.tagType = tagType
	reward.showQuantity = showQuantity
	reward.rewardType = DungeonMapLevelRewardView.RewardType.Act
	reward.customBg = customBg
	reward.customRefreshCallback = customRefreshCallback
	reward.recycleCallback = recycleCallback

	table.insert(self.actRewardList, reward)
end

function DungeonMapLevelRewardView:addActReward()
	local dropCo = self.dropCo
	local currencyReward = dropCo.itemId1

	if not string.nilorempty(currencyReward) then
		local array = string.splitToNumber(currencyReward, "#")
		local ratio = CommonConfig.instance:getAct155CurrencyRatio()
		local cost = string.splitToNumber(self.episodeConfig.cost, "#")[3]
		local quantity = ratio * cost

		self:_addActReward(array[1], array[2], quantity, array[3], true, nil, self.onRefreshV1a7Currency, self.onRecycleV1a7Currency)
	end

	local powerReward = dropCo.itemId2

	if not string.nilorempty(powerReward) then
		local array = string.splitToNumber(powerReward, "#")

		self:_addActReward(array[1], array[2], 0, array[3], false, nil, self.onRefreshV1a7Power, self.onRecycleV1a7Currency)
	end

	local act158Status = ActivityHelper.getActivityStatus(VersionActivity1_9Enum.ActivityId.ToughBattle)

	if (act158Status == ActivityEnum.ActivityStatus.Normal or act158Status == ActivityEnum.ActivityStatus.NotUnlock) and ToughBattleModel.instance:isDropActItem() then
		self:_addActReward(MaterialEnum.MaterialType.Currency, CurrencyEnum.CurrencyType.V1a9ToughEnter, 0, DungeonMapLevelRewardView.TagType.Act, false, nil, self.onRefreshV1a7Power, self.onRecycleV1a7Currency)
	end
end

function DungeonMapLevelRewardView:addAdvanceReward()
	if self.episodeInfo.star < DungeonEnum.StarType.Advanced then
		for _, reward in ipairs(DungeonModel.instance:getEpisodeAdvancedBonus(self.episodeId)) do
			self:_addReward(reward[1], reward[2], reward[3], DungeonMapLevelRewardView.TagType.SecondPass, true, DungeonMapLevelRewardView.RewardType.SecondStar)
		end
	end
end

function DungeonMapLevelRewardView:addFirstReward(direct)
	if self.episodeInfo.star == DungeonEnum.StarType.None or direct then
		for _, reward in ipairs(DungeonModel.instance:getEpisodeFirstBonus(self.episodeId)) do
			local isShowReward = true

			if tonumber(reward[1]) == MaterialEnum.MaterialType.Currency and tonumber(reward[2]) == CurrencyEnum.CurrencyType.V1a9ToughEnter then
				local act158Status = ActivityHelper.getActivityStatus(VersionActivity1_9Enum.ActivityId.ToughBattle)

				if act158Status ~= ActivityEnum.ActivityStatus.Normal and act158Status ~= ActivityEnum.ActivityStatus.NotUnlock then
					isShowReward = false
				end
			end

			if isShowReward then
				self:_addReward(reward[1], reward[2], reward[3], (direct or nil) and DungeonMapLevelRewardView.TagType.StoryFirst, true, DungeonMapLevelRewardView.RewardType.OneStar)
			end
		end
	end
end

function DungeonMapLevelRewardView:addFreeReward()
	if self.isFree then
		for _, reward in ipairs(DungeonModel.instance:getEpisodeFreeDisplayList(self.episodeId)) do
			self:_addReward(reward[1], reward[2], 0, reward[3], false, DungeonMapLevelRewardView.RewardType.Common)
		end
	end
end

function DungeonMapLevelRewardView:addDoubleDropReward()
	local isMultiDrop, limit, total, magnification = Activity217Model.instance:getShowTripleByChapter(self.chapterCo.id)
	local episodeShow = DoubleDropModel.instance:isShowDoubleByEpisode(self.episodeId, true)
	local multiDropShow = isMultiDrop and limit > 0

	if not episodeShow and not multiDropShow then
		return
	end

	local commonRewardList
	local isResourceType = self.chapterCo.type == DungeonEnum.ChapterType.Gold or self.chapterCo.type == DungeonEnum.ChapterType.Exp

	if isResourceType then
		commonRewardList = DungeonModel.instance:getEpisodeBonus(self.episodeId)

		for _, reward in ipairs(commonRewardList) do
			if multiDropShow then
				if not ((magnification - 1) * reward[3]) then
					local count = reward[3]

					self:_addReward(reward[1], reward[2], count, DungeonMapLevelRewardView.TagType.TurnBack, true, DungeonMapLevelRewardView.RewardType.TurnBack)
				end
			end
		end
	else
		commonRewardList = DungeonModel.instance:getEpisodeRewardDisplayList(self.episodeId)

		for _, reward in ipairs(commonRewardList) do
			self:_addReward(reward[1], reward[2], 0, DungeonMapLevelRewardView.TagType.TurnBack, false, DungeonMapLevelRewardView.RewardType.TurnBack)
		end
	end

	if multiDropShow then
		local bonusCo = Activity217Config.instance:getBonusCO(self.episodeId)

		if bonusCo then
			local extraBonusStr = bonusCo.extraBonus
			local extraBonus = GameUtil.splitString2(extraBonusStr, true)

			if extraBonus then
				for _, reward in ipairs(extraBonus) do
					self:_addReward(reward[1], reward[2], reward[3], DungeonMapLevelRewardView.TagType.TurnBack, false, DungeonMapLevelRewardView.RewardType.TurnBack)
				end
			end

			return
		end
	end

	local actId = DoubleDropModel.instance:getActId()
	local extraBonusStr = DoubleDropConfig.instance:getAct153ExtraBonus(actId, self.episodeId)
	local extraBonus = GameUtil.splitString2(extraBonusStr, true)

	if extraBonus then
		for _, reward in ipairs(extraBonus) do
			self:_addReward(reward[1], reward[2], reward[3], DungeonMapLevelRewardView.TagType.TurnBack, false, DungeonMapLevelRewardView.RewardType.TurnBack)
		end
	end
end

function DungeonMapLevelRewardView:addCommonRewardList()
	local commonRewardList
	local isResourceType = self.chapterCo.type == DungeonEnum.ChapterType.Gold or self.chapterCo.type == DungeonEnum.ChapterType.Exp

	if isResourceType then
		commonRewardList = DungeonModel.instance:getEpisodeBonus(self.episodeId)

		for _, reward in ipairs(commonRewardList) do
			self:_addReward(reward[1], reward[2], reward[3], DungeonMapLevelRewardView.TagType.None, true, DungeonMapLevelRewardView.RewardType.Common)
		end
	else
		commonRewardList = DungeonModel.instance:getEpisodeRewardDisplayList(self.episodeId)

		for _, reward in ipairs(commonRewardList) do
			self:_addReward(reward[1], reward[2], 0, reward[3], false, DungeonMapLevelRewardView.RewardType.Common)
		end
	end

	local isMultiDrop, limit, total = Activity217Model.instance:getShowTripleByChapter(self.chapterCo.id)
	local multiDropShow = isMultiDrop and limit > 0
	local isShowAddition = TurnbackModel.instance:isShowTurnBackAddition(self.chapterId)

	if not multiDropShow and isShowAddition then
		local additionRewardList = TurnbackModel.instance:getAdditionRewardList(commonRewardList)

		for _, reward in ipairs(additionRewardList) do
			self:_addReward(reward[1], reward[2], reward[3], DungeonMapLevelRewardView.TagType.TurnBack, true, DungeonMapLevelRewardView.RewardType.TurnBack)
		end
	end
end

function DungeonMapLevelRewardView:addNewReward()
	local commonRewardList = DungeonModel.instance:getEpisodeReward(self.episodeId)

	for _, reward in ipairs(commonRewardList) do
		self:_addReward(reward[1], reward[2], 0, reward.tagType, false, DungeonMapLevelRewardView.RewardType.Common)
	end
end

function DungeonMapLevelRewardView:setItemIcon(itemIcon)
	itemIcon:isShowAddition(false)
	itemIcon:isShowEquipAndItemCount(false)
	itemIcon:setHideLvAndBreakFlag(true)
	itemIcon:setShowCountFlag(false)
	itemIcon:hideEquipLvAndBreak(true)
end

function DungeonMapLevelRewardView:refreshOneReward(rewardData, parent)
	if not rewardData then
		return
	end

	local rewardItem = self:getRewardItem(parent)

	rewardItem.rewardData = rewardData

	rewardItem.itemIcon:setMOValue(rewardData.itemType, rewardData.id, rewardData.quantity, nil, true)

	if rewardData.customRefreshCallback then
		rewardData.customRefreshCallback(self, rewardItem)
	end

	self:setItemIcon(rewardItem.itemIcon)
	self:refreshTag(rewardItem)
	self:refreshCount(rewardItem)
	self:refreshCustomBg(rewardItem)

	return rewardItem
end

function DungeonMapLevelRewardView:refreshTag(rewardItem)
	self:clearRewardTag(rewardItem)

	local rewardData = rewardItem.rewardData
	local tagType = rewardData.tagType

	if tagType == DungeonMapLevelRewardView.TagType.None then
		return
	end

	if tagType == DungeonMapLevelRewardView.TagType.SecondPass then
		gohelper.setActive(rewardItem.goadvance, true)
	elseif tagType == DungeonMapLevelRewardView.TagType.FirstPass then
		gohelper.setActive(rewardItem.gofirst, not self.hardMode)
		gohelper.setActive(rewardItem.gofirsthard, self.hardMode)
	elseif tagType == DungeonMapLevelRewardView.TagType.TurnBack then
		gohelper.setActive(rewardItem.goAddition, true)
	elseif tagType == DungeonMapLevelRewardView.TagType.StoryFirst then
		gohelper.setActive(rewardItem.storyfirst, true)
	else
		gohelper.setActive(rewardItem.gonormal, true)

		rewardItem.txtnormal.text = luaLang("dungeon_prob_flag" .. tagType)
	end
end

function DungeonMapLevelRewardView:clearRewardTag(rewardItem)
	gohelper.setActive(rewardItem.gofirst, false)
	gohelper.setActive(rewardItem.goadvance, false)
	gohelper.setActive(rewardItem.gofirsthard, false)
	gohelper.setActive(rewardItem.gonormal, false)
	gohelper.setActive(rewardItem.goAddition, false)
	gohelper.setActive(rewardItem.finished, false)
	gohelper.setActive(rewardItem.storyfirst, false)
end

function DungeonMapLevelRewardView:refreshCount(rewardItem)
	local rewardData = rewardItem.rewardData
	local showQuantity = rewardData.showQuantity

	gohelper.setActive(rewardItem.gocount, showQuantity)

	if showQuantity then
		if rewardItem.itemIcon:isEquipIcon() then
			rewardItem.itemIcon:ShowEquipCount(rewardItem.gocount, rewardItem.txtcount)
		else
			rewardItem.itemIcon:showStackableNum2(rewardItem.gocount, rewardItem.txtcount)
		end
	end
end

function DungeonMapLevelRewardView:refreshCustomBg(rewardItem)
	local rewardData = rewardItem.rewardData
	local customBg = rewardData.customBg

	if string.nilorempty(customBg) then
		return
	end

	rewardItem.itemIcon:setIconBg(customBg)
end

function DungeonMapLevelRewardView:onRefreshV1a7Power(rewardItem)
	local itemIcon = rewardItem.itemIcon._itemIcon

	itemIcon:setCanShowDeadLine(false)

	itemIcon._gov1a7act = itemIcon._gov1a7act or gohelper.findChild(itemIcon.go, "act")

	gohelper.setActive(itemIcon._gov1a7act, true)
end

function DungeonMapLevelRewardView:onRefreshV1a7Currency(rewardItem)
	local itemIcon = rewardItem.itemIcon._itemIcon

	itemIcon._gov1a7act = itemIcon._gov1a7act or gohelper.findChild(itemIcon.go, "act")

	gohelper.setActive(itemIcon._gov1a7act, true)
end

function DungeonMapLevelRewardView:onRecycleV1a7Currency(rewardItem)
	local itemIcon = rewardItem.itemIcon._itemIcon

	gohelper.setActive(itemIcon._gov1a7act, false)
end

function DungeonMapLevelRewardView:onClose()
	self.switchInit = false

	TaskDispatcher.cancelTask(self.delayRefreshReward, self)
end

function DungeonMapLevelRewardView:onDestroyView()
	return
end

function DungeonMapLevelRewardView:onRefreshActivityState(actId)
	if actId ~= self.activityId then
		return
	end

	self:updateActiveActId()
	self:refreshReward()
end

function DungeonMapLevelRewardView:onDailyRefresh()
	self:refreshTurnBack()
end

function DungeonMapLevelRewardView:refreshTurnBack()
	self:refreshTurnBackAdditionTips()
	self:refreshReward()
end

return DungeonMapLevelRewardView
