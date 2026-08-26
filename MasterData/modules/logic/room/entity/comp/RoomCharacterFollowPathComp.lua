-- chunkname: @modules/logic/room/entity/comp/RoomCharacterFollowPathComp.lua

module("modules.logic.room.entity.comp.RoomCharacterFollowPathComp", package.seeall)

local RoomCharacterFollowPathComp = class("RoomCharacterFollowPathComp", RoomBaseFollowPathComp)

function RoomCharacterFollowPathComp:onStopMove()
	return
end

function RoomCharacterFollowPathComp:onStartMove()
	return
end

return RoomCharacterFollowPathComp
