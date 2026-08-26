-- chunkname: @modules/logic/scene/room/comp/entitymgr/RoomBaseSceneUnitMgr.lua

module("modules.logic.scene.room.comp.entitymgr.RoomBaseSceneUnitMgr", package.seeall)

local RoomBaseSceneUnitMgr = class("RoomBaseSceneUnitMgr", BaseSceneUnitMgr)

function RoomBaseSceneUnitMgr:addUnit(unit)
	local tag = unit:getTag()
	local tagUnits = self._tagUnitDict[tag]

	if not tagUnits then
		tagUnits = {}
		self._tagUnitDict[tag] = tagUnits
	end

	tagUnits[unit.id] = unit
end

return RoomBaseSceneUnitMgr
