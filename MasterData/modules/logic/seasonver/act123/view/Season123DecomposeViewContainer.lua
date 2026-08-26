-- chunkname: @modules/logic/seasonver/act123/view/Season123DecomposeViewContainer.lua

module("modules.logic.seasonver.act123.view.Season123DecomposeViewContainer", package.seeall)

local Season123DecomposeViewContainer = class("Season123DecomposeViewContainer", BaseViewContainer)

function Season123DecomposeViewContainer:buildViews()
	return {
		CommonViewFrame.New(),
		Season123DecomposeView.New()
	}
end

function Season123DecomposeViewContainer:onContainerClickModalMask()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	self:closeThis()
end

return Season123DecomposeViewContainer
