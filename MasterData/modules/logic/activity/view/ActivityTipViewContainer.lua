-- chunkname: @modules/logic/activity/view/ActivityTipViewContainer.lua

module("modules.logic.activity.view.ActivityTipViewContainer", package.seeall)

local ActivityTipViewContainer = class("ActivityTipViewContainer", BaseViewContainer)

function ActivityTipViewContainer:buildViews()
	return {
		ActivityTipView.New()
	}
end

return ActivityTipViewContainer
