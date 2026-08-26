-- chunkname: @modules/logic/permanent/view/enterview/Permanent1_7EnterViewContainer.lua

module("modules.logic.permanent.view.enterview.Permanent1_7EnterViewContainer", package.seeall)

local Permanent1_7EnterViewContainer = class("Permanent1_7EnterViewContainer", BaseViewContainer)

function Permanent1_7EnterViewContainer:buildViews()
	local views = {}

	table.insert(views, Permanent1_7EnterView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function Permanent1_7EnterViewContainer:buildTabViews(tabContainerId)
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

return Permanent1_7EnterViewContainer
