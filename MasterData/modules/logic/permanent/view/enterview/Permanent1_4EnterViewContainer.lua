-- chunkname: @modules/logic/permanent/view/enterview/Permanent1_4EnterViewContainer.lua

module("modules.logic.permanent.view.enterview.Permanent1_4EnterViewContainer", package.seeall)

local Permanent1_4EnterViewContainer = class("Permanent1_4EnterViewContainer", BaseViewContainer)

function Permanent1_4EnterViewContainer:buildViews()
	local views = {}

	table.insert(views, Permanent1_4EnterView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function Permanent1_4EnterViewContainer:buildTabViews(tabContainerId)
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

return Permanent1_4EnterViewContainer
