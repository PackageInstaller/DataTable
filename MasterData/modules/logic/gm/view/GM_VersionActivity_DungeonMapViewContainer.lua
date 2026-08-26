-- chunkname: @modules/logic/gm/view/GM_VersionActivity_DungeonMapViewContainer.lua

module("modules.logic.gm.view.GM_VersionActivity_DungeonMapViewContainer", package.seeall)

local GM_VersionActivity_DungeonMapViewContainer = class("GM_VersionActivity_DungeonMapViewContainer", BaseViewContainer)

function GM_VersionActivity_DungeonMapViewContainer:buildViews()
	return {
		GM_VersionActivity_DungeonMapView.New()
	}
end

function GM_VersionActivity_DungeonMapViewContainer:onContainerClickModalMask()
	ViewMgr.instance:closeView(self.viewName)
end

function GM_VersionActivity_DungeonMapViewContainer.addEvents(viewObj)
	GMController.instance:registerCallback(GMEvent.VersionActivity_DungeonMapView_ShowAllTabIdUpdate, viewObj._gm_showAllTabIdUpdate, viewObj)
end

function GM_VersionActivity_DungeonMapViewContainer.removeEvents(viewObj)
	GMController.instance:unregisterCallback(GMEvent.VersionActivity_DungeonMapView_ShowAllTabIdUpdate, viewObj._gm_showAllTabIdUpdate, viewObj)
end

return GM_VersionActivity_DungeonMapViewContainer
