-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_puzzle_game_activity.lua

module("logicconfig.config.t_puzzle_game_activity", package.seeall)

local title = {
	jigsawPlanId = 2,
	id = 1,
	progressPlanId = 3
}
local dataList = {
	{
		56001,
		1,
		1
	},
	{
		56002,
		2,
		2
	},
	{
		56003,
		3,
		3
	},
	{
		56004,
		4,
		4
	},
	{
		56005,
		5,
		5
	},
	{
		56006,
		6,
		6
	},
	{
		56007,
		7,
		7
	},
	{
		56008,
		8,
		8
	}
}
local t_puzzle_game_activity = {
	[56001] = dataList[1],
	[56002] = dataList[2],
	[56003] = dataList[3],
	[56004] = dataList[4],
	[56005] = dataList[5],
	[56006] = dataList[6],
	[56007] = dataList[7],
	[56008] = dataList[8]
}

t_puzzle_game_activity.dataList = dataList

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

return t_puzzle_game_activity
