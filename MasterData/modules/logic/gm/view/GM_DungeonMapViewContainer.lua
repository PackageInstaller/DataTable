-- chunkname: @modules/logic/gm/view/GM_DungeonMapViewContainer.lua

module("modules.logic.gm.view.GM_DungeonMapViewContainer", package.seeall)

local GM_DungeonMapViewContainer = class("GM_DungeonMapViewContainer", BaseViewContainer)

function GM_DungeonMapViewContainer:buildViews()
	return {
		GM_DungeonMapView.New()
	}
end

function GM_DungeonMapViewContainer:onContainerClickModalMask()
	ViewMgr.instance:closeView(self.viewName)
end

function GM_DungeonMapViewContainer.addEvents(viewObj)
	GMController.instance:registerCallback(GMEvent.DungeonMapView_ShowAllTabIdUpdate, viewObj._gm_showAllTabIdUpdate, viewObj)
end

function GM_DungeonMapViewContainer.removeEvents(viewObj)
	GMController.instance:unregisterCallback(GMEvent.DungeonMapView_ShowAllTabIdUpdate, viewObj._gm_showAllTabIdUpdate, viewObj)
end

return GM_DungeonMapViewContainer
