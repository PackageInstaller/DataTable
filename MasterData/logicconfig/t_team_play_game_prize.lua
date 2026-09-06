-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_team_play_game_prize.lua

module("logicconfig.config.t_team_play_game_prize", package.seeall)

local title = {
	score = 2,
	id = 1,
	prize = 3
}
local dataList = {
	{
		1,
		50,
		"4:701:1#104:2:10"
	},
	{
		1,
		100,
		"4:701:2#104:2:20"
	},
	{
		1,
		150,
		"4:701:3#104:2:30"
	},
	{
		1,
		200,
		"4:701:4#104:2:50"
	},
	{
		2,
		50,
		"4:701:1#104:2:10"
	},
	{
		2,
		100,
		"4:701:2#104:2:20"
	},
	{
		2,
		150,
		"4:701:3#104:2:30"
	},
	{
		2,
		200,
		"4:701:4#104:2:50"
	},
	{
		3,
		50,
		"4:30001:15#104:2:10"
	},
	{
		3,
		100,
		"4:30001:30#104:2:20"
	},
	{
		3,
		150,
		"4:30001:45#104:2:30"
	},
	{
		3,
		200,
		"4:30001:60#104:2:50"
	},
	{
		4,
		100,
		"4:501:30#104:2:10"
	},
	{
		4,
		200,
		"4:501:60#104:2:20"
	},
	{
		4,
		300,
		"4:501:90#104:2:30"
	},
	{
		4,
		400,
		"4:501:120#104:2:50"
	}
}
local t_team_play_game_prize = {
	{
		[50] = dataList[1],
		[100] = dataList[2],
		[150] = dataList[3],
		[200] = dataList[4]
	},
	{
		[50] = dataList[5],
		[100] = dataList[6],
		[150] = dataList[7],
		[200] = dataList[8]
	},
	{
		[50] = dataList[9],
		[100] = dataList[10],
		[150] = dataList[11],
		[200] = dataList[12]
	},
	{
		[100] = dataList[13],
		[200] = dataList[14],
		[300] = dataList[15],
		[400] = dataList[16]
	}
}

t_team_play_game_prize.dataList = dataList

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

return t_team_play_game_prize
