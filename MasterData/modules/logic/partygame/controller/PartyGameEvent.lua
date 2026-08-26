-- chunkname: @modules/logic/partygame/controller/PartyGameEvent.lua

module("modules.logic.partygame.controller.PartyGameEvent", package.seeall)

local PartyGameEvent = _M
local _get = GameUtil.getUniqueTb()

PartyGameEvent.GameStateChange = _get()
PartyGameEvent.LogicCalFinish = _get()
PartyGameEvent.CacheNeedTranGame = _get()
PartyGameEvent.ScoreChange = _get()
PartyGameEvent.RewardSelectFinish = _get()
PartyGameEvent.SelectCard = _get()
PartyGameEvent.PartyLittleGameEnd = _get()
PartyGameEvent.KcpConnectFail = _get()
PartyGameEvent.ShowStartTip = _get()
PartyGameEvent.GuidePauseGame = _get()
PartyGameEvent.GuideResultPause = _get()
PartyGameEvent.GuideNewGame = _get()
PartyGameEvent.gamePlayerPush = _get()
PartyGameEvent.gameStartPush = _get()
PartyGameEvent.transToGamePush = _get()
PartyGameEvent.readyPlayerNumPush = _get()
PartyGameEvent.OnGameEnd = _get()
PartyGameEvent.SetCameraFocus = _get()
PartyGameEvent.SetCameraFocusLerp = _get()

return PartyGameEvent
