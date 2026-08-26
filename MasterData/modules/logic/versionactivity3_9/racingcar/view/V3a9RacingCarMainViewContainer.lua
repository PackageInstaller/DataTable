-- chunkname: @modules/logic/versionactivity3_9/racingcar/view/V3a9RacingCarMainViewContainer.lua

module("modules.logic.versionactivity3_9.racingcar.view.V3a9RacingCarMainViewContainer", package.seeall)

local V3a9RacingCarMainViewContainer = class("V3a9RacingCarMainViewContainer", BaseViewContainer)

function V3a9RacingCarMainViewContainer:buildViews()
	local views = {}

	table.insert(views, V3a9RacingCarMainView.New())
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))

	local scrollParam1 = ListScrollParam.New()

	scrollParam1.scrollGOPath = "#go_Bottom/#scroll_section"
	scrollParam1.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam1.prefabUrl = self._viewSetting.otherRes.sectionitem
	scrollParam1.cellClass = V3a9RacingCarMainSectionItem
	scrollParam1.scrollDir = ScrollEnum.ScrollDirH
	scrollParam1.lineCount = 1
	scrollParam1.cellWidth = 145
	scrollParam1.cellHeight = 176
	scrollParam1.cellSpaceH = 0
	scrollParam1.cellSpaceV = 0
	scrollParam1.startSpace = 0
	self.scrollView = LuaListScrollExtend.New(V3a9RacingCarSectionListModel.instance, scrollParam1)

	table.insert(views, self.scrollView)

	return views
end

function V3a9RacingCarMainViewContainer:onContainerInit()
	V3a9RacingCarSectionListModel.instance:initList()
end

function V3a9RacingCarMainViewContainer:onContainerOpen()
	local index = V3a9RacingCarSectionListModel.instance:getSelectedConfigIndex()

	if index >= 5 then
		self.scrollView:moveTo(index, false)
	end
end

function V3a9RacingCarMainViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self.navigateView
		}
	end
end

return V3a9RacingCarMainViewContainer
