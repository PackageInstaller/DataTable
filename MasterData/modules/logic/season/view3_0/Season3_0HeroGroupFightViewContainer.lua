-- chunkname: @modules/logic/season/view3_0/Season3_0HeroGroupFightViewContainer.lua

module("modules.logic.season.view3_0.Season3_0HeroGroupFightViewContainer", package.seeall)

local Season3_0HeroGroupFightViewContainer = class("Season3_0HeroGroupFightViewContainer", BaseViewContainer)

function Season3_0HeroGroupFightViewContainer:buildViews()
	return {
		Season3_0HeroGroupFightView.New(),
		Season3_0HeroGroupListView.New(),
		Season3_0HeroGroupFightViewRule.New(),
		Season3_0HeroFightViewLevel.New(),
		HeroGroupInfoScrollView.New(),
		TabViewGroup.New(1, "#go_container/#go_btns/commonBtns")
	}
end

function Season3_0HeroGroupFightViewContainer:getSeason3_0HeroGroupFightView()
	return self._views[1]
end

function Season3_0HeroGroupFightViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonsView = NavigateButtonsView.New({
			true,
			true,
			true
		}, HelpEnum.HelpId.Season3_0HerogroupHelp, self._closeCallback, nil, nil, self)

		self._navigateButtonsView:setCloseCheck(self.defaultOverrideCloseCheck, self)

		return {
			self._navigateButtonsView
		}
	end
end

function Season3_0HeroGroupFightViewContainer:_closeCallback()
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

function Season3_0HeroGroupFightViewContainer:handleVersionActivityCloseCall()
	if EnterActivityViewOnExitFightSceneHelper.checkCurrentIsActivityFight() then
		EnterActivityViewOnExitFightSceneHelper.enterCurrentActivity(true, true)

		return true
	end
end

function Season3_0HeroGroupFightViewContainer:setNavigateOverrideClose(callBack, callbackObject)
	self._navigateButtonsView:setOverrideClose(callBack, callbackObject)
end

function Season3_0HeroGroupFightViewContainer:defaultOverrideCloseCheck(reallyClose, reallyCloseObj)
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

return Season3_0HeroGroupFightViewContainer
