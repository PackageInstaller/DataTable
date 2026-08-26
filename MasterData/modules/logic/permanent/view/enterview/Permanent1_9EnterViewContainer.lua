-- chunkname: @modules/logic/permanent/view/enterview/Permanent1_9EnterViewContainer.lua

module("modules.logic.permanent.view.enterview.Permanent1_9EnterViewContainer", package.seeall)

local Permanent1_9EnterViewContainer = class("Permanent1_9EnterViewContainer", BaseViewContainer)

function Permanent1_9EnterViewContainer:buildViews()
	local views = {}

	table.insert(views, Permanent1_9EnterView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function Permanent1_9EnterViewContainer:buildTabViews(tabContainerId)
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

return Permanent1_9EnterViewContainer
