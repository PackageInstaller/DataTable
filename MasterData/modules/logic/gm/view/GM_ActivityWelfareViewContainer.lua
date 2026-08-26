-- chunkname: @modules/logic/gm/view/GM_ActivityWelfareViewContainer.lua

module("modules.logic.gm.view.GM_ActivityWelfareViewContainer", package.seeall)

local GM_ActivityWelfareViewContainer = class("GM_ActivityWelfareViewContainer", BaseViewContainer)

function GM_ActivityWelfareViewContainer:buildViews()
	return {
		GM_ActivityWelfareView.New()
	}
end

function GM_ActivityWelfareViewContainer:onContainerClickModalMask()
	ViewMgr.instance:closeView(self.viewName)
end

function GM_ActivityWelfareViewContainer.addEvents(viewObj)
	GMController.instance:registerCallback(GMEvent.ActivityWelfareView_ShowAllTabIdUpdate, viewObj._gm_showAllTabIdUpdate, viewObj)
end

function GM_ActivityWelfareViewContainer.removeEvents(viewObj)
	GMController.instance:unregisterCallback(GMEvent.ActivityWelfareView_ShowAllTabIdUpdate, viewObj._gm_showAllTabIdUpdate, viewObj)
end

return GM_ActivityWelfareViewContainer
