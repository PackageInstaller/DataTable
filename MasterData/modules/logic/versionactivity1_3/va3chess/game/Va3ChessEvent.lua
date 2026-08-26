-- chunkname: @modules/logic/versionactivity1_3/va3chess/game/Va3ChessEvent.lua

module("modules.logic.versionactivity1_3.va3chess.game.Va3ChessEvent", package.seeall)

local Va3ChessEvent = _M

Va3ChessEvent.GuideOnEnterEpisode = 9
Va3ChessEvent.GuideOnEnterMap = 10
Va3ChessEvent.GuideClickTile = 11
Va3ChessEvent.GuideRoundStartCheckPlayerPos = 12
Va3ChessEvent.SceneInteractObjCreated = 10001
Va3ChessEvent.StoryReviewSceneActvie = 10002
Va3ChessEvent.AddInteractObj = 1000
Va3ChessEvent.AllObjectCreated = 1001
Va3ChessEvent.DeleteInteractAvatar = 1002
Va3ChessEvent.ResetMapView = 1003
Va3ChessEvent.SetViewVictory = 1004
Va3ChessEvent.SetViewFail = 1005
Va3ChessEvent.DeleteInteractObj = 1006
Va3ChessEvent.GameViewOpened = 1007
Va3ChessEvent.GameResultQuit = 1008
Va3ChessEvent.GameMapDataUpdate = 1009
Va3ChessEvent.GameReset = 1010
Va3ChessEvent.EnterMap = 1011
Va3ChessEvent.EnterNextMap = 1012
Va3ChessEvent.TilePosuiTrigger = 1013
Va3ChessEvent.GameLoadingMapStateUpdate = 1014
Va3ChessEvent.BeforeEnterNextMap = 1015
Va3ChessEvent.EndEnterNextMap = 1016
Va3ChessEvent.SetNeedChooseDirectionVisible = 2002
Va3ChessEvent.CurrentRoundUpdate = 2003
Va3ChessEvent.CurrentConditionUpdate = 2004
Va3ChessEvent.RewardIsClose = 2005
Va3ChessEvent.RefreshAlarmArea = 2006
Va3ChessEvent.SetCenterHintText = 2007
Va3ChessEvent.ResetGameByResultView = 2008
Va3ChessEvent.CurrentHpUpdate = 2009
Va3ChessEvent.TargetUpdate = 2010
Va3ChessEvent.GameToastUpdate = 2011
Va3ChessEvent.RefreshAlarmAreaOnXY = 2012
Va3ChessEvent.PlayStoryFinish = 2013
Va3ChessEvent.TileTriggerUpdate = 2014
Va3ChessEvent.ObjMoveStep = 4001
Va3ChessEvent.ObjMoveEnd = 4002
Va3ChessEvent.TaskJump = 3001
Va3ChessEvent.EventFinishPlay = 12001
Va3ChessEvent.EventStart = 12002
Va3ChessEvent.EventBattleReturn = 12003
Va3ChessEvent.LoadingMapState = {
	Start = 1,
	Finish = 2
}

return Va3ChessEvent
