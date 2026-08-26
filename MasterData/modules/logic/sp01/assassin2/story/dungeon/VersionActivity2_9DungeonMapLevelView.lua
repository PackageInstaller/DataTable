-- chunkname: @modules/logic/sp01/assassin2/story/dungeon/VersionActivity2_9DungeonMapLevelView.lua

module("modules.logic.sp01.assassin2.story.dungeon.VersionActivity2_9DungeonMapLevelView", package.seeall)

local VersionActivity2_9DungeonMapLevelView = class("VersionActivity2_9DungeonMapLevelView", VersionActivityFixedDungeonMapLevelView)
local EpisodeNameNormalColor = "#562626"
local EpisodeNameHardColor = "#562626"
local EpisodeTxtNormalColor = "#562626"
local EpisodeTxtHardColor = "#562626"
local UNLOCK_ANIM_TIME = 2.7

function VersionActivity2_9DungeonMapLevelView:onOpen()
	AudioMgr.instance:trigger(AudioEnum2_9.Dungeon.play_ui_clickEpisode)
	self:initViewParam()
	self:initMode()
	self:markSelectEpisode()
	self:refreshStoryIdList()
	self:refreshBg()
	self:refreshUI()
	self.animator:Play(UIAnimationName.Open, 0, 0)
	VersionActivityFixedDungeonController.instance:dispatchEvent(VersionActivityFixedDungeonEvent.OpenFinishMapLevelView, self.viewGO)
end

function VersionActivity2_9DungeonMapLevelView:onInitView()
	VersionActivity2_9DungeonMapLevelView.super.onInitView(self)

	self._gonormalprogress = gohelper.findChild(self.viewGO, "anim/versionactivity/right/content/#go_switch/#go_progress/#go_normal")
	self._gomiddleprogress = gohelper.findChild(self.viewGO, "anim/versionactivity/right/content/#go_switch/#go_progress/#go_middle")
	self._gohardprogress = gohelper.findChild(self.viewGO, "anim/versionactivity/right/content/#go_switch/#go_progress/#go_hard")
	self._sliderprogress = gohelper.findChildSlider(self.viewGO, "anim/versionactivity/right/content/#go_switch/#go_progress/#slider_progress")
	self._imageprogress = gohelper.findChildImage(self.viewGO, "anim/versionactivity/right/content/#go_switch/#go_progress/#slider_progress/Fill Area/Fill")

	gohelper.setActive(self._btnactivityreward, false)
end

function VersionActivity2_9DungeonMapLevelView:playModeUnlockAnimation()
	if not self.needPlayUnlockModeAnimation then
		return
	end

	AudioMgr.instance:trigger(AudioEnum2_9.Dungeon.play_ui_unlockMode)
	self:_playModeUnLockAnimation(UIAnimationName.Unlock)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(VersionActivityFixedHelper.getVersionActivityDungeonEnum().BlockKey.MapLevelViewPlayUnlockAnim)
	TaskDispatcher.runDelay(self.onModeUnlockAnimationPlayDone, self, UNLOCK_ANIM_TIME)
end

function VersionActivity2_9DungeonMapLevelView:refreshEpisodeTextInfo()
	local chapterCo = DungeonConfig.instance:getChapterCO(self.showEpisodeCo.chapterId)
	local targetConfig = chapterCo.id == VersionActivityFixedHelper.getVersionActivityDungeonEnum().DungeonChapterId.Story and self.showEpisodeCo or VersionActivityFixedDungeonConfig.instance:getStoryEpisodeCo(self.showEpisodeCo.id)

	self._txtmapName.text = self:buildEpisodeName(targetConfig)

	if self.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard then
		if not EpisodeTxtHardColor then
			local txtColor = EpisodeTxtNormalColor

			self._txtmapNameEn.text = self:buildColorText(targetConfig.name_En, txtColor)
			self._txtmapNum.text = self:buildColorText(string.format("%02d", self.index), txtColor)
			self._txtmapChapterIndex.text = self:buildColorText(chapterCo.chapterIndex .. " .", txtColor)
			self._txtactivitydesc.text = targetConfig.desc

			local recommendLevel = DungeonHelper.getEpisodeRecommendLevel(self.showEpisodeCo.id)
			local battleCo = lua_battle.configDict[self.showEpisodeCo.battleId]
			local firstCattleCo = lua_battle.configDict[self.showEpisodeCo.firstBattleId]
			local isFirstBalance = firstCattleCo and not string.nilorempty(firstCattleCo.balance)
			local isBalance = battleCo and not string.nilorempty(battleCo.balance)
			local isPass = DungeonModel.instance:hasPassLevel(self.showEpisodeCo.id)

			gohelper.setActive(self._gorecommend, recommendLevel > 0)

			if (isFirstBalance or isBalance) and not isPass then
				self._txtrecommendlv.text = "---"
			elseif recommendLevel > 0 then
				self._txtrecommendlv.text = HeroConfig.instance:getCommonLevelDisplay(recommendLevel)
			end
		end
	end
end

function VersionActivity2_9DungeonMapLevelView:buildEpisodeName(episodeCo)
	local name = episodeCo.name
	local firstName = GameUtil.utf8sub(name, 1, 1)
	local nameLen = GameUtil.utf8len(name)

	if self.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard then
		if not EpisodeNameHardColor then
			local txtColor = EpisodeNameNormalColor

			return self:buildColorText(string.format("<size=112>%s</size>%s", firstName, (nameLen > 1 or nil) and GameUtil.utf8sub(name, 2, nameLen - 1)), txtColor)
		end
	end
end

function VersionActivity2_9DungeonMapLevelView:refreshStar()
	if not self._progressGoTab then
		self._progressGoTab = self:getUserDataTb_()
		self._progressGoTab[VersionActivityDungeonBaseEnum.DungeonMode.Story] = self._gonormalprogress
		self._progressGoTab[VersionActivityDungeonBaseEnum.DungeonMode.Story2] = self._gomiddleprogress
		self._progressGoTab[VersionActivityDungeonBaseEnum.DungeonMode.Story3] = self._gohardprogress
	end

	for mode, goprogress in pairs(self._progressGoTab) do
		gohelper.setActive(goprogress, mode == self.mode)

		if mode == self.mode then
			self:refreshProgressUI(goprogress)
		end
	end
end

function VersionActivity2_9DungeonMapLevelView:refreshProgressUI(goprogress)
	VersionActivity2_9DungeonHelper.setEpisodeProgressBg(self.showEpisodeCo.id, self._imageprogress)

	local progress = VersionActivity2_9DungeonHelper.calcEpisodeProgress(self.showEpisodeCo.id)
	local formatProgress = VersionActivity2_9DungeonHelper.formatEpisodeProgress(progress)
	local txtprogress = gohelper.findChildText(goprogress, "#txt_progress")

	txtprogress.text = formatProgress

	self._sliderprogress:SetValue(progress)
end

function VersionActivity2_9DungeonMapLevelView:_playMainStory()
	DungeonRpc.instance:sendStartDungeonRequest(self.showEpisodeCo.chapterId, self.showEpisodeCo.id)

	local beforeStoryId = self.showEpisodeCo.beforeStory
	local isEpisodeFinish = DungeonModel.instance:hasPassLevel(self.showEpisodeCo.id)
	local afterStoryId = VersionActivity2_9DungeonHelper.getEpisodeAfterStoryId(self.showEpisodeCo.id)

	if afterStoryId and afterStoryId ~= 0 then
		isEpisodeFinish = isEpisodeFinish and StoryModel.instance:isStoryFinished(afterStoryId)
	end

	if isEpisodeFinish then
		self:_onFinishedEpisodeStories(beforeStoryId, afterStoryId)

		return
	end

	local storyFlow = self:_buildStoryEpisodeFlow(beforeStoryId, afterStoryId)

	storyFlow:start()
end

function VersionActivity2_9DungeonMapLevelView:_onFinishedEpisodeStories(beforeStoryId, afterStoryId)
	local storyIdList = {}

	if beforeStoryId ~= 0 then
		table.insert(storyIdList, beforeStoryId)
	end

	if afterStoryId ~= 0 then
		table.insert(storyIdList, afterStoryId)
	end

	local param = {}

	param.mark = true
	param.episodeId = self.showEpisodeCo.id

	StoryController.instance:playStories(storyIdList, param, self.onStoryFinished, self)
end

function VersionActivity2_9DungeonMapLevelView:_buildStoryEpisodeFlow(beforeStoryId, afterStoryId)
	self:destroyStoryFlow()

	self._storyFlow = FlowSequence.New()

	if beforeStoryId and beforeStoryId ~= 0 then
		self._storyFlow:addWork(PlayStoryWork.New(beforeStoryId))
	end

	local littleGameType = VersionActivity2_9DungeonHelper.getEpisdoeLittleGameType(self.showEpisodeCo.id)

	if littleGameType then
		self._storyFlow:addWork(FunctionWork.New(VersionActivity2_9DungeonController.startEpisodeLittleGame, VersionActivity2_9DungeonController.instance, self.showEpisodeCo.id))

		local eventParams = "AssassinController;AssassinEvent;OnGameEpisodeFinished;" .. self.showEpisodeCo.id

		self._storyFlow:addWork(WaitEventWork.New(eventParams))
	end

	if afterStoryId and afterStoryId ~= 0 then
		self._storyFlow:addWork(PlayStoryWork.New(afterStoryId))
	end

	self._storyFlow:addWork(FunctionWork.New(AssassinController.instance.dispatchEvent, AssassinController.instance, AssassinEvent.OnGameAfterStoryDone))
	self._storyFlow:addWork(FunctionWork.New(self.closeThis, self))
	self._storyFlow:registerDoneListener(self.onFinishEpisode, self)

	return self._storyFlow
end

function VersionActivity2_9DungeonMapLevelView:onFinishEpisode()
	DungeonModel.instance.curSendEpisodeId = nil

	DungeonModel.instance:setLastSendEpisodeId(self.showEpisodeCo.id)
	DungeonRpc.instance:sendEndDungeonRequest(false)
end

function VersionActivity2_9DungeonMapLevelView:refreshReward()
	local rewardList = {}
	local firstRewardIndex = 0
	local advancedRewardIndex = 0

	if self.showEpisodeMo.star ~= DungeonEnum.StarType.Advanced then
		tabletool.addValues(rewardList, DungeonModel.instance:getEpisodeAdvancedBonus(self.showEpisodeCo.id))

		advancedRewardIndex = #rewardList
	end

	if self.showEpisodeMo.star == DungeonEnum.StarType.None then
		tabletool.addValues(rewardList, DungeonModel.instance:getEpisodeFirstBonus(self.showEpisodeCo.id))

		firstRewardIndex = #rewardList
	end

	tabletool.addValues(rewardList, DungeonModel.instance:getEpisodeReward(self.showEpisodeCo.id))
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
			rewardItem.gonormal = gohelper.findChild(rewardItem.go, "rare/#go_rare1")
			rewardItem.gofirst = gohelper.findChild(rewardItem.go, "rare/#go_rare2")
			rewardItem.goadvance = gohelper.findChild(rewardItem.go, "rare/#go_rare3")
			rewardItem.gofirsthard = gohelper.findChild(rewardItem.go, "rare/#go_rare4")
			rewardItem.txtnormal = gohelper.findChildText(rewardItem.go, "rare/#go_rare1/txt")
			rewardItem.goprogress = gohelper.findChild(rewardItem.go, "rare/#go_progress")
			rewardItem.imageprogress = gohelper.findChildImage(rewardItem.go, "rare/#go_progress/#image_icon")
			rewardItem.txtprogress = gohelper.findChildText(rewardItem.go, "rare/#go_progress/#txt_progress")

			table.insert(self.rewardItems, rewardItem)
		end

		reward = rewardList[i]

		gohelper.setActive(rewardItem.gonormal, false)
		gohelper.setActive(rewardItem.gofirst, false)
		gohelper.setActive(rewardItem.goadvance, false)
		gohelper.setActive(rewardItem.gofirsthard, false)
		gohelper.setActive(rewardItem.goprogress, false)

		local quantity = reward[3]
		local isShowCount = true

		if i <= advancedRewardIndex then
			gohelper.setActive(rewardItem.goprogress, true)
			VersionActivity2_9DungeonHelper.setEpisodeProgressIcon(self.showEpisodeCo.id, rewardItem.imageprogress)
			VersionActivity2_9DungeonHelper.setEpisodeTargetProgress(self.showEpisodeCo.id, DungeonEnum.StarType.Advanced, rewardItem.txtprogress)
		elseif i <= firstRewardIndex then
			gohelper.setActive(rewardItem.goprogress, true)
			VersionActivity2_9DungeonHelper.setEpisodeProgressIcon(self.showEpisodeCo.id, rewardItem.imageprogress)
			VersionActivity2_9DungeonHelper.setEpisodeTargetProgress(self.showEpisodeCo.id, DungeonEnum.StarType.Normal, rewardItem.txtprogress)
		else
			gohelper.setActive(rewardItem.gonormal, true)

			local tagType = reward[3]

			isShowCount = true

			if reward.tagType then
				tagType = reward.tagType
				isShowCount = quantity ~= 0
			elseif #reward >= 4 then
				quantity = reward[4]
			else
				isShowCount = false
			end

			rewardItem.txtnormal.text = luaLang("dungeon_prob_flag" .. tagType)
		end

		rewardItem.iconItem:setMOValue(reward[1], reward[2], quantity, nil, true)
		rewardItem.iconItem:setCountFontSize(40)
		rewardItem.iconItem:setHideLvAndBreakFlag(true)
		rewardItem.iconItem:hideEquipLvAndBreak(true)
		rewardItem.iconItem:isShowCount(isShowCount)
		gohelper.setActive(rewardItem.go, true)
	end

	for i = count + 1, #self.rewardItems do
		gohelper.setActive(self.rewardItems[i].go, false)
	end
end

function VersionActivity2_9DungeonMapLevelView:refreshMode()
	gohelper.setActive(self._gotype1, self.mode == VersionActivityDungeonBaseEnum.DungeonMode.Story)
	gohelper.setActive(self._gotype2, self.mode == VersionActivityDungeonBaseEnum.DungeonMode.Story2)
	gohelper.setActive(self._gotype3, self.mode == VersionActivityDungeonBaseEnum.DungeonMode.Story3)
	gohelper.setActive(self._gotype4, self.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard)

	local needShowLockNode = not self.modeCanFight or self.needPlayUnlockModeAnimation

	gohelper.setActive(self._gotype0, needShowLockNode)

	if needShowLockNode then
		self.lockTypeAnimator.enabled = true
		self.txtLockType.text = luaLang(VersionActivityDungeonBaseEnum.ChapterModeNameKey[self.mode])
	end

	gohelper.setActive(self.lockTypeIconGo, needShowLockNode)
	self:refreshBg()
end

function VersionActivity2_9DungeonMapLevelView:refreshBg()
	gohelper.setActive(self._simageactivitynormalbg.gameObject, self.mode ~= VersionActivityDungeonBaseEnum.DungeonMode.Story3)
	gohelper.setActive(self._simageactivityhardbg.gameObject, self.mode == VersionActivityDungeonBaseEnum.DungeonMode.Story3)
end

function VersionActivity2_9DungeonMapLevelView:refreshCostPower()
	local cost = 0

	if not string.nilorempty(self.showEpisodeCo.cost) then
		cost = string.splitToNumber(self.showEpisodeCo.cost, "#")[3]
	end

	self._txtusepowernormal.text = "-" .. cost
	self._txtusepowerhard.text = "-" .. cost

	if cost <= CurrencyModel.instance:getPower() then
		SLFramework.UGUI.GuiHelper.SetColor(self._txtusepowernormal, "#F5EFE6")
		SLFramework.UGUI.GuiHelper.SetColor(self._txtusepowerhard, "#F5EFE6")
	else
		SLFramework.UGUI.GuiHelper.SetColor(self._txtusepowernormal, "#800015")
		SLFramework.UGUI.GuiHelper.SetColor(self._txtusepowerhard, "#C44945")
	end
end

function VersionActivity2_9DungeonMapLevelView:refreshStartBtn()
	VersionActivity2_9DungeonMapLevelView.super.refreshStartBtn(self)
	self:_setBtnVisible(self._btnnormalStart.gameObject)
	self:_setBtnVisible(self._btnhardStart.gameObject)
	self:_setBtnVisible(self._simagepower.gameObject)
	self:_setBtnVisible(self._btnreplayStory.gameObject)
end

function VersionActivity2_9DungeonMapLevelView:_setBtnVisible(gobtn)
	if gohelper.isNil(gobtn) then
		return
	end

	gohelper.setActive(gobtn, gobtn.activeSelf and not self.needPlayUnlockModeAnimation)
end

function VersionActivity2_9DungeonMapLevelView:destroyStoryFlow()
	if self._storyFlow then
		self._storyFlow:destroy()
		self._storyFlow:destroy()
	end
end

function VersionActivity2_9DungeonMapLevelView:onDestroyView()
	self:destroyStoryFlow()
	VersionActivity2_9DungeonMapLevelView.super.onDestroyView(self)
end

return VersionActivity2_9DungeonMapLevelView
