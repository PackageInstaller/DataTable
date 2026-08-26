-- chunkname: @modules/logic/seasonver/act123/view1_8/Season123_1_8EnemyViewContainer.lua

module("modules.logic.seasonver.act123.view1_8.Season123_1_8EnemyViewContainer", package.seeall)

local Season123_1_8EnemyViewContainer = class("Season123_1_8EnemyViewContainer", BaseViewContainer)

function Season123_1_8EnemyViewContainer:buildViews()
	return {
		Season123_1_8EnemyView.New(),
		Season123_1_8EnemyTabList.New(),
		Season123_1_8EnemyRule.New(),
		TabViewGroup.New(1, "#go_btns")
	}
end

function Season123_1_8EnemyViewContainer:buildTabViews(tabContainerId)
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

function Season123_1_8EnemyViewContainer:onContainerOpenFinish()
	return
end

return Season123_1_8EnemyViewContainer
