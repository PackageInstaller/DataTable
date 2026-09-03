-- chunkname: @/tmp/or_script/lua_compile/objectlua/init.lua

require("objectlua.bootstrap")
require("objectlua.Class")
require("objectlua.Interface")
require("objectlua.Object")
require("objectlua.Enumeration")

function class(classShortName, ...)
	local superClass, env = ...
	local argc = select("#", ...)

	if argc >= 1 and superClass == nil then
		error("trying to extend `nil` class", 2)
	end

	local name = classShortName

	if classShortName ~= nil then
		if env == nil then
			env = getfenv(2)
		end

		if env ~= nil and env._NAME ~= nil then
			name = env._NAME .. "." .. classShortName
		end
	end

	if superClass == nil then
		superClass = objectlua.Object
	end

	return superClass:subclass(name)
end

function interface(interfaceShortName, ...)
	local superInterface, env = ...
	local argc = select("#", ...)

	if argc >= 1 and superInterface == nil then
		error("trying to extend `nil` interface", 2)
	end

	local name = interfaceShortName

	if interfaceShortName ~= nil then
		if env == nil then
			env = getfenv(2)
		end

		if env ~= nil and env._NAME ~= nil then
			name = env._NAME .. "." .. interfaceShortName
		end
	end

	return objectlua.Interface:new(name, superInterface)
end

function enum(enumShortName, ...)
	local superEnumeration, env = ...
	local argc = select("#", ...)

	if argc >= 1 and superEnumeration == nil then
		error("trying to extend `nil` enumeration", 2)
	end

	local name = enumShortName

	if enumShortName ~= nil then
		if env == nil then
			env = getfenv(2)
		end

		if env ~= nil and env._NAME ~= nil then
			name = env._NAME .. "." .. enumShortName
		end
	end

	return objectlua.Enumeration:new(name, superEnumeration)
end
