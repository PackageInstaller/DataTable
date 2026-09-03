-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/model/RemoteObjectRegistry.lua

RemoteObjectRegistry = class("RemoteObjectRegistry", objectlua.Object, _M)

RemoteObjectRegistry:has("_objectMap", {
	is = "rw"
})

function RemoteObjectRegistry:initialize()
	super.initialize(self)

	self._objectMap = {}
end

function RemoteObjectRegistry.class:getInstance()
	if __registryInstance == nil then
		__registryInstance = RemoteObjectRegistry:new()
	end

	return __registryInstance
end

function RemoteObjectRegistry:registerObject(objectId, object)
	self._objectMap[objectId] = object
end

function RemoteObjectRegistry:unregisterObject(objectId)
	if objectId then
		self._objectMap[objectId] = nil
	end
end

function RemoteObjectRegistry:getObjectById(objectId)
	return self._objectMap[objectId]
end
