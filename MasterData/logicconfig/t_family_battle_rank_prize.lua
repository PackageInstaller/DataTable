-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_family_battle_rank_prize.lua

module("logicconfig.config.t_family_battle_rank_prize", package.seeall)

local title = {
	id = 2,
	top = 3,
	rankPrizePlanId = 1,
	prize_client = 4
}
local dataList = {
	{
		1,
		1,
		1,
		"8:5:2000#8:27:1000#4:10000047:50"
	},
	{
		1,
		2,
		2,
		"8:5:1600#8:27:800#4:10000047:40"
	},
	{
		1,
		3,
		3,
		"8:5:1200#8:27:600#4:10000047:30"
	},
	{
		1,
		4,
		4,
		"8:5:800#8:27:400#4:10000047:20"
	},
	{
		1,
		5,
		5,
		"8:5:400#8:27:200#4:10000047:10"
	}
}
local t_family_battle_rank_prize = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_family_battle_rank_prize.dataList = dataList

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

return t_family_battle_rank_prize
