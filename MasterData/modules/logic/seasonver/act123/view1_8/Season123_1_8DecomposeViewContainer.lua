-- chunkname: @modules/logic/seasonver/act123/view1_8/Season123_1_8DecomposeViewContainer.lua

module("modules.logic.seasonver.act123.view1_8.Season123_1_8DecomposeViewContainer", package.seeall)

local Season123_1_8DecomposeViewContainer = class("Season123_1_8DecomposeViewContainer", BaseViewContainer)

function Season123_1_8DecomposeViewContainer:buildViews()
	return {
		CommonViewFrame.New(),
		Season123_1_8DecomposeView.New()
	}
end

function Season123_1_8DecomposeViewContainer:onContainerClickModalMask()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	self:closeThis()
end

return Season123_1_8DecomposeViewContainer
