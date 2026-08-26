-- chunkname: @modules/logic/weekwalk/view/WeekWalkDeepLayerNoticeViewContainer.lua

module("modules.logic.weekwalk.view.WeekWalkDeepLayerNoticeViewContainer", package.seeall)

local WeekWalkDeepLayerNoticeViewContainer = class("WeekWalkDeepLayerNoticeViewContainer", BaseViewContainer)

function WeekWalkDeepLayerNoticeViewContainer:buildViews()
	return {
		WeekWalkDeepLayerNoticeView.New()
	}
end

return WeekWalkDeepLayerNoticeViewContainer
