-- chunkname: @modules/logic/permanent/view/enterview/Permanent2_3EnterViewContainer.lua

module("modules.logic.permanent.view.enterview.Permanent2_3EnterViewContainer", package.seeall)

local Permanent2_3EnterViewContainer = class("Permanent2_3EnterViewContainer", BaseViewContainer)

function Permanent2_3EnterViewContainer:buildViews()
	local views = {}

	table.insert(views, Permanent2_3EnterView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function Permanent2_3EnterViewContainer:buildTabViews(tabContainerId)
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

return Permanent2_3EnterViewContainer
