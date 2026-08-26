-- chunkname: @modules/logic/seasonver/act123/view1_9/Season123_1_9DecomposeViewContainer.lua

module("modules.logic.seasonver.act123.view1_9.Season123_1_9DecomposeViewContainer", package.seeall)

local Season123_1_9DecomposeViewContainer = class("Season123_1_9DecomposeViewContainer", BaseViewContainer)

function Season123_1_9DecomposeViewContainer:buildViews()
	return {
		CommonViewFrame.New(),
		Season123_1_9DecomposeView.New()
	}
end

function Season123_1_9DecomposeViewContainer:onContainerClickModalMask()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	self:closeThis()
end

return Season123_1_9DecomposeViewContainer
