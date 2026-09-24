-- chunkname: @modules/logic/gm/view/GM_SettingsAccountViewContainer.lua

module("modules.logic.gm.view.GM_SettingsAccountViewContainer", package.seeall)

local GM_SettingsAccountViewContainer = class("GM_SettingsAccountViewContainer", BaseViewContainer)

function GM_SettingsAccountViewContainer:buildViews()
	return {
		GM_SettingsAccountView.New()
	}
end

function GM_SettingsAccountViewContainer:onContainerClickModalMask()
	ViewMgr.instance:closeView(self.viewName)
end

function GM_SettingsAccountViewContainer.addEvents(viewObj)
	GMController.instance:registerCallback(GMEvent.SettingsAccountView_ShowNodeAccountInfo, viewObj._gm_showNodeAccountInfo, viewObj)
end

function GM_SettingsAccountViewContainer.removeEvents(viewObj)
	GMController.instance:unregisterCallback(GMEvent.SettingsAccountView_ShowNodeAccountInfo, viewObj._gm_showNodeAccountInfo, viewObj)
end

return GM_SettingsAccountViewContainer
