-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_nian_nian_benefits_achievement.lua

module("logicconfig.config.t_nian_nian_benefits_achievement", package.seeall)

local title = {
	id = 1,
	totalGrade = 3,
	achievementId = 2,
	achievementPrize = 4
}
local dataList = {
	{
		1,
		1,
		5,
		"4:8003:100"
	},
	{
		1,
		2,
		10,
		"4:111:1"
	},
	{
		1,
		3,
		15,
		"4:112:1"
	},
	{
		1,
		4,
		20,
		"4:111:2"
	},
	{
		1,
		5,
		25,
		"4:112:2"
	},
	{
		1,
		6,
		30,
		"4:111:3"
	},
	{
		1,
		7,
		35,
		"4:112:3"
	},
	{
		1,
		8,
		40,
		"4:111:4"
	},
	{
		1,
		9,
		45,
		"4:112:4"
	}
}
local t_nian_nian_benefits_achievement = {
	{
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

t_nian_nian_benefits_achievement.dataList = dataList

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

return t_nian_nian_benefits_achievement
