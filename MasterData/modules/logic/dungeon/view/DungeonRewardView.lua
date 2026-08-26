-- chunkname: @modules/logic/dungeon/view/DungeonRewardView.lua

module("modules.logic.dungeon.view.DungeonRewardView", package.seeall)

local DungeonRewardView = class("DungeonRewardView", BaseView)

function DungeonRewardView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._goitem = gohelper.findChild(self.viewGO, "#go_item")
	self._scrollreward = gohelper.findChildScrollRect(self.viewGO, "#scroll_reward")
	self._goReward = gohelper.findChild(self.viewGO, "#scroll_reward/Viewport/reward")
	self._goreward1 = gohelper.findChild(self.viewGO, "#scroll_reward/Viewport/reward/#go_reward1")
	self._gonormalstars = gohelper.findChild(self.viewGO, "#scroll_reward/Viewport/reward/#go_reward1/title/#go_normalstars")
	self._gohardlstars = gohelper.findChild(self.viewGO, "#scroll_reward/Viewport/reward/#go_reward1/title/#go_hardlstars")
	self._gocontent1 = gohelper.findChild(self.viewGO, "#scroll_reward/Viewport/reward/#go_reward1/#go_content1")
	self._goreward2 = gohelper.findChild(self.viewGO, "#scroll_reward/Viewport/reward/#go_reward2")
	self._gocontent2 = gohelper.findChild(self.viewGO, "#scroll_reward/Viewport/reward/#go_reward2/#go_content2")
	self._goreward3 = gohelper.findChild(self.viewGO, "#scroll_reward/Viewport/reward/#go_reward3")
	self._txtspecialtitle = gohelper.findChildText(self.viewGO, "#scroll_reward/Viewport/reward/#go_reward3/title/#txt_specialtitle")
	self._gocontent3 = gohelper.findChild(self.viewGO, "#scroll_reward/Viewport/reward/#go_reward3/#go_content3")
	self._goreward0 = gohelper.findChild(self.viewGO, "#scroll_reward/Viewport/reward/#go_reward0")
	self._gocontent0 = gohelper.findChild(self.viewGO, "#scroll_reward/Viewport/reward/#go_reward0/#go_content0")
	self._goactreward = gohelper.findChild(self.viewGO, "#scroll_reward/Viewport/reward/#go_actreward")
	self._txtlimittitle = gohelper.findChildText(self.viewGO, "#scroll_reward/Viewport/reward/#go_actreward/title/#txt_timelimit")
	self._goactcontent = gohelper.findChild(self.viewGO, "#scroll_reward/Viewport/reward/#go_actreward/#go_actcontent")
	self._godoubledropreward = gohelper.findChild(self.viewGO, "#scroll_reward/Viewport/reward/#go_doubledropreward")
	self._godoubledropcontent = gohelper.findChild(self.viewGO, "#scroll_reward/Viewport/reward/#go_doubledropreward/#go_content3")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DungeonRewardView:addEvents()
	return
end

function DungeonRewardView:removeEvents()
	return
end

function DungeonRewardView:_btnbackOnClick()
	self:closeThis()
end

function DungeonRewardView:_btnmainOnClick()
	ViewMgr.instance:closeAllPopupViews()
end

function DungeonRewardView:_editableInitView()
	self._simageList = self:getUserDataTb_()

	local siblingIndex = self._goreward0.transform:GetSiblingIndex()

	self._additionReward = gohelper.clone(self._goreward0, self._goReward, "additionRward")

	self._additionReward.transform:SetSiblingIndex(siblingIndex)

	self._additionContent = gohelper.findChild(self._additionReward, "#go_content0")

	local txtAdditionTitle = gohelper.findChildText(self._additionReward, "title/text")

	txtAdditionTitle.text = formatLuaLang("turnback_addition", "")
end

function DungeonRewardView:showReward(container, rewardList, starValue, showNumber, showProb, showAddition, showGet, refreshOneCallback, callbackObj)
	local trans = container.transform
	local go = trans.parent.gameObject

	if not rewardList or #rewardList <= 0 then
		if trans.childCount <= 0 then
			gohelper.setActive(go, false)
		end

		return
	end

	gohelper.setActive(go, true)

	for i, reward in ipairs(rewardList) do
		local item = gohelper.clone(self._goitem, container)

		gohelper.setActive(item, true)

		local itemIconGO = gohelper.findChild(item, "itemicon")
		local itemIcon = IconMgr.instance:getCommonPropItemIcon(itemIconGO)
		local txtnumber = gohelper.findChildText(item.gameObject, "countbg/txtnumber")
		local countbg = gohelper.findChild(item.gameObject, "countbg")
		local probabilityFlag = reward[3]

		if not reward[4] then
			local materilType, materilId, quantity = reward[1], reward[2], reward[3]

			showNumber = showNumber or reward[4]

			if reward.tagType then
				probabilityFlag = reward.tagType
				showNumber = reward[3] > 0
			end

			itemIcon:setMOValue(materilType, materilId, reward[4], nil, true)
			itemIcon:isShowEquipAndItemCount(false)
			itemIcon:setShowCountFlag(false)
			itemIcon:hideEquipLvAndBreak(true)
			itemIcon:setHideLvAndBreakFlag(true)
			gohelper.setActive(countbg, showNumber)

			if showNumber then
				if itemIcon:isEquipIcon() then
					itemIcon:ShowEquipCount(countbg, txtnumber)
					itemIcon:hideEquipLvAndBreak(true)
					itemIcon:setHideLvAndBreakFlag(true)
				else
					itemIcon:showStackableNum2(countbg, txtnumber)
				end
			end

			if tonumber(materilType) == MaterialEnum.MaterialType.Item then
				local itemConfig = ItemModel.instance:getItemConfig(materilType, materilId)

				if itemConfig and (itemConfig.subType == ItemEnum.SubType.InsightItem or itemConfig.subType == ItemEnum.SubType.EquipBreak) then
					local txtrepertory = gohelper.findChildText(item.gameObject, "txt_repertory")

					gohelper.setActive(txtrepertory.gameObject, true)

					local curOwnerQuantity = ItemModel.instance:getItemQuantity(materilType, materilId)

					txtrepertory.text = formatLuaLang("dungeonrewardview_repertory", GameUtil.numberDisplay(curOwnerQuantity))
				end
			end

			if starValue ~= DungeonEnum.StarType.None then
				if self._episodeInfo then
					if not self._episodeInfo.star then
						do
							local curStar = 0
							local flagGo

							if starValue <= curStar then
								flagGo = gohelper.findChild(item.gameObject, "no_get")
							end

							if flagGo then
								flagGo:SetActive(true)
							end
						end

						if showGet then
							local flagGo = gohelper.findChild(item.gameObject, "no_get")

							flagGo:SetActive(true)
						end

						if showProb then
							local flagGo = gohelper.findChild(item.gameObject, "get")

							if flagGo then
								flagGo:SetActive(true)

								local txt = gohelper.findChildText(flagGo, "tip")

								txt.text = luaLang("dungeon_prob_flag" .. probabilityFlag)
							end
						end
					end
				end
			end

			itemIcon:isShowAddition(showAddition and true or false)

			if refreshOneCallback then
				refreshOneCallback(callbackObj, itemIcon, materilType, materilId)
			end

			local btn = gohelper.findButtonWithAudio(item.gameObject)

			btn:AddClickListener(function(reward)
				MaterialTipController.instance:showMaterialInfo(reward[1], reward[2])
			end, reward)
			table.insert(self._btnList, btn)
		end
	end
end

function DungeonRewardView:onUpdateParam()
	return
end

function DungeonRewardView:onOpen()
	self._episodeId = self.viewParam.id
	self._episodeInfo = DungeonModel.instance:getEpisodeInfo(self._episodeId)

	if not self._episodeInfo then
		self._episodeInfo = UserDungeonMO.New()

		local episodeCo = DungeonConfig.instance:getEpisodeCO(self._episodeId)

		self._episodeInfo:initFromManual(episodeCo.chapterId, self._episodeId, 0, 0)
	end

	self._btnList = self:getUserDataTb_()

	local chapterCo = DungeonConfig.instance:getChapterCO(self._episodeInfo.chapterId)
	local isResourceType = chapterCo.type == DungeonEnum.ChapterType.Gold or chapterCo.type == DungeonEnum.ChapterType.Exp
	local isRewindType = chapterCo.type == DungeonEnum.ChapterType.Break
	local isHardMode = chapterCo and chapterCo.type == DungeonEnum.ChapterType.Hard

	self:setRewardStarsColor(isHardMode)
	self:normalRewardShow(false, isResourceType, isRewindType)

	local bonusItems = DungeonModel.instance:getEpisodeReward(self._episodeId)
	local allShowItemDict = {}

	for i = 1, #bonusItems do
		local item = bonusItems[i]

		allShowItemDict[item[1]] = allShowItemDict[item[1]] or {}
		allShowItemDict[item[1]][item[2]] = true
	end

	self:showReward(self._gocontent0, bonusItems, DungeonEnum.StarType.None, false, true)
	self:showReward(self._gocontent1, DungeonModel.instance:getEpisodeFirstBonus(self._episodeId), DungeonEnum.StarType.Normal, true, false)
	self:showReward(self._gocontent2, DungeonModel.instance:getEpisodeAdvancedBonus(self._episodeId), DungeonEnum.StarType.Advanced, true, false)

	if chapterCo.enterAfterFreeLimit > 0 then
		local freeNum = DungeonModel.instance:getChapterRemainingNum(chapterCo.type)

		if freeNum > 0 then
			gohelper.setActive(self._goreward3, true)

			local maxCount = DungeonConfig.instance:getDungeonEveryDayCount(chapterCo.type)

			self._txtspecialtitle.text = formatLuaLang("dungeon_special_drop", freeNum, maxCount)

			self:showReward(self._gocontent3, DungeonModel.instance:getEpisodeFreeDisplayList(self._episodeId), DungeonEnum.StarType.None, false, true)
		end
	end

	local commonRewardList = {}

	if isResourceType then
		commonRewardList = DungeonModel.instance:getEpisodeBonus(self._episodeId)

		self:showReward(self._gocontent0, commonRewardList, DungeonEnum.StarType.None, true, false)
	else
		commonRewardList = DungeonModel.instance:getEpisodeRewardList(self._episodeId)

		self:showReward(self._gocontent0, commonRewardList, DungeonEnum.StarType.None, false, true)
	end

	local newRewardList = DungeonModel.instance:getEpisodeBonus(self._episodeId, true)

	for i = #newRewardList, 1, -1 do
		local item = newRewardList[i]

		if allShowItemDict[item[1]] and allShowItemDict[item[1]][item[2]] then
			table.remove(newRewardList, i)
		end
	end

	self:showReward(self._gocontent0, newRewardList, DungeonEnum.StarType.None, false, true)
	tabletool.addValues(commonRewardList, newRewardList)
	self:showTurnBackAdditionReward(commonRewardList, isResourceType)
	self:showDoubleDropReward(commonRewardList, isResourceType)
	self:refreshActReward()
	TaskDispatcher.runRepeat(self.everyMinuteCall, self, TimeUtil.OneMinuteSecond)
end

function DungeonRewardView:everyMinuteCall()
	self:_refreshActLimitTime()
end

function DungeonRewardView:refreshActReward()
	local episodeCo = DungeonConfig.instance:getEpisodeCO(self._episodeId)
	local chapterCo = DungeonConfig.instance:getChapterCO(episodeCo.chapterId)

	if chapterCo.enterAfterFreeLimit > 0 and DungeonModel.instance:getChapterRemainingNum(chapterCo.type) > 0 then
		gohelper.setActive(self._goactreward, false)

		return
	end

	local activityId = 0
	local dropCo
	local chapterId = episodeCo.chapterId

	for _, co in ipairs(lua_activity155_drop.configList) do
		if chapterId == co.chapterId then
			local actId = co.activityId
			local status = ActivityHelper.getActivityStatus(actId, true)

			if status == ActivityEnum.ActivityStatus.Normal then
				activityId = actId
				dropCo = co

				break
			end
		end
	end

	self._curActivityId = activityId

	self:_refreshActLimitTime()

	if not dropCo or episodeCo.type == DungeonEnum.EpisodeType.Story then
		gohelper.setActive(self._goactreward, false)

		return
	end

	gohelper.setActive(self._goactreward, true)

	local currencyReward = dropCo.itemId1

	if not string.nilorempty(currencyReward) then
		local array = string.splitToNumber(currencyReward, "#")
		local ratio = CommonConfig.instance:getAct155CurrencyRatio()
		local cost = string.splitToNumber(episodeCo.cost, "#")[3]
		local quantity = ratio * cost
		local reward = {
			array[1],
			array[2],
			array[3],
			quantity
		}

		self.showReward(self, self._goactcontent, {
			reward
		}, DungeonEnum.StarType.None, true, true, nil, nil, self.refreshV1a7DungeonCurrencyCallback, self)
	end

	local powerReward = dropCo.itemId2

	if not string.nilorempty(powerReward) then
		local array = string.splitToNumber(powerReward, "#")
		local reward = {
			array[1],
			array[2],
			array[3]
		}

		self.showReward(self, self._goactcontent, {
			reward
		}, DungeonEnum.StarType.None, false, true, nil, nil, self.refreshV1a7PowerCallback, self)
	end

	local act158Status = ActivityHelper.getActivityStatus(VersionActivity1_9Enum.ActivityId.ToughBattle)

	if (act158Status == ActivityEnum.ActivityStatus.Normal or act158Status == ActivityEnum.ActivityStatus.NotUnlock) and ToughBattleModel.instance:isDropActItem() then
		local reward = {
			MaterialEnum.MaterialType.Currency,
			CurrencyEnum.CurrencyType.V1a9ToughEnter,
			DungeonMapLevelRewardView.TagType.Act
		}

		self.showReward(self, self._goactcontent, {
			reward
		}, DungeonEnum.StarType.None, false, true, nil, nil, self.refreshToughBattleCallback, self)
	end
end

function DungeonRewardView:_refreshActLimitTime()
	if not self._curActivityId or self._curActivityId == 0 then
		return
	end

	local actInfoMo = ActivityModel.instance:getActivityInfo()[self._curActivityId]

	if not actInfoMo then
		return
	end

	local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

	if offsetSecond > 0 then
		local dateStr = TimeUtil.SecondToActivityTimeFormat(offsetSecond)
		local param = luaLang("dungeonreward_limittime_drop")

		self._txtlimittitle.text = GameUtil.getSubPlaceholderLuaLangOneParam(param, dateStr)

		gohelper.setActive(self._txtlimittitle, true)
	else
		gohelper.setActive(self._txtlimittitle, false)
	end
end

function DungeonRewardView:refreshV1a7DungeonCurrencyCallback(iconComp, type, id)
	local itemIcon = iconComp._itemIcon

	itemIcon._gov1a7act = itemIcon._gov1a7act or gohelper.findChild(itemIcon.go, "act")

	gohelper.setActive(itemIcon._gov1a7act, true)
end

function DungeonRewardView:refreshV1a7PowerCallback(iconComp, type, id)
	iconComp:setCanShowDeadLine(false)

	local itemIcon = iconComp._itemIcon

	itemIcon._gov1a7act = itemIcon._gov1a7act or gohelper.findChild(itemIcon.go, "act")

	gohelper.setActive(itemIcon._gov1a7act, true)
end

function DungeonRewardView:refreshToughBattleCallback(iconComp, type, id)
	iconComp:setCanShowDeadLine(false)

	local itemIcon = iconComp._itemIcon

	itemIcon._gov1a7act = itemIcon._gov1a7act or gohelper.findChild(itemIcon.go, "act")

	gohelper.setActive(itemIcon._gov1a7act, true)
end

function DungeonRewardView:normalRewardShow(isHardMode, isResourceType, isRewindType)
	gohelper.setActive(self._gonormalstars, not isHardMode or isResourceType)
	gohelper.setActive(self._gohardstars, isHardMode and not isResourceType)
	gohelper.setActive(self._goreward0, not isHardMode)
	gohelper.setActive(self._goreward2, not isHardMode and not isResourceType and not isRewindType)
	gohelper.setActive(self._goreward3, false)
end

function DungeonRewardView:setRewardStarsColor(isHardMode)
	local normalStarColor, hardStarColor = "#C66030", "#FF4343"
	local singleStarImage = gohelper.findChildImage(self._gonormalstars, "star")

	SLFramework.UGUI.GuiHelper.SetColor(singleStarImage, isHardMode and hardStarColor or normalStarColor)
end

function DungeonRewardView:showTurnBackAdditionReward(commonRewardList, isResourceType)
	local isMultiDrop, limit, total = Activity217Model.instance:getShowTripleByChapter(self._episodeInfo.chapterId)
	local multiDropShow = isMultiDrop and limit > 0

	if multiDropShow then
		if self._additionReward then
			gohelper.setActive(self._additionReward, false)
		end

		return
	end

	local isShowAddition = TurnbackModel.instance:isShowTurnBackAddition(self._episodeInfo.chapterId)

	if isShowAddition then
		local additionRewardList = TurnbackModel.instance:getAdditionRewardList(commonRewardList)

		if isResourceType then
			self:showReward(self._additionContent, additionRewardList, DungeonEnum.StarType.None, true, false, true)
		else
			self:showReward(self._additionContent, additionRewardList, DungeonEnum.StarType.None, false, false, true)
		end
	end

	if self._additionReward then
		gohelper.setActive(self._additionReward, isShowAddition)
	end
end

function DungeonRewardView:showDoubleDropReward(commonRewardList, isResourceType)
	local isMultiDrop, limit, total, magnification = Activity217Model.instance:getShowTripleByChapter(self._episodeInfo.chapterId)
	local multiDropShow = isMultiDrop and limit > 0
	local episodeShow, remainTimes, dailyLimit = DoubleDropModel.instance:isShowDoubleByEpisode(self._episodeId, true)
	local showDrop = episodeShow or multiDropShow

	gohelper.setActive(self._godoubledropreward, showDrop)

	if not showDrop then
		return
	end

	local list = {}

	if multiDropShow then
		for _, commonreward in ipairs(commonRewardList) do
			local reward = {}

			reward[1] = commonreward[1]
			reward[2] = commonreward[2]
			reward[3] = tostring((magnification - 1) * tonumber(commonreward[3]))

			table.insert(list, reward)
		end

		local bonusCo = Activity217Config.instance:getBonusCO(self._episodeId)

		if bonusCo then
			local extraBonusStr = bonusCo.extraBonus
			local extraBonus = GameUtil.splitString2(extraBonusStr, true)

			if extraBonus then
				tabletool.addValues(list, extraBonus)
			end
		end
	elseif episodeShow then
		tabletool.addValues(list, commonRewardList)

		local actId = DoubleDropModel.instance:getActId()
		local extraBonusStr = DoubleDropConfig.instance:getAct153ExtraBonus(actId, self._episodeId)
		local extraBonus = GameUtil.splitString2(extraBonusStr, true)

		tabletool.addValues(list, extraBonus)
	end

	self:showReward(self._godoubledropcontent, list, DungeonEnum.StarType.None, true, false, true)
end

function DungeonRewardView:onClose()
	for i, v in ipairs(self._btnList) do
		v:RemoveClickListener()
	end

	self._btnList = nil

	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_General_OK)
	TaskDispatcher.cancelTask(self.everyMinuteCall, self)
end

function DungeonRewardView:onDestroyView()
	for k, v in pairs(self._simageList) do
		k:UnLoadImage()
	end
end

return DungeonRewardView
