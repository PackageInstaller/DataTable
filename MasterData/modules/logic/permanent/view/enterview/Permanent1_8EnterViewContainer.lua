-- chunkname: @modules/logic/permanent/view/enterview/Permanent1_8EnterViewContainer.lua

module("modules.logic.permanent.view.enterview.Permanent1_8EnterViewContainer", package.seeall)

local Permanent1_8EnterViewContainer = class("Permanent1_8EnterViewContainer", BaseViewContainer)

function Permanent1_8EnterViewContainer:buildViews()
	local views = {}

	table.insert(views, Permanent1_8EnterView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function Permanent1_8EnterViewContainer:buildTabViews(tabContainerId)
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

return Permanent1_8EnterViewContainer
