-- chunkname: @modules/logic/seasonver/act123/view2_3/Season123_2_3EnemyViewContainer.lua

module("modules.logic.seasonver.act123.view2_3.Season123_2_3EnemyViewContainer", package.seeall)

local Season123_2_3EnemyViewContainer = class("Season123_2_3EnemyViewContainer", BaseViewContainer)

function Season123_2_3EnemyViewContainer:buildViews()
	return {
		Season123_2_3EnemyView.New(),
		Season123_2_3EnemyTabList.New(),
		Season123_2_3EnemyRule.New(),
		TabViewGroup.New(1, "#go_btns")
	}
end

function Season123_2_3EnemyViewContainer:buildTabViews(tabContainerId)
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

function Season123_2_3EnemyViewContainer:onContainerOpenFinish()
	return
end

return Season123_2_3EnemyViewContainer
