-- chunkname: @modules/logic/versionactivity3_8/echosong/controller/V3a8EchoSongEvent.lua

module("modules.logic.versionactivity3_8.echosong.controller.V3a8EchoSongEvent", package.seeall)

local V3a8EchoSongEvent = _M
local _get = GameUtil.getUniqueTb()

V3a8EchoSongEvent.EmittedParticle = _get()
V3a8EchoSongEvent.ChangeJoystick = _get()
V3a8EchoSongEvent.MoveMainPlayer = _get()
V3a8EchoSongEvent.ShowResultView = _get()
V3a8EchoSongEvent.MainPlayerWin = _get()
V3a8EchoSongEvent.FinishEvent1 = _get()
V3a8EchoSongEvent.FinishSavePoint = _get()
V3a8EchoSongEvent.Event3Trigger = _get()
V3a8EchoSongEvent.Enemy1Init = _get()
V3a8EchoSongEvent.Enemy2Init = _get()
V3a8EchoSongEvent.DragLine = _get()
V3a8EchoSongEvent.DragEnd = _get()
V3a8EchoSongEvent.DragExplore = _get()
V3a8EchoSongEvent.ResetGame = _get()
V3a8EchoSongEvent.RestartGame = _get()
V3a8EchoSongEvent.PauseGame = _get()
V3a8EchoSongEvent.ResumeGame = _get()
V3a8EchoSongEvent.TouchEmitted = _get()
V3a8EchoSongEvent.GuideDragJoystick = _get()
V3a8EchoSongEvent.GuideMoveMainPlayer = _get()
V3a8EchoSongEvent.GuideShortPress = _get()

return V3a8EchoSongEvent
