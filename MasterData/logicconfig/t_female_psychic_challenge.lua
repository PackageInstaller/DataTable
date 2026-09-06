-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_female_psychic_challenge.lua

module("logicconfig.config.t_female_psychic_challenge", package.seeall)

local title = {
	challengeId = 2,
	stageName = 4,
	activityId = 1,
	openDateTime = 3
}
local dataList = {
	{
		253001,
		1,
		"2023-03-31T05:00:00",
		"通"
	},
	{
		253001,
		2,
		"2023-03-31T05:00:00",
		"灵"
	},
	{
		253001,
		3,
		"2023-04-01T05:00:00",
		"试"
	},
	{
		253001,
		4,
		"2023-04-02T05:00:00",
		"炼"
	},
	{
		253002,
		1,
		"2024-11-29T05:00:00",
		"诺"
	},
	{
		253002,
		2,
		"2024-11-29T05:00:00",
		"炎"
	},
	{
		253002,
		3,
		"2024-11-30T05:00:00",
		"修"
	},
	{
		253002,
		4,
		"2024-11-30T05:00:00",
		"天"
	},
	{
		253002,
		5,
		"2024-12-01T05:00:00",
		"瑞"
	}
}
local t_female_psychic_challenge = {
	[253001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	},
	[253002] = {
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9]
	}
}

t_female_psychic_challenge.dataList = dataList

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

return t_female_psychic_challenge
