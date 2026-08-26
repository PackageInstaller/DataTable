-- chunkname: @modules/logic/seasonver/act123/view2_0/Season123_2_0EnemyViewContainer.lua

module("modules.logic.seasonver.act123.view2_0.Season123_2_0EnemyViewContainer", package.seeall)

local Season123_2_0EnemyViewContainer = class("Season123_2_0EnemyViewContainer", BaseViewContainer)

function Season123_2_0EnemyViewContainer:buildViews()
	return {
		Season123_2_0EnemyView.New(),
		Season123_2_0EnemyTabList.New(),
		Season123_2_0EnemyRule.New(),
		TabViewGroup.New(1, "#go_btns")
	}
end

function Season123_2_0EnemyViewContainer:buildTabViews(tabContainerId)
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

function Season123_2_0EnemyViewContainer:onContainerOpenFinish()
	return
end

return Season123_2_0EnemyViewContainer
