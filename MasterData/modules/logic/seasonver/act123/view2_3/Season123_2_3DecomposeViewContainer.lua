-- chunkname: @modules/logic/seasonver/act123/view2_3/Season123_2_3DecomposeViewContainer.lua

module("modules.logic.seasonver.act123.view2_3.Season123_2_3DecomposeViewContainer", package.seeall)

local Season123_2_3DecomposeViewContainer = class("Season123_2_3DecomposeViewContainer", BaseViewContainer)

function Season123_2_3DecomposeViewContainer:buildViews()
	return {
		CommonViewFrame.New(),
		Season123_2_3DecomposeView.New()
	}
end

function Season123_2_3DecomposeViewContainer:onContainerClickModalMask()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	self:closeThis()
end

return Season123_2_3DecomposeViewContainer
