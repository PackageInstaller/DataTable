-- chunkname: @modules/logic/permanent/view/enterview/Permanent2_5EnterViewContainer.lua

module("modules.logic.permanent.view.enterview.Permanent2_5EnterViewContainer", package.seeall)

local Permanent2_5EnterViewContainer = class("Permanent2_5EnterViewContainer", BaseViewContainer)

function Permanent2_5EnterViewContainer:buildViews()
	local views = {}

	table.insert(views, Permanent2_5EnterView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function Permanent2_5EnterViewContainer:buildTabViews(tabContainerId)
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

return Permanent2_5EnterViewContainer
