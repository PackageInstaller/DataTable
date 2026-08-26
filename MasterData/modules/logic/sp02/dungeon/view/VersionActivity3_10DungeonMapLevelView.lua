-- chunkname: @modules/logic/sp02/dungeon/view/VersionActivity3_10DungeonMapLevelView.lua

module("modules.logic.sp02.dungeon.view.VersionActivity3_10DungeonMapLevelView", package.seeall)

local VersionActivity3_10DungeonMapLevelView = class("VersionActivity3_10DungeonMapLevelView", VersionActivityFixedDungeonMapLevelView)
local UNLOCK_ANIM_TIME = 2.7

function VersionActivity3_10DungeonMapLevelView:onOpen()
	AudioMgr.instance:trigger(AudioEnum3_10.Dungeon.play_ui_langchao_tv_unfold)

	self.fightPosX = 70

	self:initViewParam()
	self:refreshView()
	self.animator:Play(UIAnimationName.Open, 0, 0)
	VersionActivityFixedDungeonController.instance:dispatchEvent(VersionActivityFixedDungeonEvent.OpenFinishMapLevelView, self.viewGO)
end

function VersionActivity3_10DungeonMapLevelView:refreshViewOrUI()
	if self.isRefreshView then
		self:refreshView()
	else
		self:refreshUI()
	end

	self.isRefreshView = nil
end

function VersionActivity3_10DungeonMapLevelView:refreshView()
	self:initMode()
	self:markSelectEpisode()
	self:refreshStoryIdList()
	self:refreshBg()
	self:refreshUI()
	self:playEpisodeVideo()
	self:refreshPreNextEpisode()
end

function VersionActivity3_10DungeonMapLevelView:onInitView()
	VersionActivity3_10DungeonMapLevelView.super.onInitView(self)

	self._modeColor1 = "#D9C999"
	self._modeColor2 = "#F94D2B"
	self._modeColor3 = "#E1273E"
	self._modeColor4 = "#E1273E"
	self.goStarSP02 = gohelper.findChild(self.viewGO, "anim/versionactivity/right/title/#txt_mapName/stars_sp02")
	self.imageFrameBG = gohelper.findChildImage(self.goStarSP02, "#image_framefg")
	self.imageFrameIcon = gohelper.findChildImage(self.goStarSP02, "#image_icon")

	gohelper.setActive(self._btnactivityreward, false)

	self._btncloseview = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_closeview")

	self.addClickCb(self, self._btncloseview, self.onClickCloseView, self)

	self.goVideoRoot = gohelper.findChild(self.viewGO, "anim/versionactivity/bgmask/#go_videomask/#go_video")
	self.txtPlace = gohelper.findChildTextMesh(self.viewGO, "anim/versionactivity/right/place/#txt_place")
	self._txtactivitydesc = gohelper.findChildText(self.viewGO, "anim/versionactivity/right/content/#scroll_desc/viewport/#txt_activitydesc")
	self._btnPreEpisode = gohelper.findChildButtonWithAudio(self.viewGO, "anim/versionactivity/#btn_leftarrow")
	self._btnNextEpisode = gohelper.findChildButtonWithAudio(self.viewGO, "anim/versionactivity/#btn_rightarrow")
	self.goNormalReplay = gohelper.findChild(self.viewGO, "anim/versionactivity/right/startBtn/#btn_replayStory/normalbtn")
	self.goHardReplay = gohelper.findChild(self.viewGO, "anim/versionactivity/right/startBtn/#btn_replayStory/hardbtn")
	self._txtmapChapterIndex2 = gohelper.findChildText(self.viewGO, "anim/versionactivity/right/title/#txt_mapName/#txt_mapName/#txt_mapChapterIndex")
	self._txtMapS02Name = gohelper.findChildText(self.viewGO, "anim/versionactivity/right/title/#txt_mapName/#txt_mapName")
end

function VersionActivity3_10DungeonMapLevelView:addEvents()
	VersionActivity3_10DungeonMapLevelView.super.addEvents(self)
	self.addClickCb(self, self._btnPreEpisode, self.onClickPreEpisode, self)
	self.addClickCb(self, self._btnNextEpisode, self.onClickNextEpisode, self)
	self.animationEventWrap:AddEventListener("refresh", self.refreshViewOrUI, self)
end

function VersionActivity3_10DungeonMapLevelView:removeEvents()
	VersionActivity3_10DungeonMapLevelView.super.removeEvents(self)
	self:removeClickCb(self._btnPreEpisode)
	self:removeClickCb(self._btnNextEpisode)
end

function VersionActivity3_10DungeonMapLevelView:onClickPreEpisode()
	self:moveToEpisode(-1)
end

function VersionActivity3_10DungeonMapLevelView:onClickNextEpisode()
	self:moveToEpisode(1)
end

function VersionActivity3_10DungeonMapLevelView:moveToEpisode(offset)
	local config = self:getEpisodeConfigByOffset(offset)

	if not self:isEpisodeUnlock(config) then
		return
	end

	self:initViewParamByEpisodeId(config.id)

	self.isRefreshView = true

	if offset < 0 then
		self.animator:Play("switch_left", 0, 0)
	else
		self.animator:Play("switch_right", 0, 0)
	end
end

function VersionActivity3_10DungeonMapLevelView:getEpisodeConfigByOffset(offset)
	local curEpisodeConfig = self.originEpisodeConfig
	local episodeList = DungeonConfig.instance:getChapterEpisodeCOList(curEpisodeConfig.chapterId)
	local curIndex = 1

	for i, config in ipairs(episodeList) do
		if config.id == curEpisodeConfig.id then
			curIndex = i

			break
		end
	end

	return episodeList[curIndex + offset]
end

function VersionActivity3_10DungeonMapLevelView:refreshPreNextEpisode()
	local isHardMode = self.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard

	if not isHardMode then
		VersionActivity3_10DungeonController.instance:setHasUnlockEpisode(self.originEpisodeConfig.id)
	end

	local preConfig = self:getEpisodeConfigByOffset(-1)
	local nextConfig = self:getEpisodeConfigByOffset(1)

	gohelper.setActive(self._btnPreEpisode, self:isEpisodeUnlock(preConfig))
	gohelper.setActive(self._btnNextEpisode, self:isEpisodeUnlock(nextConfig))
end

function VersionActivity3_10DungeonMapLevelView:isEpisodeUnlock(config)
	local episodeMo = config and DungeonModel.instance:getEpisodeInfo(config.id) or nil

	return episodeMo ~= nil
end

function VersionActivity3_10DungeonMapLevelView:onClickCloseView()
	AudioMgr.instance:trigger(AudioEnum3_10.Dungeon.play_ui_langchao_tv_click)
	self:closeThis()
end

function VersionActivity3_10DungeonMapLevelView:playModeUnlockAnimation()
	if not self.needPlayUnlockModeAnimation then
		return
	end

	self:_playModeUnLockAnimation(UIAnimationName.Unlock)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(VersionActivityFixedHelper.getVersionActivityDungeonEnum().BlockKey.MapLevelViewPlayUnlockAnim)
	TaskDispatcher.runDelay(self.onModeUnlockAnimationPlayDone, self, UNLOCK_ANIM_TIME)
end

function VersionActivity3_10DungeonMapLevelView:refreshEpisodeTextInfo()
	local chapterCo = DungeonConfig.instance:getChapterCO(self.showEpisodeCo.chapterId)
	local targetConfig = chapterCo.id == VersionActivityFixedHelper.getVersionActivityDungeonEnum().DungeonChapterId.Story and self.showEpisodeCo or VersionActivityFixedDungeonConfig.instance:getStoryEpisodeCo(self.showEpisodeCo.id)

	self._txtmapName.text = self:buildEpisodeName(targetConfig)
	self._txtactivitydesc.text = targetConfig.desc

	local indexStr = chapterCo.chapterIndex .. " ."

	self._txtmapChapterIndex.text = indexStr
	self._txtmapChapterIndex2.text = indexStr

	if self.index == 1 then
		gohelper.setActive(self._txtmapNum, false)
		gohelper.setActive(self._txtMapS02Name, true)

		self._txtMapS02Name.text = luaLang("sp02_dungeonmap_txt1")
	elseif self.index == 16 then
		gohelper.setActive(self._txtmapNum, false)
		gohelper.setActive(self._txtMapS02Name, true)

		self._txtMapS02Name.text = luaLang("sp02_dungeonmap_txt2")
	else
		gohelper.setActive(self._txtmapNum, true)
		gohelper.setActive(self._txtMapS02Name, false)

		self._txtmapNum.text = string.format("%02d", self.index - 1)
	end

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

function VersionActivity3_10DungeonMapLevelView:buildEpisodeName(episodeCo)
	local name = episodeCo.name
	local firstName = GameUtil.utf8sub(name, 1, 1)
	local nameLen = GameUtil.utf8len(name)

	return string.format("<size=74>%s</size>%s", firstName, (nameLen > 1 or nil) and GameUtil.utf8sub(name, 2, nameLen - 1))
end

function VersionActivity3_10DungeonMapLevelView:refreshStar()
	local progress = VersionActivity3_10DungeonHelper.calcEpisodeProgress(self.showEpisodeCo.id)
	local showColor = self[string.format("_modeColor%d", self.mode)] or self._modeColor

	SLFramework.UGUI.GuiHelper.SetColor(self.imageFrameBG, showColor)
	SLFramework.UGUI.GuiHelper.SetColor(self.imageFrameIcon, showColor)

	self.imageFrameBG.fillAmount = progress
end

function VersionActivity3_10DungeonMapLevelView:refreshMode()
	VersionActivity3_10DungeonMapLevelView.super.refreshMode(self)
	self:refreshBg()
end

function VersionActivity3_10DungeonMapLevelView:refreshBg()
	gohelper.setActive(self._simageactivitynormalbg.gameObject, self.mode ~= VersionActivityDungeonBaseEnum.DungeonMode.Story3)
	gohelper.setActive(self._simageactivityhardbg.gameObject, self.mode == VersionActivityDungeonBaseEnum.DungeonMode.Story3)
end

function VersionActivity3_10DungeonMapLevelView:refreshCostPower()
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

function VersionActivity3_10DungeonMapLevelView:refreshStartBtn()
	self:refreshCostPower()

	local currencyCo = CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.Power)
	local powerIcon = ResUrl.getCurrencyItemIcon(currencyCo.icon .. "_btn")
	local isHardMode = self.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard
	local notHardMode = not isHardMode

	gohelper.setActive(self._btnnormalStart, self.modeCanFight and notHardMode)
	gohelper.setActive(self._btnhardStart, isHardMode)
	gohelper.setActive(self._btnlockStart, not self.modeCanFight or self.needPlayUnlockModeAnimation)
	gohelper.setActive(self.goNormalReplay, notHardMode)
	gohelper.setActive(self.goHardReplay, isHardMode)

	if self.storyIdList then
		local hasStory = #self.storyIdList > 0

		if self.mode2EpisodeDict then
			if self.mode2EpisodeDict then
				if not self.mode2EpisodeDict.id then
					local checkPassEpisodeId = self.originEpisodeConfig.id
					local hasPassLevelAndStory = DungeonModel.instance:hasPassLevelAndStory(checkPassEpisodeId)

					gohelper.setActive(self._btnreplayStory, hasPassLevelAndStory and hasStory)

					if isHardMode then
						return
					end

					if self.modeCanFight then
						local hasPassLevel = DungeonModel.instance:hasPassLevel(self.showEpisodeCo.id)
						local isStoryFinished = StoryModel.instance:isStoryFinished(self.showEpisodeCo.afterStory)

						if hasPassLevel and self.showEpisodeCo.afterStory > 0 and not isStoryFinished then
							self._txtnorstarttext.text = luaLang("p_dungeonlevelview_continuestory")

							gohelper.setActive(self._txtusepowernormal, false)
						else
							self._txtnorstarttext.text = luaLang("p_dungeonlevelview_startfight")

							gohelper.setActive(self._txtusepowernormal, true)
						end
					else
						gohelper.setActive(self._txtusepowernormal, false)
					end

					self:_setBtnVisible(self._btnnormalStart.gameObject)
					self:_setBtnVisible(self._btnhardStart.gameObject)
					self:_setBtnVisible(self._btnreplayStory.gameObject)
				end
			end
		end
	end
end

function VersionActivity3_10DungeonMapLevelView:_setBtnVisible(gobtn)
	if gohelper.isNil(gobtn) then
		return
	end

	gohelper.setActive(gobtn, gobtn.activeSelf and not self.needPlayUnlockModeAnimation)
end

function VersionActivity3_10DungeonMapLevelView:playEpisodeVideo()
	local animConfig = AtomicConfig.instance:getEpisodeAnimConfig(self.originEpisodeId)

	if not animConfig then
		return
	end

	self.txtPlace.text = animConfig.place

	local videoPath = animConfig.video
	local isLoop = animConfig.isloop == 1

	self._videoItem = self._videoItem or StoryActivityVideoItem.New(self.goVideoRoot)

	local videoCo = {
		height = 756,
		width = 882,
		loop = isLoop
	}

	self._videoItem:playVideo(videoPath, videoCo)

	if self.maskComp then
		return
	end

	require("tolua.reflection")
	tolua.loadassembly("Coffee.SoftMaskForUGUI")

	local type = tolua.findtype("Coffee.UISoftMask.SoftMaskable")

	self.maskComp = gohelper.onceAddComponent(self._videoItem._videoGo, type)
end

function VersionActivity3_10DungeonMapLevelView:customInitRewardItem(rewardItem)
	rewardItem.goProgress = gohelper.findChild(rewardItem.go, "rare/#go_progress")
	rewardItem.imgProgressIcon = gohelper.findChildImage(rewardItem.goProgress, "icon")
	rewardItem.imgProgress = gohelper.findChildImage(rewardItem.goProgress, "#image_icon")
end

function VersionActivity3_10DungeonMapLevelView:customRefreshRewardItem(rewardItem, reward)
	local gonormalShow = rewardItem.gonormal.activeSelf

	if gonormalShow then
		gohelper.setActive(rewardItem.goProgress, false)

		return
	end

	local var_25_0 = rewardItem.goadvance.activeSelf

	if not rewardItem.goadvance.activeSelf then
		var_25_0 = rewardItem.gofirsthard.activeSelf

		if not rewardItem.gofirsthard.activeSelf then
			local goAdvanceRareShow = rewardItem.gofirst.activeSelf

			if goAdvanceRareShow then
				gohelper.setActive(rewardItem.goProgress, true)
				gohelper.setActive(rewardItem.goadvance, false)
				gohelper.setActive(rewardItem.gofirsthard, false)
				gohelper.setActive(rewardItem.gofirst, false)

				local progress = VersionActivity3_10DungeonHelper.calcEpisodeProgress(self.showEpisodeCo.id)
				local showColor = self[string.format("_modeColor%d", self.mode)] or self._modeColor

				SLFramework.UGUI.GuiHelper.SetColor(rewardItem.imgProgressIcon, showColor)
				SLFramework.UGUI.GuiHelper.SetColor(rewardItem.imgProgress, showColor)

				rewardItem.imgProgress.fillAmount = progress
			else
				gohelper.setActive(rewardItem.goProgress, false)
			end
		end
	end
end

function VersionActivity3_10DungeonMapLevelView:onClose()
	VersionActivity3_10DungeonMapLevelView.super.onClose(self)
	AudioMgr.instance:trigger(AudioEnum3_10.Dungeon.play_ui_langchao_tv_close)
end

function VersionActivity3_10DungeonMapLevelView:onDestroyView()
	if self._videoItem then
		self._videoItem:onDestroy()

		self._videoItem = nil
	end

	VersionActivity3_10DungeonMapLevelView.super.onDestroyView(self)
end

return VersionActivity3_10DungeonMapLevelView
