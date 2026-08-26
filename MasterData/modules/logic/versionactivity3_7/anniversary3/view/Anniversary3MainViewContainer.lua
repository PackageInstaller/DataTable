-- chunkname: @modules/logic/versionactivity3_7/anniversary3/view/Anniversary3MainViewContainer.lua

module("modules.logic.versionactivity3_7.anniversary3.view.Anniversary3MainViewContainer", package.seeall)

local Anniversary3MainViewContainer = class("Anniversary3MainViewContainer", BaseViewContainer)

function Anniversary3MainViewContainer:buildViews()
	local views = {}

	self._view = Anniversary3MainView.New()

	table.insert(views, self._view)
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))

	return views
end

function Anniversary3MainViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			self._navigateButtonView
		}
	end
end

return Anniversary3MainViewContainer
