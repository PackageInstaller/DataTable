-- chunkname: @modules/logic/versionactivity3_8/dianjishi/define/DianJiShiGameEvent.lua

module("modules.logic.versionactivity3_8.dianjishi.define.DianJiShiGameEvent", package.seeall)

local DianJiShiGameEvent = _M

DianJiShiGameEvent.OnBeginDragBlock = GameUtil.getEventId()
DianJiShiGameEvent.OnDragBlock = GameUtil.getEventId()
DianJiShiGameEvent.OnEndDragBlock = GameUtil.getEventId()
DianJiShiGameEvent.OnPlaceBlockDone = GameUtil.getEventId()
DianJiShiGameEvent.OnPlaceBlockError = GameUtil.getEventId()
DianJiShiGameEvent.OnUpdateGameStatus = GameUtil.getEventId()
DianJiShiGameEvent.OnHelpPlaceBlock = GameUtil.getEventId()
DianJiShiGameEvent.OnLightAreaValue = GameUtil.getEventId()
DianJiShiGameEvent.OnMapAreaValueNotFit = GameUtil.getEventId()
DianJiShiGameEvent.OneClickClaimReward = GameUtil.getEventId()
DianJiShiGameEvent.EpisodeFinished = GameUtil.getEventId()
DianJiShiGameEvent.OnBackToLevel = GameUtil.getEventId()
DianJiShiGameEvent.GuideOnEnterEpisode = GameUtil.getEventId()
DianJiShiGameEvent.GuideFindShowDragEffect = GameUtil.getEventId()
DianJiShiGameEvent.GuideStartShowDragEffect = GameUtil.getEventId()
DianJiShiGameEvent.GuideShowDragEffectDone = GameUtil.getEventId()

return DianJiShiGameEvent
