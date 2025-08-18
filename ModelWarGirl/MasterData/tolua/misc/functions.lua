-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ToLua\\misc\\functions.lua

local require = require

function reimport(name)
	local package = package

	package.loaded[name] = nil
	package.preload[name] = nil

	return require(name)
end
