-- chunkname: @modules/common/gameobject/GameObjectLiveEvent.lua

module("modules.common.gameobject.GameObjectLiveEvent", package.seeall)

local GameObjectLiveEvent = _M
local _get = GameUtil.getUniqueTb()

GameObjectLiveEvent.OnAwake = _get()
GameObjectLiveEvent.OnStart = _get()
GameObjectLiveEvent.OnEnable = _get()
GameObjectLiveEvent.OnDestroy = _get()

return GameObjectLiveEvent
