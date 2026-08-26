-- chunkname: @modules/logic/seasonver/act123/view2_1/Season123_2_1EnemyViewContainer.lua

module("modules.logic.seasonver.act123.view2_1.Season123_2_1EnemyViewContainer", package.seeall)

local Season123_2_1EnemyViewContainer = class("Season123_2_1EnemyViewContainer", BaseViewContainer)

function Season123_2_1EnemyViewContainer:buildViews()
	return {
		Season123_2_1EnemyView.New(),
		Season123_2_1EnemyTabList.New(),
		Season123_2_1EnemyRule.New(),
		TabViewGroup.New(1, "#go_btns")
	}
end

function Season123_2_1EnemyViewContainer:buildTabViews(tabContainerId)
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

function Season123_2_1EnemyViewContainer:onContainerOpenFinish()
	return
end

return Season123_2_1EnemyViewContainer
