-- chunkname: @modules/logic/partygamelobby/model/PartyGameVectorPool.lua

module("modules.logic.partygamelobby.model.PartyGameVectorPool", package.seeall)

local PartyGameVectorPool = class("PartyGameVectorPool")

function PartyGameVectorPool:ctor()
	self._posList = {}
	self._xCache = {}
	self._yCache = {}
	self._zCache = {}
end

function PartyGameVectorPool:packPosList(posOriginList)
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

function PartyGameVectorPool:get()
	local len = #self._posList

	if len > 0 then
		self._posList[len] = nil

		return self._posList[len]
	end

	return Vector3.New()
end

function PartyGameVectorPool:recycle(pos)
	pos:Set(0, 0, 0)
	table.insert(self._posList, pos)
end

function PartyGameVectorPool:clean()
	self:cleanTable(self._posList)
end

function PartyGameVectorPool:cleanTable(t)
	for k, v in pairs(t) do
		t[k] = nil
	end
end

PartyGameVectorPool.instance = PartyGameVectorPool.New()

return PartyGameVectorPool
