-- chunkname: @modules/logic/gm/view/GM_StoreViewContainer.lua

module("modules.logic.gm.view.GM_StoreViewContainer", package.seeall)

local GM_StoreViewContainer = class("GM_StoreViewContainer", BaseViewContainer)

function GM_StoreViewContainer:buildViews()
	return {
		GM_StoreView.New()
	}
end

function GM_StoreViewContainer:onContainerClickModalMask()
	ViewMgr.instance:closeView(self.viewName)
end

function GM_StoreViewContainer.addEvents(viewObj)
	GMController.instance:registerCallback(GMEvent.StoreView_ShowAllTabIdUpdate, viewObj._gm_showAllTabIdUpdate, viewObj)
end

function GM_StoreViewContainer.removeEvents(viewObj)
	GMController.instance:unregisterCallback(GMEvent.StoreView_ShowAllTabIdUpdate, viewObj._gm_showAllTabIdUpdate, viewObj)
end

return GM_StoreViewContainer
