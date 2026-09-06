-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_planetarium_game_prize.lua

module("logicconfig.config.t_planetarium_game_prize", package.seeall)

local title = {
	prizeId = 2,
	passNum = 3,
	activityId = 1,
	prize = 4
}
local dataList = {
	{
		280001,
		1,
		1,
		"10:17076:800#4:31:10#8:1:1000000"
	},
	{
		280001,
		2,
		2,
		"10:17076:800#4:31:10#8:1:1000000"
	},
	{
		280001,
		3,
		3,
		"10:17076:800#4:31:10#8:1:1000000"
	},
	{
		280001,
		4,
		4,
		"10:17076:800#4:31:10#8:1:1000000"
	},
	{
		280001,
		5,
		5,
		"10:17076:800#4:31:10#8:1:1000000"
	},
	{
		280001,
		6,
		6,
		"10:17076:800#4:31:10#8:1:1000000"
	},
	{
		280001,
		7,
		7,
		"10:17076:1200#4:31:10#8:1:1000000"
	},
	{
		280002,
		1,
		1,
		"4:31:6#4:111:4#8:1:1000000"
	},
	{
		280002,
		2,
		2,
		"4:31:6#4:111:4#8:1:1000000"
	},
	{
		280002,
		3,
		3,
		"4:31:6#4:111:4#8:1:1000000"
	},
	{
		280002,
		4,
		4,
		"4:31:6#4:111:4#8:1:1000000"
	},
	{
		280002,
		5,
		5,
		"4:31:6#4:111:4#8:1:1000000"
	},
	{
		280003,
		1,
		1,
		"4:31:2#8:1:2000000"
	},
	{
		280003,
		2,
		2,
		"4:31:2#8:1:2000000"
	},
	{
		280003,
		3,
		3,
		"4:31:2#8:1:2000000"
	},
	{
		280003,
		4,
		4,
		"4:31:2#8:1:2000000"
	},
	{
		280003,
		5,
		5,
		"4:31:2#8:1:2000000"
	},
	{
		280004,
		1,
		9999,
		"4:31:2#8:1:2000000"
	}
}
local t_planetarium_game_prize = {
	[280001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	},
	[280002] = {
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12]
	},
	[280003] = {
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16],
		dataList[17]
	},
	[280004] = {
		dataList[18]
	}
}

t_planetarium_game_prize.dataList = dataList

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

return t_planetarium_game_prize
