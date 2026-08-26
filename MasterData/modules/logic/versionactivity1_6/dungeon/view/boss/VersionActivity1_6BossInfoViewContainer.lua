-- chunkname: @modules/logic/versionactivity1_6/dungeon/view/boss/VersionActivity1_6BossInfoViewContainer.lua

module("modules.logic.versionactivity1_6.dungeon.view.boss.VersionActivity1_6BossInfoViewContainer", package.seeall)

local VersionActivity1_6BossInfoViewContainer = class("VersionActivity1_6BossInfoViewContainer", BaseViewContainer)

function VersionActivity1_6BossInfoViewContainer:buildViews()
	self._bossRushViewRule = VersionActivity1_6_BossInfoRuleView.New()

	return {
		VersionActivity1_6BossInfoView.New(),
		TabViewGroup.New(1, "#go_btns"),
		self._bossRushViewRule
	}
end

function VersionActivity1_6BossInfoViewContainer:getBossRushViewRule()
	return self._bossRushViewRule
end

function VersionActivity1_6BossInfoViewContainer:buildTabViews(tabContainerId)
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

function VersionActivity1_6BossInfoViewContainer:diffRootChild(viewGO)
	return false
end

return VersionActivity1_6BossInfoViewContainer
