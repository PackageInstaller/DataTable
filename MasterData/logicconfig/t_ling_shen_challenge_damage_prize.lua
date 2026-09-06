-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ling_shen_challenge_damage_prize.lua

module("logicconfig.config.t_ling_shen_challenge_damage_prize", package.seeall)

local title = {
	prizeId = 2,
	prize = 4,
	damage = 3,
	prizePlanId = 1
}
local dataList = {
	{
		1,
		1,
		100000,
		"10:377001:100"
	},
	{
		1,
		2,
		1000000,
		"10:377001:200"
	},
	{
		1,
		3,
		10000000,
		"10:377001:300"
	},
	{
		1,
		4,
		50000000,
		"10:377001:500"
	},
	{
		1,
		5,
		100000000,
		"10:377001:800"
	},
	{
		1,
		6,
		500000000,
		"10:377001:1200"
	},
	{
		2,
		1,
		100000,
		"10:377002:100"
	},
	{
		2,
		2,
		1000000,
		"10:377002:200"
	},
	{
		2,
		3,
		10000000,
		"10:377002:300"
	},
	{
		2,
		4,
		50000000,
		"10:377002:500"
	},
	{
		2,
		5,
		100000000,
		"10:377002:800"
	},
	{
		2,
		6,
		500000000,
		"10:377002:1200"
	},
	{
		3,
		1,
		100000,
		"10:377003:100"
	},
	{
		3,
		2,
		1000000,
		"10:377003:200"
	},
	{
		3,
		3,
		10000000,
		"10:377003:300"
	},
	{
		3,
		4,
		50000000,
		"10:377003:500"
	},
	{
		3,
		5,
		100000000,
		"10:377003:800"
	},
	{
		3,
		6,
		500000000,
		"10:377003:1200"
	},
	{
		4,
		1,
		10000,
		"10:377004:100"
	},
	{
		4,
		2,
		100000,
		"10:377004:200"
	},
	{
		4,
		3,
		1000000,
		"10:377004:300"
	},
	{
		4,
		4,
		5000000,
		"10:377004:500"
	},
	{
		4,
		5,
		10000000,
		"10:377004:800"
	},
	{
		4,
		6,
		50000000,
		"10:377004:1200"
	}
}
local t_ling_shen_challenge_damage_prize = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	},
	{
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12]
	},
	{
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16],
		dataList[17],
		dataList[18]
	},
	{
		dataList[19],
		dataList[20],
		dataList[21],
		dataList[22],
		dataList[23],
		dataList[24]
	}
}

t_ling_shen_challenge_damage_prize.dataList = dataList

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

return t_ling_shen_challenge_damage_prize
