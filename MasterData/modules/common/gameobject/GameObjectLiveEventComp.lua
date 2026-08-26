-- chunkname: @modules/common/gameobject/GameObjectLiveEventComp.lua

module("modules.common.gameobject.GameObjectLiveEventComp", package.seeall)

local GameObjectLiveEventComp = class("GameObjectLiveEventComp", LuaCompBase)

function GameObjectLiveEventComp:init(go)
	self.go = go
end

function GameObjectLiveEventComp:onStart()
	GameObjectLiveMgr.instance:dispatchEvent(GameObjectLiveEvent.OnStart, self.go)
end

function GameObjectLiveEventComp:onDestroy()
	GameObjectLiveMgr.instance:dispatchEvent(GameObjectLiveEvent.OnDestroy, self.go)
end

return GameObjectLiveEventComp
