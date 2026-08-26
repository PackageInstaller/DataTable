-- chunkname: @modules/logic/permanent/view/enterview/Permanent2_0EnterViewContainer.lua

module("modules.logic.permanent.view.enterview.Permanent2_0EnterViewContainer", package.seeall)

local Permanent2_0EnterViewContainer = class("Permanent2_0EnterViewContainer", BaseViewContainer)

function Permanent2_0EnterViewContainer:buildViews()
	local views = {}

	table.insert(views, Permanent2_0EnterView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function Permanent2_0EnterViewContainer:buildTabViews(tabContainerId)
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

return Permanent2_0EnterViewContainer
