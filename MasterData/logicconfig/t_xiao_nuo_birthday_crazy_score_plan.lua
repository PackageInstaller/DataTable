-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_xiao_nuo_birthday_crazy_score_plan.lua

module("logicconfig.config.t_xiao_nuo_birthday_crazy_score_plan", package.seeall)

local title = {
	crazyScorePlan = 1,
	score = 3,
	prize = 4,
	passStage = 2
}
local dataList = {
	{
		1,
		1,
		100,
		"8:1:10000"
	},
	{
		1,
		2,
		120,
		"8:1:10000"
	},
	{
		1,
		3,
		140,
		"8:1:10000"
	},
	{
		1,
		4,
		160,
		"8:1:10000"
	},
	{
		1,
		5,
		180,
		"8:1:10000"
	},
	{
		1,
		6,
		200,
		"8:1:10000"
	},
	{
		1,
		7,
		220,
		"8:1:10000"
	},
	{
		1,
		8,
		240,
		"8:1:10000"
	},
	{
		1,
		9,
		260,
		"8:1:10000"
	},
	{
		1,
		10,
		280,
		"8:1:10000"
	},
	{
		1,
		11,
		300,
		"8:1:10000"
	},
	{
		1,
		12,
		320,
		"8:1:10000"
	}
}
local t_xiao_nuo_birthday_crazy_score_plan = {
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
		dataList[10],
		dataList[11],
		dataList[12]
	}
}

t_xiao_nuo_birthday_crazy_score_plan.dataList = dataList

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

return t_xiao_nuo_birthday_crazy_score_plan
