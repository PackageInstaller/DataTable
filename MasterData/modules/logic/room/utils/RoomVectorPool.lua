-- chunkname: @modules/logic/room/utils/RoomVectorPool.lua

module("modules.logic.room.utils.RoomVectorPool", package.seeall)

local RoomVectorPool = class("RoomVectorPool")

function RoomVectorPool:ctor()
	self._posList = {}
	self._xCache = {}
	self._yCache = {}
	self._zCache = {}
end

function RoomVectorPool:packPosList(posOriginList)
	local result = {}

	ZProj.AStarPathBridge.PosListToLuaTable(posOriginList, self._xCache, self._yCache, self._zCache)

	for i = 1, #self._xCache do
		local pos = self:get()

		pos.x, pos.y, pos.z = self._xCache[i], self._yCache[i], self._zCache[i]

		table.insert(result, pos)
	end

	self:cleanTable(self._xCache)
	self:cleanTable(self._yCache)
	self:cleanTable(self._zCache)

	return result
end

function RoomVectorPool:get()
	local len = #self._posList

	if len > 0 then
		self._posList[len] = nil

		return self._posList[len]
	end

	return Vector3.New()
end

function RoomVectorPool:recycle(pos)
	pos:Set(0, 0, 0)
	table.insert(self._posList, pos)
end

function RoomVectorPool:clean()
	self:cleanTable(self._posList)
end

function RoomVectorPool:cleanTable(t)
	for k, v in pairs(t) do
		t[k] = nil
	end
end

RoomVectorPool.instance = RoomVectorPool.New()

return RoomVectorPool
