-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_ji_normal_clg_progress.lua

module("logicconfig.config.t_divine_ji_normal_clg_progress", package.seeall)

local title = {
	dataBitId = 2,
	prize = 4,
	activityId = 1,
	progress = 3
}
local dataList = {
	{
		421001,
		1,
		1,
		"4:257:5"
	},
	{
		421001,
		2,
		3,
		"4:90004:1"
	},
	{
		421001,
		3,
		5,
		"4:257:5"
	},
	{
		421001,
		4,
		7,
		"8:1:1000000"
	},
	{
		421001,
		5,
		9,
		"4:257:10"
	},
	{
		421002,
		1,
		1,
		"8:1:1"
	},
	{
		421002,
		2,
		3,
		"8:1:1"
	},
	{
		421002,
		3,
		5,
		"8:1:1"
	},
	{
		421002,
		4,
		7,
		"8:1:1"
	},
	{
		421002,
		5,
		9,
		"8:1:1"
	}
}
local t_divine_ji_normal_clg_progress = {
	[421001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	},
	[421002] = {
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	}
}

t_divine_ji_normal_clg_progress.dataList = dataList

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

return t_divine_ji_normal_clg_progress
