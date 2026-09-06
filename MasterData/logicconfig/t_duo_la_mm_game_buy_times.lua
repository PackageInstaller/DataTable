-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_duo_la_mm_game_buy_times.lua

module("logicconfig.config.t_duo_la_mm_game_buy_times", package.seeall)

local title = {
	times = 3,
	consume = 4,
	planId = 1,
	type = 2
}
local dataList = {
	{
		1,
		1,
		1,
		"105:163:50"
	},
	{
		1,
		1,
		2,
		"105:163:50"
	},
	{
		1,
		1,
		3,
		"105:163:100"
	},
	{
		1,
		2,
		1,
		"105:168:10"
	}
}
local t_duo_la_mm_game_buy_times = {
	{
		{
			dataList[1],
			dataList[2],
			dataList[3]
		},
		{
			dataList[4]
		}
	}
}

t_duo_la_mm_game_buy_times.dataList = dataList

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

return t_duo_la_mm_game_buy_times
