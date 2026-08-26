-- chunkname: @modules/logic/versionactivity1_6/decalogpresent/view/DecalogPresentViewContainer.lua

module("modules.logic.versionactivity1_6.decalogpresent.view.DecalogPresentViewContainer", package.seeall)

local DecalogPresentViewContainer = class("DecalogPresentViewContainer", BaseViewContainer)

function DecalogPresentViewContainer:buildViews()
	return {
		DecalogPresentView.New()
	}
end

function DecalogPresentViewContainer:onContainerClickModalMask()
	self:closeThis()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
end

return DecalogPresentViewContainer
