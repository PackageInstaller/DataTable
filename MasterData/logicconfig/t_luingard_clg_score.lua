-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_luingard_clg_score.lua

module("logicconfig.config.t_luingard_clg_score", package.seeall)

local title = {
	score = 4,
	damage = 3,
	activityId = 1,
	level = 2
}
local dataList = {
	{
		465001,
		1,
		"0",
		0
	},
	{
		465001,
		2,
		"100000",
		10
	},
	{
		465001,
		3,
		"200000",
		20
	},
	{
		465001,
		4,
		"300000",
		30
	},
	{
		465001,
		5,
		"400000",
		40
	},
	{
		465001,
		6,
		"500000",
		50
	},
	{
		465001,
		7,
		"600000",
		60
	},
	{
		465001,
		8,
		"700000",
		70
	},
	{
		465001,
		9,
		"800000",
		80
	},
	{
		465001,
		10,
		"900000",
		90
	}
}
local t_luingard_clg_score = {
	[465001] = {
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
	}
}

t_luingard_clg_score.dataList = dataList

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

return t_luingard_clg_score
