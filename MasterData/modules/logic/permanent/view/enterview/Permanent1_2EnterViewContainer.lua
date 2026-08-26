-- chunkname: @modules/logic/permanent/view/enterview/Permanent1_2EnterViewContainer.lua

module("modules.logic.permanent.view.enterview.Permanent1_2EnterViewContainer", package.seeall)

local Permanent1_2EnterViewContainer = class("Permanent1_2EnterViewContainer", BaseViewContainer)

function Permanent1_2EnterViewContainer:buildViews()
	local views = {}

	table.insert(views, Permanent1_2EnterView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function Permanent1_2EnterViewContainer:buildTabViews(tabContainerId)
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

return Permanent1_2EnterViewContainer
