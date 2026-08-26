-- chunkname: @modules/logic/gm/view/GM_ActivityBeginnerViewContainer.lua

module("modules.logic.gm.view.GM_ActivityBeginnerViewContainer", package.seeall)

local GM_ActivityBeginnerViewContainer = class("GM_ActivityBeginnerViewContainer", BaseViewContainer)

function GM_ActivityBeginnerViewContainer:buildViews()
	return {
		GM_ActivityBeginnerView.New()
	}
end

function GM_ActivityBeginnerViewContainer:onContainerClickModalMask()
	ViewMgr.instance:closeView(self.viewName)
end

function GM_ActivityBeginnerViewContainer.addEvents(viewObj)
	GMController.instance:registerCallback(GMEvent.ActivityBeginnerView_ShowAllTabIdUpdate, viewObj._gm_showAllTabIdUpdate, viewObj)
end

function GM_ActivityBeginnerViewContainer.removeEvents(viewObj)
	GMController.instance:unregisterCallback(GMEvent.ActivityBeginnerView_ShowAllTabIdUpdate, viewObj._gm_showAllTabIdUpdate, viewObj)
end

return GM_ActivityBeginnerViewContainer
