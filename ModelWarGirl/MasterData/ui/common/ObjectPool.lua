-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\ObjectPool.lua

local UIUtils = require("Framework.UI.UIUtils")
local ObjectPool = {}
local mt = {}

mt.__index = ObjectPool

setmetatable(ObjectPool, {
	__call = function(self, func, duration, loop, scale)
		return ObjectPool.New(func, duration, loop, scale)
	end
})

function ObjectPool.New(parent, mountPath, prefabPath, itemLua)
	if prefabPath and itemLua then
		local objectPool = {}

		setmetatable(objectPool, mt)
		objectPool:Setting(parent, mountPath, prefabPath, itemLua)

		return objectPool
	else
		return nil
	end
end

function ObjectPool:Setting(parent, mountPath, prefabPath, itemLua)
	self.prefabPath = prefabPath
	self.parent = parent
	self.defaultCount = 20
	self.curCount = self.defaultCount
	self.itemLua = itemLua
	self.mountPath = mountPath
	self.cacheList = {}
	self.cacheIndex = 1
	self.curAvailable = 0
	self.originalX = UIUtils.GetCurDesignWidth()
	self.originalY = 0
	self.expandNum = 20
	self.shrinkNum = 30
	self.shrinkTime = 5
	self.shrinkTimer = Timer.New(Slot(self.doShrink, self), self.shrinkTime, -1)

	self.shrinkTimer:Start()
	self:initPool()
end

function ObjectPool:fetch()
	if self.curAvailable > 0 then
		local obj = self.cacheList[self.cacheIndex]

		if not obj.inPool then
			-- block empty
		end

		if obj == nil then
			return nil
		end

		self.cacheIndex = self.cacheIndex + 1
		self.curAvailable = self.curAvailable - 1
		obj.inPool = false

		return obj
	else
		self:expandPool()

		return self:fetch()
	end
end

function ObjectPool:initPool()
	for i = 1, self.curCount do
		self:createNew()
	end
end

function ObjectPool:expandPool()
	for i = 1, self.expandNum do
		self:createNew()
	end

	self.curCount = self.curCount + self.expandNum
end

function ObjectPool:returnToPool(obj)
	if obj.inPool then
		-- block empty
	end

	obj:setVisible(false)
	obj:setPosition(self.originalX, self.originalY)

	local prevIndex = obj.poolIndex
	local lastIndex = self.cacheIndex - 1

	obj.inPool = true

	if lastIndex < 1 then
		return
	end

	self.cacheList[prevIndex], self.cacheList[lastIndex] = self.cacheList[lastIndex], self.cacheList[prevIndex]
	self.cacheList[prevIndex].poolIndex = prevIndex
	self.cacheList[lastIndex].poolIndex = lastIndex
	self.cacheIndex = self.cacheIndex - 1
	self.curAvailable = self.curAvailable + 1
end

function ObjectPool:doShrink()
	if self.curAvailable > self.shrinkNum then
		for i = #self.cacheList, #self.cacheList - self.shrinkNum + 1, -1 do
			self.cacheList[i]:destroy()
			table.remove(self.cacheList, i)

			self.curCount = self.curCount - 1
		end

		self.curAvailable = self.curAvailable - self.shrinkNum
		self.prevShrinked = true
	elseif self.prevShrinked then
		if self.curAvailable > 0 then
			for i = #self.cacheList, self.cacheIndex, -1 do
				self.cacheList[i]:destroy()
				table.remove(self.cacheList, i)

				self.curCount = self.curCount - 1
			end

			self.curAvailable = 0
		end

		if self.curCount <= 0 then
			self.prevShrinked = false
		end
	else
		self.prevShrinked = false
	end
end

function ObjectPool:createNew()
	local obj = self.itemLua(self.parent, self.mountPath, self.prefabPath)

	table.insert(self.cacheList, obj)

	obj.poolIndex = #self.cacheList
	obj.inPool = true
	self.curAvailable = self.curAvailable + 1

	obj:setVisible(false)
	obj:setPosition(self.originalX, self.originalY)
end

function ObjectPool:destroy()
	for i = 1, #self.cacheList do
		self.cacheList[i]:destroy()
	end

	self.cacheList = nil
	self.curCount = 0
	self.curAvailable = 0
	self.cacheIndex = 0

	self.shrinkTimer:Stop()

	self.shrinkTimer = nil
end

return ObjectPool
