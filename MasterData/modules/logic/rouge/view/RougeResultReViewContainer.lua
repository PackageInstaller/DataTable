-- chunkname: @modules/logic/rouge/view/RougeResultReViewContainer.lua

module("modules.logic.rouge.view.RougeResultReViewContainer", package.seeall)

local RougeResultReViewContainer = class("RougeResultReViewContainer", BaseViewContainer)

function RougeResultReViewContainer:buildViews()
	local views = {}

	table.insert(views, RougeResultReView.New())
	table.insert(views, RougeResultReViewDLCComp.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function RougeResultReViewContainer:buildTabViews(tabContainerId)
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

return RougeResultReViewContainer
