-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dumpling_feast_intimacy_progress.lua

module("logicconfig.config.t_dumpling_feast_intimacy_progress", package.seeall)

local title = {
	progressId = 2,
	intimacy = 3,
	activityId = 1,
	prize = 4
}
local dataList = {
	{
		562001,
		1,
		200,
		"8:1:500000"
	},
	{
		562001,
		2,
		400,
		"10:562004:3"
	},
	{
		562001,
		3,
		600,
		"8:1:500000"
	},
	{
		562001,
		4,
		800,
		"10:562004:3"
	},
	{
		562001,
		5,
		1000,
		"8:1:500000"
	},
	{
		562001,
		6,
		1200,
		"10:562004:3"
	},
	{
		562001,
		7,
		1800,
		"8:1:500000"
	},
	{
		562001,
		8,
		2400,
		"10:562004:3"
	},
	{
		562001,
		9,
		3000,
		"8:1:500000"
	},
	{
		562001,
		10,
		3600,
		"10:562004:3"
	},
	{
		562001,
		11,
		4200,
		"8:1:500000"
	}
}
local t_dumpling_feast_intimacy_progress = {
	[562001] = {
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
		dataList[11]
	}
}

t_dumpling_feast_intimacy_progress.dataList = dataList

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

return t_dumpling_feast_intimacy_progress
