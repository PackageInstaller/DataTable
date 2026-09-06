-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_new_family_season_rank_score_prize.lua

module("logicconfig.config.t_new_family_season_rank_score_prize", package.seeall)

local title = {
	id = 2,
	scorePrizePlanId = 1,
	score = 3,
	prize_client = 4
}
local dataList = {
	{
		1,
		1,
		50,
		"4:10000051:1#8:5:500#8:27:300"
	},
	{
		1,
		2,
		100,
		"4:10000050:1#8:5:1500#8:27:400"
	},
	{
		1,
		3,
		150,
		"4:10000049:1#8:5:2500#8:27:550"
	},
	{
		1,
		4,
		200,
		"4:10000048:1#8:5:3500#8:27:750"
	}
}
local t_new_family_season_rank_score_prize = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_new_family_season_rank_score_prize.dataList = dataList

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

return t_new_family_season_rank_score_prize
