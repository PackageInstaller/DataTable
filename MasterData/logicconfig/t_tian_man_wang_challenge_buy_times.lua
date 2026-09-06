-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_tian_man_wang_challenge_buy_times.lua

module("logicconfig.config.t_tian_man_wang_challenge_buy_times", package.seeall)

local title = {
	buyTimesPlanId = 1,
	consume = 3,
	times = 2
}
local dataList = {
	{
		2,
		1,
		"105:183:50"
	},
	{
		2,
		2,
		"105:183:50"
	},
	{
		2,
		3,
		"105:183:50"
	},
	{
		2,
		4,
		"105:183:50"
	},
	{
		2,
		5,
		"105:183:50"
	},
	{
		3,
		1,
		"105:184:50"
	}
}
local t_tian_man_wang_challenge_buy_times = {
	[2] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	},
	[3] = {
		dataList[6]
	}
}

t_tian_man_wang_challenge_buy_times.dataList = dataList

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

return t_tian_man_wang_challenge_buy_times
