-- chunkname: @modules/logic/bossrush/view/v3a9/V3a9_BossRush_BonusViewContainer.lua

module("modules.logic.bossrush.view.v3a9.V3a9_BossRush_BonusViewContainer", package.seeall)

local V3a9_BossRush_BonusViewContainer = class("V3a9_BossRush_BonusViewContainer", BaseViewContainer)

function V3a9_BossRush_BonusViewContainer:buildViews()
	local views = {}

	table.insert(views, V3a9_BossRush_BonusView.New())
	table.insert(views, TabViewGroup.New(1, "top_left"))

	return views
end

function V3a9_BossRush_BonusViewContainer:buildTabViews(tabContainerId)
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

return V3a9_BossRush_BonusViewContainer
