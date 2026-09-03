-- chunkname: @/tmp/or_script/lua_compile/objectlua/Mixin.lua

local Object = require("objectlua.Object")
local _ = Object:subclass(...)

function _.class:new(...)
	local o = super(self, ...)

	o.__methods__ = {}

	return o
end

return _
