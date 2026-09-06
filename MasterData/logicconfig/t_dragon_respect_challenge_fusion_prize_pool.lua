-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dragon_respect_challenge_fusion_prize_pool.lua

module("logicconfig.config.t_dragon_respect_challenge_fusion_prize_pool", package.seeall)

local title = {
	prizeId = 2,
	prize = 3,
	fusionDrawPlanId = 1,
	isBigPirze = 4
}
local dataList = {
	{
		1,
		1,
		"100:17002:1:1",
		true
	},
	{
		1,
		2,
		"4:30001:5",
		false
	},
	{
		1,
		3,
		"4:30002:2",
		false
	},
	{
		1,
		4,
		"4:30003:1",
		false
	},
	{
		1,
		5,
		"4:5101:3",
		false
	},
	{
		1,
		6,
		"4:5102:3",
		false
	},
	{
		1,
		7,
		"4:5103:3",
		false
	},
	{
		1,
		8,
		"4:5201:1",
		false
	},
	{
		1,
		9,
		"4:5202:1",
		false
	},
	{
		1,
		10,
		"4:5203:1",
		false
	},
	{
		1,
		11,
		"4:501:10",
		false
	},
	{
		1,
		12,
		"4:502:3",
		false
	},
	{
		1,
		13,
		"4:503:1",
		false
	},
	{
		1,
		14,
		"4:30004:10",
		false
	},
	{
		1,
		15,
		"4:30005:3",
		false
	},
	{
		1,
		16,
		"4:30006:1",
		false
	}
}
local t_dragon_respect_challenge_fusion_prize_pool = {
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
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16]
	}
}

t_dragon_respect_challenge_fusion_prize_pool.dataList = dataList

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

return t_dragon_respect_challenge_fusion_prize_pool
