-- chunkname: @modules/logic/weekwalk_2/view/WeekWalk_2DeepLayerNoticeViewContainer.lua

module("modules.logic.weekwalk_2.view.WeekWalk_2DeepLayerNoticeViewContainer", package.seeall)

local WeekWalk_2DeepLayerNoticeViewContainer = class("WeekWalk_2DeepLayerNoticeViewContainer", BaseViewContainer)

function WeekWalk_2DeepLayerNoticeViewContainer:buildViews()
	return {
		WeekWalk_2DeepLayerNoticeView.New()
	}
end

return WeekWalk_2DeepLayerNoticeViewContainer
