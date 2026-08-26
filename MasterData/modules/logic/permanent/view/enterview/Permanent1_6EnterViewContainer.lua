-- chunkname: @modules/logic/permanent/view/enterview/Permanent1_6EnterViewContainer.lua

module("modules.logic.permanent.view.enterview.Permanent1_6EnterViewContainer", package.seeall)

local Permanent1_6EnterViewContainer = class("Permanent1_6EnterViewContainer", BaseViewContainer)

function Permanent1_6EnterViewContainer:buildViews()
	local views = {}

	table.insert(views, Permanent1_6EnterView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function Permanent1_6EnterViewContainer:buildTabViews(tabContainerId)
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

return Permanent1_6EnterViewContainer
