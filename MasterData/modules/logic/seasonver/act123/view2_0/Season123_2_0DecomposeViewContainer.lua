-- chunkname: @modules/logic/seasonver/act123/view2_0/Season123_2_0DecomposeViewContainer.lua

module("modules.logic.seasonver.act123.view2_0.Season123_2_0DecomposeViewContainer", package.seeall)

local Season123_2_0DecomposeViewContainer = class("Season123_2_0DecomposeViewContainer", BaseViewContainer)

function Season123_2_0DecomposeViewContainer:buildViews()
	return {
		CommonViewFrame.New(),
		Season123_2_0DecomposeView.New()
	}
end

function Season123_2_0DecomposeViewContainer:onContainerClickModalMask()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	self:closeThis()
end

return Season123_2_0DecomposeViewContainer
