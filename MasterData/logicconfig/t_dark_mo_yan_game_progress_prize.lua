-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dark_mo_yan_game_progress_prize.lua

module("logicconfig.config.t_dark_mo_yan_game_progress_prize", package.seeall)

local title = {
	id = 2,
	prize = 4,
	activityId = 1,
	progress = 3
}
local dataList = {
	{
		458001,
		1,
		20,
		"8:1:2000000"
	},
	{
		458001,
		2,
		40,
		"10:453001:200"
	},
	{
		458001,
		3,
		60,
		"10:453001:200"
	},
	{
		458001,
		4,
		80,
		"8:1:2000000"
	},
	{
		458001,
		5,
		100,
		"10:453001:300"
	},
	{
		458001,
		6,
		120,
		"10:453001:300"
	},
	{
		458001,
		7,
		140,
		"8:1:3000000"
	},
	{
		458001,
		8,
		160,
		"10:453001:500"
	},
	{
		458001,
		9,
		180,
		"10:453001:500"
	},
	{
		458001,
		10,
		200,
		"8:1:3000000"
	},
	{
		458001,
		11,
		220,
		"10:453001:500"
	},
	{
		458001,
		12,
		240,
		"10:453001:500"
	}
}
local t_dark_mo_yan_game_progress_prize = {
	[458001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12]
	}
}

t_dark_mo_yan_game_progress_prize.dataList = dataList

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

return t_dark_mo_yan_game_progress_prize
