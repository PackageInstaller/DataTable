-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_chuang_zhengli_clg_stage.lua

module("logicconfig.config.t_chuang_zhengli_clg_stage", package.seeall)

local title = {
	openDay = 3,
	stageId = 2,
	counterRequiredNum = 4,
	teams = 6,
	activityId = 1,
	passPrize = 5
}
local dataList = {
	{
		398001,
		1,
		1,
		1,
		"4:247:5",
		{
			1001
		}
	},
	{
		398001,
		2,
		1,
		2,
		"4:247:5",
		{
			1002
		}
	},
	{
		398001,
		3,
		1,
		3,
		"4:247:10",
		{
			1003
		}
	},
	{
		398001,
		4,
		1,
		4,
		"4:247:10",
		{
			1004
		}
	},
	{
		398001,
		5,
		1,
		5,
		"4:247:15",
		{
			1005,
			1006
		}
	},
	{
		398001,
		6,
		1,
		6,
		"4:247:15",
		{
			1007,
			1008
		}
	},
	{
		398001,
		7,
		1,
		6,
		"4:247:20",
		{
			1009,
			1010
		}
	},
	{
		398001,
		8,
		1,
		7,
		"4:247:20",
		{
			1011,
			1012
		}
	},
	{
		398001,
		9,
		1,
		8,
		"4:247:20",
		{
			1013,
			1014
		}
	}
}
local t_chuang_zhengli_clg_stage = {
	[398001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9]
	}
}

t_chuang_zhengli_clg_stage.dataList = dataList

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

return t_chuang_zhengli_clg_stage
