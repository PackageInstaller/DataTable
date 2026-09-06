-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pay_shop_group.lua

module("logicconfig.config.t_pay_shop_group", package.seeall)

local title = {
	groupId = 1,
	presentGain = 3,
	totalDays = 2
}
local dataList = {
	{
		1,
		7,
		"104:2:100"
	},
	{
		2,
		7,
		"4:30002:10#4:502:20"
	},
	{
		3,
		7,
		"9:1024:50"
	}
}
local t_pay_shop_group = {
	dataList[1],
	dataList[2],
	dataList[3]
}

t_pay_shop_group.dataList = dataList

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

return t_pay_shop_group
