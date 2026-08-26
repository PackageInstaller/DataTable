-- chunkname: @modules/logic/versionactivity2_7/act191/view/Act191EnemyInfoViewContainer.lua

module("modules.logic.versionactivity2_7.act191.view.Act191EnemyInfoViewContainer", package.seeall)

local Act191EnemyInfoViewContainer = class("Act191EnemyInfoViewContainer", BaseViewContainer)

function Act191EnemyInfoViewContainer:buildViews()
	local views = {}

	table.insert(views, Act191EnemyInfoView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function Act191EnemyInfoViewContainer:buildTabViews(tabContainerId)
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

return Act191EnemyInfoViewContainer
