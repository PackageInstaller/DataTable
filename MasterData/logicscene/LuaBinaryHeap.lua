-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/pathfinder/lua/LuaBinaryHeap.lua

module("logicscene.scene.component.pathfinder.lua.LuaBinaryHeap", package.seeall)

local insert = table.insert
local remove = table.remove
local floor = math.floor
local LuaBinaryHeap = class("LuaBinaryHeap")

local function defaultCompareFunc(a, b)
	return a < b
end

function LuaBinaryHeap:ctor(compareFunc)
	self._value = {}
	self._size = 0
	self._compareFunc = compareFunc or defaultCompareFunc
end

function LuaBinaryHeap:size()
	return self._size
end

function LuaBinaryHeap:push(value)
	insert(self._value, value)

	self._size = self._size + 1

	self:_sinkDown(self._size)
end

function LuaBinaryHeap:pop()
	local min = self._value[1]

	self._value[1] = self._value[self._size]

	remove(self._value, self._size)

	self._size = self._size - 1

	if self._size > 0 then
		self:_bubbleUp()
	end

	return min
end

function LuaBinaryHeap:rescoreElement(node)
	local index = table.indexof(self._value, node)

	if index then
		self:_sinkDown(index)
	end
end

function LuaBinaryHeap:_sinkDown(tail)
	local middle

	while tail > 1 do
		middle = floor(tail * 0.5)

		if self._compareFunc(self._value[tail], self._value[middle]) then
			self._value[tail], self._value[middle] = self._value[middle], self._value[tail]
			tail = middle
		else
			break
		end
	end
end

function LuaBinaryHeap:_bubbleUp()
	local p = 1
	local length = self._size
	local mul = p * 2
	local mulNext = mul + 1
	local minP

	while mul <= length do
		minP = mulNext < length and (self._compareFunc(self._value[mulNext], self._value[mul]) and mulNext or mul) or mul

		if self._compareFunc(self._value[minP], self._value[p]) then
			self._value[minP], self._value[p] = self._value[p], self._value[minP]
			p = minP
			mul = minP * 2
			mulNext = minP * 2 + 1
		else
			break
		end
	end
end

return LuaBinaryHeap
