-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_god_hyur_challenge_mood.lua

module("logicconfig.config.t_god_hyur_challenge_mood", package.seeall)

local title = {
	moodType = 2,
	range = 4,
	buffPlanId = 5,
	name = 3,
	id = 1
}
local dataList = {
	{
		1,
		1,
		"喜",
		{
			0,
			5
		},
		0
	},
	{
		2,
		1,
		"喜",
		{
			6,
			10
		},
		1
	},
	{
		3,
		1,
		"喜",
		{
			11,
			15
		},
		2
	},
	{
		4,
		1,
		"喜",
		{
			16,
			99
		},
		3
	},
	{
		5,
		2,
		"悲",
		{
			-5,
			0
		},
		0
	},
	{
		6,
		2,
		"悲",
		{
			-10,
			-6
		},
		4
	},
	{
		7,
		2,
		"悲",
		{
			-15,
			-11
		},
		5
	},
	{
		8,
		2,
		"悲",
		{
			-99,
			-16
		},
		6
	},
	{
		9,
		3,
		"常",
		{},
		0
	},
	{
		10,
		4,
		"圆",
		{},
		0
	}
}
local t_god_hyur_challenge_mood = {
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

t_god_hyur_challenge_mood.dataList = dataList

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

return t_god_hyur_challenge_mood
