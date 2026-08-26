-- chunkname: @modules/logic/permanent/view/enterview/Permanent2_4EnterViewContainer.lua

module("modules.logic.permanent.view.enterview.Permanent2_4EnterViewContainer", package.seeall)

local Permanent2_4EnterViewContainer = class("Permanent2_4EnterViewContainer", BaseViewContainer)

function Permanent2_4EnterViewContainer:buildViews()
	local views = {}

	table.insert(views, Permanent2_4EnterView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function Permanent2_4EnterViewContainer:buildTabViews(tabContainerId)
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

return Permanent2_4EnterViewContainer
