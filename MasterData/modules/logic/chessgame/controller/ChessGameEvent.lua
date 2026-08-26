-- chunkname: @modules/logic/chessgame/controller/ChessGameEvent.lua

module("modules.logic.chessgame.controller.ChessGameEvent", package.seeall)

local ChessGameEvent = _M
local _get = GameUtil.getUniqueTb()

ChessGameEvent.DeleteInteractAvatar = _get()
ChessGameEvent.GameMapDataUpdate = _get()
ChessGameEvent.SetNeedChooseDirectionVisible = _get()
ChessGameEvent.SetAlarmAreaVisible = _get()
ChessGameEvent.CurrentRoundUpdate = _get()
ChessGameEvent.GameLoadingMapStateUpdate = _get()
ChessGameEvent.GameReset = _get()
ChessGameEvent.RollBack = _get()
ChessGameEvent.AllObjectCreated = _get()
ChessGameEvent.AddInteractObj = _get()
ChessGameEvent.OnVictory = _get()
ChessGameEvent.OnFail = _get()
ChessGameEvent.GamePointReturn = _get()
ChessGameEvent.ChangeMap = _get()
ChessGameEvent.RefreshScene = _get()
ChessGameEvent.GameResultQuit = _get()
ChessGameEvent.PlayStoryFinish = _get()
ChessGameEvent.PlayDialogue = _get()
ChessGameEvent.DialogEnd = _get()
ChessGameEvent.ClickOnTalking = _get()
ChessGameEvent.CurrentConditionUpdate = _get()
ChessGameEvent.GuideStart = _get()
ChessGameEvent.GuideOnEnterEpisode = _get()
ChessGameEvent.GameToastUpdate = _get()
ChessGameEvent.EnterGameFinish = _get()
ChessGameEvent.LoadingMapState = {
	Start = 998,
	Finish = 999
}

return ChessGameEvent
