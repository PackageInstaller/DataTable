-- chunkname: @modules/logic/activity/view/V1a5_DoubleFestival_WishPanelContainer.lua

module("modules.logic.activity.view.V1a5_DoubleFestival_WishPanelContainer", package.seeall)

local V1a5_DoubleFestival_WishPanelContainer = class("V1a5_DoubleFestival_WishPanelContainer", BaseViewContainer)

function V1a5_DoubleFestival_WishPanelContainer:buildViews()
	return {
		V1a5_DoubleFestival_WishPanel.New()
	}
end

function V1a5_DoubleFestival_WishPanelContainer:playOpenTransition()
	AudioMgr.instance:trigger(AudioEnum.ui_mail.play_ui_mail_open_1)
	self:onPlayOpenTransitionFinish()
end

return V1a5_DoubleFestival_WishPanelContainer
