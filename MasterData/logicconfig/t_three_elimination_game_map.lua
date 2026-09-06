-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_three_elimination_game_map.lua

module("logicconfig.config.t_three_elimination_game_map", package.seeall)

local title = {
	data = 3,
	mapId = 1,
	line = 2
}
local dataList = {
	{
		1,
		1,
		{
			301,
			201,
			202,
			201,
			102
		}
	},
	{
		1,
		2,
		{
			204,
			103,
			302,
			203,
			101
		}
	},
	{
		1,
		3,
		{
			101,
			301,
			104,
			102,
			303
		}
	},
	{
		1,
		4,
		{
			201,
			302,
			302,
			301,
			203
		}
	},
	{
		1,
		5,
		{
			303,
			202,
			103,
			304,
			101
		}
	}
}
local t_three_elimination_game_map = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_three_elimination_game_map.dataList = dataList

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

return t_three_elimination_game_map
