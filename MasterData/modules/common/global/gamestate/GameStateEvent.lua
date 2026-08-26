-- chunkname: @modules/common/global/gamestate/GameStateEvent.lua

module("modules.common.global.gamestate.GameStateEvent", package.seeall)

local GameStateEvent = {}

GameStateEvent.onApplicationPause = 1
GameStateEvent.OnTouchScreen = 2
GameStateEvent.OnTouchScreenUp = 4
GameStateEvent.OnQualityChange = 3
GameStateEvent.OnScreenResize = 5
GameStateEvent.OnApplicationQuit = 6

return GameStateEvent
