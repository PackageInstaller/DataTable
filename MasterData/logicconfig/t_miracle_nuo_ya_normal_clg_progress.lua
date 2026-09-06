-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_miracle_nuo_ya_normal_clg_progress.lua

module("logicconfig.config.t_miracle_nuo_ya_normal_clg_progress", package.seeall)

local title = {
	dataBitId = 2,
	prize = 4,
	activityId = 1,
	progress = 3
}
local dataList = {
	{
		382001,
		1,
		90,
		"4:90004:1"
	},
	{
		382001,
		2,
		180,
		"4:240:5"
	},
	{
		382001,
		3,
		270,
		"8:1:1000000"
	},
	{
		382001,
		4,
		360,
		"4:240:5"
	},
	{
		382001,
		5,
		450,
		"4:240:10"
	},
	{
		382002,
		1,
		90,
		"8:1:1000"
	},
	{
		382002,
		2,
		180,
		"8:1:1000"
	},
	{
		382002,
		3,
		270,
		"8:1:1000"
	},
	{
		382002,
		4,
		360,
		"8:1:1000"
	},
	{
		382002,
		5,
		450,
		"8:1:1000"
	}
}
local t_miracle_nuo_ya_normal_clg_progress = {
	[382001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	},
	[382002] = {
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	}
}

t_miracle_nuo_ya_normal_clg_progress.dataList = dataList

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

return t_miracle_nuo_ya_normal_clg_progress
