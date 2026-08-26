-- chunkname: @modules/logic/versionactivity1_5/dungeon/view/revivaltask/VersionActivity1_5RevivalTaskViewContainer.lua

module("modules.logic.versionactivity1_5.dungeon.view.revivaltask.VersionActivity1_5RevivalTaskViewContainer", package.seeall)

local VersionActivity1_5RevivalTaskViewContainer = class("VersionActivity1_5RevivalTaskViewContainer", BaseViewContainer)

function VersionActivity1_5RevivalTaskViewContainer:buildViews()
	self.exploreTipView = VersionActivity1_5ExploreTaskTipView.New()

	return {
		VersionActivity1_5RevivalTaskView.New(),
		VersionActivity1_5ExploreTaskView.New(),
		VersionActivity1_5HeroTaskView.New(),
		VersionActivity1_5RevivalTaskTipView.New(),
		self.exploreTipView,
		TabViewGroup.New(1, "#go_topleft")
	}
end

function VersionActivity1_5RevivalTaskViewContainer:buildTabViews(tabContainerId)
	self._navigateButtonsView = NavigateButtonsView.New({
		true,
		false,
		false
	})

	self._navigateButtonsView:setHelpId(HelpEnum.HelpId.Dungeon1_5TaskHelp)

	return {
		self._navigateButtonsView
	}
end

function VersionActivity1_5RevivalTaskViewContainer:onContainerInit()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_paiqian_open)
end

return VersionActivity1_5RevivalTaskViewContainer
