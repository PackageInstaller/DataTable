-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_angel_power_monster.lua

module("logicconfig.config.t_angel_power_monster", package.seeall)

local title = {
	formCondition = 9,
	name = 2,
	ruleDesc = 11,
	skipTime = 3,
	retreatMsgType = 7,
	btlMode = 5,
	btlBg = 4,
	selfBuffProviderId = 8,
	winId = 6,
	creepsMasterId = 1,
	heroSkillId = 10
}
local dataList = {
	{
		1001,
		"极限挑战-1",
		3,
		"",
		"",
		172,
		0,
		308,
		0,
		"",
		"刚毅(火)≥1,温柔(水)≥1\r\n己方存活≥2"
	},
	{
		1002,
		"极限挑战-2",
		3,
		"",
		"",
		172,
		0,
		308,
		0,
		"",
		"阳光(光)≥1,沮丧(暗)≥1\r\n己方存活≥2"
	},
	{
		1003,
		"极限挑战-3",
		3,
		"",
		"",
		172,
		0,
		308,
		0,
		"",
		"超越(空)≥1,创造(创)≥1\r\n己方存活≥2"
	},
	{
		1004,
		"极限挑战-4",
		3,
		"",
		"",
		171,
		0,
		308,
		0,
		"",
		"友善(草)≥2,刚毅(火)≥1\r\n己方存活≥3"
	},
	{
		1005,
		"极限挑战-5",
		3,
		"",
		"",
		171,
		0,
		308,
		0,
		"",
		"创造(空)≥2,沮丧(暗)≥1\r\n己方存活≥3"
	},
	{
		1006,
		"极限挑战-6",
		3,
		"",
		"",
		171,
		0,
		308,
		0,
		"",
		"超越(创)≥2,阳光(光)≥1\r\n己方存活≥3"
	},
	{
		1007,
		"极限挑战-7",
		3,
		"",
		"",
		170,
		0,
		308,
		0,
		"",
		"超越(创)≥4,刚毅(火)≥2\r\n己方存活≥4"
	},
	{
		1008,
		"极限挑战-8",
		3,
		"",
		"",
		170,
		0,
		308,
		0,
		"",
		"超越(创)≥3,友善(草)≥3\r\n己方存活≥4"
	},
	{
		1009,
		"极限挑战-9",
		3,
		"",
		"",
		170,
		0,
		308,
		0,
		"",
		"超越(创)≥3,温柔(水)≥3\r\n己方存活≥4"
	}
}
local t_angel_power_monster = {
	[1001] = dataList[1],
	[1002] = dataList[2],
	[1003] = dataList[3],
	[1004] = dataList[4],
	[1005] = dataList[5],
	[1006] = dataList[6],
	[1007] = dataList[7],
	[1008] = dataList[8],
	[1009] = dataList[9]
}

t_angel_power_monster.dataList = dataList

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

return t_angel_power_monster
