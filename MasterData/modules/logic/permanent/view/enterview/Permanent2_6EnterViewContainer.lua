-- chunkname: @modules/logic/permanent/view/enterview/Permanent2_6EnterViewContainer.lua

module("modules.logic.permanent.view.enterview.Permanent2_6EnterViewContainer", package.seeall)

local Permanent2_6EnterViewContainer = class("Permanent2_6EnterViewContainer", BaseViewContainer)

function Permanent2_6EnterViewContainer:buildViews()
	local views = {}

	table.insert(views, Permanent2_6EnterView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function Permanent2_6EnterViewContainer:buildTabViews(tabContainerId)
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

return Permanent2_6EnterViewContainer
