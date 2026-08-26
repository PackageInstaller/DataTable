-- chunkname: @modules/logic/versionactivity3_9/bird/controller/V3a9BirdEvent.lua

module("modules.logic.versionactivity3_9.bird.controller.V3a9BirdEvent", package.seeall)

local V3a9BirdEvent = _M
local _get = GameUtil.getUniqueTb()

V3a9BirdEvent.OpenFinishLoadingView = _get()
V3a9BirdEvent.CloseFinishLoadingView = _get()
V3a9BirdEvent.onStartGame = _get()
V3a9BirdEvent.onGameOver = _get()
V3a9BirdEvent.onAgainGame = _get()

return V3a9BirdEvent
