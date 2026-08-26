-- chunkname: @modules/logic/versionactivity2_8/dungeonboss/view/VersionActivity2_8BossStoryEnterViewContainer.lua

module("modules.logic.versionactivity2_8.dungeonboss.view.VersionActivity2_8BossStoryEnterViewContainer", package.seeall)

local VersionActivity2_8BossStoryEnterViewContainer = class("VersionActivity2_8BossStoryEnterViewContainer", BaseViewContainer)

function VersionActivity2_8BossStoryEnterViewContainer:buildViews()
	local views = {}

	self._mapScene = VersionActivity2_8BossStorySceneView.New()

	table.insert(views, VersionActivity2_8BossStoryEnterView.New())
	table.insert(views, self._mapScene)
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))

	return views
end

function VersionActivity2_8BossStoryEnterViewContainer:buildTabViews(tabContainerId)
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

function VersionActivity2_8BossStoryEnterViewContainer:setVisibleInternal(isVisible)
	VersionActivity2_8BossStoryEnterViewContainer.super.setVisibleInternal(self, isVisible)

	if self._mapScene then
		self._mapScene:setSceneVisible(isVisible)
	end
end

return VersionActivity2_8BossStoryEnterViewContainer
