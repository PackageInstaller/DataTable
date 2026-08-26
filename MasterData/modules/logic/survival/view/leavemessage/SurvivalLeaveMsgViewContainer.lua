-- chunkname: @modules/logic/survival/view/leavemessage/SurvivalLeaveMsgViewContainer.lua

module("modules.logic.survival.view.leavemessage.SurvivalLeaveMsgViewContainer", package.seeall)

local SurvivalLeaveMsgViewContainer = class("SurvivalLeaveMsgViewContainer", BaseViewContainer)

function SurvivalLeaveMsgViewContainer:buildViews()
	return {
		SurvivalLeaveMsgView.New()
	}
end

return SurvivalLeaveMsgViewContainer
