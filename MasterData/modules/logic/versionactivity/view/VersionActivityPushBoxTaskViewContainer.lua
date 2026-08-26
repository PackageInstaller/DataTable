-- chunkname: @modules/logic/versionactivity/view/VersionActivityPushBoxTaskViewContainer.lua

module("modules.logic.versionactivity.view.VersionActivityPushBoxTaskViewContainer", package.seeall)

local VersionActivityPushBoxTaskViewContainer = class("VersionActivityPushBoxTaskViewContainer", BaseViewContainer)

function VersionActivityPushBoxTaskViewContainer:buildViews()
	return {
		VersionActivityPushBoxTaskView.New()
	}
end

function VersionActivityPushBoxTaskViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self._navigateButtonView
		}
	end
end

return VersionActivityPushBoxTaskViewContainer
