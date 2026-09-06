-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_goddess_trial_boss_score.lua

module("logicconfig.config.t_goddess_trial_boss_score", package.seeall)

local title = {
	id = 2,
	damageScorePlanId = 1,
	damage = 3,
	score = 4
}
local dataList = {
	{
		1,
		1,
		"50000000",
		100
	},
	{
		1,
		2,
		"80000000",
		180
	},
	{
		1,
		3,
		"100000000",
		280
	},
	{
		1,
		4,
		"150000000",
		380
	},
	{
		1,
		5,
		"200000000",
		480
	},
	{
		1,
		6,
		"300000000",
		500
	},
	{
		1,
		7,
		"500000000",
		600
	},
	{
		1,
		8,
		"800000000",
		720
	},
	{
		1,
		9,
		"1000000000",
		840
	},
	{
		1,
		10,
		"1200000000",
		960
	}
}
local t_goddess_trial_boss_score = {
	{
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

t_goddess_trial_boss_score.dataList = dataList

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

return t_goddess_trial_boss_score
