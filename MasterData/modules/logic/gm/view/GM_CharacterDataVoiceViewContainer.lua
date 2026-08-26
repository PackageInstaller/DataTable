-- chunkname: @modules/logic/gm/view/GM_CharacterDataVoiceViewContainer.lua

module("modules.logic.gm.view.GM_CharacterDataVoiceViewContainer", package.seeall)

local GM_CharacterDataVoiceViewContainer = class("GM_CharacterDataVoiceViewContainer", BaseViewContainer)

function GM_CharacterDataVoiceViewContainer:buildViews()
	return {
		GM_CharacterDataVoiceView.New()
	}
end

function GM_CharacterDataVoiceViewContainer:onContainerClickModalMask()
	ViewMgr.instance:closeView(self.viewName)
end

function GM_CharacterDataVoiceViewContainer.addEvents(viewObj)
	GMController.instance:registerCallback(GMEvent.CharacterDataVoiceView_ShowAllTabIdUpdate, viewObj._gm_showAllTabIdUpdate, viewObj)
end

function GM_CharacterDataVoiceViewContainer.removeEvents(viewObj)
	GMController.instance:unregisterCallback(GMEvent.CharacterDataVoiceView_ShowAllTabIdUpdate, viewObj._gm_showAllTabIdUpdate, viewObj)
end

return GM_CharacterDataVoiceViewContainer
