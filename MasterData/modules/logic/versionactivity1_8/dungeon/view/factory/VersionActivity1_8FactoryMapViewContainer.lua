-- chunkname: @modules/logic/versionactivity1_8/dungeon/view/factory/VersionActivity1_8FactoryMapViewContainer.lua

module("modules.logic.versionactivity1_8.dungeon.view.factory.VersionActivity1_8FactoryMapViewContainer", package.seeall)

local VersionActivity1_8FactoryMapViewContainer = class("VersionActivity1_8FactoryMapViewContainer", BaseViewContainer)

function VersionActivity1_8FactoryMapViewContainer:buildViews()
	return {
		VersionActivity1_8FactoryMapView.New(),
		TabViewGroup.New(1, "#go_topleft")
	}
end

function VersionActivity1_8FactoryMapViewContainer:buildTabViews(tabContainerId)
	local navigateView = NavigateButtonsView.New({
		true,
		true,
		false
	})

	return {
		navigateView
	}
end

function VersionActivity1_8FactoryMapViewContainer:onContainerInit()
	AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_day_night)
end

return VersionActivity1_8FactoryMapViewContainer
