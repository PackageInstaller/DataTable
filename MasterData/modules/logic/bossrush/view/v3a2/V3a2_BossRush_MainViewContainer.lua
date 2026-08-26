-- chunkname: @modules/logic/bossrush/view/v3a2/V3a2_BossRush_MainViewContainer.lua

module("modules.logic.bossrush.view.v3a2.V3a2_BossRush_MainViewContainer", package.seeall)

local V3a2_BossRush_MainViewContainer = class("V3a2_BossRush_MainViewContainer", BaseViewContainer)

function V3a2_BossRush_MainViewContainer:buildViews()
	local views = {}

	table.insert(views, V3a2_BossRush_MainView.New())
	table.insert(views, TabViewGroup.New(1, "top_left"))

	return views
end

function V3a2_BossRush_MainViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			true
		}, HelpEnum.HelpId.BossRushViewHelp)

		return {
			self.navigateView
		}
	end
end

return V3a2_BossRush_MainViewContainer
