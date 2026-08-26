-- chunkname: @modules/logic/versionactivity3_7/wmz/view/V3a7_Wmz_LevelViewContainer.lua

module("modules.logic.versionactivity3_7.wmz.view.V3a7_Wmz_LevelViewContainer", package.seeall)

local V3a7_Wmz_LevelViewContainer = class("V3a7_Wmz_LevelViewContainer", WmzViewBaseContainer)

function V3a7_Wmz_LevelViewContainer:buildViews()
	self._mainView = V3a7_Wmz_LevelView.New()

	return {
		self._mainView,
		TabViewGroup.New(1, "#go_topleft")
	}
end

local kTabContainerId_NavigateButtonsView = 1

function V3a7_Wmz_LevelViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == kTabContainerId_NavigateButtonsView then
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

function V3a7_Wmz_LevelViewContainer:onContainerDestroy()
	UIBlockMgrExtend.setNeedCircleMv(true)
	V3a7_Wmz_LevelViewContainer.super.onContainerDestroy(self)
end

return V3a7_Wmz_LevelViewContainer
