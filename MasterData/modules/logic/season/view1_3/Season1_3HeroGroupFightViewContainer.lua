-- chunkname: @modules/logic/season/view1_3/Season1_3HeroGroupFightViewContainer.lua

module("modules.logic.season.view1_3.Season1_3HeroGroupFightViewContainer", package.seeall)

local Season1_3HeroGroupFightViewContainer = class("Season1_3HeroGroupFightViewContainer", BaseViewContainer)

function Season1_3HeroGroupFightViewContainer:buildViews()
	return {
		Season1_3HeroGroupFightView.New(),
		Season1_3HeroGroupListView.New(),
		Season1_3HeroGroupFightViewRule.New(),
		Season1_3HeroFightViewLevel.New(),
		TabViewGroup.New(1, "#go_container/#go_btns/commonBtns")
	}
end

function Season1_3HeroGroupFightViewContainer:getSeason1_3HeroGroupFightView()
	return self._views[1]
end

function Season1_3HeroGroupFightViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonsView = NavigateButtonsView.New({
			true,
			true,
			true
		}, HelpEnum.HelpId.Season1_3HerogroupHelp, self._closeCallback, nil, nil, self)

		self._navigateButtonsView:setCloseCheck(self.defaultOverrideCloseCheck, self)

		return {
			self._navigateButtonsView
		}
	end
end

function Season1_3HeroGroupFightViewContainer:_closeCallback()
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

function Season1_3HeroGroupFightViewContainer:handleVersionActivityCloseCall()
	if EnterActivityViewOnExitFightSceneHelper.checkCurrentIsActivityFight() then
		EnterActivityViewOnExitFightSceneHelper.enterCurrentActivity(true, true)

		return true
	end
end

function Season1_3HeroGroupFightViewContainer:setNavigateOverrideClose(callBack, callbackObject)
	self._navigateButtonsView:setOverrideClose(callBack, callbackObject)
end

function Season1_3HeroGroupFightViewContainer:defaultOverrideCloseCheck(reallyClose, reallyCloseObj)
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

return Season1_3HeroGroupFightViewContainer
