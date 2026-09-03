-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/components/BaseComponent.lua

BaseComponent = class("BaseComponent", objectlua.Object, _M)

function BaseComponent.class:create(...)
	return self:new():initWithRawData(...)
end

function BaseComponent:initialize()
	super.initialize(self)
end

function BaseComponent:setEntity(entity)
	self._entity = entity
end

function BaseComponent:getEntity()
	return self._entity
end

function BaseComponent:initWithRawData(data)
	return
end

function BaseComponent:copyComponent(srcComponent, ratio)
	assert(nil, "please implent me!!!")
end
