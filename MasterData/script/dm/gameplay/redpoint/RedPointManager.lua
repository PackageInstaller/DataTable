-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/redpoint/RedPointManager.lua

RedPointManager = class("RedPointManager", objectlua.Object, _M)

function RedPointManager.class:getInstance()
	if __redPointManager == nil then
		__redPointManager = RedPointManager:new()
	end

	return __redPointManager
end

function RedPointManager:initialize()
	super.initialize(self)

	self._objects = {}
end

function RedPointManager:registerObject(object)
	table.insert(self._objects, object)
end

function RedPointManager:refresh()
	for index, object in pairs(self._objects) do
		if DisposableObject:isDisposed(object) then
			self._objects[index] = nil
		else
			object:refresh()
		end
	end
end
