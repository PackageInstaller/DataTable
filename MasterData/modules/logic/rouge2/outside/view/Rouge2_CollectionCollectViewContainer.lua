-- chunkname: @modules/logic/rouge2/outside/view/Rouge2_CollectionCollectViewContainer.lua

module("modules.logic.rouge2.outside.view.Rouge2_CollectionCollectViewContainer", package.seeall)

local Rouge2_CollectionCollectViewContainer = class("Rouge2_CollectionCollectViewContainer", BaseViewContainer)

function Rouge2_CollectionCollectViewContainer:buildViews()
	local views = {}

	table.insert(views, Rouge2_CollectionCollectView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function Rouge2_CollectionCollectViewContainer:buildTabViews(tabContainerId)
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

return Rouge2_CollectionCollectViewContainer
