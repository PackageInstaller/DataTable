-- chunkname: @modules/logic/dungeon/view/DungeonMapLevelViewContainer.lua

module("modules.logic.dungeon.view.DungeonMapLevelViewContainer", package.seeall)

local DungeonMapLevelViewContainer = class("DungeonMapLevelViewContainer", BaseViewContainer)

function DungeonMapLevelViewContainer:buildViews()
	local views = {}

	table.insert(views, DungeonMapLevelView.New())
	table.insert(views, DungeonMapLevelRewardView.New())
	table.insert(views, TabViewGroup.New(1, "anim/#go_righttop"))
	table.insert(views, TabViewGroup.New(2, "anim/top_left"))

	return views
end

function DungeonMapLevelViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		local currencyType = CurrencyEnum.CurrencyType
		local currencyParam = {
			currencyType.Power
		}

		return {
			CurrencyView.New(currencyParam)
		}
	elseif tabContainerId == 2 then
		local chapterType = DungeonModel.instance.curChapterType
		local showHelp = chapterType == DungeonEnum.ChapterType.Normal and HelpModel.instance:isShowedHelp(HelpEnum.HelpId.Dungeon)

		self._navigateButtonView = DungeonNavigateButtonsView.New({
			true,
			true,
			showHelp
		}, HelpEnum.HelpId.Dungeon)

		self._navigateButtonView:setOverrideClose(self._overrideClose, self)
		self._navigateButtonView:setAnimEnabled(false)
		self._navigateButtonView:setOpenCallback(self.initChapterRecheck, self)
		self._navigateButtonView:setOverrideClickRecheck(self.closeThis, self)

		return {
			self._navigateButtonView
		}
	end
end

function DungeonMapLevelViewContainer:onContainerOpenFinish()
	self._navigateButtonView:resetOnCloseViewAudio(0)
	DungeonModel.instance:setLastSelectMode(nil, nil)
end

function DungeonMapLevelViewContainer:_overrideClose()
	if ViewMgr.instance:isOpen(ViewName.DungeonView) or ViewMgr.instance:isOpen(ViewName.RoleStoryDispatchMainView) or ViewMgr.instance:isOpen(ViewName.CommandStationEnterView) then
		ViewMgr.instance:closeView(ViewName.DungeonMapView, false, true)
		ViewMgr.instance:closeView(ViewName.DungeonMapLevelView, false, true)

		return
	end

	module_views_preloader.DungeonViewPreload(function()
		DungeonController.instance:openDungeonView(nil, true)
		ViewMgr.instance:closeView(ViewName.DungeonMapView, false, true)
		ViewMgr.instance:closeView(ViewName.DungeonMapLevelView, false, true)
	end)
end

function DungeonMapLevelViewContainer:refreshHelp()
	if self._navigateButtonView then
		local chapterType = DungeonModel.instance.curChapterType
		local showHelp = chapterType == DungeonEnum.ChapterType.Normal and HelpModel.instance:isShowedHelp(HelpEnum.HelpId.Dungeon)

		self._navigateButtonView:setParam({
			true,
			true,
			showHelp
		})
	end
end

function DungeonMapLevelViewContainer:initChapterRecheck()
	local chapterId = self:_getChapterId()

	if self._navigateButtonView then
		self._navigateButtonView:initChapterRecheck(chapterId)
	end
end

function DungeonMapLevelViewContainer:_getChapterId()
	return self.viewParam and self.viewParam[1] and self.viewParam[1].chapterId
end

return DungeonMapLevelViewContainer
