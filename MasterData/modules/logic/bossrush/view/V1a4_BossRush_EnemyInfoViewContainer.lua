-- chunkname: @modules/logic/bossrush/view/V1a4_BossRush_EnemyInfoViewContainer.lua

module("modules.logic.bossrush.view.V1a4_BossRush_EnemyInfoViewContainer", package.seeall)

local V1a4_BossRush_EnemyInfoViewContainer = class("V1a4_BossRush_EnemyInfoViewContainer", BaseViewContainer)

function V1a4_BossRush_EnemyInfoViewContainer:buildViews()
	self._bossRushViewRule = V1a4_BossRushViewRule.New()

	return {
		V1a4_BossRush_EnemyInfoView.New(),
		TabViewGroup.New(1, "#go_btns"),
		self._bossRushViewRule
	}
end

function V1a4_BossRush_EnemyInfoViewContainer:getBossRushViewRule()
	return self._bossRushViewRule
end

function V1a4_BossRush_EnemyInfoViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		}, 100, self._closeCallback, nil, nil, self)

		return {
			self._navigateButtonView
		}
	end
end

function V1a4_BossRush_EnemyInfoViewContainer:diffRootChild(viewGO)
	return false
end

return V1a4_BossRush_EnemyInfoViewContainer
