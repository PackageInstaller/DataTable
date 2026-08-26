-- chunkname: @modules/logic/versionactivity2_4/wuerlixi/define/WuErLiXiEvent.lua

module("modules.logic.versionactivity2_4.wuerlixi.define.WuErLiXiEvent", package.seeall)

local WuErLiXiEvent = _M

WuErLiXiEvent.EpisodeFinished = GameUtil.getUniqueTb()
WuErLiXiEvent.NodeClicked = GameUtil.getUniqueTb()
WuErLiXiEvent.ActUnitDragEnd = GameUtil.getUniqueTb()
WuErLiXiEvent.NodeUnitDragEnd = GameUtil.getUniqueTb()
WuErLiXiEvent.UnitDraging = GameUtil.getUniqueTb()
WuErLiXiEvent.NodeUnitPlaced = GameUtil.getUniqueTb()
WuErLiXiEvent.NodeUnitPlaceBack = GameUtil.getUniqueTb()
WuErLiXiEvent.MapResetClicked = GameUtil.getUniqueTb()
WuErLiXiEvent.NodeSelected = GameUtil.getUniqueTb()
WuErLiXiEvent.MapConnectSuccess = GameUtil.getUniqueTb()
WuErLiXiEvent.OneClickClaimReward = GameUtil.getUniqueTb()
WuErLiXiEvent.OnBackToLevel = GameUtil.getUniqueTb()
WuErLiXiEvent.OnCloseTask = GameUtil.getUniqueTb()
WuErLiXiEvent.StartGuideDragUnit = GameUtil.getUniqueTb()
WuErLiXiEvent.PutUnitGuideFinish = GameUtil.getUniqueTb()

return WuErLiXiEvent
