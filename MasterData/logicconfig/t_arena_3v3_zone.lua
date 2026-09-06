-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_arena_3v3_zone.lua

module("logicconfig.config.t_arena_3v3_zone", package.seeall)

local title = {
	zoneId = 1,
	zoneName = 2
}
local dataList = {
	{
		1,
		"怒炎战区"
	},
	{
		2,
		"极霜战区"
	},
	{
		3,
		"蛮荒战区"
	},
	{
		4,
		"炫光战区"
	}
}
local t_arena_3v3_zone = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4]
}

t_arena_3v3_zone.dataList = dataList

local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			return rawget(t, index)
		end
	end
}

for i, v in ipairs(dataList) do
	setmetatable(v, mt)
end

return t_arena_3v3_zone
