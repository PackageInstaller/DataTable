-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/miniGame/model/plane/PlaneQuadtree.lua

MAX_OBJECTS = 5
MAX_LEVELS = 3
QuadtreeBound = class("QuadtreeBound", objectlua.Object, _M)

QuadtreeBound:has("_x", {
	is = "rw"
})
QuadtreeBound:has("_y", {
	is == "rw"
})
QuadtreeBound:has("_width", {
	is == "rw"
})
QuadtreeBound:has("_height", {
	is == "rw"
})

function QuadtreeBound:initialize(x, y, w, h, owner)
	super.initialize(self)

	self._x = x or 0
	self._y = y or 0
	self._width = w or 0
	self._height = h or 0
	self._ownerConfig = setmetatable({}, {
		__index = {
			owner = owner
		}
	})
end

function QuadtreeBound:refreshBounds(rect)
	self._x = rect.x
	self._y = rect.y
	self._width = rect.width
	self._height = rect.height
end

function QuadtreeBound:getOwner()
	return self._ownerConfig and self._ownerConfig.owner
end

function QuadtreeBound:getContentSize()
	return cc.size(self._width, self._height)
end

PlaneQuadtree = class("PlaneQuadtree", objectlua.Object, _M)

PlaneQuadtree:has("_level", {
	is = "rw"
})
PlaneQuadtree:has("_objects", {
	is == "rw"
})
PlaneQuadtree:has("_bounds", {
	is == "rw"
})
PlaneQuadtree:has("_nodes", {
	is == "rw"
})

function PlaneQuadtree:initialize(bounds, level, owner)
	super.initialize(self)

	self._owner = owner
	self._level = level or 0
	self._bounds = bounds or QuadtreeBound:new()
	self._objects = {}
	self._nodes = {}
end

function PlaneQuadtree:clear()
	self._objects = {}
	self._nodes = {}
end

function PlaneQuadtree:split(owner)
	local subWidth = self._bounds:getWidth() / 2
	local subHeight = self._bounds:getHeight() / 2
	local x = self._bounds:getX()
	local y = self._bounds:getY()

	self._nodes[1] = PlaneQuadtree:new(QuadtreeBound:new(x + subWidth, y, subWidth, subHeight), self._level + 1, owner)
	self._nodes[2] = PlaneQuadtree:new(QuadtreeBound:new(x, y, subWidth, subHeight), self._level + 1, self._owner)
	self._nodes[3] = PlaneQuadtree:new(QuadtreeBound:new(x, y + subHeight, subWidth, subHeight), self._level + 1, owner)
	self._nodes[4] = PlaneQuadtree:new(QuadtreeBound:new(x + subWidth, y + subHeight, subWidth, subHeight), self._level + 1, owner)
end

function PlaneQuadtree:getIndex(pRect)
	local index = -1
	local minWidth = self._bounds:getX()
	local middleWidth = self._bounds:getX() + self._bounds:getWidth() / 2
	local maxWidth = self._bounds:getX() + self._bounds:getWidth()
	local minHeight = self._bounds:getY()
	local middleHeight = self._bounds:getY() + self._bounds:getHeight() / 2
	local maxHeight = self._bounds:getY() + self._bounds:getHeight()
	local onTop = middleHeight <= pRect:getY()
	local onBottom = middleHeight >= pRect:getY() + pRect:getHeight()
	local onLeft = middleWidth >= pRect:getX() + pRect:getWidth()
	local onRight = middleWidth <= pRect:getX()

	if onTop then
		if onLeft then
			return 3
		elseif onRight then
			return 4
		end
	elseif onBottom then
		if onLeft then
			return 2
		elseif onRight then
			return 1
		end
	end

	return index
end

function PlaneQuadtree:insert(pRect)
	if self._nodes[1] then
		local index = self:getIndex(pRect)

		if index ~= -1 then
			self._nodes[index]:insert(pRect)

			return
		end
	end

	self._objects[#self._objects + 1] = pRect

	if #self._objects > MAX_OBJECTS and self._level < MAX_LEVELS then
		if not self._nodes[1] then
			self:split(self._owner)
		end

		local cache = {}
		local insertCache = {}

		for i = 1, #self._objects do
			local object = self._objects[i]
			local index = self:getIndex(object)

			if index ~= -1 then
				local var_9_0 = {
					index = index,
					object = object
				}

				var_9_0.hp = object:getOwner():getHp()
				insertCache[#insertCache + 1] = var_9_0
			else
				cache[object] = object:getOwner():getHp()
			end
		end

		for i = 1, #insertCache do
			local data = insertCache[i]

			self._nodes[data.index]:insert(data.object)
		end

		self._objects = {}

		for oj, hp in pairs(cache) do
			self._objects[#self._objects + 1] = oj
		end
	end

	local str = ""

	for i = 1, #self._objects do
		local hp = self._objects[i]:getOwner():getHp()

		if self._objects[i].getOwner then
			str = str .. hp .. ":"
		end
	end
end

function PlaneQuadtree:retrieve(returnObjects, pRect, checkFunc)
	local index = self:getIndex(pRect)

	if index ~= -1 and self._nodes[1] then
		self._nodes[index]:retrieve(returnObjects, pRect, checkFunc)
	elseif index == -1 and self._nodes[1] then
		local list = self:carve(pRect, self._bounds)

		for i = 1, #list do
			local bound = list[i].bound
			local index = self:getIndex(bound)

			if index ~= -1 and self._nodes[1] then
				self._nodes[index]:retrieve(returnObjects, bound, checkFunc)
			end
		end
	end

	for i = 1, #self._objects do
		local object = self._objects[i]

		if checkFunc and checkFunc(object) then
			returnObjects[#returnObjects + 1] = object
		elseif not checkFunc then
			returnObjects[#returnObjects + 1] = object
		end
	end

	return returnObjects
end

function PlaneQuadtree:carve(pRect, bounds)
	local list = {}
	local onLeft = pRect:getX() < bounds:getX() + bounds:getWidth() / 2
	local onRight = pRect:getX() + pRect:getWidth() > bounds:getX() + bounds:getWidth() / 2
	local onTop = pRect:getY() + pRect:getHeight() > bounds:getY() + bounds:getHeight() / 2
	local onBottom = pRect:getY() < bounds:getY() + bounds:getHeight() / 2

	if onLeft and onRight and onTop and onBottom then
		local posX = bounds:getX() + bounds:getWidth() / 2
		local posY = pRect:getY()
		local width = pRect:getX() + pRect:getWidth() - (bounds:getX() + bounds:getWidth() / 2)
		local height = bounds:getY() + bounds:getHeight() / 2 - pRect:getY()

		list[#list + 1] = {
			index = 1,
			bound = QuadtreeBound:new(posX, posY, width, height)
		}

		local posX = pRect:getX()
		local posY = pRect:getY()
		local width = bounds:getX() + bounds:getWidth() / 2 - pRect:getX()
		local height = bounds:getY() + bounds:getHeight() / 2 - pRect:getY()

		list[#list + 1] = {
			index = 1,
			bound = QuadtreeBound:new(posX, posY, width, height)
		}

		local posX = pRect:getX()
		local posY = bounds:getY() + bounds:getHeight() / 2
		local width = bounds:getX() + bounds:getWidth() / 2 - pRect:getX()
		local height = pRect:getY() + pRect:getHeight() - (bounds:getY() + bounds:getHeight() / 2)

		list[#list + 1] = {
			index = 3,
			bound = QuadtreeBound:new(posX, posY, width, height)
		}

		local posX = bounds:getX() + bounds:getWidth() / 2
		local posY = bounds:getY() + bounds:getHeight() / 2
		local width = pRect:getX() + pRect:getWidth() - (bounds:getX() + bounds:getWidth() / 2)
		local height = pRect:getY() + pRect:getHeight() - (bounds:getY() + bounds:getHeight() / 2)

		list[#list + 1] = {
			index = 4,
			bound = QuadtreeBound:new(posX, posY, width, height)
		}
	elseif onLeft and onTop and onBottom then
		local posX = pRect:getX()
		local posY = pRect:getY()
		local width = pRect:getWidth()
		local height = bounds:getY() + bounds:getHeight() / 2 - pRect:getY()

		list[#list + 1] = {
			index = 2,
			bound = QuadtreeBound:new(posX, posY, width, height)
		}

		local posX = pRect:getX()
		local posY = bounds:getY() + bounds:getHeight() / 2
		local width = pRect:getWidth()
		local height = pRect:getY() + pRect:getHeight() - (bounds:getY() + bounds:getHeight() / 2)

		list[#list + 1] = {
			index = 3,
			bound = QuadtreeBound:new(posX, posY, width, height)
		}
	elseif onRight and onTop and onBottom then
		local posX = pRect:getX()
		local posY = pRect:getY()
		local width = pRect:getWidth()
		local height = bounds:getY() + bounds:getHeight() / 2 - pRect:getY()

		list[#list + 1] = {
			index = 1,
			bound = QuadtreeBound:new(posX, posY, width, height)
		}

		local posX = pRect:getX()
		local posY = bounds:getY() + bounds:getHeight() / 2
		local width = pRect:getWidth()
		local height = pRect:getY() + pRect:getHeight() - (bounds:getY() + bounds:getHeight() / 2)

		list[#list + 1] = {
			index = 4,
			bound = QuadtreeBound:new(posX, posY, width, height)
		}
	elseif onTop and onLeft and onRight then
		local posX = pRect:getX()
		local posY = pRect:getY()
		local width = bounds:getX() + bounds:getWidth() / 2 - pRect:getX()
		local height = pRect:getHeight()

		list[#list + 1] = {
			index = 3,
			bound = QuadtreeBound:new(posX, posY, width, height)
		}

		local posX = bounds:getX() + bounds:getWidth() / 2
		local posY = pRect:getY()
		local width = pRect:getX() + pRect:getWidth() - (bounds:getX() + bounds:getWidth() / 2)
		local height = pRect:getHeight()

		list[#list + 1] = {
			index = 4,
			bound = QuadtreeBound:new(posX, posY, width, height)
		}
	elseif onBottom and onLeft and onRight then
		local posX = bounds:getX() + bounds:getWidth() / 2
		local posY = pRect:getY()
		local width = pRect:getX() + pRect:getWidth() - (bounds:getX() + bounds:getWidth() / 2)
		local height = pRect:getHeight()

		list[#list + 1] = {
			index = 1,
			bound = QuadtreeBound:new(posX, posY, width, height)
		}

		local posX = pRect:getX()
		local posY = pRect:getY()
		local width = bounds:getX() + bounds:getWidth() / 2 - pRect:getX()
		local height = pRect:getHeight()

		list[#list + 1] = {
			index = 2,
			bound = QuadtreeBound:new(posX, posY, width, height)
		}
	end

	return list
end
