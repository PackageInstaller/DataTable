-- chunkname: @modules/logic/postprocessing/define/PostProcessingEvent.lua

module("modules.logic.postprocessing.define.PostProcessingEvent", package.seeall)

local PostProcessingEvent = {}

PostProcessingEvent.onRefreshPopUpBlurNotBlur = 1
PostProcessingEvent.onUnitCameraVisibleChange = 2
PostProcessingEvent.onCameraRootAnimatorControllerChange = 3

return PostProcessingEvent
