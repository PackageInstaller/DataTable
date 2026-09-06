-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_new_family_battle_rank_prize.lua

module("logicconfig.config.t_new_family_battle_rank_prize", package.seeall)

local title = {
	top = 3,
	rankPrizeId = 2,
	rankPrizePlanId = 1,
	prize_client = 4
}
local dataList = {
	{
		1,
		1,
		1,
		"8:5:2000#8:27:1000#8:42:8000"
	},
	{
		1,
		2,
		2,
		"8:5:1600#8:27:800#8:42:7000"
	},
	{
		1,
		3,
		3,
		"8:5:1200#8:27:600#8:42:6000"
	},
	{
		1,
		4,
		4,
		"8:5:800#8:27:400#8:42:5000"
	},
	{
		2,
		1,
		1,
		"8:42:5000"
	},
	{
		2,
		2,
		2,
		"8:42:4000"
	},
	{
		2,
		3,
		3,
		"8:42:3000"
	},
	{
		2,
		4,
		4,
		"8:42:2000"
	},
	{
		3,
		1,
		1,
		"2:146:1#8:42:5000"
	},
	{
		3,
		2,
		2,
		"2:147:1#8:42:4000"
	},
	{
		3,
		3,
		3,
		"2:148:1#8:42:3000"
	},
	{
		3,
		4,
		4,
		"2:149:1#8:42:2000"
	}
}
local t_new_family_battle_rank_prize = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	},
	{
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	},
	{
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12]
	}
}

t_new_family_battle_rank_prize.dataList = dataList

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

return t_new_family_battle_rank_prize
