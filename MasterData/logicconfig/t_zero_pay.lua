-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_zero_pay.lua

module("logicconfig.config.t_zero_pay", package.seeall)

local title = {
	giftContent = 4,
	followUpGiftContent = 5,
	payGoodsId = 3,
	giftId = 2,
	mailDay = 7,
	mailContent = 6,
	activityId = 1
}
local dataList = {
	{
		28001,
		1,
		"rmb_98",
		"4:1008:1#100:10147:1:1",
		"4:36:5#100:10147:1:1#4:901:6800",
		"104:2:280",
		7
	}
}
local t_zero_pay = {
	[28001] = {
		dataList[1]
	}
}

t_zero_pay.dataList = dataList

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

return t_zero_pay
