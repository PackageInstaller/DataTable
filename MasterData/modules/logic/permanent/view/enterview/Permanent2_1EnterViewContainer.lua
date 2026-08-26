-- chunkname: @modules/logic/permanent/view/enterview/Permanent2_1EnterViewContainer.lua

module("modules.logic.permanent.view.enterview.Permanent2_1EnterViewContainer", package.seeall)

local Permanent2_1EnterViewContainer = class("Permanent2_1EnterViewContainer", BaseViewContainer)

function Permanent2_1EnterViewContainer:buildViews()
	local views = {}

	table.insert(views, Permanent2_1EnterView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function Permanent2_1EnterViewContainer:buildTabViews(tabContainerId)
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

return Permanent2_1EnterViewContainer
