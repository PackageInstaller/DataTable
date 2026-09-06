-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_new_family_season_rank_prize.lua

module("logicconfig.config.t_new_family_season_rank_prize", package.seeall)

local title = {
	id = 2,
	rank = 3,
	rankPrizePlanId = 1,
	prize_client = 4
}
local dataList = {
	{
		1,
		1,
		1,
		"8:5:3500#8:27:750"
	},
	{
		1,
		2,
		5,
		"8:5:2500#8:27:550"
	},
	{
		1,
		3,
		100,
		"8:5:1500#8:27:400"
	},
	{
		1,
		4,
		1000,
		"8:5:500#8:27:300"
	}
}
local t_new_family_season_rank_prize = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_new_family_season_rank_prize.dataList = dataList

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

return t_new_family_season_rank_prize
