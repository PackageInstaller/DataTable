-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_rose_clg_stage.lua

module("logicconfig.config.t_rose_clg_stage", package.seeall)

local title = {
	openDay = 3,
	stageId = 2,
	teams = 5,
	activityId = 1,
	passPrize = 4
}
local dataList = {
	{
		414001,
		1,
		1,
		"4:254:5",
		{
			1001,
			1002
		}
	},
	{
		414001,
		2,
		1,
		"4:254:5",
		{
			1003,
			1004
		}
	},
	{
		414001,
		3,
		1,
		"4:254:10",
		{
			1005,
			1006
		}
	},
	{
		414001,
		4,
		1,
		"4:254:20",
		{
			1007,
			1008
		}
	},
	{
		414001,
		5,
		1,
		"4:254:20",
		{
			1009,
			1010
		}
	},
	{
		414001,
		6,
		1,
		"4:254:30",
		{
			1011,
			1012
		}
	},
	{
		414001,
		7,
		1,
		"4:254:30",
		{
			1013,
			1014
		}
	}
}
local t_rose_clg_stage = {
	[414001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	}
}

t_rose_clg_stage.dataList = dataList

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

return t_rose_clg_stage
