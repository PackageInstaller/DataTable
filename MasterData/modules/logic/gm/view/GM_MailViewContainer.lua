-- chunkname: @modules/logic/gm/view/GM_MailViewContainer.lua

module("modules.logic.gm.view.GM_MailViewContainer", package.seeall)

local GM_MailViewContainer = class("GM_MailViewContainer", BaseViewContainer)

function GM_MailViewContainer:buildViews()
	return {
		GM_MailView.New()
	}
end

function GM_MailViewContainer:onContainerClickModalMask()
	ViewMgr.instance:closeView(self.viewName)
end

function GM_MailViewContainer.addEvents(viewObj)
	GMController.instance:registerCallback(GMEvent.MailView_ShowAllTabIdUpdate, viewObj._gm_showAllTabIdUpdate, viewObj)
end

function GM_MailViewContainer.removeEvents(viewObj)
	GMController.instance:unregisterCallback(GMEvent.MailView_ShowAllTabIdUpdate, viewObj._gm_showAllTabIdUpdate, viewObj)
end

return GM_MailViewContainer
