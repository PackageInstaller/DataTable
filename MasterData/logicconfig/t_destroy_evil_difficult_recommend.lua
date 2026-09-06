-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_destroy_evil_difficult_recommend.lua

module("logicconfig.config.t_destroy_evil_difficult_recommend", package.seeall)

local title = {
	powerRange = 3,
	difficult = 2,
	activityId = 1,
	desc = 4
}
local dataList = {
	{
		322001,
		1,
		{
			0,
			10000
		},
		"0-1w"
	},
	{
		322001,
		2,
		{
			10001,
			100000
		},
		"1w-10w"
	},
	{
		322001,
		3,
		{
			100001,
			-1
		},
		"10w-∞"
	},
	{
		322002,
		1,
		{
			0,
			600000
		},
		"0-60w"
	},
	{
		322002,
		2,
		{
			600000,
			1200000
		},
		"60w-120w"
	},
	{
		322002,
		3,
		{
			1200000,
			-1
		},
		"120w-∞"
	},
	{
		322003,
		1,
		{
			0,
			600000
		},
		"0-60w"
	},
	{
		322003,
		2,
		{
			600000,
			1200000
		},
		"60w-120w"
	},
	{
		322003,
		3,
		{
			1200000,
			-1
		},
		"120w-∞"
	}
}
local t_destroy_evil_difficult_recommend = {
	[322001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	},
	[322002] = {
		dataList[4],
		dataList[5],
		dataList[6]
	},
	[322003] = {
		dataList[7],
		dataList[8],
		dataList[9]
	}
}

t_destroy_evil_difficult_recommend.dataList = dataList

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

return t_destroy_evil_difficult_recommend
