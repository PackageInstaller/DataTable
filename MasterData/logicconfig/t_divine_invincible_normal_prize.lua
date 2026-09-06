-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_invincible_normal_prize.lua

module("logicconfig.config.t_divine_invincible_normal_prize", package.seeall)

local title = {
	prizeId = 2,
	num = 3,
	normalPlanId = 1,
	prize = 4
}
local dataList = {
	{
		1,
		1,
		3,
		"4:90004:1"
	},
	{
		1,
		2,
		6,
		"4:281:5"
	},
	{
		1,
		3,
		9,
		"8:1:1000000"
	},
	{
		1,
		4,
		12,
		"4:281:5"
	},
	{
		1,
		5,
		15,
		"4:281:10"
	}
}
local t_divine_invincible_normal_prize = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_divine_invincible_normal_prize.dataList = dataList

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

return t_divine_invincible_normal_prize
