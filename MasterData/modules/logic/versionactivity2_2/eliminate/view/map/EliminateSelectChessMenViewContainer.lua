-- chunkname: @modules/logic/versionactivity2_2/eliminate/view/map/EliminateSelectChessMenViewContainer.lua

module("modules.logic.versionactivity2_2.eliminate.view.map.EliminateSelectChessMenViewContainer", package.seeall)

local EliminateSelectChessMenViewContainer = class("EliminateSelectChessMenViewContainer", BaseViewContainer)

function EliminateSelectChessMenViewContainer:buildViews()
	local views = {}

	table.insert(views, EliminateSelectChessMenView.New())
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))

	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "Left/#scroll_ChessList"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = EliminateSelectChessMenItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 5
	scrollParam.cellWidth = 220
	scrollParam.cellHeight = 272
	scrollParam.startSpace = 20

	table.insert(views, LuaListScrollView.New(EliminateSelectChessMenListModel.instance, scrollParam))

	return views
end

function EliminateSelectChessMenViewContainer:buildTabViews(tabContainerId)
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

return EliminateSelectChessMenViewContainer
