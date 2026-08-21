-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/viewlib/item/ViewlibCollection.lua

module("logic.common.viewlib.item.ViewlibCollection", package.seeall)

local ViewlibCollection = class("ViewlibCollection")

function ViewlibCollection:create(resPath, capacity)
	return ViewlibCollection.New(resPath, capacity)
end

function ViewlibCollection:ctor(resPath, capacity)
	local itemClass = ViewlibUtil.getItemClass(resPath)

	self._prefab = ViewlibUtil.getItemPrefab(resPath)
	self._pool = ReusablePool.New(itemClass, capacity)
	self._using = {}
end

function ViewlibCollection:createInstance(parent)
	local item = self._pool:fetchObject(self._prefab, parent)

	table.insert(self._using, item)

	return item
end

function ViewlibCollection:releaseInstance(item)
	self._pool:returnObject(item)
	table.removebyvalue(self._using, item)
end

function ViewlibCollection:pairs()
	return pairs(self._using)
end

function ViewlibCollection:clear()
	self:clearAllInstance()
	self:clearPool()
end

function ViewlibCollection:clearAllInstance()
	for _, item in pairs(self._using) do
		self._pool:returnObject(item)
	end

	BattleTableUtil.clearTable(self._using)
end

function ViewlibCollection:clearPool()
	self._pool:clear()
end

function ViewlibCollection:getAllInstances()
	return self._using
end

return ViewlibCollection
