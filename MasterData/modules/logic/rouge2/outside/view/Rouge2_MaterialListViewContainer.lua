-- chunkname: @modules/logic/rouge2/outside/view/Rouge2_MaterialListViewContainer.lua

module("modules.logic.rouge2.outside.view.Rouge2_MaterialListViewContainer", package.seeall)

local Rouge2_MaterialListViewContainer = class("Rouge2_MaterialListViewContainer", BaseViewContainer)

function Rouge2_MaterialListViewContainer:buildViews()
	local views = {}

	table.insert(views, Rouge2_MaterialListView.New())
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))

	local scrollParam = MixScrollParam.New()

	scrollParam.scrollGOPath = "Left/#scroll_collection"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = Rouge2_MaterialListRow
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.startSpace = 0
	scrollParam.endSpace = 0

	table.insert(views, LuaMixScrollView.New(Rouge2_MaterialListModel.instance, scrollParam))

	return views
end

function Rouge2_MaterialListViewContainer:buildScrollParam()
	return
end

function Rouge2_MaterialListViewContainer:buildTabViews(tabContainerId)
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

return Rouge2_MaterialListViewContainer
