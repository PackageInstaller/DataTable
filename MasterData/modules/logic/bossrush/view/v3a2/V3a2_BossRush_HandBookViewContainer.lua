-- chunkname: @modules/logic/bossrush/view/v3a2/V3a2_BossRush_HandBookViewContainer.lua

module("modules.logic.bossrush.view.v3a2.V3a2_BossRush_HandBookViewContainer", package.seeall)

local V3a2_BossRush_HandBookViewContainer = class("V3a2_BossRush_HandBookViewContainer", BaseViewContainer)

function V3a2_BossRush_HandBookViewContainer:buildViews()
	local views = {}

	table.insert(views, V3a2_BossRush_HandBookView.New())
	table.insert(views, V3a2_BossRush_HandBookEnemyInfoView.New())
	table.insert(views, TabViewGroup.New(1, "top_left"))

	return views
end

function V3a2_BossRush_HandBookViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			self.navigateView
		}
	end
end

return V3a2_BossRush_HandBookViewContainer
