-- chunkname: @modules/logic/rouge2/start/view/Rouge2_SystemSelectViewContainer.lua

module("modules.logic.rouge2.start.view.Rouge2_SystemSelectViewContainer", package.seeall)

local Rouge2_SystemSelectViewContainer = class("Rouge2_SystemSelectViewContainer", BaseViewContainer)

function Rouge2_SystemSelectViewContainer:buildViews()
	local views = {}
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#go_Root/#scroll_List"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "#go_Root/#scroll_List/Viewport/Content/#go_SystemItem"
	scrollParam.cellClass = Rouge2_SystemSelectItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 1750
	scrollParam.cellHeight = 250
	scrollParam.startSpace = 23
	scrollParam.cellSpaceV = 23

	table.insert(views, Rouge2_SystemSelectView.New())
	table.insert(views, TabViewGroup.New(1, "#go_Root/#go_topleft"))
	table.insert(views, LuaListScrollView.New(Rouge2_SystemSelectListModel.instance, scrollParam))

	return views
end

function Rouge2_SystemSelectViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			false,
			false,
			true
		})

		self.navigateView:setOverrideHelp(self.overrideHelpBtn, self)

		return {
			self.navigateView
		}
	end
end

function Rouge2_SystemSelectViewContainer:overrideHelpBtn()
	Rouge2_Controller.instance:openTechniqueView(Rouge2_MapEnum.TechniqueId.SelectSystem)
end

return Rouge2_SystemSelectViewContainer
