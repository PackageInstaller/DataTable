-- chunkname: @modules/logic/permanent/view/enterview/Permanent3_0EnterViewContainer.lua

module("modules.logic.permanent.view.enterview.Permanent3_0EnterViewContainer", package.seeall)

local Permanent3_0EnterViewContainer = class("Permanent3_0EnterViewContainer", BaseViewContainer)

function Permanent3_0EnterViewContainer:buildViews()
	local views = {}

	table.insert(views, Permanent3_0EnterView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function Permanent3_0EnterViewContainer:buildTabViews(tabContainerId)
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

return Permanent3_0EnterViewContainer
