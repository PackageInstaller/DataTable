-- chunkname: @modules/logic/permanent/view/enterview/Permanent1_3EnterViewContainer.lua

module("modules.logic.permanent.view.enterview.Permanent1_3EnterViewContainer", package.seeall)

local Permanent1_3EnterViewContainer = class("Permanent1_3EnterViewContainer", BaseViewContainer)

function Permanent1_3EnterViewContainer:buildViews()
	local views = {}

	table.insert(views, Permanent1_3EnterView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function Permanent1_3EnterViewContainer:buildTabViews(tabContainerId)
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

return Permanent1_3EnterViewContainer
