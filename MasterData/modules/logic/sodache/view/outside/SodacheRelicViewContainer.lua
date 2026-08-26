-- chunkname: @modules/logic/sodache/view/outside/SodacheRelicViewContainer.lua

module("modules.logic.sodache.view.outside.SodacheRelicViewContainer", package.seeall)

local SodacheRelicViewContainer = class("SodacheRelicViewContainer", BaseViewContainer)

function SodacheRelicViewContainer:buildViews()
	local views = {}
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_Card"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "#scroll_Card/Viewport/Content/RelicItem"
	scrollParam.cellClass = SodacheRelicItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirH
	scrollParam.cellWidth = 228
	scrollParam.cellHeight = 336
	scrollParam.lineCount = 2
	scrollParam.startSpace = 200
	scrollParam.endSpace = 200
	scrollParam.cellSpaceH = 50
	scrollParam.cellSpaceV = 100
	self.scrollView = LuaListScrollExtend.New(SodacheRelicMoListModel.instance, scrollParam)

	table.insert(views, self.scrollView)
	table.insert(views, SodacheRelicView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function SodacheRelicViewContainer:buildTabViews(tabContainerId)
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

return SodacheRelicViewContainer
