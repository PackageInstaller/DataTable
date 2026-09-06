-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_halloween_boss_challenge_rank_prize.lua

module("logicconfig.config.t_halloween_boss_challenge_rank_prize", package.seeall)

local title = {
	id = 2,
	top = 3,
	rankPrizePlanId = 1,
	prize = 4
}
local dataList = {
	{
		1,
		1,
		1,
		"14:49:1#104:2:500#4:120:100"
	},
	{
		1,
		2,
		2,
		"14:49:1#104:2:450#4:120:100"
	},
	{
		1,
		3,
		3,
		"14:49:1#104:2:400#4:120:100"
	},
	{
		1,
		4,
		5,
		"14:49:1#104:2:350#4:120:80"
	},
	{
		1,
		5,
		10,
		"14:49:1#104:2:300#4:120:60"
	},
	{
		1,
		6,
		20,
		"14:49:1#104:2:200#4:120:50"
	},
	{
		2,
		1,
		1,
		"14:50:1#104:2:500#4:120:100"
	},
	{
		2,
		2,
		2,
		"14:50:1#104:2:450#4:120:100"
	},
	{
		2,
		3,
		3,
		"14:50:1#104:2:400#4:120:100"
	},
	{
		2,
		4,
		5,
		"14:50:1#104:2:350#4:120:80"
	},
	{
		2,
		5,
		10,
		"14:50:1#104:2:300#4:120:60"
	},
	{
		2,
		6,
		20,
		"14:50:1#104:2:200#4:120:50"
	}
}
local t_halloween_boss_challenge_rank_prize = {
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
	}
}

t_halloween_boss_challenge_rank_prize.dataList = dataList

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

return t_halloween_boss_challenge_rank_prize
