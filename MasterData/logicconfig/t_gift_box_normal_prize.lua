-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_gift_box_normal_prize.lua

module("logicconfig.config.t_gift_box_normal_prize", package.seeall)

local title = {
	prizeId = 2,
	addScore = 4,
	prize = 3,
	normalPrizePlanId = 1
}
local dataList = {
	{
		1,
		1,
		"8:25:100",
		5
	},
	{
		2,
		1,
		"8:1:50000",
		1
	}
}
local t_gift_box_normal_prize = {
	{
		dataList[1]
	},
	{
		dataList[2]
	}
}

t_gift_box_normal_prize.dataList = dataList

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

return t_gift_box_normal_prize
