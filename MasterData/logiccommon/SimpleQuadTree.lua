-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/util/SimpleQuadTree.lua

module("logiccommon.common.util.SimpleQuadTree", package.seeall)

local SimpleQuadTree = class("SimpleQuadTree")

function SimpleQuadTree:ctor(x, y, w, h, maxDepth)
	self.boundary = SimpleQuadTree.createRect(x, y, w, h)
	self.depth = 0
	self.maxDepth = maxDepth
	self.objects = {}
	self.divided = false
end

function SimpleQuadTree.createRect(x, y, w, h)
	return {
		x = x,
		y = y,
		w = w,
		h = h
	}
end

function SimpleQuadTree.contains(rect, point)
	return point.x >= rect.x and point.x < rect.x + rect.w and point.y >= rect.y and point.y < rect.y + rect.h
end

function SimpleQuadTree.intersects(rect, range)
	return range.x <= rect.x + rect.w and range.x + range.w >= rect.x and range.y <= rect.y + rect.h and range.y + range.h >= rect.y
end

function SimpleQuadTree:subdivide()
	local x = self.boundary.x
	local y = self.boundary.y
	local w = self.boundary.w / 2
	local h = self.boundary.h / 2

	self.northeast = SimpleQuadTree.New(x + w, y, w, h, self.maxDepth)
	self.northwest = SimpleQuadTree.New(x, y, w, h, self.maxDepth)
	self.southeast = SimpleQuadTree.New(x + w, y + h, w, h, self.maxDepth)
	self.southwest = SimpleQuadTree.New(x, y + h, w, h, self.maxDepth)
	self.divided = true
end

function SimpleQuadTree:insert(obj, depth)
	if not SimpleQuadTree.contains(self.boundary, obj.position) then
		return false
	end

	depth = depth or 0

	if depth < self.maxDepth then
		if not self.divided then
			self:subdivide()
		end

		if self.northeast:insert(obj, depth + 1) then
			return true
		elseif self.northwest:insert(obj, depth + 1) then
			return true
		elseif self.southeast:insert(obj, depth + 1) then
			return true
		elseif self.southwest:insert(obj, depth + 1) then
			return true
		end
	end

	table.insert(self.objects, obj)

	return true
end

function SimpleQuadTree:query(range, found)
	found = found or {}

	if not SimpleQuadTree.intersects(self.boundary, range) then
		return found
	end

	for _, obj in ipairs(self.objects) do
		if SimpleQuadTree.contains(range, obj.position) then
			table.insert(found, obj)
		end
	end

	if self.divided then
		self.northwest:query(range, found)
		self.northeast:query(range, found)
		self.southwest:query(range, found)
		self.southeast:query(range, found)
	end

	return found
end

function SimpleQuadTree:clear()
	table.clear(self.objects)

	if self.divided then
		self.northeast:clear()
		self.northwest:clear()
		self.southeast:clear()
		self.southwest:clear()
	end
end

return SimpleQuadTree
