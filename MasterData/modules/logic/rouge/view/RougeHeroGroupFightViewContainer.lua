-- chunkname: @modules/logic/rouge/view/RougeHeroGroupFightViewContainer.lua

module("modules.logic.rouge.view.RougeHeroGroupFightViewContainer", package.seeall)

local RougeHeroGroupFightViewContainer = class("RougeHeroGroupFightViewContainer", BaseViewContainer)

function RougeHeroGroupFightViewContainer:buildViews()
	self._heroGroupFightView = RougeHeroGroupFightView.New()
	self._heroGroupLayoutView = HeroGroupFightLayoutView.New()

	return {
		self._heroGroupLayoutView,
		self._heroGroupFightView,
		HeroGroupAnimView.New(),
		RougeHeroGroupListView.New(),
		RougeHeroGroupFightViewLevel.New(),
		RougeHeroGroupFightViewRule.New(),
		HeroGroupInfoScrollView.New(),
		CheckActivityEndView.New(),
		RougeHeroGroupFightMiscView.New(),
		RougeBaseDLCViewComp.New(),
		TabViewGroup.New(1, "#go_container/btnContain/commonBtns"),
		TabViewGroup.New(2, "#go_righttop/#go_power")
	}
end

function RougeHeroGroupFightViewContainer:getHeroGroupFightView()
	return self._heroGroupFightView
end

function RougeHeroGroupFightViewContainer:beforeEnterFight()
	return
end

function RougeHeroGroupFightViewContainer:buildTabViews(tabContainerId)
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

function RougeHeroGroupFightViewContainer:getHelpId()
	return HelpEnum.HelpId.RougeHeroGroupFightViewHelp
end

function RougeHeroGroupFightViewContainer:_closeCallback()
	self._manualClose = true

	self:closeThis()
end

function RougeHeroGroupFightViewContainer:onContainerCloseFinish()
	if self._manualClose then
		RougeController.instance:enterRouge()
	end
end

function RougeHeroGroupFightViewContainer:handleVersionActivityCloseCall()
	if EnterActivityViewOnExitFightSceneHelper.checkCurrentIsActivityFight() then
		EnterActivityViewOnExitFightSceneHelper.enterCurrentActivity(true, true)

		return true
	end
end

function RougeHeroGroupFightViewContainer:_checkHideHomeBtn()
	return true
end

RougeHeroGroupFightViewContainer._hideHomeBtnEpisodeType = {
	[DungeonEnum.EpisodeType.Act1_3Role1Chess] = true,
	[DungeonEnum.EpisodeType.Act1_3Role2Chess] = true
}

function RougeHeroGroupFightViewContainer:checkShowHomeByEpisodeType()
	local episodeId = HeroGroupModel.instance.episodeId
	local episodeCfg = DungeonConfig.instance:getEpisodeCO(episodeId)

	return RougeHeroGroupFightViewContainer._hideHomeBtnEpisodeType[episodeCfg.type]
end

function RougeHeroGroupFightViewContainer:_checkHidePowerCurrencyBtn()
	return (self:checkHidePowerCurrencyBtnByEpisodeType())
end

RougeHeroGroupFightViewContainer._hidePowerCurrencyBtnEpisodeType = {
	[DungeonEnum.EpisodeType.Act1_3Role1Chess] = true,
	[DungeonEnum.EpisodeType.Act1_3Role2Chess] = true
}

function RougeHeroGroupFightViewContainer:checkHidePowerCurrencyBtnByEpisodeType()
	local episodeId = HeroGroupModel.instance.episodeId
	local episodeCfg = DungeonConfig.instance:getEpisodeCO(episodeId)

	return RougeHeroGroupFightViewContainer._hidePowerCurrencyBtnEpisodeType[episodeCfg.type]
end

function RougeHeroGroupFightViewContainer:setNavigateOverrideClose(callBack, callbackObject)
	self._navigateButtonsView:setOverrideClose(callBack, callbackObject)
end

function RougeHeroGroupFightViewContainer:defaultOverrideCloseCheck(reallyClose, reallyCloseObj)
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

function RougeHeroGroupFightViewContainer:onContainerInit()
	HelpController.instance:registerCallback(HelpEvent.RefreshHelp, self.refreshHelpBtnIcon, self)
end

function RougeHeroGroupFightViewContainer:onContainerOpenFinish()
	self._navigateButtonsView:resetOnCloseViewAudio(AudioEnum.UI.UI_Team_close)
end

function RougeHeroGroupFightViewContainer:onContainerDestroy()
	HelpController.instance:unregisterCallback(HelpEvent.RefreshHelp, self.refreshHelpBtnIcon, self)
end

function RougeHeroGroupFightViewContainer:refreshHelpBtnIcon()
	self._navigateButtonsView:changerHelpId(self:getHelpId())
end

return RougeHeroGroupFightViewContainer
