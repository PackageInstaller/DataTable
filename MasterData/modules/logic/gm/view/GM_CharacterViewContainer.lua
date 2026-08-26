-- chunkname: @modules/logic/gm/view/GM_CharacterViewContainer.lua

module("modules.logic.gm.view.GM_CharacterViewContainer", package.seeall)

local GM_CharacterViewContainer = class("GM_CharacterViewContainer", BaseViewContainer)

function GM_CharacterViewContainer:buildViews()
	return {
		GM_CharacterView.New()
	}
end

function GM_CharacterViewContainer:onContainerClickModalMask()
	ViewMgr.instance:closeView(self.viewName)
end

function GM_CharacterViewContainer.addEvents(viewObj)
	GMController.instance:registerCallback(GMEvent.CharacterView_ShowAllTabIdUpdate, viewObj._gm_showAllTabIdUpdate, viewObj)
	GMController.instance:registerCallback(GMEvent.CharacterView_OnClickCheckFace, viewObj._gm_onClickCheckFace, viewObj)
	GMController.instance:registerCallback(GMEvent.CharacterView_OnClickCheckMouth, viewObj._gm_onClickCheckMouth, viewObj)
end

function GM_CharacterViewContainer.removeEvents(viewObj)
	GMController.instance:unregisterCallback(GMEvent.CharacterView_ShowAllTabIdUpdate, viewObj._gm_showAllTabIdUpdate, viewObj)
	GMController.instance:unregisterCallback(GMEvent.CharacterView_OnClickCheckFace, viewObj._gm_onClickCheckFace, viewObj)
	GMController.instance:unregisterCallback(GMEvent.CharacterView_OnClickCheckMouth, viewObj._gm_onClickCheckMouth, viewObj)
end

return GM_CharacterViewContainer
