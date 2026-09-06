-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pin_ball_ext_prize.lua

module("logicconfig.config.t_pin_ball_ext_prize", package.seeall)

local title = {
	prizeId = 2,
	prize = 3,
	activityId = 1,
	limit = 4
}
local dataList = {
	{
		554001,
		1,
		"10:556001:10",
		4
	},
	{
		554002,
		1,
		"8:1:5000",
		4
	}
}
local t_pin_ball_ext_prize = {
	[554001] = {
		dataList[1]
	},
	[554002] = {
		dataList[2]
	}
}

t_pin_ball_ext_prize.dataList = dataList

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

return t_pin_ball_ext_prize
