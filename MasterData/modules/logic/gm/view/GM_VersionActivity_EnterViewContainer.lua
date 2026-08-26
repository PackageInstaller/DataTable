-- chunkname: @modules/logic/gm/view/GM_VersionActivity_EnterViewContainer.lua

module("modules.logic.gm.view.GM_VersionActivity_EnterViewContainer", package.seeall)

local GM_VersionActivity_EnterViewContainer = class("GM_VersionActivity_EnterViewContainer", BaseViewContainer)

function GM_VersionActivity_EnterViewContainer:buildViews()
	return {
		GM_VersionActivity_EnterView.New()
	}
end

function GM_VersionActivity_EnterViewContainer:onContainerClickModalMask()
	ViewMgr.instance:closeView(self.viewName)
end

function GM_VersionActivity_EnterViewContainer.addEvents(viewObj)
	GMController.instance:registerCallback(GMEvent.VersionActivity_EnterView_ShowAllTabIdUpdate, viewObj._gm_showAllTabIdUpdate, viewObj)
end

function GM_VersionActivity_EnterViewContainer.removeEvents(viewObj)
	GMController.instance:unregisterCallback(GMEvent.VersionActivity_EnterView_ShowAllTabIdUpdate, viewObj._gm_showAllTabIdUpdate, viewObj)
end

return GM_VersionActivity_EnterViewContainer
