-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_powers_clg_common_prize.lua

module("logicconfig.config.t_origin_powers_clg_common_prize", package.seeall)

local title = {
	prizeId = 2,
	prize = 4,
	activityId = 1,
	progress = 3
}
local dataList = {
	{
		576001,
		1,
		5,
		"8:1:1000"
	},
	{
		576001,
		2,
		10,
		"8:1:1001"
	},
	{
		576001,
		3,
		15,
		"8:1:1002"
	}
}
local t_origin_powers_clg_common_prize = {
	[576001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_origin_powers_clg_common_prize.dataList = dataList

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

return t_origin_powers_clg_common_prize
