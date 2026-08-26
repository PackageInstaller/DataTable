-- chunkname: @modules/logic/weekwalk/controller/WeekWalkEvent.lua

module("modules.logic.weekwalk.controller.WeekWalkEvent", package.seeall)

local WeekWalkEvent = _M

WeekWalkEvent.TarotReply = 11
WeekWalkEvent.WeekWalkRespawnReply = 12
WeekWalkEvent.OnWeekwalkInfoUpdate = 13
WeekWalkEvent.OnClickElement = 14
WeekWalkEvent.OnGetBuffReward = 15
WeekWalkEvent.OnDialogReply = 16
WeekWalkEvent.OnClickTarot = 18
WeekWalkEvent.OnConfirmBindingBuff = 19
WeekWalkEvent.OnWeekwalkResetLayer = 20
WeekWalkEvent.OnWeekwalkTaskUpdate = 21
WeekWalkEvent.OnShowFinishAnimDone = 22
WeekWalkEvent.OnScrollPage = 23
WeekWalkEvent.OnChangeRightBtnVisible = 24
WeekWalkEvent.OnChapterMapUpdate = 100
WeekWalkEvent.OnChangeMap = 103
WeekWalkEvent.OnGetPointReward = 104
WeekWalkEvent.OnCheckVision = 105
WeekWalkEvent.OnSetEpisodeListVisible = 107
WeekWalkEvent.OnChangeFocusEpisodeItem = 108
WeekWalkEvent.OnUpdateMapElementState = 109
WeekWalkEvent.OnAddSmokeMask = 110
WeekWalkEvent.OnRemoveSmokeMask = 111
WeekWalkEvent.OnGetTaskReward = 112
WeekWalkEvent.OnChangeLayerRewardMapId = 113
WeekWalkEvent.OnSelectLevel = 201
WeekWalkEvent.OnGetInfo = 202
WeekWalkEvent.OnQuestionReply = 203
WeekWalkEvent.OnSelectNotCdHeroReply = 204
WeekWalkEvent.OnAllShallowLayerFinish = 205
WeekWalkEvent.GuideClickElement = 301
WeekWalkEvent.GuideShowResetBtn = 302
WeekWalkEvent.GuideChangeToLayerPage3 = 303
WeekWalkEvent.GuideChangeToLayerPage5 = 304
WeekWalkEvent.GuideShowElement10112 = 305
WeekWalkEvent.GuideMoveLayerPage = 306
WeekWalkEvent.GuideFinishLayer = 307
WeekWalkEvent.GuideOnLayerViewOpen = 308
WeekWalkEvent.GuideDeepPageOpenShow = 309
WeekWalkEvent.GuideShallowPageOpenShow = 310

return WeekWalkEvent
