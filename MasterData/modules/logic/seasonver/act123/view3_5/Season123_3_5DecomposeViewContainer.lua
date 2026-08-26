-- chunkname: @modules/logic/seasonver/act123/view3_5/Season123_3_5DecomposeViewContainer.lua

module("modules.logic.seasonver.act123.view3_5.Season123_3_5DecomposeViewContainer", package.seeall)

local Season123_3_5DecomposeViewContainer = class("Season123_3_5DecomposeViewContainer", BaseViewContainer)

function Season123_3_5DecomposeViewContainer:buildViews()
	return {
		CommonViewFrame.New(),
		Season123_3_5DecomposeView.New()
	}
end

function Season123_3_5DecomposeViewContainer:onContainerClickModalMask()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	self:closeThis()
end

return Season123_3_5DecomposeViewContainer
