-- chunkname: @modules/logic/critter/controller/CritterEvent.lua

module("modules.logic.critter.controller.CritterEvent", package.seeall)

local CritterEvent = _M

CritterEvent.CheckCritterIconSelected = 100
CritterEvent.CritterBuildingHideView = 101
CritterEvent.CritterBuildingShowView = 102
CritterEvent.CritterBuildingSelectCritter = 103
CritterEvent.CritterBuildingChangeRestingCritter = 104
CritterEvent.CritterBuildingChangSeatSlotVisible = 105
CritterEvent.CritterBuildingSetCanOperateRestingCritter = 106
CritterEvent.CritterBuildingCameraTweenFinish = 107
CritterEvent.CritterListOnDragBeginListener = 108
CritterEvent.CritterListOnDragListener = 109
CritterEvent.CritterListOnDragEndListener = 110
CritterEvent.CritterUnlockSeatSlot = 111
CritterEvent.CritterFeedFood = 112
CritterEvent.CritterInfoPushUpdate = 113
CritterEvent.CritterDecomposeReply = 114
CritterEvent.CritterGuideReply = 115
CritterEvent.PlayAddCritterEff = 116
CritterEvent.CritterChangeFilterType = 200
CritterEvent.CritterChangeSort = 201
CritterEvent.CritterUpdateAttrPreview = 202
CritterEvent.CritterListUpdate = 203
CritterEvent.CritterListResetScrollPos = 204
CritterEvent.CritterDecomposeChangeSelect = 301
CritterEvent.BeforeDecomposeCritter = 302
CritterEvent.CritterChangeLockStatus = 303
CritterEvent.UITrainSelectCritter = 401
CritterEvent.UITrainSelectHero = 402
CritterEvent.UITrainSelectSlot = 403
CritterEvent.UITrainSubTab = 404
CritterEvent.UITrainCdTime = 405
CritterEvent.UIChangeTrainCritter = 406
CritterEvent.UITrainViewGoBack = 407
CritterEvent.TrainSelectEventOptionReply = 1001
CritterEvent.TrainFinishTrainCritterReply = 1002
CritterEvent.TrainCancelTrainReply = 1003
CritterEvent.TrainStartTrainCritterReply = 1004
CritterEvent.CritterInfoPushReply = 1005
CritterEvent.FastForwardTrainReply = 1006
CritterEvent.StartTrainCritterPreviewReply = 1007
CritterEvent.CritterRenameReply = 1008
CritterEvent.onEnterCritterBuildingView = 501
CritterEvent.CritterBuildingViewRefreshCamera = 502
CritterEvent.CritterBuildingViewChange = 503
CritterEvent.CritterBuildingViewChangeBuilding = 504
CritterEvent.CritterTrainStarted = 6001
CritterEvent.CritterTrainFinished = 6002
CritterEvent.UICritterDragIng = 7001
CritterEvent.UICritterDragEnd = 7002

return CritterEvent
