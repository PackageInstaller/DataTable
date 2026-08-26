-- chunkname: @modules/logic/seasonver/act123/view2_1/Season123_2_1DecomposeViewContainer.lua

module("modules.logic.seasonver.act123.view2_1.Season123_2_1DecomposeViewContainer", package.seeall)

local Season123_2_1DecomposeViewContainer = class("Season123_2_1DecomposeViewContainer", BaseViewContainer)

function Season123_2_1DecomposeViewContainer:buildViews()
	return {
		CommonViewFrame.New(),
		Season123_2_1DecomposeView.New()
	}
end

function Season123_2_1DecomposeViewContainer:onContainerClickModalMask()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	self:closeThis()
end

return Season123_2_1DecomposeViewContainer
