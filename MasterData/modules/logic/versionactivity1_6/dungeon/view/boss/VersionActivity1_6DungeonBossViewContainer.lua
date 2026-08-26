-- chunkname: @modules/logic/versionactivity1_6/dungeon/view/boss/VersionActivity1_6DungeonBossViewContainer.lua

module("modules.logic.versionactivity1_6.dungeon.view.boss.VersionActivity1_6DungeonBossViewContainer", package.seeall)

local VersionActivity1_6DungeonBossViewContainer = class("VersionActivity1_6DungeonBossViewContainer", BaseViewContainer)

function VersionActivity1_6DungeonBossViewContainer:buildViews()
	self._bossRuleView = VersionActivity1_6_BossRuleView.New()

	return {
		VersionActivity1_6DungeonBossView.New(),
		TabViewGroup.New(1, "#go_BackBtns"),
		self._bossRuleView
	}
end

function VersionActivity1_6DungeonBossViewContainer:buildTabViews(tabContainerId)
	self.navigateView = NavigateButtonsView.New({
		true,
		true,
		false
	})

	return {
		self.navigateView
	}
end

function VersionActivity1_6DungeonBossViewContainer:onContainerInit()
	return
end

function VersionActivity1_6DungeonBossViewContainer:getBossRuleView()
	return self._bossRuleView
end

return VersionActivity1_6DungeonBossViewContainer
