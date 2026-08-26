-- chunkname: @modules/logic/versionactivity2_5/decoratestore/view/V2a5_DecorateStoreFullViewContainer.lua

module("modules.logic.versionactivity2_5.decoratestore.view.V2a5_DecorateStoreFullViewContainer", package.seeall)

local V2a5_DecorateStoreFullViewContainer = class("V2a5_DecorateStoreFullViewContainer", BaseViewContainer)

function V2a5_DecorateStoreFullViewContainer:buildViews()
	local views = {}

	table.insert(views, V2a5_DecorateStoreView.New())

	return views
end

function V2a5_DecorateStoreFullViewContainer:buildTabViews(tabContainerId)
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

return V2a5_DecorateStoreFullViewContainer
