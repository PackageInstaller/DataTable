-- chunkname: @/tmp/or_script/lua_compile/dragon/fsm/State.lua

State = class("State", objectlua.Object, _M)

function State:initialize(name)
	super.initialize(self)

	self._name = name ~= nil and name or self:className()
end

function State:getName()
	return self._name
end

function State:enter(agent, ...)
	return
end

function State:update(agent, ...)
	return
end

function State:exit(agent, ...)
	return
end

function State:onMessage(agent, message)
	return false
end
