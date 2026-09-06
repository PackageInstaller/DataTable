-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_tian_shan_clg_normal_clg_prize.lua

module("logicconfig.config.t_divine_tian_shan_clg_normal_clg_prize", package.seeall)

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
		"10000000",
		"4:90004:1"
	},
	{
		1,
		2,
		"50000000",
		"4:290:5"
	},
	{
		1,
		3,
		"100000000",
		"8:1:1000000"
	},
	{
		1,
		4,
		"150000000",
		"4:290:5"
	},
	{
		1,
		5,
		"200000000",
		"4:290:10"
	}
}
local t_divine_tian_shan_clg_normal_clg_prize = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_divine_tian_shan_clg_normal_clg_prize.dataList = dataList

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

return t_divine_tian_shan_clg_normal_clg_prize
