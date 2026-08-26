-- chunkname: @modules/logic/dungeon/view/DungeonMapViewContainer.lua

module("modules.logic.dungeon.view.DungeonMapViewContainer", package.seeall)

local DungeonMapViewContainer = class("DungeonMapViewContainer", BaseViewContainer)

function DungeonMapViewContainer:buildViews()
	local views = {}

	table.insert(views, DungeonMapHoleView.New())

	self._mapScene = DungeonMapScene.New()
	self._mapTaskInfo = DungeonMapTaskInfo.New()

	table.insert(views, DungeonMapView.New())
	table.insert(views, self._mapTaskInfo)
	table.insert(views, DungeonMapSceneElements.New())
	table.insert(views, DungeonMapSceneDecorate.New())
	table.insert(views, self._mapScene)
	table.insert(views, DungeonMapEpisode.New())
	table.insert(views, DungeonMapElementReward.New())
	table.insert(views, DungeonMapEquipEntry.New())
	table.insert(views, TabViewGroup.New(1, "top_left"))
	table.insert(views, DungeonMapOtherBtnView.New())
	table.insert(views, DungeonMapActDropView.New())
	table.insert(views, DungeonMapToughBattleActView.New())
	table.insert(views, BalanceUmbrellaDungeonMapView.New())
	table.insert(views, InvestigateDungeonMapView.New())
	table.insert(views, DiceHeroDungeonMapView.New())
	table.insert(views, VersionActivity2_8BossActDungeonMapView.New())
	table.insert(views, CommandStationDungeonMapView.New())
	table.insert(views, TowerV3a7DungeonMapView.New())

	return views
end

function DungeonMapViewContainer:getMapScene()
	return self._mapScene
end

function DungeonMapViewContainer:getMapTaskInfo()
	return self._mapTaskInfo
end

function DungeonMapViewContainer:buildTabViews(tabContainerId)
	local chapterType = DungeonModel.instance.curChapterType
	local showHelp = chapterType == DungeonEnum.ChapterType.Normal and HelpModel.instance:isShowedHelp(HelpEnum.HelpId.Dungeon)

	self._navigateButtonView = DungeonNavigateButtonsView.New({
		true,
		true,
		showHelp
	}, HelpEnum.HelpId.Dungeon)

	self._navigateButtonView:setOverrideClose(self.overrideClose, self)
	self._navigateButtonView:setOpenCallback(self.initChapterRecheck, self)

	if chapterType == DungeonEnum.ChapterType.Equip then
		self._navigateButtonView.helpId = nil

		self._navigateButtonView:setParam({
			true,
			true,
			false
		})
	end

	return {
		self._navigateButtonView
	}
end

function DungeonMapViewContainer:onContainerInit()
	HelpController.instance:registerCallback(HelpEvent.RefreshHelp, self.refreshHelpBtnIcon, self)
end

function DungeonMapViewContainer:onContainerOpenFinish()
	self._navigateButtonView:resetOnCloseViewAudio(AudioEnum.UI.Play_UI_OperaHouse)
end

function DungeonMapViewContainer:onContainerDestroy()
	HelpController.instance:unregisterCallback(HelpEvent.RefreshHelp, self.refreshHelpBtnIcon, self)
end

function DungeonMapViewContainer:refreshHelpBtnIcon()
	self._navigateButtonView:changerHelpId(HelpEnum.HelpId.Dungeon)
end

function DungeonMapViewContainer:overrideCloseElement()
	DungeonController.instance:dispatchEvent(DungeonEvent.closeMapInteractiveItem)
end

function DungeonMapViewContainer:_overrideHelp()
	ViewMgr.instance:openView(ViewName.DungeonRewardTipView)
end

function DungeonMapViewContainer:overrideClose()
	self:closeThis()
end

function DungeonMapViewContainer:refreshHelp()
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

function DungeonMapViewContainer:setVisibleInternal(isVisible)
	DungeonMapViewContainer.super.setVisibleInternal(self, isVisible)

	if self._mapScene then
		self._mapScene:setSceneVisible(isVisible)
	end
end

function DungeonMapViewContainer:getNavigateButtonView()
	return self._navigateButtonView
end

function DungeonMapViewContainer:initChapterRecheck()
	local chapterId = self:_getChapterId()

	if self._navigateButtonView then
		self._navigateButtonView:initChapterRecheck(chapterId)
	end
end

function DungeonMapViewContainer:_getChapterId()
	return self.viewParam.chapterId
end

return DungeonMapViewContainer
