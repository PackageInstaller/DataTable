-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_miya_challenge_tier.lua

module("logicconfig.config.t_miya_challenge_tier", package.seeall)

local title = {
	firstRandomPlanId = 6,
	tierId = 2,
	secondRandomPlanId = 7,
	tierPlanId = 1,
	secondName = 10,
	thirdRandomPlanId = 8,
	secondPlanId = 4,
	thirdPlanId = 5,
	firstName = 9,
	thirdName = 11,
	firstPlanId = 3
}
local dataList = {
	{
		1,
		1,
		1,
		2,
		3,
		6,
		1,
		1,
		"时耗",
		"渡时",
		"时轮"
	},
	{
		1,
		2,
		4,
		5,
		6,
		6,
		2,
		2,
		"时耗",
		"渡时",
		"时轮"
	},
	{
		1,
		3,
		7,
		8,
		9,
		6,
		3,
		3,
		"时耗",
		"渡时",
		"时轮"
	},
	{
		1,
		4,
		10,
		11,
		12,
		6,
		4,
		4,
		"时耗",
		"渡时",
		"时轮"
	},
	{
		1,
		5,
		13,
		14,
		15,
		6,
		5,
		5,
		"时耗",
		"渡时",
		"时轮"
	},
	{
		2,
		1,
		16,
		17,
		18,
		12,
		7,
		7,
		"创界",
		"润物",
		"福泽"
	},
	{
		2,
		2,
		19,
		20,
		21,
		12,
		8,
		8,
		"创界",
		"润物",
		"福泽"
	},
	{
		2,
		3,
		22,
		23,
		24,
		12,
		9,
		9,
		"创界",
		"润物",
		"福泽"
	},
	{
		2,
		4,
		25,
		26,
		27,
		12,
		10,
		10,
		"创界",
		"润物",
		"福泽"
	},
	{
		2,
		5,
		28,
		29,
		30,
		12,
		11,
		11,
		"创界",
		"润物",
		"福泽"
	},
	{
		3,
		1,
		31,
		32,
		33,
		18,
		12,
		12,
		"时耗",
		"渡时",
		"时轮"
	},
	{
		3,
		2,
		34,
		35,
		36,
		18,
		13,
		13,
		"时耗",
		"渡时",
		"时轮"
	},
	{
		3,
		3,
		37,
		38,
		39,
		18,
		14,
		14,
		"时耗",
		"渡时",
		"时轮"
	},
	{
		3,
		4,
		40,
		41,
		42,
		18,
		15,
		15,
		"时耗",
		"渡时",
		"时轮"
	},
	{
		3,
		5,
		43,
		44,
		45,
		18,
		16,
		16,
		"时耗",
		"渡时",
		"时轮"
	}
}
local t_miya_challenge_tier = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	},
	{
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	},
	{
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15]
	}
}

t_miya_challenge_tier.dataList = dataList

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

return t_miya_challenge_tier
