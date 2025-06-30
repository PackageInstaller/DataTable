-- chunkname: @IQIGame\\Scene\\Guild\\Input\\GuildInputManager.lua

local m = {}

m = extend(InputManager, m)

function m.New()
	local obj = Clone(m)

	obj:Init()

	return obj
end

return m
