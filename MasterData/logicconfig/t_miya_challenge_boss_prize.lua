-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_miya_challenge_boss_prize.lua

module("logicconfig.config.t_miya_challenge_boss_prize", package.seeall)

local title = {
	prizeId = 2,
	prize = 3,
	bossPrizePlanId = 1
}
local dataList = {
	{
		1,
		1,
		"10:218001:35"
	},
	{
		1,
		2,
		"10:218001:50"
	},
	{
		1,
		3,
		"10:218001:65"
	},
	{
		2,
		1,
		"4:199:165"
	},
	{
		2,
		2,
		"4:199:235"
	},
	{
		2,
		3,
		"4:199:300"
	},
	{
		3,
		1,
		"10:2180001:35"
	},
	{
		3,
		2,
		"10:2180001:50"
	},
	{
		3,
		3,
		"10:2180001:65"
	}
}
local t_miya_challenge_boss_prize = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	},
	{
		dataList[4],
		dataList[5],
		dataList[6]
	},
	{
		dataList[7],
		dataList[8],
		dataList[9]
	}
}

t_miya_challenge_boss_prize.dataList = dataList

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

return t_miya_challenge_boss_prize
