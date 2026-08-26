-- chunkname: @modules/logic/versionactivity2_8/dungeonboss/view/VersionActivity2_8BossActEnterViewContainer.lua

module("modules.logic.versionactivity2_8.dungeonboss.view.VersionActivity2_8BossActEnterViewContainer", package.seeall)

local VersionActivity2_8BossActEnterViewContainer = class("VersionActivity2_8BossActEnterViewContainer", BaseViewContainer)

function VersionActivity2_8BossActEnterViewContainer:buildViews()
	local views = {}

	self._mapScene = VersionActivity2_8BossActSceneView.New()

	table.insert(views, VersionActivity2_8BossActEnterView.New())
	table.insert(views, self._mapScene)
	table.insert(views, TabViewGroup.New(1, "anim/#go_lefttop"))

	return views
end

function VersionActivity2_8BossActEnterViewContainer:buildTabViews(tabContainerId)
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

function VersionActivity2_8BossActEnterViewContainer:setVisibleInternal(isVisible)
	VersionActivity2_8BossActEnterViewContainer.super.setVisibleInternal(self, isVisible)

	if self._mapScene then
		self._mapScene:setSceneVisible(isVisible)
	end
end

return VersionActivity2_8BossActEnterViewContainer
