-- chunkname: @modules/logic/permanent/view/enterview/Permanent2_2EnterViewContainer.lua

module("modules.logic.permanent.view.enterview.Permanent2_2EnterViewContainer", package.seeall)

local Permanent2_2EnterViewContainer = class("Permanent2_2EnterViewContainer", BaseViewContainer)

function Permanent2_2EnterViewContainer:buildViews()
	local views = {}

	table.insert(views, Permanent2_2EnterView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function Permanent2_2EnterViewContainer:buildTabViews(tabContainerId)
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

return Permanent2_2EnterViewContainer
