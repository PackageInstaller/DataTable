-- chunkname: @/tmp/or_script/lua_compile/foundation/ccext/ActionExt.lua

local Action = cc.Action

function Action:tagWith(tag)
	self:setTag(tag)

	return self
end

function ccAction(name, implClazz)
	assert(name ~= nil and implClazz ~= nil)

	return cclass(name, function(duration, ...)
		local impl = implClazz:new(duration, ...)
		local obj = cc.LuaActionInterval:create(duration, impl)

		obj.impl = impl

		return obj
	end)
end

function ccSequenceAction(name, subCreator)
	assert(name ~= nil and subCreator ~= nil)

	return cclass(name, function(...)
		local subActions = subCreator(...)

		assert(subActions ~= nil and #subActions > 0, "No sub-actions")

		return cc.Sequence:create(unpack(subActions))
	end)
end

function ccSpawnAction(name, subCreator)
	assert(name ~= nil and subCreator ~= nil)

	return cclass(name, function(...)
		local subActions = subCreator(...) or {}

		assert(subActions ~= nil and #subActions > 0, "No sub-actions")

		return cc.Spawn:create(unpack(subActions))
	end)
end
