-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/resourceDouble/ResourceDoubleManager.lua

ResourceDoubleManager = class("ResourceDoubleManager", objectlua.Object, _M)

function ResourceDoubleManager.class:getInstance()
	if __resourceDoubleManager == nil then
		__resourceDoubleManager = ResourceDoubleManager:new()
	end

	return __resourceDoubleManager
end

function ResourceDoubleManager:initialize()
	super.initialize(self)

	self._objects = {}
end

function ResourceDoubleManager:registerObject(object)
	table.insert(self._objects, object)
end

function ResourceDoubleManager:refresh()
	for index, object in pairs(self._objects) do
		if DisposableObject:isDisposed(object) then
			self._objects[index] = nil
		else
			object:refresh()
		end
	end
end
