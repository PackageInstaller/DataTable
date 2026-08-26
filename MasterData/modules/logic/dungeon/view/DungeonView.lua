-- chunkname: @modules/logic/dungeon/view/DungeonView.lua

module("modules.logic.dungeon.view.DungeonView", package.seeall)

local DungeonView = class("DungeonView", BaseView)

function DungeonView:onInitView()
	self._gostory = gohelper.findChild(self.viewGO, "#go_story")
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#go_story/#simage_bg")
	self._scrollchapter = gohelper.findChildScrollRect(self.viewGO, "#go_story/chapterlist/#scroll_chapter")
	self._goresource = gohelper.findChild(self.viewGO, "#go_resource")
	self._simageresourcebg = gohelper.findChildSingleImage(self.viewGO, "#go_resource/#simage_resourcebg")
	self._simagedrawbg = gohelper.findChildSingleImage(self.viewGO, "#go_resource/#simage_drawbg")
	self._scrollchapterresource = gohelper.findChildScrollRect(self.viewGO, "#go_resource/chapterlist/#scroll_chapter_resource")
	self._gorescontent = gohelper.findChild(self.viewGO, "#go_resource/chapterlist/#scroll_chapter_resource/#go_rescontent")
	self._goweekwalk = gohelper.findChild(self.viewGO, "#go_weekwalk")
	self._goexplore = gohelper.findChild(self.viewGO, "#go_explore")
	self._btnstory = gohelper.findChildButtonWithAudio(self.viewGO, "bottom/categorylist/#btn_story")
	self._gostoryUnselectText = gohelper.findChild(self.viewGO, "bottom/categorylist/#btn_story/#go_storyUnselectText")
	self._gostorySelectText = gohelper.findChild(self.viewGO, "bottom/categorylist/#btn_story/#go_storySelectText")
	self._gostorytrace = gohelper.findChild(self.viewGO, "bottom/categorylist/#btn_story/#go_trace")
	self._btnexplore = gohelper.findChildButtonWithAudio(self.viewGO, "bottom/categorylist/#btn_secretroom")
	self._goexploreUnselectText = gohelper.findChild(self.viewGO, "bottom/categorylist/#btn_secretroom/#go_secretroomUnselectText")
	self._goexploreSelectText = gohelper.findChild(self.viewGO, "bottom/categorylist/#btn_secretroom/#go_secretroomSelectText")
	self._gogoldUnselectIcon = gohelper.findChild(self.viewGO, "bottom/categorylist/#btn_gold/#go_goldUnselectText/icon")
	self._gogoldRedPoint = gohelper.findChild(self.viewGO, "bottom/categorylist/#btn_gold/#go_goldUnselectText/icon_redpoint")
	self._btngold = gohelper.findChildButtonWithAudio(self.viewGO, "bottom/categorylist/#btn_gold")
	self._gogoldUnselectText = gohelper.findChild(self.viewGO, "bottom/categorylist/#btn_gold/#go_goldUnselectText")
	self._gogoldSelectText = gohelper.findChild(self.viewGO, "bottom/categorylist/#btn_gold/#go_goldSelectText")
	self._gogoldtrace = gohelper.findChild(self.viewGO, "bottom/categorylist/#btn_gold/#go_trace")
	self._btnresource = gohelper.findChildButtonWithAudio(self.viewGO, "bottom/categorylist/#btn_resource")
	self._goresUnselectText = gohelper.findChild(self.viewGO, "bottom/categorylist/#btn_resource/#go_resUnselectText")
	self._goresSelectText = gohelper.findChild(self.viewGO, "bottom/categorylist/#btn_resource/#go_resSelectText")
	self._goresourcetrace = gohelper.findChild(self.viewGO, "bottom/categorylist/#btn_resource/#go_trace")
	self._btnweekwalk = gohelper.findChildButtonWithAudio(self.viewGO, "bottom/categorylist/#btn_weekwalk")
	self._goweekwalkUnselectText = gohelper.findChild(self.viewGO, "bottom/categorylist/#btn_weekwalk/#go_weekwalkUnselectText")
	self._goweekwalkSelectText = gohelper.findChild(self.viewGO, "bottom/categorylist/#btn_weekwalk/#go_weekwalkSelectText")
	self._goweekwalkicon = gohelper.findChild(self.viewGO, "bottom/categorylist/#btn_weekwalk/#go_weekwalkUnselectText/#go_weekwalk_icon")
	self._goweekwalkreward1 = gohelper.findChild(self.viewGO, "bottom/categorylist/#btn_weekwalk/#go_weekwalkUnselectText/#go_weekwalk_reward1")
	self._goweekwalkreward2 = gohelper.findChild(self.viewGO, "bottom/categorylist/#btn_weekwalk/#go_weekwalkUnselectText/#go_weekwalk_reward2")
	self._goweekwalkreward3 = gohelper.findChild(self.viewGO, "bottom/categorylist/#btn_weekwalk/#go_weekwalkUnselectText/#go_weekwalk_reward3")
	self._btnrouge = gohelper.findChildButtonWithAudio(self.viewGO, "bottom/categorylist/#btn_rouge")
	self._gorougeUnselectText = gohelper.findChild(self.viewGO, "bottom/categorylist/#btn_rouge/#go_rougeUnselectText")
	self._gorougeSelectText = gohelper.findChild(self.viewGO, "bottom/categorylist/#btn_rouge/#go_rougeSelectText")
	self._gorougeUnRed = gohelper.findChild(self.viewGO, "bottom/categorylist/#btn_rouge/#go_rougeUnselectText/redpoint")

	RedDotController.instance:addRedDotTag(self._gorougeUnRed, RedDotEnum.DotNode.DungeonRougeEntry)

	self._goRoleStory = gohelper.findChild(self.viewGO, "#go_RoleStory")
	self._btnanecdote = gohelper.findChildButtonWithAudio(self.viewGO, "bottom/categorylist/#btn_anecdote")
	self._goanecdoteUnselectText = gohelper.findChild(self.viewGO, "bottom/categorylist/#btn_anecdote/#go_anecdoteUnselectText")
	self._goanecdoteSelectText = gohelper.findChild(self.viewGO, "bottom/categorylist/#btn_anecdote/#go_anecdoteSelectText")
	self._goanecdoteUnRed = gohelper.findChild(self.viewGO, "bottom/categorylist/#btn_anecdote/#go_anecdoteUnselectText/icon")
	self._goanecdoteRed = gohelper.findChild(self.viewGO, "bottom/categorylist/#btn_anecdote/#go_anecdoteUnselectText/icon1")

	RedDotController.instance:addRedDotTag(self._goanecdoteUnRed, RedDotEnum.DotNode.RoleStory, true)
	RedDotController.instance:addRedDotTag(self._goanecdoteRed, RedDotEnum.DotNode.RoleStory)

	self._gopermanent = gohelper.findChild(self.viewGO, "#go_permanent")
	self._btnpermanent = gohelper.findChildButtonWithAudio(self.viewGO, "bottom/categorylist/#btn_permanent")
	self._goperUnselectText = gohelper.findChild(self.viewGO, "bottom/categorylist/#btn_permanent/#go_perUnselectText")
	self._goperUnselectIcon = gohelper.findChild(self.viewGO, "bottom/categorylist/#btn_permanent/#go_perUnselectText/icon")
	self._goperSelectText = gohelper.findChild(self.viewGO, "bottom/categorylist/#btn_permanent/#go_perSelectText")
	self._goreddotpermanent = gohelper.findChild(self.viewGO, "bottom/categorylist/#btn_permanent/#go_perUnselectText/redpoint")
	self._goreddotpermanentTag = RedDotController.instance:addRedDotTag(self._goreddotpermanent, RedDotEnum.DotNode.Dungeon_Permanent, false, self._checkPermanentReddot, self)
	self._btntrace = gohelper.findChildButtonWithAudio(self.viewGO, "#go_story/layout/#btn_trace")
	self._simagetracehero = gohelper.findChildSingleImage(self.viewGO, "#go_story/layout/#btn_trace/#simage_hero")
	self._btnDramaReward = gohelper.findChildButtonWithAudio(self.viewGO, "#go_story/layout/#btn_story")
	self._gostoryUnselectTextIcon = gohelper.findChild(self.viewGO, "bottom/categorylist/#btn_story/#go_storyUnselectText/icon")
	self._goreddotstory = gohelper.findChild(self.viewGO, "bottom/categorylist/#btn_story/#go_storyUnselectText/redpoint")
	self.storyUnSelectIconTag = RedDotController.instance:addRedDotTag(self._gostoryUnselectTextIcon, RedDotEnum.DotNode.HeroInvitationReward, true, self.refreshStoryIcon, self)
	self.storySelectIconTag = RedDotController.instance:addRedDotTag(self._goreddotstory, RedDotEnum.DotNode.HeroInvitationReward, nil, self.refreshStoryIcon, self)
	self._btntower = gohelper.findChildButtonWithAudio(self.viewGO, "bottom/categorylist/#btn_tower")
	self._gotowerUnselectText = gohelper.findChild(self.viewGO, "bottom/categorylist/#btn_tower/#go_towerUnselectText")
	self._gotowerSelectText = gohelper.findChild(self.viewGO, "bottom/categorylist/#btn_tower/#go_towerSelectText")
	self._gotowerReddotEffect = gohelper.findChild(self.viewGO, "bottom/categorylist/#btn_tower/#go_towerUnselectText/redpoint")
	self._btnadvplay = gohelper.findChildButtonWithAudio(self.viewGO, "bottom/categorylist/#btn_advplay")
	self._goadvplayUnselectText = gohelper.findChild(self.viewGO, "bottom/categorylist/#btn_advplay/#go_advplayUnselectText")
	self._goadvplaySelectText = gohelper.findChild(self.viewGO, "bottom/categorylist/#btn_advplay/#go_advplaySelectText")
	self._goadvplayReddotEffect = gohelper.findChild(self.viewGO, "bottom/categorylist/#btn_advplay/#go_advplayUnselectText/redpoint")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DungeonView:addEvents()
	self._btnpermanent:AddClickListener(self._btnpermanentOnClick, self)
	self._btnrouge:AddClickListener(self._btnrougeOnClick, self)
	self._btnexplore:AddClickListener(self._btnexploreOnClick, self)
	self._btntrace:AddClickListener(self._btntracedOnClick, self)
	self._btnstory:AddClickListener(self._btnstoryOnClick, self)
	self._btngold:AddClickListener(self._btngoldOnClick, self)
	self._btnresource:AddClickListener(self._btnresourceOnClick, self)
	self._btnweekwalk:AddClickListener(self._btnweekwalkOnClick, self)
	self._btnanecdote:AddClickListener(self._btnanecdoteOnClick, self)
	self._btnDramaReward:AddClickListener(self._btnDramaRewardOnClick, self)
	self._btntower:AddClickListener(self._btnTowerOnClick, self)
	self._btnadvplay:AddClickListener(self._btnadvplayOnClick, self)
	self.addEventCb(self, RoleStoryController.instance, RoleStoryEvent.ResidentStoryChange, self._onResidentStoryChange, self)
	self.addEventCb(self, TowerController.instance, TowerEvent.RefreshTowerReddot, self._showTowerEffect, self)
	self.addEventCb(self, CharacterRecommedController.instance, CharacterRecommedEvent.OnLoadFinishTracedIcon, self._refreshTracedIcon, self)
	self.addEventCb(self, CharacterRecommedController.instance, CharacterRecommedEvent.OnRefreshTraced, self._refreshTraced, self)
end

function DungeonView:removeEvents()
	self._btnpermanent:RemoveClickListener()
	self._btnrouge:RemoveClickListener()
	self._btnexplore:RemoveClickListener()
	self._btntrace:RemoveClickListener()
	self._btnstory:RemoveClickListener()
	self._btngold:RemoveClickListener()
	self._btnresource:RemoveClickListener()
	self._btnweekwalk:RemoveClickListener()
	self._btnanecdote:RemoveClickListener()
	self._btnDramaReward:RemoveClickListener()
	self._btntower:RemoveClickListener()
	self._btnadvplay:RemoveClickListener()
	self.removeEventCb(self, RoleStoryController.instance, RoleStoryEvent.ResidentStoryChange, self._onResidentStoryChange, self)
	self.removeEventCb(self, TowerController.instance, TowerEvent.RefreshTowerReddot, self._showTowerEffect, self)
	self.removeEventCb(self, CharacterRecommedController.instance, CharacterRecommedEvent.OnLoadFinishTracedIcon, self._refreshTracedIcon, self)
	self.removeEventCb(self, CharacterRecommedController.instance, CharacterRecommedEvent.OnRefreshTraced, self._refreshTraced, self)
end

function DungeonView:_btnTowerOnClick()
	TowerComposeController.instance:openTowerMainSelectView()
end

function DungeonView:_btnadvplayOnClick()
	self:trackClickButton("_btnadvplayOnClick")

	if DungeonModel.instance:chapterListIsAdvPlay() then
		return
	end

	self:changeCategory(DungeonEnum.ChapterType.AdvPlay)
	self:setBtnStatus()
end

function DungeonView:trackClickButton(buttonName)
	StatController.instance:track(StatEnum.EventName.ButtonClick, {
		[StatEnum.EventProperties.ViewName] = "DungeonView",
		[StatEnum.EventProperties.ButtonName] = buttonName or ""
	})
end

function DungeonView:_btnpermanentOnClick()
	local isPermanent = DungeonModel.instance:chapterListIsPermanent()

	if isPermanent then
		return
	end

	self:changeCategory(DungeonEnum.ChapterType.PermanentActivity)
	self:setBtnStatus()
end

function DungeonView:_btnanecdoteOnClick()
	local isRoleStory = DungeonModel.instance:chapterListIsRoleStory()

	if isRoleStory then
		return
	end

	self:changeCategory(DungeonEnum.ChapterType.RoleStory)
	self:setBtnStatus()
end

function DungeonView:_btnweekwalkOnClick()
	self:changeCategory(DungeonEnum.ChapterType.WeekWalk, false)
	module_views_preloader.DungeonViewWeekWalk(function()
		self:setBtnStatus()
	end)
end

function DungeonView:_btnexploreOnClick()
	if OptionPackageController.instance:checkNeedDownload(OptionPackageEnum.Package.Explore) then
		return
	end

	self:changeCategory(DungeonEnum.ChapterType.Explore, false)
	module_views_preloader.DungeonViewExplore(function()
		self:setBtnStatus()
	end)
end

function DungeonView:_btnrougeOnClick()
	self:changeCategory(DungeonEnum.ChapterType.Rouge)
	self:setBtnStatus()
end

function DungeonView:_btnDramaRewardOnClick()
	DungeonRpc.instance:sendGetMainDramaRewardRequest()
end

function DungeonView:_onNavigateCloseCallback()
	self.viewContainer:setOverrideClose(nil, nil)
	gohelper.setActive(self._gocategory, true)
	self:_btnstoryOnClick()
end

function DungeonView:_onExploreClose()
	local exploreView = self.viewContainer:getExploreView()

	if exploreView then
		exploreView:onHide(self._realCloseSubView, self)
	end
end

function DungeonView:_realCloseSubView()
	self.viewContainer:setOverrideClose(nil, nil)
	gohelper.setActive(self._gocategory, true)
	self:_btnstoryOnClick()
end

function DungeonView:_btntracedOnClick()
	CharacterRecommedController.instance:onJumpReturnRecommedView()
end

function DungeonView:_btnstoryOnClick()
	if self._curIsNormalType then
		return
	end

	self:changeCategory(DungeonEnum.ChapterType.Normal)
	self:setBtnStatus()
	self:_delayOnShowStoryView()
	TaskDispatcher.cancelTask(self._delayOnShowStoryView, self)
	TaskDispatcher.runDelay(self._delayOnShowStoryView, self, 0)
end

function DungeonView:_delayOnShowStoryView()
	DungeonController.instance:dispatchEvent(DungeonEvent.OnShowStoryView)
end

function DungeonView:_btnmainOnClick()
	self:closeThis()
end

function DungeonView:_btngoldOnClick()
	local isResourceType = DungeonModel.instance:chapterListIsResType()

	if isResourceType then
		return
	end

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.GainDungeon) then
		self:changeCategory(DungeonEnum.ChapterType.Gold)
		DungeonController.instance:dispatchEvent(DungeonEvent.OnClickDungeonCategory)
		module_views_preloader.DungeonViewGold(function()
			self:setBtnStatus()
		end)
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.GainDungeon))
	end
end

function DungeonView:_btnresourceOnClick()
	local isBreakType = DungeonModel.instance:chapterListIsBreakType()

	if isBreakType then
		return
	end

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.ResDungeon) then
		self:changeCategory(DungeonEnum.ChapterType.Break)
		DungeonController.instance:dispatchEvent(DungeonEvent.OnClickDungeonCategory)
		module_views_preloader.DungeonViewBreak(function()
			self:setBtnStatus()
		end)
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.ResDungeon))
	end
end

function DungeonView:changeCategory(type, refreshModel)
	if DungeonModel.instance.curChapterType == type then
		return
	end

	if type == DungeonEnum.ChapterType.Normal then
		self._scrollchapter.horizontalNormalizedPosition = 0
	else
		self._scrollchapterresource.horizontalNormalizedPosition = 0

		if DungeonModel.instance.resScrollPosX then
			recthelper.setAnchorX(self._scrollchapterresource.transform, DungeonModel.instance.resScrollPosX)

			DungeonModel.instance.resScrollPosX = nil
		end
	end

	DungeonController.instance:dispatchEvent(DungeonEvent.OnChangeChapterList, type)
	DungeonModel.instance:changeCategory(type, refreshModel)
end

function DungeonView:_btnbackOnClick()
	self:closeThis()
end

function DungeonView:playCategoryAnimation()
	gohelper.setActive(self._btnstory.gameObject, true)
	gohelper.setActive(self._btnresource.gameObject, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.ResDungeon))
	gohelper.setActive(self._btngold.gameObject, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.GainDungeon))
end

function DungeonView:_editableInitView()
	self._simagebg:LoadImage(ResUrl.getDungeonIcon("full/bg1"))

	self._gocategory = gohelper.findChild(self.viewGO, "bottom/categorylist")

	gohelper.addUIClickAudio(self._btnstory.gameObject, AudioEnum.UI.UI_checkpoint_story_Click)
	gohelper.addUIClickAudio(self._btngold.gameObject, AudioEnum.UI.UI_checkpoint_resources_Click)
	gohelper.addUIClickAudio(self._btnresource.gameObject, AudioEnum.UI.UI_checkpoint_Insight_Click)
	gohelper.addUIClickAudio(self._btnweekwalk.gameObject, AudioEnum.UI.UI_checkpoint_story_Click)
end

function DungeonView:_isShowWeekWalk()
	local isOpen = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.WeekWalk)

	if not isOpen then
		return false
	end

	local isForbid = GuideController.instance:isForbidGuides()

	if isForbid then
		return true
	end

	if VersionValidator.instance:isInReviewing() then
		return true
	end

	local guideMo = GuideModel.instance:getById(501)

	if not guideMo then
		return false
	end

	if guideMo.isFinish then
		return true
	end

	return guideMo.currStepId > 1
end

function DungeonView:_isShowExplore()
	return false
end

function DungeonView:_isShowAdvPlay()
	local isExploreOpen = ExploreSimpleModel.instance:isShowExplore()
	local isSurvivalOpen = SurvivalController.instance:isOpenSurvival()

	return isExploreOpen or isSurvivalOpen
end

function DungeonView:_refreshBtnUnlock()
	gohelper.setActive(self._btngold.gameObject, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.GainDungeon))
	gohelper.setActive(self._btnweekwalk.gameObject, self:_isShowWeekWalk())
	gohelper.setActive(self._btnexplore.gameObject, self:_isShowExplore())
	gohelper.setActive(self._btnadvplay.gameObject, self:_isShowAdvPlay())

	local breakTypeOpenTimeValid = DungeonModel.instance:getChapterListOpenTimeValid(DungeonEnum.ChapterType.Break)

	gohelper.setActive(self._btnresource.gameObject, breakTypeOpenTimeValid and OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.ResDungeon))

	local isResident = RoleStoryModel.instance:isInResident()
	local isIOSReviewing = VersionValidator.instance:isInReviewing() and BootNativeUtil.isIOS()

	gohelper.setActive(self._btnanecdote, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.RoleStory) and isResident and isIOSReviewing == false)

	local hasPermanentOnline = PermanentModel.instance:hasActivityOnline()

	gohelper.setActive(self._btnpermanent, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Permanent) and hasPermanentOnline)
	gohelper.setActive(self._btnrouge, RougeOutsideController.instance:isOpen() or Rouge2_Controller.instance:checkIsOpen())
	gohelper.setActive(self._btntower, TowerController.instance:isOpen())
end

function DungeonView:setBtnStatus()
	local isNormalType, isResourceType, isBreakType, isWeekWalkType, isSeasonType, isExploreType = DungeonModel.instance:getChapterListTypes()
	local isRoleStory = DungeonModel.instance:chapterListIsRoleStory()
	local isPermanent = DungeonModel.instance:chapterListIsPermanent()
	local isRougeType = DungeonModel.instance:chapterListIsRouge()
	local isTowerType = false
	local isAdvPlayType = DungeonModel.instance:chapterListIsAdvPlay()

	isNormalType = isNormalType or isSeasonType

	gohelper.setActive(self._gostorySelectText, isNormalType)
	gohelper.setActive(self._gostoryUnselectText, not isNormalType)

	self._curIsNormalType = isNormalType

	gohelper.setActive(self._goexploreSelectText, isExploreType)
	gohelper.setActive(self._goexploreUnselectText, not isExploreType)
	gohelper.setActive(self._gogoldSelectText, isResourceType)
	gohelper.setActive(self._gogoldUnselectText, not isResourceType)
	gohelper.setActive(self._goresSelectText, isBreakType)
	gohelper.setActive(self._goresUnselectText, not isBreakType)
	gohelper.setActive(self._goweekwalkSelectText, isWeekWalkType)
	gohelper.setActive(self._goweekwalkUnselectText, not isWeekWalkType)
	gohelper.setActive(self._gorougeSelectText, isRougeType)
	gohelper.setActive(self._gorougeUnselectText, not isRougeType)
	gohelper.setActive(self._gocategory, not isWeekWalkType and not isExploreType)
	gohelper.setActive(self._goanecdoteUnselectText, not isRoleStory)
	gohelper.setActive(self._goanecdoteSelectText, isRoleStory)
	gohelper.setActive(self._goperUnselectText, not isPermanent)
	gohelper.setActive(self._goperSelectText, isPermanent)
	gohelper.setActive(self._gotowerSelectText, isTowerType)
	gohelper.setActive(self._gotowerUnselectText, not isTowerType)

	if isExploreType then
		self.viewContainer:setOverrideClose(self._onExploreClose, self)
	elseif isWeekWalkType then
		self.viewContainer:setOverrideClose(self._onNavigateCloseCallback, self)
	else
		self.viewContainer:setOverrideClose(nil, nil)
	end

	gohelper.setActive(self._gostory, true)

	if isNormalType then
		if not self._firstShowNormal then
			self._firstShowNormal = true
			DungeonChapterListModel.instance.firstShowNormalTime = Time.time
		end

		self:_focusNormalChapter(self._moveChapterId)
		recthelper.setAnchorY(self._gostory.transform, 0)

		self._animator = self._animator or self.viewGO:GetComponent("Animator")

		if self._animator then
			self._animator.enabled = true

			self._animator:Play("open", 0, 0)
		end
	else
		DungeonController.instance:dispatchEvent(DungeonEvent.FakeUnfoldMainStorySection)
		recthelper.setAnchorY(self._gostory.transform, 10000)
	end

	gohelper.setActive(self._goresource, isResourceType or isBreakType)
	gohelper.setActive(self._goweekwalk, isWeekWalkType)
	gohelper.setActive(self._goexplore, isExploreType)
	gohelper.setActive(self._gopermanent, isPermanent)
	gohelper.setActive(self._goadvplayUnselectText, not isAdvPlayType)
	gohelper.setActive(self._goadvplaySelectText, isAdvPlayType)
	DungeonModel.instance:setDungeonStoryviewState(isNormalType)
	self:refreshRoleStoryStatus()

	if isResourceType or isBreakType then
		DungeonController.instance:dispatchEvent(DungeonEvent.OnShowResourceView)
	end

	self._isWeekWalkType = isWeekWalkType

	if isWeekWalkType then
		self:_switchWeekWalkTab()
	elseif isExploreType then
		self.viewContainer:switchTab(DungeonEnum.DungeonViewTabEnum.Explore)
	elseif isPermanent then
		self.viewContainer:switchTab(DungeonEnum.DungeonViewTabEnum.Permanent)
	elseif isAdvPlayType then
		self.viewContainer:switchTab(DungeonEnum.DungeonViewTabEnum.AdvPlay)
	elseif isRougeType then
		self.viewContainer:switchTab(DungeonEnum.DungeonViewTabEnum.Rouge)
	else
		self.viewContainer:switchTab()
	end

	if DungeonModel.instance.resScrollPosX then
		recthelper.setAnchorX(self._scrollchapterresource.transform, DungeonModel.instance.resScrollPosX)

		DungeonModel.instance.resScrollPosX = nil
	end

	self:_showWeekWalkEffect()
	self:_showGoldEffect()
	self:_showTowerEffect()
	AudioBgmManager.instance:checkBgm()
end

function DungeonView:_switchWeekWalkTab()
	local info = WeekWalkModel.instance:getInfo()
	local map = info:getNotFinishedMap()
	local isShallow = map and WeekWalkModel.isShallowMap(map.sceneId)

	if isShallow then
		self.viewContainer:switchTab(DungeonEnum.DungeonViewTabEnum.WeekWalk)
	else
		local info = WeekWalk_2Model.instance:getInfo()

		if info and info:isOpen() then
			self.viewContainer:switchTab(DungeonEnum.DungeonViewTabEnum.WeekWalk_2)
		else
			self.viewContainer:switchTab(DungeonEnum.DungeonViewTabEnum.WeekWalk)
		end
	end
end

function DungeonView:_showWeekWalkEffect()
	local canGet = WeekWalkTaskListModel.instance:canGetReward(WeekWalkEnum.TaskType.Week)
	local info = WeekWalkModel.instance:getInfo()
	local isPopShallowSettle = canGet or info and info.isPopShallowSettle
	local isPopDeepSettle = info and info.isPopDeepSettle
	local weekWalk_2Info = WeekWalk_2Model.instance:getInfo()
	local isPopSettle = weekWalk_2Info and weekWalk_2Info.isPopSettle

	gohelper.setActive(self._goweekwalkreward1, false)
	gohelper.setActive(self._goweekwalkreward2, false)
	gohelper.setActive(self._goweekwalkreward3, false)
	gohelper.setActive(self._goweekwalkicon, not isPopShallowSettle and not isPopDeepSettle and not isPopSettle)

	if isPopShallowSettle then
		gohelper.setActive(self._goweekwalkreward1, true)
	elseif isPopDeepSettle then
		gohelper.setActive(self._goweekwalkreward2, true)
	elseif isPopSettle then
		gohelper.setActive(self._goweekwalkreward3, true)
	end
end

function DungeonView:_showGoldEffect()
	local haveRemaintime = DungeonModel.instance:getEquipRemainingNum() > 0
	local isUnLock = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.EquipDungeon)

	if isUnLock then
		gohelper.setActive(self._gogoldUnselectIcon, not haveRemaintime)
		gohelper.setActive(self._gogoldRedPoint, haveRemaintime)
	else
		gohelper.setActive(self._gogoldUnselectIcon, true)
		gohelper.setActive(self._gogoldRedPoint, false)
	end
end

function DungeonView:_showTowerEffect()
	if not TowerController.instance:isOpen() then
		return
	end

	local towerTasks = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Tower) or {}
	local canGetTaskNum = TowerTaskModel.instance:getTaskItemCanGetCount(towerTasks)
	local isFullMopUp = TowerPermanentModel.instance:checkCanShowMopUpReddot()
	local hasNewUpdateTower = TowerController.instance:checkReddotHasNewUpdateTower()
	local isTowerCanShow = canGetTaskNum > 0 or isFullMopUp or hasNewUpdateTower
	local towerComposeTasks = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.TowerCompose) or {}
	local canGetComposeTaskNum = TowerTaskModel.instance:getTaskItemCanGetCount(towerComposeTasks)
	local isTowerComposeCanShow = canGetComposeTaskNum > 0

	gohelper.setActive(self._gotowerReddotEffect, isTowerCanShow or isTowerComposeCanShow)
end

function DungeonView:onUpdateParam()
	self:setBtnStatus()
end

function DungeonView:onOpen()
	if ViewMgr.instance:isOpen(ViewName.MainView) then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Main_enterance)
	end

	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnChangeChapter, self._onChangeChapter, self)
	self.addEventCb(self, MainController.instance, MainEvent.OnFuncUnlockRefresh, self._refreshBtnUnlock, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.DestroyViewFinish, self._onDestroyViewFinish, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.addEventCb(self, WeekWalkController.instance, WeekWalkEvent.OnAllShallowLayerFinish, self._onAllShallowLayerFinish, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnDramaRewardStatusChange, self._refreshDramaBtnStatus, self)
	self.addEventCb(self, Activity165Controller.instance, Activity165Event.refreshStoryReddot, self._onRefreshStoryReddot, self)
	self:_refreshDramaBtnStatus()
	self:_moveChapter(DungeonMainStoryModel.instance:getJumpFocusChapterIdOnce())
	self:_refreshBtnUnlock()
	self:playCategoryAnimation()
	self:_refreshTraced()
	RedDotController.instance:addRedDotTag(self._goadvplayReddotEffect, RedDotEnum.DotNode.AdvPlay)
end

function DungeonView:_moveChapter(chapterId)
	if not chapterId then
		chapterId = DungeonMainStoryModel.instance:getClickChapterId()
	else
		DungeonMainStoryModel.instance:saveClickChapterId(chapterId)
	end

	if not chapterId then
		DungeonMainStoryModel.instance:initSelectedSectionId()
	end

	self._moveChapterId = chapterId

	self:setBtnStatus()
	DungeonController.instance:dispatchEvent(DungeonEvent.OnEnterDungeonChatperView, self._moveChapterId)
end

function DungeonView:_onCloseView(viewName)
	if viewName == ViewName.DungeonMapView and DungeonModel.instance.chapterTriggerNewChapter then
		local chapterId = DungeonModel.instance.unlockNewChapterId

		self:_focusNormalChapter(chapterId)
	end

	if (viewName == ViewName.RougeMainView or viewName == ViewName.TowerMainSelectView) and self._animator then
		self._animator.enabled = true

		self._animator:Play("open", 0, 0)
		DungeonController.instance:dispatchEvent(DungeonEvent.OnShowStoryView)
	end
end

function DungeonView:_onAllShallowLayerFinish()
	if self._isWeekWalkType then
		self:_switchWeekWalkTab()
	end
end

function DungeonView:_focusNormalChapter(chapterId)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnFocusNormalChapter, chapterId)
end

function DungeonView:_resetMovementType()
	self._scrollchapter.movementType = 1
end

function DungeonView:_onDestroyViewFinish(viewName)
	return
end

function DungeonView:_onChangeChapter(chapterId)
	local isNormalType = DungeonModel.instance:chapterListIsNormalType()

	if not isNormalType then
		return
	end

	self:_moveChapter(chapterId)
end

function DungeonView:refreshRoleStoryStatus()
	local isRoleStory = DungeonModel.instance:chapterListIsRoleStory()
	local isResident = RoleStoryModel.instance:isInResident()
	local isAct = RoleStoryModel.instance:checkActStoryOpen()

	self:setRoleStoryStatus((isResident or isAct) and isRoleStory)

	if isRoleStory and not isResident and not isAct then
		self:_btnstoryOnClick()
		self:_refreshBtnUnlock()
	end
end

function DungeonView:setRoleStoryStatus(show)
	if show then
		self._roleStoryView = self._roleStoryView or RoleStoryView.New(self._goRoleStory)

		self._roleStoryView:show()
	elseif self._roleStoryView then
		self._roleStoryView:hide()
	end
end

function DungeonView:_onResidentStoryChange()
	self:refreshRoleStoryStatus()
end

function DungeonView:destoryRoleStory()
	if self._roleStoryView then
		self._roleStoryView:destory()

		self._roleStoryView = nil
	end
end

function DungeonView:onClose()
	return
end

function DungeonView:onDestroyView()
	self._simagebg:UnLoadImage()
	self._simagetracehero:UnLoadImage()
	TaskDispatcher.cancelTask(self._resetMovementType, self)
	TaskDispatcher.cancelTask(self._delayOnShowStoryView, self)
	self:destoryRoleStory()
end

function DungeonView:_refreshDramaBtnStatus()
	self.storyUnSelectIconTag:refreshDot()
	self.storySelectIconTag:refreshDot()

	local active = DungeonModel.instance:isCanGetDramaReward()

	gohelper.setActive(self._btnDramaReward, active)

	if active then
		local viewParams = self.viewParam

		if viewParams and viewParams.fromMainView then
			DungeonController.instance:dispatchEvent(DungeonEvent.OnShowDramaRewardGuide)
		end
	end
end

function DungeonView:refreshStoryIcon(icon)
	local show = RedDotModel.instance:isDotShow(icon.dotId, 0) or DungeonModel.instance:isCanGetDramaReward()

	if icon.reverse then
		show = not show
	end

	gohelper.setActive(icon.go, show)
end

function DungeonView:_checkPermanentReddot(redDotTag)
	local show = RedDotModel.instance:isDotShow(redDotTag.dotId, 0)

	show = show or not PermanentModel.instance:isActivityLocalRead()
	show = show or PermanentModel.instance:IsDotShowPermanent2_1()

	gohelper.setActive(self._goperUnselectIcon, not show)
	gohelper.setActive(self._goreddotpermanent, show)
end

function DungeonView:_onRefreshStoryReddot()
	if not self._goreddotpermanentTag then
		return
	end

	self._goreddotpermanentTag:refreshDot()
end

function DungeonView:_refreshTraced()
	self:_refreshTracedIcon()
	self:_refreshTracedHeroIcon()
end

function DungeonView:_refreshTracedHeroIcon()
	local tradeMo = CharacterRecommedModel.instance:getTracedHeroDevelopGoalsMO()

	if tradeMo then
		local skinCo = tradeMo:getHeroSkinCo()

		self._simagetracehero:LoadImage(ResUrl.getHeadIconSmall(skinCo.headIcon))
		gohelper.setActive(self._btntrace.gameObject, true)
	else
		gohelper.setActive(self._btntrace.gameObject, false)
	end
end

function DungeonView:_refreshTracedIcon()
	local tradeIconPrefab = CharacterRecommedController.instance:getTradeIcon()

	if not tradeIconPrefab then
		return
	end

	local isTradeStory = CharacterRecommedModel.instance:isTradeStory()

	if isTradeStory and not self._tracedStoryIcon then
		self._tracedStoryIcon = gohelper.clone(tradeIconPrefab, self._gostorytrace)
	end

	gohelper.setActive(self._tracedStoryIcon, isTradeStory)

	local isTradeStory = CharacterRecommedModel.instance:isTradeResDungeon()

	if isTradeStory and not self._tracedResIcon then
		self._tracedResIcon = gohelper.clone(tradeIconPrefab, self._gogoldtrace)
	end

	gohelper.setActive(self._tracedResIcon, isTradeStory)

	local isTradeStory = CharacterRecommedModel.instance:isTradeRankResDungeon()

	if isTradeStory and not self._tracedresourceIcon then
		self._tracedresourceIcon = gohelper.clone(tradeIconPrefab, self._goresourcetrace)
	end

	gohelper.setActive(self._tracedresourceIcon, isTradeStory)
end

return DungeonView
