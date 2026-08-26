-- chunkname: @modules/logic/seasonver/act123/view/Season123EnemyViewContainer.lua

module("modules.logic.seasonver.act123.view.Season123EnemyViewContainer", package.seeall)

local Season123EnemyViewContainer = class("Season123EnemyViewContainer", BaseViewContainer)

function Season123EnemyViewContainer:buildViews()
	return {
		Season123EnemyView.New(),
		Season123EnemyTabList.New(),
		Season123EnemyRule.New(),
		TabViewGroup.New(1, "#go_btns")
	}
end

function Season123EnemyViewContainer:buildTabViews(tabContainerId)
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

function Season123EnemyViewContainer:onContainerOpenFinish()
	return
end

return Season123EnemyViewContainer
