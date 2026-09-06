-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_three_matches_game_prize.lua

module("logicconfig.config.t_three_matches_game_prize", package.seeall)

local title = {
	prizeId = 2,
	prize = 4,
	activityId = 1,
	scoreLimit = 3
}
local dataList = {
	{
		349001,
		1,
		2000,
		"10:349002:20"
	},
	{
		349001,
		2,
		3000,
		"10:349002:20"
	},
	{
		349001,
		3,
		4000,
		"10:349002:20"
	},
	{
		349002,
		1,
		2000,
		"10:349002:5"
	},
	{
		349002,
		2,
		3000,
		"10:349002:10"
	},
	{
		349002,
		3,
		4000,
		"10:349002:20"
	},
	{
		349003,
		1,
		2000,
		"10:349003:5"
	},
	{
		349003,
		2,
		3000,
		"10:349003:10"
	},
	{
		349003,
		3,
		4000,
		"10:349003:20"
	},
	{
		349004,
		1,
		2000,
		"10:349004:15"
	},
	{
		349004,
		2,
		3000,
		"10:349004:20"
	},
	{
		349004,
		3,
		4000,
		"10:349004:30"
	}
}
local t_three_matches_game_prize = {
	[349001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	},
	[349002] = {
		dataList[4],
		dataList[5],
		dataList[6]
	},
	[349003] = {
		dataList[7],
		dataList[8],
		dataList[9]
	},
	[349004] = {
		dataList[10],
		dataList[11],
		dataList[12]
	}
}

t_three_matches_game_prize.dataList = dataList

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

return t_three_matches_game_prize
