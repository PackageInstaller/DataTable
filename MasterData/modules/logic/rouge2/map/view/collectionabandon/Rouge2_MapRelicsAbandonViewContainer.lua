-- chunkname: @modules/logic/rouge2/map/view/collectionabandon/Rouge2_MapRelicsAbandonViewContainer.lua

module("modules.logic.rouge2.map.view.collectionabandon.Rouge2_MapRelicsAbandonViewContainer", package.seeall)

local Rouge2_MapRelicsAbandonViewContainer = class("Rouge2_MapRelicsAbandonViewContainer", BaseViewContainer)

function Rouge2_MapRelicsAbandonViewContainer:buildViews()
	local views = {}

	table.insert(views, Rouge2_MapRelicsAbandonView.New())

	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "Container/#scroll_view"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "Container/#scroll_view/Viewport/Content/#go_Item"
	scrollParam.cellClass = Rouge2_MapRelicsLossItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirH
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 450
	scrollParam.cellHeight = 736
	scrollParam.cellSpaceH = 30
	self.scrollView = LuaListScrollView.New(Rouge2_LossRelicsListModel.instance, scrollParam)

	table.insert(views, self.scrollView)

	return views
end

function Rouge2_MapRelicsAbandonViewContainer:buildTabViews(tabContainerId)
	return
end

return Rouge2_MapRelicsAbandonViewContainer
