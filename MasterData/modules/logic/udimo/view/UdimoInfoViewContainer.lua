-- chunkname: @modules/logic/udimo/view/UdimoInfoViewContainer.lua

module("modules.logic.udimo.view.UdimoInfoViewContainer", package.seeall)

local UdimoInfoViewContainer = class("UdimoInfoViewContainer", BaseViewContainer)

function UdimoInfoViewContainer:buildViews()
	local views = {}
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "Root/Left/#scroll_list"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "Root/Left/#scroll_list/Viewport/Content/#go_Item"
	scrollParam.cellClass = UdimoInfoHeadItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 2
	scrollParam.cellWidth = 350
	scrollParam.cellHeight = 220

	table.insert(views, LuaListScrollView.New(UdimoInfoListModel.instance, scrollParam))
	table.insert(views, UdimoInfoView.New())
	table.insert(views, TabViewGroup.New(1, "Root/#go_topleft"))

	return views
end

function UdimoInfoViewContainer:buildTabViews(tabContainerId)
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

return UdimoInfoViewContainer
