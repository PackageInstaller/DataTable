-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_three_matches_game_progress_prize.lua

module("logicconfig.config.t_three_matches_game_progress_prize", package.seeall)

local title = {
	prizeId = 2,
	prize = 4,
	activityId = 1,
	progress = 3
}
local dataList = {
	{
		349001,
		1,
		5,
		"8:1:1000"
	},
	{
		349001,
		2,
		10,
		"8:1:2000"
	},
	{
		349002,
		1,
		30,
		"4:111:5"
	},
	{
		349002,
		2,
		60,
		"8:1:1000000"
	},
	{
		349002,
		3,
		90,
		"4:111:5"
	},
	{
		349002,
		4,
		120,
		"104:2:333"
	},
	{
		349002,
		5,
		150,
		"4:510313:1"
	},
	{
		349002,
		6,
		180,
		"104:2:333"
	},
	{
		349003,
		1,
		10,
		"10:453001:500"
	},
	{
		349003,
		2,
		30,
		"10:453001:500"
	},
	{
		349003,
		3,
		50,
		"10:453001:500"
	},
	{
		349003,
		4,
		70,
		"10:453001:500"
	},
	{
		349003,
		5,
		90,
		"10:453001:500"
	},
	{
		349003,
		6,
		110,
		"10:453001:500"
	},
	{
		349003,
		7,
		130,
		"10:453001:1000"
	},
	{
		349003,
		8,
		150,
		"10:453001:1000"
	},
	{
		349003,
		9,
		170,
		"10:453001:1000"
	},
	{
		349003,
		10,
		180,
		"10:453001:1500"
	},
	{
		349004,
		1,
		30,
		"10:540002:1"
	},
	{
		349004,
		2,
		60,
		"10:540003:1"
	},
	{
		349004,
		3,
		90,
		"10:540004:1"
	},
	{
		349004,
		4,
		120,
		"10:540005:1"
	},
	{
		349004,
		5,
		150,
		"10:540006:1"
	}
}
local t_three_matches_game_progress_prize = {
	[349001] = {
		dataList[1],
		dataList[2]
	},
	[349002] = {
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	},
	[349003] = {
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16],
		dataList[17],
		dataList[18]
	},
	[349004] = {
		dataList[19],
		dataList[20],
		dataList[21],
		dataList[22],
		dataList[23]
	}
}

t_three_matches_game_progress_prize.dataList = dataList

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

return t_three_matches_game_progress_prize
