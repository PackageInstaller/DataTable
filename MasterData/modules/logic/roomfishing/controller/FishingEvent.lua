-- chunkname: @modules/logic/roomfishing/controller/FishingEvent.lua

module("modules.logic.roomfishing.controller.FishingEvent", package.seeall)

local FishingEvent = _M
local _get = GameUtil.getUniqueTb()

FishingEvent.OnFishingInfoUpdate = _get()
FishingEvent.OnFishingProgressUpdate = _get()
FishingEvent.ShowFishingTip = _get()
FishingEvent.OnSelectFriendTab = _get()
FishingEvent.GuideTouchFishingStore = _get()
FishingEvent.GuideOnOpenFishingView = _get()

return FishingEvent
