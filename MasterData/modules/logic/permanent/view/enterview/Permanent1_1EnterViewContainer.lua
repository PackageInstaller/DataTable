-- chunkname: @modules/logic/permanent/view/enterview/Permanent1_1EnterViewContainer.lua

module("modules.logic.permanent.view.enterview.Permanent1_1EnterViewContainer", package.seeall)

local Permanent1_1EnterViewContainer = class("Permanent1_1EnterViewContainer", BaseViewContainer)

function Permanent1_1EnterViewContainer:buildViews()
	local views = {}

	table.insert(views, Permanent1_1EnterView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function Permanent1_1EnterViewContainer:buildTabViews(tabContainerId)
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

return Permanent1_1EnterViewContainer
