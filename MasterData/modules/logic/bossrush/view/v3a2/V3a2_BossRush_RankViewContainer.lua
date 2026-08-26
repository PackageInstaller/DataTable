-- chunkname: @modules/logic/bossrush/view/v3a2/V3a2_BossRush_RankViewContainer.lua

module("modules.logic.bossrush.view.v3a2.V3a2_BossRush_RankViewContainer", package.seeall)

local V3a2_BossRush_RankViewContainer = class("V3a2_BossRush_RankViewContainer", BaseViewContainer)

function V3a2_BossRush_RankViewContainer:buildViews()
	local views = {}

	table.insert(views, V3a2_BossRush_RankView.New())
	table.insert(views, TabViewGroup.New(1, "top_left"))

	return views
end

function V3a2_BossRush_RankViewContainer:buildTabViews(tabContainerId)
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

return V3a2_BossRush_RankViewContainer
