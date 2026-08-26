-- chunkname: @modules/logic/room/view/critter/summon/RoomGetCritterEgg.lua

module("modules.logic.room.view.critter.summon.RoomGetCritterEgg", package.seeall)

local RoomGetCritterEgg = class("RoomGetCritterEgg", LuaCompBase)

function RoomGetCritterEgg:init(go)
	self.go = go
	self._animatorPlayer = SLFramework.AnimatorPlayer.Get(go)
end

function RoomGetCritterEgg:playIdleAnim(callback, callbackObj)
	self._animatorPlayer:Play("idle", callback, callbackObj)
end

function RoomGetCritterEgg:playOpenAnim(callback, callbackObj)
	self._animatorPlayer:Play("open", callback, callbackObj)
end

return RoomGetCritterEgg
