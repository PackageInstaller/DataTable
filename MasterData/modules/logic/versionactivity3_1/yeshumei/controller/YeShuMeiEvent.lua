-- chunkname: @modules/logic/versionactivity3_1/yeshumei/controller/YeShuMeiEvent.lua

module("modules.logic.versionactivity3_1.yeshumei.controller.YeShuMeiEvent", package.seeall)

local YeShuMeiEvent = _M
local _get = GameUtil.getUniqueTb()

YeShuMeiEvent.EpisodeFinished = _get()
YeShuMeiEvent.OnBackToLevel = _get()
YeShuMeiEvent.OneClickClaimReward = _get()
YeShuMeiEvent.OnDragGuideFinish = _get()
YeShuMeiEvent.ShowGuideDrag = _get()
YeShuMeiEvent.OnClickShadowGuide = _get()

return YeShuMeiEvent
