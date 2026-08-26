-- chunkname: @modules/logic/seasonver/act123/view3_5/Season123_3_5EnemyViewContainer.lua

module("modules.logic.seasonver.act123.view3_5.Season123_3_5EnemyViewContainer", package.seeall)

local Season123_3_5EnemyViewContainer = class("Season123_3_5EnemyViewContainer", BaseViewContainer)

function Season123_3_5EnemyViewContainer:buildViews()
	return {
		Season123_3_5EnemyView.New(),
		Season123_3_5EnemyTabList.New(),
		Season123_3_5EnemyRule.New(),
		TabViewGroup.New(1, "#go_btns")
	}
end

function Season123_3_5EnemyViewContainer:buildTabViews(tabContainerId)
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

function Season123_3_5EnemyViewContainer:onContainerOpenFinish()
	return
end

return Season123_3_5EnemyViewContainer
