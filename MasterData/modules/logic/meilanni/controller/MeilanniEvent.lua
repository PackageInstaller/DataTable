-- chunkname: @modules/logic/meilanni/controller/MeilanniEvent.lua

module("modules.logic.meilanni.controller.MeilanniEvent", package.seeall)

local MeilanniEvent = _M

MeilanniEvent.clickEventItem = 1
MeilanniEvent.dialogChange = 2
MeilanniEvent.setElementsVisible = 3
MeilanniEvent.getTaskBouns = 4
MeilanniEvent.updateExcludeRules = 5
MeilanniEvent.dialogClose = 6
MeilanniEvent.guideEnterMapDay1 = 7
MeilanniEvent.guideEnterMapDay2 = 8
MeilanniEvent.resetDialogPos = 9
MeilanniEvent.resetMap = 10
MeilanniEvent.episodeInfoUpdate = 11
MeilanniEvent.getInfo = 12
MeilanniEvent.bonusReply = 13
MeilanniEvent.mapFail = 14
MeilanniEvent.mapSuccess = 15
MeilanniEvent.dialogListAnimChange = 20
MeilanniEvent.showDialogEndBtn = 30
MeilanniEvent.showDialogOptionBtn = 31
MeilanniEvent.startShowDialogOptionBtn = 32
MeilanniEvent.refreshDialogBtnState = 33

return MeilanniEvent
