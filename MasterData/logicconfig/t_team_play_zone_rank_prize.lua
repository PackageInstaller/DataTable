-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_team_play_zone_rank_prize.lua

module("logicconfig.config.t_team_play_zone_rank_prize", package.seeall)

local title = {
	id = 2,
	top = 3,
	rankPrizePlanId = 1,
	seasonScore = 4
}
local dataList = {
	{
		1,
		1,
		10,
		40
	},
	{
		1,
		2,
		50,
		30
	},
	{
		1,
		3,
		100,
		20
	},
	{
		1,
		4,
		200,
		10
	},
	{
		1,
		5,
		500,
		5
	}
}
local t_team_play_zone_rank_prize = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_team_play_zone_rank_prize.dataList = dataList

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

return t_team_play_zone_rank_prize
