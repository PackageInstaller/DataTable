-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_upcoming_unlock_world_prize.lua

module("logicconfig.config.t_upcoming_unlock_world_prize", package.seeall)

local title = {
	prizeId = 2,
	num = 3,
	activityId = 1,
	prize = 4
}
local dataList = {
	{
		181009,
		1,
		500,
		"4:36:2"
	},
	{
		181009,
		2,
		2500,
		"4:36:2"
	},
	{
		181009,
		3,
		5000,
		"4:36:2"
	},
	{
		181009,
		4,
		7000,
		"4:36:2"
	},
	{
		181009,
		5,
		9000,
		"4:36:2"
	},
	{
		181009,
		6,
		11000,
		"4:36:2"
	},
	{
		181009,
		7,
		13000,
		"4:36:2"
	},
	{
		181009,
		8,
		15000,
		"4:36:2"
	},
	{
		181009,
		9,
		17000,
		"4:36:2"
	},
	{
		181009,
		10,
		19000,
		"4:36:2"
	},
	{
		181012,
		1,
		500,
		"4:36:2"
	},
	{
		181012,
		2,
		2500,
		"4:36:2"
	},
	{
		181012,
		3,
		5000,
		"4:36:2"
	},
	{
		181012,
		4,
		7000,
		"4:36:2"
	},
	{
		181012,
		5,
		9000,
		"4:36:2"
	},
	{
		181012,
		6,
		11000,
		"4:36:2"
	},
	{
		181012,
		7,
		13000,
		"4:36:2"
	},
	{
		181012,
		8,
		15000,
		"4:36:2"
	},
	{
		181012,
		9,
		17000,
		"4:36:2"
	},
	{
		181012,
		10,
		19000,
		"4:36:2"
	}
}
local t_upcoming_unlock_world_prize = {
	[181009] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	},
	[181012] = {
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16],
		dataList[17],
		dataList[18],
		dataList[19],
		dataList[20]
	}
}

t_upcoming_unlock_world_prize.dataList = dataList

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

return t_upcoming_unlock_world_prize
