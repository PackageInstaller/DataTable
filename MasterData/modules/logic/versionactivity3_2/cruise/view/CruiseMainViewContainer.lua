-- chunkname: @modules/logic/versionactivity3_2/cruise/view/CruiseMainViewContainer.lua

module("modules.logic.versionactivity3_2.cruise.view.CruiseMainViewContainer", package.seeall)

local CruiseMainViewContainer = class("CruiseMainViewContainer", BaseViewContainer)

function CruiseMainViewContainer:buildViews()
	local views = {}

	table.insert(views, CruiseMainView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function CruiseMainViewContainer:buildTabViews(tabContainerId)
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

return CruiseMainViewContainer
