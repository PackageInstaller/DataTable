-- chunkname: @modules/logic/versionactivity1_2/versionactivity1_2dungeonbase/view/VersionActivity1_2DungeonMapLevelBaseView.lua

module("modules.logic.versionactivity1_2.versionactivity1_2dungeonbase.view.VersionActivity1_2DungeonMapLevelBaseView", package.seeall)

local VersionActivity1_2DungeonMapLevelBaseView = class("VersionActivity1_2DungeonMapLevelBaseView", BaseView)

function VersionActivity1_2DungeonMapLevelBaseView:_btnreplayStoryOnClick()
	if not self.storyIdList or #self.storyIdList < 1 then
		return
	end

	StoryController.instance:playStories(self.storyIdList)
end

function VersionActivity1_2DungeonMapLevelBaseView:refreshStoryIdList()
	local episodeConfig = self._episode_list[1]

	if episodeConfig.type == DungeonEnum.EpisodeType.Story then
		self.storyIdList = nil

		return
	end

	if self.mode == VersionActivity1_2DungeonEnum.DungeonMode.Hard then
		self.storyIdList = nil

		return
	end

	self.storyIdList = {}

	if episodeConfig.beforeStory > 0 and StoryModel.instance:isStoryHasPlayed(episodeConfig.beforeStory) then
		table.insert(self.storyIdList, episodeConfig.beforeStory)
	end

	if episodeConfig.afterStory > 0 and StoryModel.instance:isStoryHasPlayed(episodeConfig.afterStory) then
		table.insert(self.storyIdList, episodeConfig.afterStory)
	end
end

function VersionActivity1_2DungeonMapLevelBaseView:_btncloseviewOnClick()
	self:startCloseTaskNextFrame()
end

function VersionActivity1_2DungeonMapLevelBaseView:startCloseTaskNextFrame()
	TaskDispatcher.runDelay(self.reallyClose, self, 0.01)
end

function VersionActivity1_2DungeonMapLevelBaseView:cancelStartCloseTask()
	TaskDispatcher.cancelTask(self.reallyClose, self)
end

function VersionActivity1_2DungeonMapLevelBaseView:reallyClose()
	self:closeThis()
end

function VersionActivity1_2DungeonMapLevelBaseView:_btnleftarrowOnClick()
	if self.mode == VersionActivity1_2DungeonEnum.DungeonMode.Hard then
		return
	end

	if #self._episode_list == 1 then
		return
	end

	if self._cur_select_index <= 1 then
		return
	end

	self._cur_select_index = self._cur_select_index - 1

	self:refreshUIByMode(self._cur_select_index)
end

function VersionActivity1_2DungeonMapLevelBaseView:_btnrightarrowOnClick()
	if self.mode == VersionActivity1_2DungeonEnum.DungeonMode.Hard then
		return
	end

	if #self._episode_list == 1 then
		return
	end

	if self._cur_select_index >= #self._episode_list then
		return
	end

	self._cur_select_index = self._cur_select_index + 1

	self:refreshUIByMode(self._cur_select_index)
end

function VersionActivity1_2DungeonMapLevelBaseView:refreshUIByMode(_cur_select_index)
	self.animator:Play("switch", 0, 0)
	self:_refreshSelectData(_cur_select_index)
	self:refreshUI()
end

function VersionActivity1_2DungeonMapLevelBaseView:_refreshSelectData(_cur_select_index)
	self.showEpisodeCo = self._episode_list[_cur_select_index]

	if not self.showEpisodeCo then
		self._cur_select_index = 1
		self.showEpisodeCo = self._episode_list[self._cur_select_index]
	end

	self.showEpisodeMo = DungeonModel.instance:getEpisodeInfo(self.showEpisodeCo.id)

	if not self.showEpisodeMo then
		self.showEpisodeMo = UserDungeonMO.New()

		self.showEpisodeMo:initFromManual(self.showEpisodeCo.chapterId, self.showEpisodeCo.id, 0, 0)
	end

	self._chapterConfig = DungeonConfig.instance:getChapterCO(self.showEpisodeCo.chapterId)
	self.modeCanFight = DungeonModel.instance:hasPassLevelAndStory(self.showEpisodeCo.preEpisode) and DungeonModel.instance:isFinishElementList(self.showEpisodeCo)

	local recommendLevel = FightHelper.getEpisodeRecommendLevel(self.showEpisodeCo.id)

	gohelper.setActive(self._gorecommond, recommendLevel > 0)

	if recommendLevel > 0 then
		self._txtrecommondlv.text = HeroConfig.instance:getCommonLevelDisplay(recommendLevel)
	end

	local isLock = not DungeonModel.instance:isUnlock(self.showEpisodeCo)

	gohelper.setActive(self._golock, isLock)
	self._lockAni:Play("idle")
end

function VersionActivity1_2DungeonMapLevelBaseView:_btnactivityrewardOnClick()
	DungeonController.instance:openDungeonRewardView(self.showEpisodeCo)
end

function VersionActivity1_2DungeonMapLevelBaseView:_btnnormalStartOnClick()
	if not self.modeCanFight then
		GameFacade.showToast(ToastEnum.VersionActivityCanFight, self:getPreModeName())

		return
	end

	self:startBattle()
end

function VersionActivity1_2DungeonMapLevelBaseView:_btnhardStartOnClick()
	self:startBattle()
end

function VersionActivity1_2DungeonMapLevelBaseView:_btncloseruleOnClick()
	return
end

function VersionActivity1_2DungeonMapLevelBaseView:startBattle()
	if self.showEpisodeCo.type == DungeonEnum.EpisodeType.Story then
		self:_playMainStory()

		return
	end

	if DungeonModel.instance:hasPassLevelAndStory(self.showEpisodeCo.id) then
		self:_enterFight()

		return
	end

	if self.showEpisodeCo.beforeStory > 0 and not StoryModel.instance:isStoryFinished(self.showEpisodeCo.beforeStory) then
		self:_playStoryAndEnterFight(self.showEpisodeCo.beforeStory)

		return
	end

	if self.showEpisodeMo.star <= DungeonEnum.StarType.None then
		self:_enterFight()

		return
	end

	if self.showEpisodeCo.afterStory > 0 and not StoryModel.instance:isStoryFinished(self.showEpisodeCo.afterStory) then
		self:playAfterStory(self.showEpisodeCo.afterStory)

		return
	end

	self:_enterFight()
end

function VersionActivity1_2DungeonMapLevelBaseView:_playMainStory()
	DungeonRpc.instance:sendStartDungeonRequest(self.showEpisodeCo.chapterId, self.showEpisodeCo.id)

	local param = {}

	param.mark = true
	param.episodeId = self.showEpisodeCo.id

	StoryController.instance:playStory(self.showEpisodeCo.beforeStory, param, self.onStoryFinished, self)
end

function VersionActivity1_2DungeonMapLevelBaseView:playAfterStory(storyId)
	local param = {}

	param.mark = true
	param.episodeId = self.showEpisodeCo.id

	StoryController.instance:playStory(storyId, param, function()
		DungeonController.instance:dispatchEvent(DungeonEvent.OnUpdateDungeonInfo, nil)

		DungeonMapModel.instance.playAfterStory = true

		self:closeThis()
	end, self)
end

function VersionActivity1_2DungeonMapLevelBaseView:_playStoryAndEnterFight(storyId)
	if StoryModel.instance:isStoryFinished(storyId) then
		self:_enterFight()

		return
	end

	local param = {}

	param.mark = true
	param.episodeId = self.showEpisodeCo.id

	StoryController.instance:playStory(storyId, param, self._enterFight, self)
end

function VersionActivity1_2DungeonMapLevelBaseView:_enterFight()
	for i, v in ipairs(self._episode_list) do
		VersionActivity1_2DungeonMapLevelBaseView.setlastBattleEpisodeId2Index(v.id, self._cur_select_index)
	end

	VersionActivity1_2DungeonController.instance:dispatchEvent(VersionActivity1_2DungeonEvent.enterFight, self._episode_list[1].id)

	DungeonModel.instance.versionActivityChapterType = DungeonConfig.instance:getChapterTypeByEpisodeId(self.showEpisodeCo.id)

	DungeonFightController.instance:enterFight(self.showEpisodeCo.chapterId, self.showEpisodeCo.id, 1)
end

function VersionActivity1_2DungeonMapLevelBaseView.getlastBattleEpisodeId2Index(episodeId)
	return PlayerPrefsHelper.getNumber(PlayerModel.instance:getMyUserId() .. PlayerPrefsKey.Fight1_2LastBattleEpisodeId2Index .. "_" .. episodeId, 1)
end

function VersionActivity1_2DungeonMapLevelBaseView.setlastBattleEpisodeId2Index(episodeId, index)
	return PlayerPrefsHelper.setNumber(PlayerModel.instance:getMyUserId() .. PlayerPrefsKey.Fight1_2LastBattleEpisodeId2Index .. "_" .. episodeId, index)
end

function VersionActivity1_2DungeonMapLevelBaseView:onStoryFinished()
	DungeonModel.instance.curSendEpisodeId = nil

	DungeonModel.instance:setLastSendEpisodeId(self.showEpisodeCo.id)
	DungeonRpc.instance:sendEndDungeonRequest(false)
	self:closeThis()
end

function VersionActivity1_2DungeonMapLevelBaseView:_onClueFlowDone()
	self:closeThis()
end

function VersionActivity1_2DungeonMapLevelBaseView:_editableInitView()
	gohelper.setActive(self._goactivityrewarditem, false)

	self.storyGoType = self._gotype1
	self.story3GoType = self._gotype2
	self.story4GoType = self._gotype3
	self.hardGoType = self._gotype4
	self.rewardItems = {}

	self._simageactivitynormalbg:LoadImage(ResUrl.getVersionActivityDungeon_1_2("bg002"))
	self._simageactivityhardbg:LoadImage(ResUrl.getVersionActivityDungeon_1_2("bg003"))

	self.goVersionActivity = gohelper.findChild(self.viewGO, "anim/versionactivity")
	self.animator = self.goVersionActivity:GetComponent(typeof(UnityEngine.Animator))
end

function VersionActivity1_2DungeonMapLevelBaseView:onUpdateParam()
	gohelper.setActive(self.viewGO, false)
	gohelper.setActive(self.viewGO, true)
	self:onOpen()
end

function VersionActivity1_2DungeonMapLevelBaseView:onOpen()
	self.showEpisodeCo = DungeonConfig.instance:getEpisodeCO(self.viewParam.episodeId)
	self.showEpisodeMo = DungeonModel.instance:getEpisodeInfo(self.viewParam.episodeId)
	self.isFromJump = self.viewParam.isJump

	self:initMode()

	self.modeCanFight = true

	self:refreshStoryIdList()
	self:refreshBg()
	self:refreshUI()
	VersionActivity1_2DungeonController.instance:setDungeonSelectedEpisodeId(self._episode_list[1].id)
end

function VersionActivity1_2DungeonMapLevelBaseView.getEpisodeUnlockAniFinish(episodeId)
	return PlayerPrefsHelper.getNumber(PlayerModel.instance:getMyUserId() .. PlayerPrefsKey.Fight1_2EpisodeUnlockAniFinish .. "_" .. episodeId, 0)
end

function VersionActivity1_2DungeonMapLevelBaseView.setEpisodeUnlockAniFinish(episodeId)
	return PlayerPrefsHelper.setNumber(PlayerModel.instance:getMyUserId() .. PlayerPrefsKey.Fight1_2EpisodeUnlockAniFinish .. "_" .. episodeId, 1)
end

function VersionActivity1_2DungeonMapLevelBaseView:initMode()
	local defaultSelectIndex = VersionActivity1_2DungeonMapLevelBaseView.getlastBattleEpisodeId2Index(self.showEpisodeCo.id)

	self.mode = VersionActivity1_2DungeonEnum.DungeonChapterId2UIModel[self.showEpisodeCo.chapterId]
	self._episode_list = {}
	self._playUnlockAniIndex = nil

	local list = DungeonConfig.instance:get1_2VersionActivityEpisodeCoList(self.showEpisodeCo.id)

	for i, id in ipairs(DungeonConfig.instance:get1_2VersionActivityEpisodeCoList(self.showEpisodeCo.id)) do
		local episodeConfig = DungeonConfig.instance:getEpisodeCO(id)

		table.insert(self._episode_list, episodeConfig)
	end

	if self.isFromJump then
		local unlock = DungeonModel.instance:isUnlock(self.showEpisodeCo)

		if unlock then
			for i, v in ipairs(self._episode_list) do
				if v.id == self.showEpisodeCo.id then
					self._cur_select_index = i

					break
				end
			end

			local finish = VersionActivity1_2DungeonMapLevelBaseView.getEpisodeUnlockAniFinish(self.showEpisodeCo.id)

			if not self._playUnlockAniIndex and finish == 0 then
				self._playUnlockAniIndex = self._cur_select_index

				VersionActivity1_2DungeonMapLevelBaseView.setEpisodeUnlockAniFinish(self.showEpisodeCo.id)
			end
		end
	else
		for i, id in ipairs(list) do
			local episodeConfig = DungeonConfig.instance:getEpisodeCO(id)

			if i > 1 then
				local unlock = DungeonModel.instance:isUnlock(episodeConfig)

				if unlock then
					local finish = VersionActivity1_2DungeonMapLevelBaseView.getEpisodeUnlockAniFinish(id)

					if not self._playUnlockAniIndex and finish == 0 then
						self._playUnlockAniIndex = i
						self._cur_select_index = i

						VersionActivity1_2DungeonMapLevelBaseView.setEpisodeUnlockAniFinish(id)
					end
				end
			end
		end
	end

	self._cur_select_index = self._cur_select_index or defaultSelectIndex

	self:_refreshSelectData(self._cur_select_index)

	if self._playUnlockAniIndex then
		gohelper.setActive(self._golock, true)
		self._lockAni:Play("unlock")
		TaskDispatcher.runDelay(self._playUnlockAudio, self, 1)
	end
end

function VersionActivity1_2DungeonMapLevelBaseView:_playUnlockAudio()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_unlock)
end

function VersionActivity1_2DungeonMapLevelBaseView:refreshBg()
	gohelper.setActive(self._simageactivitynormalbg.gameObject, self.mode ~= VersionActivity1_2DungeonEnum.DungeonMode.Hard)
	gohelper.setActive(self._simageactivityhardbg.gameObject, self.mode == VersionActivity1_2DungeonEnum.DungeonMode.Hard)
end

function VersionActivity1_2DungeonMapLevelBaseView:refreshUI()
	self:refreshEpisodeTextInfo()
	self:refreshStar()
	self:refreshMode()
	self:refreshArrow()
	self:refreshReward()
	self:refreshStartBtn()
end

function VersionActivity1_2DungeonMapLevelBaseView:refreshEpisodeTextInfo()
	self._txtmapName.text = self:buildEpisodeName()
	self._txtmapNameEn.text = self.showEpisodeCo.name_En
	self._txtmapNum.text = string.format("%02d", VersionActivity1_2DungeonConfig.instance:getEpisodeIndex(self.showEpisodeCo.id))
	self._txtactivitydesc.text = self.showEpisodeCo.desc
end

function VersionActivity1_2DungeonMapLevelBaseView:refreshStar()
	local normalEpisodeId = self.showEpisodeCo.id

	if normalEpisodeId then
		::label_35_0::

		local passStory = DungeonModel.instance:hasPassLevelAndStory(normalEpisodeId)
		local advancedConditionText = DungeonConfig.instance:getEpisodeAdvancedConditionText(normalEpisodeId)

		self:setImage(self._imagestar1, passStory)

		if string.nilorempty(advancedConditionText) then
			gohelper.setActive(self._imagestar2.gameObject, false)
		else
			self:setImage(self._imagestar2, self.showEpisodeMo.star >= DungeonEnum.StarType.Advanced)
		end
	end
end

function VersionActivity1_2DungeonMapLevelBaseView:refreshMode()
	gohelper.setActive(self.storyGoType, self.mode ~= VersionActivity1_2DungeonEnum.DungeonMode.Hard and self._cur_select_index == 1)
	gohelper.setActive(self.story3GoType, self.mode ~= VersionActivity1_2DungeonEnum.DungeonMode.Hard and self._cur_select_index == 2)
	gohelper.setActive(self.story4GoType, self.mode ~= VersionActivity1_2DungeonEnum.DungeonMode.Hard and self._cur_select_index == 3)
	gohelper.setActive(self.hardGoType, self.mode == VersionActivity1_2DungeonEnum.DungeonMode.Hard)
end

function VersionActivity1_2DungeonMapLevelBaseView:refreshArrow()
	local showArrow = self.mode ~= VersionActivity1_2DungeonEnum.DungeonMode.Hard and #self._episode_list > 1

	gohelper.setActive(self._btnleftarrow.gameObject, showArrow)
	gohelper.setActive(self._btnrightarrow.gameObject, showArrow)

	if showArrow then
		self._leftArrow = self._leftArrow or gohelper.findChildImage(self._btnleftarrow.gameObject, "left_arrow")
		self._rightArrow = self._rightArrow or gohelper.findChildImage(self._btnrightarrow.gameObject, "right_arrow")

		SLFramework.UGUI.GuiHelper.SetColor(self._leftArrow, self._cur_select_index == 1 and "#8C8C8C" or "#FFFFFF")
		SLFramework.UGUI.GuiHelper.SetColor(self._rightArrow, self._cur_select_index == #self._episode_list and "#8C8C8C" or "#FFFFFF")
	end
end

function VersionActivity1_2DungeonMapLevelBaseView:refreshReward()
	local rewardList = {}
	local firstRewardIndex = 0
	local advancedRewardIndex = 0

	if self.showEpisodeMo and self.showEpisodeMo.star ~= DungeonEnum.StarType.Advanced then
		tabletool.addValues(rewardList, DungeonModel.instance:getEpisodeAdvancedBonus(self.showEpisodeCo.id))

		advancedRewardIndex = #rewardList
	end

	if self.mode == VersionActivity1_2DungeonEnum.DungeonMode.Hard then
		tabletool.addValues(rewardList, DungeonModel.instance:getEpisodeFirstBonus(self.showEpisodeCo.id))

		firstRewardIndex = #rewardList
	elseif self.showEpisodeMo and self.showEpisodeMo.star == DungeonEnum.StarType.None then
		tabletool.addValues(rewardList, DungeonModel.instance:getEpisodeFirstBonus(self.showEpisodeCo.id))

		firstRewardIndex = #rewardList
	end

	tabletool.addValues(rewardList, DungeonModel.instance:getEpisodeRewardDisplayList(self.showEpisodeCo.id))

	local rewardCount = #rewardList

	gohelper.setActive(self._gorewards, rewardCount > 0)
	gohelper.setActive(self._gonorewards, rewardCount == 0)

	if rewardCount == 0 then
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
			rewardItem.gorare = gohelper.findChild(rewardItem.go, "rare")
			rewardItem.gonormal = gohelper.findChild(rewardItem.go, "rare/#go_rare1")
			rewardItem.gofirst = gohelper.findChild(rewardItem.go, "rare/#go_rare2")
			rewardItem.goadvance = gohelper.findChild(rewardItem.go, "rare/#go_rare3")
			rewardItem.gofirsthard = gohelper.findChild(rewardItem.go, "rare/#go_rare4")
			rewardItem.txtnormal = gohelper.findChildText(rewardItem.go, "rare/#go_rare1/txt")
			rewardItem.count = gohelper.findChildText(rewardItem.go, "countbg/count")
			rewardItem.countBg = gohelper.findChild(rewardItem.go, "countbg")
			rewardItem.got = gohelper.findChild(rewardItem.go, "got")

			table.insert(self.rewardItems, rewardItem)
		end

		reward = rewardList[i]

		gohelper.setActive(rewardItem.gonormal, false)
		gohelper.setActive(rewardItem.gofirst, false)
		gohelper.setActive(rewardItem.goadvance, false)
		gohelper.setActive(rewardItem.gofirsthard, false)
		gohelper.setActive(rewardItem.got, false)
		gohelper.setActive(rewardItem.gorare, true)

		local goFirstRare, goAdvanceRare
		local quantity = reward[3]
		local isShowCount = true

		if self.mode == VersionActivity1_2DungeonEnum.DungeonMode.Hard then
			goFirstRare = rewardItem.gofirsthard
			goAdvanceRare = rewardItem.goadvance
		else
			goFirstRare = rewardItem.gofirst
			goAdvanceRare = rewardItem.goadvance
		end

		if i <= advancedRewardIndex then
			gohelper.setActive(goAdvanceRare, true)
		elseif i <= firstRewardIndex then
			gohelper.setActive(goFirstRare, true)
		else
			gohelper.setActive(rewardItem.gonormal, true)

			rewardItem.txtnormal.text = luaLang("dungeon_prob_flag" .. reward[3])

			if #reward >= 4 then
				quantity = reward[4]
			else
				isShowCount = false
			end
		end

		gohelper.setActive(rewardItem.countBg, isShowCount)

		rewardItem.count.text = isShowCount and quantity or ""

		rewardItem.iconItem:setMOValue(reward[1], reward[2], quantity, nil, true)
		rewardItem.iconItem:setCountFontSize(0)
		rewardItem.iconItem:setHideLvAndBreakFlag(true)
		rewardItem.iconItem:hideEquipLvAndBreak(true)
		rewardItem.iconItem:isShowCount(isShowCount)

		if DungeonModel.instance:hasPassLevelAndStory(self.showEpisodeCo.id) and self.mode == VersionActivity1_2DungeonEnum.DungeonMode.Hard then
			gohelper.setActive(rewardItem.got, true)
			gohelper.setActive(rewardItem.gorare, false)
		end

		gohelper.setActive(rewardItem.go, true)
	end

	for i = count + 1, #self.rewardItems do
		gohelper.setActive(self.rewardItems[i].go, false)
	end
end

function VersionActivity1_2DungeonMapLevelBaseView:refreshStartBtn()
	local cost = 0

	if not string.nilorempty(self.showEpisodeCo.cost) then
		cost = string.splitToNumber(self.showEpisodeCo.cost, "#")[3]
	end

	local currencyCo = CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.Power)
	local powerIcon = ResUrl.getCurrencyItemIcon(currencyCo.icon)

	if self._simagepower then
		self._simagepower:LoadImage(powerIcon)
	end

	if self._simagepower2 then
		self._simagepower2:LoadImage(powerIcon)
	end

	self._txtusepowernormal.text = "-" .. cost
	self._txtusepowernormal2.text = "-" .. cost
	self._txtusepowerhard.text = "-" .. cost

	if cost <= CurrencyModel.instance:getPower() then
		SLFramework.UGUI.GuiHelper.SetColor(self._txtusepowernormal, "#ACCB8C")
		SLFramework.UGUI.GuiHelper.SetColor(self._txtusepowernormal2, "#ACCB8C")
		SLFramework.UGUI.GuiHelper.SetColor(self._txtusepowerhard, "#FFB7B7")
	else
		SLFramework.UGUI.GuiHelper.SetColor(self._txtusepowernormal, "#800015")
		SLFramework.UGUI.GuiHelper.SetColor(self._txtusepowernormal2, "#800015")
		SLFramework.UGUI.GuiHelper.SetColor(self._txtusepowerhard, "#C44945")
	end

	if DungeonModel.instance:hasPassLevelAndStory(self._episode_list[1].id) then
		if self.storyIdList then
			local couldReviewStory = true

			couldReviewStory = #self.storyIdList > 0

			if self._btnreplayStory then
				gohelper.setActive(self._btnreplayStory.gameObject, couldReviewStory)
			end

			gohelper.setActive(self._btnnormalStart.gameObject, self.mode ~= VersionActivity1_2DungeonEnum.DungeonMode.Hard and not couldReviewStory)
			gohelper.setActive(self._btnnormalStart2.gameObject, self.mode ~= VersionActivity1_2DungeonEnum.DungeonMode.Hard and couldReviewStory)
			gohelper.setActive(self._btnhardStart.gameObject, self.mode == VersionActivity1_2DungeonEnum.DungeonMode.Hard)

			if DungeonModel.instance:hasPassLevel(self.showEpisodeCo.id) and self.showEpisodeCo.afterStory > 0 and not StoryModel.instance:isStoryFinished(self.showEpisodeCo.afterStory) then
				self._txtnorstarttext.text = luaLang("p_dungeonlevelview_continuestory")
				self._txtnorstarttext2.text = luaLang("p_dungeonlevelview_continuestory")

				gohelper.setActive(self._txtusepowernormal.gameObject, false)
				gohelper.setActive(self._gonormalStartnode, false)

				if self._simagepower then
					gohelper.setActive(self._simagepower.gameObject, false)
				end
			else
				self._txtnorstarttext.text = luaLang("p_dungeonlevelview_startfight")
				self._txtnorstarttext2.text = luaLang("p_dungeonlevelview_startfight")

				gohelper.setActive(self._txtusepowernormal.gameObject, true)
				gohelper.setActive(self._txtusepowernormal2.gameObject, true)

				if self._simagepower then
					gohelper.setActive(self._simagepower.gameObject, true)
					gohelper.setActive(self._simagepower2.gameObject, true)
				end
			end
		end
	end
end

function VersionActivity1_2DungeonMapLevelBaseView:setImage(image, light)
	if light then
		UISpriteSetMgr.instance:setVersionActivitySprite(image, "star_1_3")
	else
		UISpriteSetMgr.instance:setVersionActivitySprite(image, "star_1_1")
	end
end

function VersionActivity1_2DungeonMapLevelBaseView:buildEpisodeName()
	local name = self.showEpisodeCo.name
	local firstName = GameUtil.utf8sub(name, 1, 1)
	local nameLen = GameUtil.utf8len(name)

	return string.format("<size=112>%s</size>%s", firstName, (nameLen > 1 or nil) and GameUtil.utf8sub(name, 2, nameLen - 1))
end

function VersionActivity1_2DungeonMapLevelBaseView:buildColorText(text, color)
	return string.format("<color=%s>%s</color>", color, text)
end

function VersionActivity1_2DungeonMapLevelBaseView:getPreModeName()
	if self._cur_select_index - 1 <= 0 then
		logWarn("not modeIndex mode : " .. self._cur_select_index)

		return ""
	end

	local index = self.mode == VersionActivity1_2DungeonEnum.DungeonMode.Hard and 99 or self._cur_select_index - 1

	return luaLang(VersionActivityDungeonBaseEnum.ChapterModeNameKey[index])
end

function VersionActivity1_2DungeonMapLevelBaseView:onClose()
	TaskDispatcher.cancelTask(self._playUnlockAudio, self)

	if self._clueFlow then
		self._clueFlow:unregisterDoneListener(self._onClueFlowDone, self)
		self._clueFlow:stop()

		self._clueFlow = nil
	end
end

function VersionActivity1_2DungeonMapLevelBaseView:onDestroyView()
	self.rewardItems = nil

	self._simageactivitynormalbg:UnLoadImage()
	self._simageactivityhardbg:UnLoadImage()

	if self._simagepower then
		self._simagepower:UnLoadImage()
	end

	if self._simagepower2 then
		self._simagepower2:UnLoadImage()
	end
end

return VersionActivity1_2DungeonMapLevelBaseView
