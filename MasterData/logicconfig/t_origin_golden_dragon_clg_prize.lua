-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_golden_dragon_clg_prize.lua

module("logicconfig.config.t_origin_golden_dragon_clg_prize", package.seeall)

local title = {
	prizeId = 2,
	prize = 4,
	activityId = 1,
	needScore = 3
}
local dataList = {
	{
		617001,
		1,
		80,
		"4:510827:25"
	},
	{
		617001,
		2,
		160,
		"4:510827:25"
	},
	{
		617001,
		3,
		180,
		"4:510827:50"
	}
}
local t_origin_golden_dragon_clg_prize = {
	[617001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_origin_golden_dragon_clg_prize.dataList = dataList

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

return t_origin_golden_dragon_clg_prize
