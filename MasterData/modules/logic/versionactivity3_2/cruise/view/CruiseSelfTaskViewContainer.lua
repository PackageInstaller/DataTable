-- chunkname: @modules/logic/versionactivity3_2/cruise/view/CruiseSelfTaskViewContainer.lua

module("modules.logic.versionactivity3_2.cruise.view.CruiseSelfTaskViewContainer", package.seeall)

local CruiseSelfTaskViewContainer = class("CruiseSelfTaskViewContainer", BaseViewContainer)

function CruiseSelfTaskViewContainer:buildViews()
	local views = {}

	table.insert(views, CruiseSelfTaskView.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function CruiseSelfTaskViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonsView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			self._navigateButtonsView
		}
	end
end

return CruiseSelfTaskViewContainer
