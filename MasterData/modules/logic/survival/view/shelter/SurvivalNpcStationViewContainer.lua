-- chunkname: @modules/logic/survival/view/shelter/SurvivalNpcStationViewContainer.lua

module("modules.logic.survival.view.shelter.SurvivalNpcStationViewContainer", package.seeall)

local SurvivalNpcStationViewContainer = class("SurvivalNpcStationViewContainer", BaseViewContainer)

function SurvivalNpcStationViewContainer:buildViews()
	local views = {}
	local scrollParam1 = ListScrollParam.New()

	scrollParam1.scrollGOPath = "Panel/Right/#scroll_List"
	scrollParam1.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam1.prefabUrl = "Panel/Right/#scroll_List/Viewport/Content/#go_Item"
	scrollParam1.cellClass = SurvivalMonsterEventNpcItem
	scrollParam1.scrollDir = ScrollEnum.ScrollDirV
	scrollParam1.lineCount = 1
	scrollParam1.cellWidth = 800
	scrollParam1.cellHeight = 336
	scrollParam1.cellSpaceH = 0
	scrollParam1.cellSpaceV = 0
	scrollParam1.startSpace = 0
	self.scrollView = LuaListScrollViewWithAnimator.New(SurvivalShelterNpcMonsterListModel.instance, scrollParam1)
	self._survivalNpcStationView = SurvivalNpcStationView.New()

	table.insert(views, self.scrollView)
	table.insert(views, self._survivalNpcStationView)

	return views
end

function SurvivalNpcStationViewContainer:refreshView()
	if self._survivalNpcStationView then
		self._survivalNpcStationView:refreshView()
	end
end

return SurvivalNpcStationViewContainer
