-- chunkname: @modules/logic/seasonver/act123/view1_9/Season123_1_9EnemyViewContainer.lua

module("modules.logic.seasonver.act123.view1_9.Season123_1_9EnemyViewContainer", package.seeall)

local Season123_1_9EnemyViewContainer = class("Season123_1_9EnemyViewContainer", BaseViewContainer)

function Season123_1_9EnemyViewContainer:buildViews()
	return {
		Season123_1_9EnemyView.New(),
		Season123_1_9EnemyTabList.New(),
		Season123_1_9EnemyRule.New(),
		TabViewGroup.New(1, "#go_btns")
	}
end

function Season123_1_9EnemyViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigationView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self.navigationView
		}
	end
end

function Season123_1_9EnemyViewContainer:onContainerOpenFinish()
	return
end

return Season123_1_9EnemyViewContainer
