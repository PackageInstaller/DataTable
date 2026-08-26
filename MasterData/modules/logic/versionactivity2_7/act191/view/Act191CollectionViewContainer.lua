-- chunkname: @modules/logic/versionactivity2_7/act191/view/Act191CollectionViewContainer.lua

module("modules.logic.versionactivity2_7.act191.view.Act191CollectionViewContainer", package.seeall)

local Act191CollectionViewContainer = class("Act191CollectionViewContainer", BaseViewContainer)

function Act191CollectionViewContainer:buildViews()
	local views = {}

	table.insert(views, Act191CollectionView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function Act191CollectionViewContainer:buildTabViews(tabContainerId)
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

return Act191CollectionViewContainer
