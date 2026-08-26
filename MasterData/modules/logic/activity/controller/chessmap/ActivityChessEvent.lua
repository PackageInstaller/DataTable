-- chunkname: @modules/logic/activity/controller/chessmap/ActivityChessEvent.lua

module("modules.logic.activity.controller.chessmap.ActivityChessEvent", package.seeall)

local ActivityChessEvent = _M

ActivityChessEvent.GuideOnEnterMap = 10
ActivityChessEvent.GuideClickTile = 11
ActivityChessEvent.InteractObjectCreated = 1000
ActivityChessEvent.AllObjectCreated = 1001
ActivityChessEvent.DeleteInteractAvatar = 1002
ActivityChessEvent.ResetMapView = 1003
ActivityChessEvent.SetViewVictory = 1004
ActivityChessEvent.SetViewFail = 1005
ActivityChessEvent.SetAlwayUpdateRenderOrder = 1006
ActivityChessEvent.GameViewOpened = 1007
ActivityChessEvent.GameResultQuit = 1008
ActivityChessEvent.GameMapDataUpdate = 1009
ActivityChessEvent.GameReset = 1010
ActivityChessEvent.SetNeedChooseDirectionVisible = 2002
ActivityChessEvent.CurrentRoundUpdate = 2003
ActivityChessEvent.CurrentConditionUpdate = 2004
ActivityChessEvent.RewardIsClose = 2005
ActivityChessEvent.RefreshAlarmArea = 2006
ActivityChessEvent.SetCenterHintText = 2007
ActivityChessEvent.ResetGameByResultView = 2008
ActivityChessEvent.TaskJump = 3001
ActivityChessEvent.EventFinishPlay = 12001

return ActivityChessEvent
