-- chunkname: @modules/logic/rouge2/start/view/Rouge2_CareerSelectViewContainer.lua

module("modules.logic.rouge2.start.view.Rouge2_CareerSelectViewContainer", package.seeall)

local Rouge2_CareerSelectViewContainer = class("Rouge2_CareerSelectViewContainer", BaseViewContainer)

function Rouge2_CareerSelectViewContainer:buildViews()
	local views = {}
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_CareerList"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "#scroll_CareerList/Viewport/Content/#go_CareerItem"
	scrollParam.cellClass = Rouge2_CareerSelectItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirH
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 240
	scrollParam.cellHeight = 200

	table.insert(views, Rouge2_CareerSelectView.New())
	table.insert(views, LuaListScrollView.New(Rouge2_CareerSelectListModel.instance, scrollParam))
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))

	return views
end

function Rouge2_CareerSelectViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			true
		}, nil, self.closeCallback, nil, nil, self)

		self.navigateView:setOverrideHelp(self.overrideHelpBtn, self)

		return {
			self.navigateView
		}
	end
end

function Rouge2_CareerSelectViewContainer:closeCallback()
	Rouge2_OutsideController.instance:dispatchEvent(Rouge2_OutsideEvent.BackEnterScene, Rouge2_OutsideEnum.SceneIndex.MainScene)
end

function Rouge2_CareerSelectViewContainer:overrideHelpBtn()
	Rouge2_Controller.instance:openTechniqueView(Rouge2_MapEnum.TechniqueId.CareerSelect)
end

return Rouge2_CareerSelectViewContainer
