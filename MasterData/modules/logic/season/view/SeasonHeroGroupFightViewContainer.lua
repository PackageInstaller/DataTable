-- chunkname: @modules/logic/season/view/SeasonHeroGroupFightViewContainer.lua

module("modules.logic.season.view.SeasonHeroGroupFightViewContainer", package.seeall)

local SeasonHeroGroupFightViewContainer = class("SeasonHeroGroupFightViewContainer", BaseViewContainer)

function SeasonHeroGroupFightViewContainer:buildViews()
	return {
		SeasonHeroGroupFightView.New(),
		SeasonHeroGroupListView.New(),
		SeasonHeroGroupFightViewRule.New(),
		CheckActivityEndView.New(),
		TabViewGroup.New(1, "#go_container/#go_btns/commonBtns")
	}
end

function SeasonHeroGroupFightViewContainer:getSeasonHeroGroupFightView()
	return self._views[1]
end

function SeasonHeroGroupFightViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonsView = NavigateButtonsView.New({
			true,
			false,
			true
		}, HelpEnum.HelpId.SeasonHerogroup, self._closeCallback, nil, nil, self)

		self._navigateButtonsView:setCloseCheck(self.defaultOverrideCloseCheck, self)

		return {
			self._navigateButtonsView
		}
	end
end

function SeasonHeroGroupFightViewContainer:_closeCallback()
	self:closeThis()

	if self:handleVersionActivityCloseCall() then
		return
	end

	local episodeId = HeroGroupModel.instance.episodeId
	local episodeCO = DungeonConfig.instance:getEpisodeCO(episodeId)

	if episodeCO.type == DungeonEnum.EpisodeType.Explore then
		ExploreController.instance:enterExploreChapter(episodeCO.chapterId)
	else
		MainController.instance:enterMainScene(true, false)
	end
end

function SeasonHeroGroupFightViewContainer:handleVersionActivityCloseCall()
	if EnterActivityViewOnExitFightSceneHelper.checkCurrentIsActivityFight() then
		EnterActivityViewOnExitFightSceneHelper.enterCurrentActivity(true, true)

		return true
	end
end

function SeasonHeroGroupFightViewContainer:setNavigateOverrideClose(callBack, callbackObject)
	self._navigateButtonsView:setOverrideClose(callBack, callbackObject)
end

function SeasonHeroGroupFightViewContainer:defaultOverrideCloseCheck(reallyClose, reallyCloseObj)
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

return SeasonHeroGroupFightViewContainer
