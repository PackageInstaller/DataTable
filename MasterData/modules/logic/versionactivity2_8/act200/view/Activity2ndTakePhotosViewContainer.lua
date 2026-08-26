-- chunkname: @modules/logic/versionactivity2_8/act200/view/Activity2ndTakePhotosViewContainer.lua

module("modules.logic.versionactivity2_8.act200.view.Activity2ndTakePhotosViewContainer", package.seeall)

local Activity2ndTakePhotosViewContainer = class("Activity2ndTakePhotosViewContainer", BaseViewContainer)

function Activity2ndTakePhotosViewContainer:buildViews()
	local views = {}

	table.insert(views, Activity2ndTakePhotosView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function Activity2ndTakePhotosViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		self._navigateButtonView:setOverrideClose(self._overrideCloseFunc, self)

		return {
			self._navigateButtonView
		}
	end
end

return Activity2ndTakePhotosViewContainer
