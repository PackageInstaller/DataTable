-- chunkname: @modules/logic/permanent/view/enterview/Permanent3_1EnterViewContainer.lua

module("modules.logic.permanent.view.enterview.Permanent3_1EnterViewContainer", package.seeall)

local Permanent3_1EnterViewContainer = class("Permanent3_1EnterViewContainer", BaseViewContainer)

function Permanent3_1EnterViewContainer:buildViews()
	local views = {}

	table.insert(views, Permanent3_1EnterView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function Permanent3_1EnterViewContainer:buildTabViews(tabContainerId)
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

return Permanent3_1EnterViewContainer
