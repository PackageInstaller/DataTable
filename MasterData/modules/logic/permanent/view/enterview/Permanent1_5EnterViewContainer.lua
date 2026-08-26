-- chunkname: @modules/logic/permanent/view/enterview/Permanent1_5EnterViewContainer.lua

module("modules.logic.permanent.view.enterview.Permanent1_5EnterViewContainer", package.seeall)

local Permanent1_5EnterViewContainer = class("Permanent1_5EnterViewContainer", BaseViewContainer)

function Permanent1_5EnterViewContainer:buildViews()
	local views = {}

	table.insert(views, Permanent1_5EnterView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function Permanent1_5EnterViewContainer:buildTabViews(tabContainerId)
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

return Permanent1_5EnterViewContainer
