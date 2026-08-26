-- chunkname: @modules/logic/sp01/reactivity/view/V2a3_ReactivityEnterviewContainer.lua

module("modules.logic.sp01.reactivity.view.V2a3_ReactivityEnterviewContainer", package.seeall)

local V2a3_ReactivityEnterviewContainer = class("V2a3_ReactivityEnterviewContainer", BaseViewContainer)

function V2a3_ReactivityEnterviewContainer:buildViews()
	local views = {}

	table.insert(views, V2a3_ReactivityEnterview.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function V2a3_ReactivityEnterviewContainer:buildTabViews(tabContainerId)
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

return V2a3_ReactivityEnterviewContainer
