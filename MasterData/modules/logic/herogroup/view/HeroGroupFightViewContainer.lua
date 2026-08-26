-- chunkname: @modules/logic/herogroup/view/HeroGroupFightViewContainer.lua

module("modules.logic.herogroup.view.HeroGroupFightViewContainer", package.seeall)

local HeroGroupFightViewContainer = class("HeroGroupFightViewContainer", BaseViewContainer)

function HeroGroupFightViewContainer:buildViews()
	local views = {}

	self:defineFightView()
	self:addFirstViews(views)
	self:addCommonViews(views)
	self:addLastViews(views)

	return views
end

function HeroGroupFightViewContainer:addFirstViews(views)
	table.insert(views, HeroGroupFightCleanView.New())
end

function HeroGroupFightViewContainer:defineFightView()
	self._heroGroupFightView = HeroGroupFightView.New()
	self._heroGroupFightListView = HeroGroupListView.New()
end

function HeroGroupFightViewContainer:getFightLevelView()
	return HeroGroupFightViewLevel.New()
end

function HeroGroupFightViewContainer:getFightRuleView()
	return HeroGroupFightViewRule.New()
end

function HeroGroupFightViewContainer:getPresetFightView()
	return HeroGroupPresetFightView.New()
end

function HeroGroupFightViewContainer:addCommonViews(views)
	table.insert(views, self._heroGroupFightView)
	table.insert(views, HeroGroupAnimView.New())
	table.insert(views, self._heroGroupFightListView.New())
	table.insert(views, self:getFightLevelView())
	table.insert(views, self:getFightRuleView())
	table.insert(views, HeroGroupInfoScrollView.New())
	table.insert(views, CheckActivityEndView.New())
	table.insert(views, self:getPresetFightView())

	local isAllowAssist = HeroGroupModel.instance:getAssistMo()

	if isAllowAssist then
		table.insert(views, HeroGroupFightAssistBtn.New())
	end

	table.insert(views, TabViewGroup.New(1, "#go_container/btnContain/commonBtns"))
	table.insert(views, TabViewGroup.New(2, "#go_righttop/#go_power"))
end

function HeroGroupFightViewContainer:addLastViews(views)
	return
end

function HeroGroupFightViewContainer:getHeroGroupFightView()
	return self._heroGroupFightView
end

function HeroGroupFightViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		local helpId = self:getHelpId()

		self._navigateButtonsView = NavigateButtonsView.New({
			true,
			true,
			helpId ~= nil
		}, helpId, self._closeCallback, nil, nil, self)

		self._navigateButtonsView:setCloseCheck(self.defaultOverrideCloseCheck, self)

		return {
			self._navigateButtonsView
		}
	elseif tabContainerId == 2 then
		local currencyType = CurrencyEnum.CurrencyType

		return {
			CurrencyView.New({
				currencyType.Power
			})
		}
	end
end

function HeroGroupFightViewContainer:getHelpId()
	local helpId
	local episodeId = HeroGroupModel.instance.episodeId
	local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)
	local chapterConfig = DungeonConfig.instance:getChapterCO(episodeConfig.chapterId)
	local isHardMode = chapterConfig.type == DungeonEnum.ChapterType.Hard
	local normalGuideId = CommonConfig.instance:getConstNum(ConstEnum.HeroGroupGuideNormal)
	local hardGuideId = CommonConfig.instance:getConstNum(ConstEnum.HeroGroupGuideHard)

	if HeroGroupBalanceHelper.getIsBalanceMode() then
		return HelpEnum.HelpId.Balance
	end

	if isHardMode then
		if GuideModel.instance:isGuideFinish(hardGuideId) and HelpModel.instance:isShowedHelp(HelpEnum.HelpId.HeroGroupHard) then
			helpId = HelpEnum.HelpId.HeroGroupHard
		end
	elseif GuideModel.instance:isGuideFinish(normalGuideId) and HelpModel.instance:isShowedHelp(HelpEnum.HelpId.HeroGroupNormal) then
		helpId = HelpEnum.HelpId.HeroGroupNormal
	end

	return helpId
end

function HeroGroupFightViewContainer:_closeCallback()
	self:closeThis()

	if DungeonJumpGameController.instance:checkIsJumpGameBattle() then
		DungeonJumpGameController.instance:returnToJumpGameView()

		return
	end

	if VersionActivity2_8DungeonBossBattleController.instance:checkIsBossBattle() then
		VersionActivity2_8DungeonBossBattleController.instance:enterBossView(true)

		return
	end

	if ToughBattleController.instance:checkIsToughBattle() then
		ToughBattleController.instance:enterToughBattle(true)

		return
	end

	if self:handleVersionActivityCloseCall() then
		return
	end

	local episodeId = HeroGroupModel.instance.episodeId
	local episodeCO = DungeonConfig.instance:getEpisodeCO(episodeId)

	if episodeCO.type == DungeonEnum.EpisodeType.Explore then
		ExploreController.instance:enterExploreScene()
	elseif episodeCO.type == DungeonEnum.EpisodeType.Survival then
		SurvivalController.instance:enterSurvivalMap()
	elseif episodeCO.type == DungeonEnum.EpisodeType.Shelter then
		SurvivalController.instance:enterShelterMap()
	elseif episodeCO.type == DungeonEnum.EpisodeType.Sodache then
		SodacheStatHelper.instance:startEnterFight()
		SodacheController.instance:enterScene()
	else
		if episodeCO.chapterId == DungeonEnum.ChapterId.BossStory then
			GameSceneMgr.instance:dispatchEvent(SceneEventName.SetLoadingTypeOnce, GameLoadingState.VersionActivity2_8BossStoryLoadingView)
		end

		MainController.instance:enterMainScene(true, false)

		if TeachNoteModel.instance:isJumpEnter() then
			TeachNoteModel.instance:setJumpEnter(false)
			TeachNoteController.instance:enterTeachNoteView(episodeId, true)

			DungeonModel.instance.curSendEpisodeId = nil
		end
	end
end

function HeroGroupFightViewContainer:handleVersionActivityCloseCall()
	if EnterActivityViewOnExitFightSceneHelper.checkCurrentIsActivityFight() then
		EnterActivityViewOnExitFightSceneHelper.enterCurrentActivity(true, true)

		return true
	end
end

function HeroGroupFightViewContainer:setNavigateOverrideClose(callBack, callbackObject)
	self._navigateButtonsView:setOverrideClose(callBack, callbackObject)
end

function HeroGroupFightViewContainer:defaultOverrideCloseCheck(reallyClose, reallyCloseObj)
	local chapterId = DungeonModel.instance.curSendChapterId
	local chapterCo = DungeonConfig.instance:getChapterCO(chapterId)
	local actId = chapterCo.actId

	if actId == VersionActivityEnum.ActivityId.Act109 then
		GameFacade.showMessageBox(MessageBoxIdDefine.QuitPushBoxEpisode, MsgBoxEnum.BoxType.Yes_No, reallyClose, nil, nil, reallyCloseObj)

		return false
	end

	return true
end

function HeroGroupFightViewContainer:onContainerInit()
	HelpController.instance:registerCallback(HelpEvent.RefreshHelp, self.refreshHelpBtnIcon, self)
end

function HeroGroupFightViewContainer:onContainerOpenFinish()
	self._navigateButtonsView:resetOnCloseViewAudio(AudioEnum.UI.UI_Team_close)
end

function HeroGroupFightViewContainer:onContainerDestroy()
	HelpController.instance:unregisterCallback(HelpEvent.RefreshHelp, self.refreshHelpBtnIcon, self)
end

function HeroGroupFightViewContainer:refreshHelpBtnIcon()
	self._navigateButtonsView:changerHelpId(self:getHelpId())
end

return HeroGroupFightViewContainer
