-- chunkname: @modules/common/gameobject/GameObjectLiveEvent.lua

module("modules.common.gameobject.GameObjectLiveEvent", package.seeall)

local GameObjectLiveEvent = _M

GameObjectLiveEvent.OnAwake = 1
GameObjectLiveEvent.OnStart = 2
GameObjectLiveEvent.OnDestroy = 3

return GameObjectLiveEvent
