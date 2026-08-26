-- chunkname: @modules/logic/versionactivity1_3/versionactivity1_3dungeonbase/view/VersionActivity1_3DungeonBaseMapLevelView.lua

module("modules.logic.versionactivity1_3.versionactivity1_3dungeonbase.view.VersionActivity1_3DungeonBaseMapLevelView", package.seeall)

local VersionActivity1_3DungeonBaseMapLevelView = class("VersionActivity1_3DungeonBaseMapLevelView", BaseView)

function VersionActivity1_3DungeonBaseMapLevelView:onInitView()
	self._btncloseview = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_closeview")
	self._simageactivitynormalbg = gohelper.findChildSingleImage(self.viewGO, "anim/versionactivity/bgmask/#simage_activitynormalbg")
	self._simageactivityhardbg = gohelper.findChildSingleImage(self.viewGO, "anim/versionactivity/bgmask/#simage_activityhardbg")
	self._txtmapName = gohelper.findChildText(self.viewGO, "anim/versionactivity/right/title/#txt_mapName")
	self._txtmapNameEn = gohelper.findChildText(self.viewGO, "anim/versionactivity/right/title/#txt_mapName/#txt_mapNameEn")
	self._txtmapNum = gohelper.findChildText(self.viewGO, "anim/versionactivity/right/title/#txt_mapName/#txt_mapNum")
	self._txtMapChapterIndex = gohelper.findChildText(self.viewGO, "anim/versionactivity/right/title/#txt_mapName/#txt_mapNum/#txt_mapChapterIndex")
	self._gonormaleye = gohelper.findChild(self.viewGO, "anim/versionactivity/right/title/#txt_mapName/#txt_mapNum/#image_normal")
	self._gohardeye = gohelper.findChild(self.viewGO, "anim/versionactivity/right/title/#txt_mapName/#txt_mapNum/#image_hard")
	self._imagestar1 = gohelper.findChildImage(self.viewGO, "anim/versionactivity/right/title/#txt_mapName/#txt_mapNum/stars/starLayout/#image_star1")
	self._imagestar2 = gohelper.findChildImage(self.viewGO, "anim/versionactivity/right/title/#txt_mapName/#txt_mapNum/stars/starLayout/#image_star2")
	self._goswitch = gohelper.findChild(self.viewGO, "anim/versionactivity/right/content/#go_switch")
	self._gotype0 = gohelper.findChild(self.viewGO, "anim/versionactivity/right/content/#go_switch/#go_type0")
	self._gotype1 = gohelper.findChild(self.viewGO, "anim/versionactivity/right/content/#go_switch/#go_type1")
	self._gotype2 = gohelper.findChild(self.viewGO, "anim/versionactivity/right/content/#go_switch/#go_type2")
	self._gotype3 = gohelper.findChild(self.viewGO, "anim/versionactivity/right/content/#go_switch/#go_type3")
	self._gotype4 = gohelper.findChild(self.viewGO, "anim/versionactivity/right/content/#go_switch/#go_type4")
	self._btnleftarrow = gohelper.findChildButtonWithAudio(self.viewGO, "anim/versionactivity/right/content/#go_switch/#btn_leftarrow")
	self._btnrightarrow = gohelper.findChildButtonWithAudio(self.viewGO, "anim/versionactivity/right/content/#go_switch/#btn_rightarrow")
	self._gorecommond = gohelper.findChild(self.viewGO, "anim/versionactivity/right/content/#go_recommend")
	self._txtrecommondlv = gohelper.findChildText(self.viewGO, "anim/versionactivity/right/content/#go_recommend/txt/#txt_recommendlv")
	self._txtactivitydesc = gohelper.findChildText(self.viewGO, "anim/versionactivity/right/content/#txt_activitydesc")
	self._gorewards = gohelper.findChild(self.viewGO, "anim/versionactivity/right/#go_rewards")
	self._goactivityrewarditem = gohelper.findChild(self.viewGO, "anim/versionactivity/right/#go_rewards/rewardList/#go_activityrewarditem")
	self._btnactivityreward = gohelper.findChildButtonWithAudio(self.viewGO, "anim/versionactivity/right/#go_rewards/#btn_activityreward")
	self._gonorewards = gohelper.findChild(self.viewGO, "anim/versionactivity/right/#go_norewards")
	self._btnnormalStart = gohelper.findChildButtonWithAudio(self.viewGO, "anim/versionactivity/right/startBtn/#btn_normalStart")
	self._txtusepowernormal = gohelper.findChildText(self.viewGO, "anim/versionactivity/right/startBtn/#btn_normalStart/#txt_usepowernormal")
	self._txtnorstarttext = gohelper.findChildText(self.viewGO, "anim/versionactivity/right/startBtn/#btn_normalStart/#txt_norstarttext")
	self._txtnorstarttexten = gohelper.findChildText(self.viewGO, "anim/versionactivity/right/startBtn/#btn_normalStart/#txt_norstarttexten")
	self._btnhardStart = gohelper.findChildButtonWithAudio(self.viewGO, "anim/versionactivity/right/startBtn/#btn_hardStart")
	self._btnlockStart = gohelper.findChildButtonWithAudio(self.viewGO, "anim/versionactivity/right/startBtn/#btn_lock")
	self._txtusepowerhard = gohelper.findChildText(self.viewGO, "anim/versionactivity/right/startBtn/#btn_hardStart/#txt_usepowerhard")
	self._simagepower = gohelper.findChildSingleImage(self.viewGO, "anim/versionactivity/right/startBtn/#simage_power")
	self._btnreplayStory = gohelper.findChildButtonWithAudio(self.viewGO, "anim/versionactivity/right/startBtn/#btn_replayStory")
	self._gorighttop = gohelper.findChild(self.viewGO, "anim/#go_righttop")
	self._golefttop = gohelper.findChild(self.viewGO, "anim/#go_lefttop")
	self._goruledesc = gohelper.findChild(self.viewGO, "anim/#go_ruledesc")
	self._btncloserule = gohelper.findChildButtonWithAudio(self.viewGO, "anim/#go_ruledesc/#btn_closerule")
	self._goruleitem = gohelper.findChild(self.viewGO, "anim/#go_ruledesc/bg/#go_ruleitem")
	self._goruleDescList = gohelper.findChild(self.viewGO, "anim/#go_ruledesc/bg/#go_ruleDescList")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_3DungeonBaseMapLevelView:addEvents()
	self._btncloseview:AddClickListener(self._btncloseviewOnClick, self)
	self._btnleftarrow:AddClickListener(self._btnleftarrowOnClick, self)
	self._btnrightarrow:AddClickListener(self._btnrightarrowOnClick, self)
	self._btnactivityreward:AddClickListener(self._btnactivityrewardOnClick, self)
	self._btnnormalStart:AddClickListener(self._btnnormalStartOnClick, self)
	self._btnhardStart:AddClickListener(self._btnhardStartOnClick, self)
	self._btnlockStart:AddClickListener(self._btnLockStartOnClick, self)
	self._btnreplayStory:AddClickListener(self._btnreplayStoryOnClick, self)
	self._btncloserule:AddClickListener(self._btncloseruleOnClick, self)
end

function VersionActivity1_3DungeonBaseMapLevelView:removeEvents()
	self._btncloseview:RemoveClickListener()
	self._btnleftarrow:RemoveClickListener()
	self._btnrightarrow:RemoveClickListener()
	self._btnactivityreward:RemoveClickListener()
	self._btnnormalStart:RemoveClickListener()
	self._btnlockStart:RemoveClickListener()
	self._btnhardStart:RemoveClickListener()
	self._btnreplayStory:RemoveClickListener()
	self._btncloserule:RemoveClickListener()
end

function VersionActivity1_3DungeonBaseMapLevelView:_btnreplayStoryOnClick()
	if not self.storyIdList or #self.storyIdList < 1 then
		return
	end

	StoryController.instance:playStories(self.storyIdList)

	local param = {}

	param.isLeiMiTeActivityStory = true

	StoryController.instance:resetStoryParam(param)
end

function VersionActivity1_3DungeonBaseMapLevelView:refreshStoryIdList()
	if self.originEpisodeConfig.type == DungeonEnum.EpisodeType.Story then
		self.storyIdList = nil

		return
	end

	if self.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard then
		self.storyIdList = nil

		return
	end

	self.storyIdList = {}

	if self.normalConfig.beforeStory > 0 and StoryModel.instance:isStoryHasPlayed(self.normalConfig.beforeStory) then
		table.insert(self.storyIdList, self.normalConfig.beforeStory)
	end

	if self.normalConfig.afterStory > 0 and StoryModel.instance:isStoryHasPlayed(self.normalConfig.afterStory) then
		table.insert(self.storyIdList, self.normalConfig.afterStory)
	end
end

function VersionActivity1_3DungeonBaseMapLevelView:_btncloseviewOnClick()
	self:startCloseTaskNextFrame()
end

function VersionActivity1_3DungeonBaseMapLevelView:startCloseTaskNextFrame()
	TaskDispatcher.runDelay(self.reallyClose, self, 0.01)
end

function VersionActivity1_3DungeonBaseMapLevelView:cancelStartCloseTask()
	TaskDispatcher.cancelTask(self.reallyClose, self)
end

function VersionActivity1_3DungeonBaseMapLevelView:reallyClose()
	self:closeThis()
end

function VersionActivity1_3DungeonBaseMapLevelView:_btnleftarrowOnClick()
	if self.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard then
		return
	end

	if #self.mode2EpisodeDict == 1 then
		return
	end

	if self.modeIndex <= 1 then
		return
	end

	self.modeIndex = self.modeIndex - 1

	self:refreshUIByMode(self.modeList[self.modeIndex])
end

function VersionActivity1_3DungeonBaseMapLevelView:_btnrightarrowOnClick()
	if self.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard then
		return
	end

	if #self.mode2EpisodeDict == 1 then
		return
	end

	if self.modeIndex >= #self.modeList then
		return
	end

	self.modeIndex = self.modeIndex + 1

	self:refreshUIByMode(self.modeList[self.modeIndex])
end

function VersionActivity1_3DungeonBaseMapLevelView:refreshUIByMode(mode)
	if self.mode == mode then
		return
	end

	self.animator:Play(UIAnimationName.Switch, 0, 0)

	self.mode = mode
	self.showEpisodeCo = self.mode2EpisodeDict[self.mode]
	self.showEpisodeMo = DungeonModel.instance:getEpisodeInfo(self.showEpisodeCo.id)

	if not self.showEpisodeMo then
		self.showEpisodeMo = UserDungeonMO.New()

		self.showEpisodeMo:initFromManual(self.showEpisodeCo.chapterId, self.showEpisodeCo.id, 0, 0)
	end
end

function VersionActivity1_3DungeonBaseMapLevelView:startRefreshUI()
	self:refreshUI()
end

function VersionActivity1_3DungeonBaseMapLevelView:_btnactivityrewardOnClick()
	DungeonController.instance:openDungeonRewardView(self.showEpisodeCo)
end

function VersionActivity1_3DungeonBaseMapLevelView:_btnnormalStartOnClick()
	if not self.modeCanFight then
		GameFacade.showToast(ToastEnum.VersionActivityCanFight, self:getPreModeName())

		return
	end

	self:startBattle()
end

function VersionActivity1_3DungeonBaseMapLevelView:_btnhardStartOnClick()
	self:startBattle()
end

function VersionActivity1_3DungeonBaseMapLevelView:_btnLockStartOnClick()
	GameFacade.showToast(ToastEnum.VersionActivityCanFight, self:getPreModeName())
end

function VersionActivity1_3DungeonBaseMapLevelView:_btncloseruleOnClick()
	return
end

function VersionActivity1_3DungeonBaseMapLevelView:startBattle()
	if self.showEpisodeCo.type == DungeonEnum.EpisodeType.Story then
		local skipStory = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.SkipStroy) or self.showEpisodeCo.beforeStory == 0

		if skipStory then
			self:_playSkipMainStory()
		else
			self:_playMainStory()
		end

		return
	end

	if self.isSpecialEpisode then
		self.lastEpisodeSelectModeDict[tostring(self.specialEpisodeId)] = self.mode

		self:saveEpisodeLastSelectMode()
	end

	if DungeonModel.instance:hasPassLevelAndStory(self.showEpisodeCo.id) then
		self:_enterFight()

		return
	end

	if self.showEpisodeCo.beforeStory > 0 then
		if not StoryModel.instance:isStoryFinished(self.showEpisodeCo.beforeStory) then
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
	end

	self:_enterFight()
end

function VersionActivity1_3DungeonBaseMapLevelView:_playMainStory()
	DungeonRpc.instance:sendStartDungeonRequest(self.showEpisodeCo.chapterId, self.showEpisodeCo.id)

	local param = {}

	param.mark = true
	param.episodeId = self.showEpisodeCo.id

	StoryController.instance:playStory(self.showEpisodeCo.beforeStory, param, self.onStoryFinished, self)
end

function VersionActivity1_3DungeonBaseMapLevelView:_playSkipMainStory()
	DungeonRpc.instance:sendStartDungeonRequest(self.showEpisodeCo.chapterId, self.showEpisodeCo.id)
	self:onStoryFinished()
end

function VersionActivity1_3DungeonBaseMapLevelView:playAfterStory(storyId)
	local param = {}

	param.mark = true
	param.episodeId = self.showEpisodeCo.id

	StoryController.instance:playStory(storyId, param, function()
		DungeonController.instance:dispatchEvent(DungeonEvent.OnUpdateDungeonInfo, nil)

		DungeonMapModel.instance.playAfterStory = true

		self:closeThis()
	end, self)
end

function VersionActivity1_3DungeonBaseMapLevelView:_playStoryAndEnterFight(storyId)
	if StoryModel.instance:isStoryFinished(storyId) then
		self:_enterFight()

		return
	end

	local param = {}

	param.mark = true
	param.episodeId = self.showEpisodeCo.id

	StoryController.instance:playStory(storyId, param, self._enterFight, self)
end

function VersionActivity1_3DungeonBaseMapLevelView:_enterFight()
	DungeonFightController.instance:enterFight(self.showEpisodeCo.chapterId, self.showEpisodeCo.id, 1)
end

function VersionActivity1_3DungeonBaseMapLevelView:onStoryFinished()
	DungeonModel.instance.curSendEpisodeId = nil

	DungeonModel.instance:setLastSendEpisodeId(self.showEpisodeCo.id)
	DungeonRpc.instance:sendEndDungeonRequest(false)
	self:closeThis()
end

function VersionActivity1_3DungeonBaseMapLevelView:initLocalEpisodeMode()
	self.unlockedEpisodeModeDict = self:loadDict(VersionActivity1_3EnterController.GetActivityPrefsKey(PlayerPrefsKey.ActivityDungeonSpecialEpisodeLastUnLockMode))
	self.lastEpisodeSelectModeDict = self:loadDict(VersionActivity1_3EnterController.GetActivityPrefsKey(PlayerPrefsKey.ActivityDungeonSpecialEpisodeLastSelectMode))
end

function VersionActivity1_3DungeonBaseMapLevelView:_onCurrencyChange(changeIds)
	if not changeIds[CurrencyEnum.CurrencyType.Power] then
		return
	end

	self:refreshCostPower()
end

function VersionActivity1_3DungeonBaseMapLevelView:_showEye()
	local showEye = self.originEpisodeConfig.displayMark == 1

	if not showEye then
		gohelper.setActive(self._gonormaleye, false)
		gohelper.setActive(self._gohardeye, false)

		return
	end

	local isHard = self.originEpisodeConfig.chapterId == VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBeiHard

	gohelper.setActive(self._gonormaleye, not isHard)
	gohelper.setActive(self._gohardeye, isHard)
end

function VersionActivity1_3DungeonBaseMapLevelView:_editableInitView()
	gohelper.setActive(self._goactivityrewarditem, false)
	gohelper.setActive(self._gonormaleye, false)
	gohelper.setActive(self._gohardeye, false)

	self.lockGoType = self._gotype0
	self.storyGoType = self._gotype1
	self.story2GoType = self._gotype2
	self.story3GoType = self._gotype3
	self.hardGoType = self._gotype4
	self.rewardItems = {}

	self._simageactivitynormalbg:LoadImage("singlebg/v1a3_dungeon_singlebg/v1a3_dungeon_normaldetailpanelbg.png")
	self._simageactivityhardbg:LoadImage("singlebg/v1a3_dungeon_singlebg/v1a3_dungeon_harddetailpanelbg.png")

	self.goVersionActivity = gohelper.findChild(self.viewGO, "anim/versionactivity")
	self.animator = self.goVersionActivity:GetComponent(typeof(UnityEngine.Animator))
	self.animationEventWrap = self.goVersionActivity:GetComponent(typeof(ZProj.AnimationEventWrap))

	self.animationEventWrap:AddEventListener("refresh", self.startRefreshUI, self)

	self.txtLockType = gohelper.findChildText(self.lockGoType, "txt")
	self.leftArrowLight = gohelper.findChild(self._btnleftarrow.gameObject, "left_arrow")
	self.leftArrowDisable = gohelper.findChild(self._btnleftarrow.gameObject, "left_arrow_disable")
	self.rightArrowLight = gohelper.findChild(self._btnrightarrow.gameObject, "right_arrow")
	self.rightArrowDisable = gohelper.findChild(self._btnrightarrow.gameObject, "right_arrow_disable")
	self.userId = PlayerModel.instance:getMyUserId()

	self:initLocalEpisodeMode()
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._onCurrencyChange, self)
end

function VersionActivity1_3DungeonBaseMapLevelView:initViewParam()
	self.originEpisodeId = self.viewParam.episodeId
	self.originEpisodeConfig = DungeonConfig.instance:getEpisodeCO(self.originEpisodeId)
	self.normalConfig = DungeonConfig.instance:getVersionActivityDungeonNormalEpisode(self.originEpisodeId, VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBeiHard, VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBei)
	self.isFromJump = self.viewParam.isJump
	self.index = self:getEpisodeIndex()

	self.viewContainer:setOpenedEpisodeId(self.originEpisodeId)

	self.showEpisodeCo = DungeonConfig.instance:getEpisodeCO(self.originEpisodeId)
	self.showEpisodeMo = DungeonModel.instance:getEpisodeInfo(self.originEpisodeId)
end

function VersionActivity1_3DungeonBaseMapLevelView:getEpisodeIndex()
	return DungeonConfig.instance:getEpisodeLevelIndexByEpisodeId(self.originEpisodeId)
end

function VersionActivity1_3DungeonBaseMapLevelView:markSelectEpisode()
	if self.originEpisodeConfig.type == DungeonEnum.EpisodeType.Act1_3Dungeon or self.originEpisodeConfig.type == DungeonEnum.EpisodeType.Boss then
		VersionActivityDungeonBaseController.instance:setChapterIdLastSelectEpisodeId(self.originEpisodeConfig.chapterId, self.originEpisodeId)
	end
end

function VersionActivity1_3DungeonBaseMapLevelView:onUpdateParam()
	self:onOpen()
end

function VersionActivity1_3DungeonBaseMapLevelView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_pagesopen)
	self:initViewParam()
	self:initMode()
	self:markSelectEpisode()
	self:refreshStoryIdList()
	self:refreshBg()
	self:refreshUI()
	self.animator:Play(UIAnimationName.Open, 0, 0)
	self:_showEye()
end

function VersionActivity1_3DungeonBaseMapLevelView:initMode()
	self.mode = ActivityConfig.instance:getChapterIdMode(self.originEpisodeConfig.chapterId)
	self.modeIndex = 1

	if self.mode ~= VersionActivityDungeonBaseEnum.DungeonMode.Hard then
		self.modeList = {
			VersionActivityDungeonBaseEnum.DungeonMode.Story,
			VersionActivityDungeonBaseEnum.DungeonMode.Story2,
			VersionActivityDungeonBaseEnum.DungeonMode.Story3
		}

		local episodeList = DungeonConfig.instance:getVersionActivityBrotherEpisodeByEpisodeCo(self.originEpisodeConfig)

		self.mode2EpisodeDict = {}

		for _, episodeCo in ipairs(episodeList) do
			self.mode2EpisodeDict[ActivityConfig.instance:getChapterIdMode(episodeCo.chapterId)] = episodeCo
		end

		self.isSpecialEpisode = #episodeList > 1
		self.specialEpisodeId = episodeList[1].id

		if self.isSpecialEpisode then
			if not self.isFromJump then
				local episodeCo

				for i = #episodeList, 1, -1 do
					if DungeonModel.instance:hasPassLevelAndStory(episodeList[i].preEpisode) then
						self.mode = self.modeList[i]

						break
					end
				end

				self:checkNeedPlayModeUnLockAnimation()

				if not self.needPlayUnlockModeAnimation then
					self.mode = self.lastEpisodeSelectModeDict[tostring(self.specialEpisodeId)] or VersionActivityDungeonBaseEnum.DungeonMode.Story
				end
			else
				self:checkNeedPlayModeUnLockAnimation()
			end

			for index, mode in ipairs(self.modeList) do
				if mode == self.mode then
					self.modeIndex = index

					break
				end
			end

			self.showEpisodeCo = self.mode2EpisodeDict[self.mode]
			self.showEpisodeMo = DungeonModel.instance:getEpisodeInfo(self.showEpisodeCo.id)

			if not self.showEpisodeMo then
				self.showEpisodeMo = UserDungeonMO.New()

				self.showEpisodeMo:initFromManual(self.showEpisodeCo.chapterId, self.showEpisodeCo.id, 0, 0)
			end
		end
	end
end

function VersionActivity1_3DungeonBaseMapLevelView:refreshBg()
	gohelper.setActive(self._simageactivitynormalbg.gameObject, self.mode ~= VersionActivityDungeonBaseEnum.DungeonMode.Hard)
	gohelper.setActive(self._simageactivityhardbg.gameObject, self.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard)
end

function VersionActivity1_3DungeonBaseMapLevelView:refreshUI()
	self:refreshModeCanFight()
	self:refreshEpisodeTextInfo()
	self:refreshStar()
	self:refreshMode()
	self:refreshArrow()
	self:refreshReward()
	self:refreshStartBtn()

	if self.needPlayUnlockModeAnimation then
		TaskDispatcher.runDelay(self.playModeUnlockAnimation, self, 0.4)
	end
end

function VersionActivity1_3DungeonBaseMapLevelView:refreshModeCanFight()
	if self.showEpisodeCo.preEpisode == 0 then
		self.modeCanFight = true

		return
	end

	self.modeCanFight = DungeonModel.instance:hasPassLevelAndStory(self.showEpisodeCo.preEpisode)
end

function VersionActivity1_3DungeonBaseMapLevelView:refreshEpisodeTextInfo()
	local chapterCo = DungeonConfig.instance:getChapterCO(self.showEpisodeCo.chapterId)

	self._txtmapName.text = self:buildEpisodeName()

	local txtColor = self.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard and "#cfccc9" or "#cfccc9"

	self._txtmapNameEn.text = self:buildColorText(self.showEpisodeCo.name_En, txtColor)
	self._txtmapNum.text = self:buildColorText(string.format("%02d", self.index), txtColor)
	self._txtMapChapterIndex.text = self:buildColorText(chapterCo.chapterIndex .. " .", txtColor)
	self._txtactivitydesc.text = self.showEpisodeCo.desc

	local recommendLevel = FightHelper.getEpisodeRecommendLevel(self.showEpisodeCo.id)

	gohelper.setActive(self._gorecommond, recommendLevel > 0)

	if recommendLevel > 0 then
		self._txtrecommondlv.text = HeroConfig.instance:getCommonLevelDisplay(recommendLevel)
	end
end

function VersionActivity1_3DungeonBaseMapLevelView:refreshStar()
	local normalEpisodeId = self.showEpisodeCo.id

	if normalEpisodeId then
		::label_41_0::

		local passStory = DungeonModel.instance:hasPassLevelAndStory(normalEpisodeId)
		local advancedConditionText = DungeonConfig.instance:getEpisodeAdvancedConditionText(normalEpisodeId)

		self:setImage(self._imagestar1, passStory, normalEpisodeId)

		if string.nilorempty(advancedConditionText) then
			gohelper.setActive(self._imagestar2.gameObject, false)
		else
			gohelper.setActive(self._imagestar2.gameObject, true)
			self:setImage(self._imagestar2, passStory and self.showEpisodeMo.star >= DungeonEnum.StarType.Advanced, normalEpisodeId)
		end
	end
end

function VersionActivity1_3DungeonBaseMapLevelView:refreshMode()
	gohelper.setActive(self.storyGoType, self.mode == VersionActivityDungeonBaseEnum.DungeonMode.Story)
	gohelper.setActive(self.story2GoType, self.mode == VersionActivityDungeonBaseEnum.DungeonMode.Story2)
	gohelper.setActive(self.story3GoType, self.mode == VersionActivityDungeonBaseEnum.DungeonMode.Story3)
	gohelper.setActive(self.hardGoType, self.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard)

	local needShowLockNode = not self.modeCanFight or self.needPlayUnlockModeAnimation

	gohelper.setActive(self.lockGoType, needShowLockNode)

	if needShowLockNode then
		self.txtLockType.text = luaLang(VersionActivityDungeonBaseEnum.ChapterModeNameKey[self.mode])

		if self.mode == VersionActivityDungeonBaseEnum.DungeonMode.Story2 then
			SLFramework.UGUI.GuiHelper.SetColor(self.txtLockType, "#757563")
		elseif self.mode == VersionActivityDungeonBaseEnum.DungeonMode.Story3 then
			SLFramework.UGUI.GuiHelper.SetColor(self.txtLockType, "#757563")
		end
	end

	local iconGo = gohelper.findChild(self.txtLockType.gameObject, "icon")

	gohelper.setActive(iconGo, needShowLockNode)
end

function VersionActivity1_3DungeonBaseMapLevelView:refreshArrow()
	local showArrow = self.mode ~= VersionActivityDungeonBaseEnum.DungeonMode.Hard and self.isSpecialEpisode

	gohelper.setActive(self._btnleftarrow.gameObject, showArrow)
	gohelper.setActive(self._btnrightarrow.gameObject, showArrow)

	if showArrow then
		gohelper.setActive(self.leftArrowLight, self.modeIndex ~= 1)
		gohelper.setActive(self.leftArrowDisable, self.modeIndex == 1)

		local isLast = #self.modeList == self.modeIndex

		gohelper.setActive(self.rightArrowLight, not isLast)
		gohelper.setActive(self.rightArrowDisable, isLast)
	end
end

function VersionActivity1_3DungeonBaseMapLevelView:refreshReward()
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

		if self.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard then
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

function VersionActivity1_3DungeonBaseMapLevelView:refreshStartBtn()
	self:refreshCostPower()

	local currencyCo = CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.Power)
	local powerIcon = ResUrl.getCurrencyItemIcon(currencyCo.icon .. "_btn")

	self._simagepower:LoadImage(powerIcon)
	gohelper.setActive(self._btnnormalStart.gameObject, self.modeCanFight and self.mode ~= VersionActivityDungeonBaseEnum.DungeonMode.Hard)
	gohelper.setActive(self._btnhardStart.gameObject, self.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard)
	gohelper.setActive(self._btnlockStart.gameObject, not self.modeCanFight or self.needPlayUnlockModeAnimation)

	if DungeonModel.instance:hasPassLevelAndStory(self.normalConfig.id) then
		if self.storyIdList then
			local showReplay = true

			showReplay = #self.storyIdList > 0

			gohelper.setActive(self._btnreplayStory, showReplay)

			if self.mode ~= VersionActivityDungeonBaseEnum.DungeonMode.Hard then
				if self.modeCanFight then
					if DungeonModel.instance:hasPassLevel(self.showEpisodeCo.id) and self.showEpisodeCo.afterStory > 0 and not StoryModel.instance:isStoryFinished(self.showEpisodeCo.afterStory) then
						self._txtnorstarttext.text = luaLang("p_dungeonlevelview_continuestory")

						recthelper.setAnchorX(self._txtnorstarttext.gameObject.transform, 0)
						recthelper.setAnchorX(self._txtnorstarttexten.gameObject.transform, 0)
						gohelper.setActive(self._txtusepowernormal.gameObject, false)
						gohelper.setActive(self._simagepower.gameObject, false)
					else
						self._txtnorstarttext.text = luaLang("p_dungeonlevelview_startfight")

						recthelper.setAnchorX(self._txtnorstarttext.gameObject.transform, 121)
						recthelper.setAnchorX(self._txtnorstarttexten.gameObject.transform, 121)
						gohelper.setActive(self._txtusepowernormal.gameObject, true)
						gohelper.setActive(self._simagepower.gameObject, true)
					end
				else
					gohelper.setActive(self._simagepower.gameObject, false)
					gohelper.setActive(self._txtusepowernormal.gameObject, false)
				end
			end
		end
	end
end

function VersionActivity1_3DungeonBaseMapLevelView:refreshCostPower()
	local cost = 0

	if not string.nilorempty(self.showEpisodeCo.cost) then
		cost = string.splitToNumber(self.showEpisodeCo.cost, "#")[3]
	end

	self._txtusepowernormal.text = "-" .. cost
	self._txtusepowerhard.text = "-" .. cost

	if cost <= CurrencyModel.instance:getPower() then
		SLFramework.UGUI.GuiHelper.SetColor(self._txtusepowernormal, "#070706")
		SLFramework.UGUI.GuiHelper.SetColor(self._txtusepowerhard, "#FFEAEA")
	else
		SLFramework.UGUI.GuiHelper.SetColor(self._txtusepowernormal, "#800015")
		SLFramework.UGUI.GuiHelper.SetColor(self._txtusepowerhard, "#C44945")
	end
end

function VersionActivity1_3DungeonBaseMapLevelView:checkNeedPlayModeUnLockAnimation()
	if self.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard or self.mode == VersionActivityDungeonBaseEnum.DungeonMode.Story then
		self.needPlayUnlockModeAnimation = false

		return
	end

	local unLockedMode = self.unlockedEpisodeModeDict[tostring(self.specialEpisodeId)] or VersionActivityDungeonBaseEnum.DungeonMode.Story

	self.needPlayUnlockModeAnimation = unLockedMode < self.mode
end

function VersionActivity1_3DungeonBaseMapLevelView:_playModeUnLockAnimation(animationName)
	local animator = self.lockGoType:GetComponent(typeof(UnityEngine.Animator))

	animator:Play(animationName)

	local goStartBtnRoot = gohelper.findChild(self.viewGO, "anim/versionactivity/right/startBtn")
	local btnAnimator = goStartBtnRoot:GetComponent(typeof(UnityEngine.Animator))

	btnAnimator:Play(animationName)
end

function VersionActivity1_3DungeonBaseMapLevelView:playModeUnlockAnimation()
	if self.needPlayUnlockModeAnimation then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_level_difficulty)
		self:_playModeUnLockAnimation(UIAnimationName.Unlock)
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("playModeUnlockAnimation")
		TaskDispatcher.runDelay(self.onModeUnlockAnimationPlayDone, self, 2.7)
	end
end

function VersionActivity1_3DungeonBaseMapLevelView:onModeUnlockAnimationPlayDone()
	self:_playModeUnLockAnimation(UIAnimationName.Idle)

	self.unlockedEpisodeModeDict[tostring(self.specialEpisodeId)] = self.mode

	self:saveEpisodeUnlockMode()
	UIBlockMgrExtend.setNeedCircleMv(true)

	self.needPlayUnlockModeAnimation = false

	self:refreshMode()
	self:refreshStartBtn()
	UIBlockMgr.instance:endBlock("playModeUnlockAnimation")
end

function VersionActivity1_3DungeonBaseMapLevelView:setImage(image, light, episodeId)
	if light then
		local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)
		local starType = VersionActivity1_3DungeonEnum.EpisodeStarType[episodeConfig.chapterId]

		UISpriteSetMgr.instance:setVersionActivity1_3Sprite(image, starType)
	else
		local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)
		local starType = VersionActivity1_3DungeonEnum.EpisodeStarEmptyType[episodeConfig.chapterId]

		UISpriteSetMgr.instance:setVersionActivity1_3Sprite(image, starType)
	end
end

function VersionActivity1_3DungeonBaseMapLevelView:buildEpisodeName()
	local name = self.showEpisodeCo.name
	local firstName = GameUtil.utf8sub(name, 1, 1)
	local nameLen = GameUtil.utf8len(name)
	local txtColor = self.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard and "#cfccc9" or "#cfccc9"

	return self:buildColorText(string.format("<size=112>%s</size>%s", firstName, (nameLen > 1 or nil) and GameUtil.utf8sub(name, 2, nameLen - 1)), txtColor)
end

function VersionActivity1_3DungeonBaseMapLevelView:buildColorText(text, color)
	return string.format("<color=%s>%s</color>", color, text)
end

function VersionActivity1_3DungeonBaseMapLevelView:getPreModeName()
	local modeIndex = self.modeIndex - 1
	local mode = self.modeList[modeIndex]

	if not mode then
		logWarn("not modeIndex mode : " .. modeIndex)

		return ""
	end

	return luaLang(VersionActivityDungeonBaseEnum.ChapterModeNameKey[mode])
end

function VersionActivity1_3DungeonBaseMapLevelView:getKey(key)
	return key .. self.userId
end

function VersionActivity1_3DungeonBaseMapLevelView:loadDict(key)
	key = self:getKey(key)

	local playerString = PlayerPrefsHelper.getString(key, "")

	if string.nilorempty(playerString) then
		return {}
	end

	return cjson.decode(playerString)
end

function VersionActivity1_3DungeonBaseMapLevelView:saveEpisodeUnlockMode()
	PlayerPrefsHelper.setString(self:getKey(VersionActivity1_3EnterController.GetActivityPrefsKey(PlayerPrefsKey.ActivityDungeonSpecialEpisodeLastUnLockMode)), cjson.encode(self.unlockedEpisodeModeDict))
end

function VersionActivity1_3DungeonBaseMapLevelView:saveEpisodeLastSelectMode()
	PlayerPrefsHelper.setString(self:getKey(VersionActivity1_3EnterController.GetActivityPrefsKey(PlayerPrefsKey.ActivityDungeonSpecialEpisodeLastSelectMode)), cjson.encode(self.lastEpisodeSelectModeDict))
end

function VersionActivity1_3DungeonBaseMapLevelView:onClose()
	TaskDispatcher.cancelTask(self.onModeUnlockAnimationPlayDone, self)
	TaskDispatcher.cancelTask(self.playModeUnlockAnimation, self)
end

function VersionActivity1_3DungeonBaseMapLevelView:onDestroyView()
	self.animationEventWrap:RemoveAllEventListener()

	self.rewardItems = nil

	self._simageactivitynormalbg:UnLoadImage()
	self._simageactivityhardbg:UnLoadImage()
	self._simagepower:UnLoadImage()
end

return VersionActivity1_3DungeonBaseMapLevelView
