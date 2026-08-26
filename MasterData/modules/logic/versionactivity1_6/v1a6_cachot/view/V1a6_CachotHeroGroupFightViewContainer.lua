-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotHeroGroupFightViewContainer.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotHeroGroupFightViewContainer", package.seeall)

local V1a6_CachotHeroGroupFightViewContainer = class("V1a6_CachotHeroGroupFightViewContainer", BaseViewContainer)

function V1a6_CachotHeroGroupFightViewContainer:buildViews()
	self._heroGroupFightView = V1a6_CachotHeroGroupFightView.New()
	self._heroGroupLayoutView = HeroGroupFightLayoutView.New()

	return {
		self._heroGroupLayoutView,
		self._heroGroupFightView,
		HeroGroupAnimView.New(),
		V1a6_CachotHeroGroupListView.New(),
		HeroGroupFightViewLevel.New(),
		HeroGroupFightViewRule.New(),
		HeroGroupInfoScrollView.New(),
		CheckActivityEndView.New(),
		V1a5HeroGroupBuildingView.New(),
		TabViewGroup.New(1, "#go_container/btnContain/commonBtns")
	}
end

function V1a6_CachotHeroGroupFightViewContainer:getHeroGroupFightView()
	return self._heroGroupFightView
end

function V1a6_CachotHeroGroupFightViewContainer:beforeEnterFight()
	return
end

function V1a6_CachotHeroGroupFightViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		local helpId = self:getHelpId()
		local showHome = not self:_checkHideHomeBtn()

		self._navigateButtonsView = NavigateButtonsView.New({
			true,
			showHome,
			helpId ~= nil
		}, helpId, self._closeCallback, nil, nil, self)

		self._navigateButtonsView:setCloseCheck(self.defaultOverrideCloseCheck, self)

		return {
			self._navigateButtonsView
		}
	elseif tabContainerId == 2 then
		local currencyType = CurrencyEnum.CurrencyType
		local hidePower = self:_checkHidePowerCurrencyBtn()
		local currencyParam = hidePower and {} or {
			currencyType.Power
		}

		return {
			CurrencyView.New(currencyParam)
		}
	end
end

function V1a6_CachotHeroGroupFightViewContainer:getHelpId()
	return HelpEnum.HelpId.Cachot1_6TotalHelp
end

function V1a6_CachotHeroGroupFightViewContainer:_closeCallback()
	self:closeThis()

	if self:handleVersionActivityCloseCall() then
		return
	end

	local episodeId = HeroGroupModel.instance.episodeId
	local episodeCO = DungeonConfig.instance:getEpisodeCO(episodeId)

	if episodeCO.type == DungeonEnum.EpisodeType.Explore then
		ExploreController.instance:enterExploreScene()
	else
		MainController.instance:enterMainScene(true, false)

		if TeachNoteModel.instance:isJumpEnter() then
			TeachNoteModel.instance:setJumpEnter(false)
			TeachNoteController.instance:enterTeachNoteView(episodeId, true)

			DungeonModel.instance.curSendEpisodeId = nil
		end
	end
end

function V1a6_CachotHeroGroupFightViewContainer:handleVersionActivityCloseCall()
	if EnterActivityViewOnExitFightSceneHelper.checkCurrentIsActivityFight() then
		EnterActivityViewOnExitFightSceneHelper.enterCurrentActivity(true, true)

		return true
	end
end

function V1a6_CachotHeroGroupFightViewContainer:_checkHideHomeBtn()
	return true
end

V1a6_CachotHeroGroupFightViewContainer._hideHomeBtnEpisodeType = {
	[DungeonEnum.EpisodeType.Act1_3Role1Chess] = true,
	[DungeonEnum.EpisodeType.Act1_3Role2Chess] = true
}

function V1a6_CachotHeroGroupFightViewContainer:checkShowHomeByEpisodeType()
	local episodeId = HeroGroupModel.instance.episodeId
	local episodeCfg = DungeonConfig.instance:getEpisodeCO(episodeId)

	return V1a6_CachotHeroGroupFightViewContainer._hideHomeBtnEpisodeType[episodeCfg.type]
end

function V1a6_CachotHeroGroupFightViewContainer:_checkHidePowerCurrencyBtn()
	return (self:checkHidePowerCurrencyBtnByEpisodeType())
end

V1a6_CachotHeroGroupFightViewContainer._hidePowerCurrencyBtnEpisodeType = {
	[DungeonEnum.EpisodeType.Act1_3Role1Chess] = true,
	[DungeonEnum.EpisodeType.Act1_3Role2Chess] = true
}

function V1a6_CachotHeroGroupFightViewContainer:checkHidePowerCurrencyBtnByEpisodeType()
	local episodeId = HeroGroupModel.instance.episodeId
	local episodeCfg = DungeonConfig.instance:getEpisodeCO(episodeId)

	return V1a6_CachotHeroGroupFightViewContainer._hidePowerCurrencyBtnEpisodeType[episodeCfg.type]
end

function V1a6_CachotHeroGroupFightViewContainer:setNavigateOverrideClose(callBack, callbackObject)
	self._navigateButtonsView:setOverrideClose(callBack, callbackObject)
end

function V1a6_CachotHeroGroupFightViewContainer:defaultOverrideCloseCheck(reallyClose, reallyCloseObj)
	local chapterId = DungeonModel.instance.curSendChapterId
	local chapterCo = DungeonConfig.instance:getChapterCO(chapterId)
	local actId = chapterCo.actId

	if actId == VersionActivityEnum.ActivityId.Act109 then
		local function yesFunc()
			reallyClose(reallyCloseObj)
		end

		GameFacade.showMessageBox(MessageBoxIdDefine.QuitPushBoxEpisode, MsgBoxEnum.BoxType.Yes_No, yesFunc)

		return false
	end

	return true
end

function V1a6_CachotHeroGroupFightViewContainer:onContainerInit()
	HelpController.instance:registerCallback(HelpEvent.RefreshHelp, self.refreshHelpBtnIcon, self)
end

function V1a6_CachotHeroGroupFightViewContainer:onContainerOpenFinish()
	self._navigateButtonsView:resetOnCloseViewAudio(AudioEnum.UI.UI_Team_close)
end

function V1a6_CachotHeroGroupFightViewContainer:onContainerDestroy()
	HelpController.instance:unregisterCallback(HelpEvent.RefreshHelp, self.refreshHelpBtnIcon, self)
end

function V1a6_CachotHeroGroupFightViewContainer:refreshHelpBtnIcon()
	self._navigateButtonsView:changerHelpId(self:getHelpId())
end

return V1a6_CachotHeroGroupFightViewContainer
