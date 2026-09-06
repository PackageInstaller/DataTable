-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_strength_buy.lua

module("logicconfig.config.t_strength_buy", package.seeall)

local title = {
	consume = 2,
	buyTimePlanId = 3,
	times = 1
}
local dataList = {
	{
		1,
		"105:2:50",
		0
	},
	{
		2,
		"105:2:50",
		0
	},
	{
		3,
		"105:2:50",
		0
	},
	{
		4,
		"105:2:50",
		0
	},
	{
		5,
		"105:2:50",
		0
	},
	{
		6,
		"105:2:50",
		85
	},
	{
		7,
		"105:2:50",
		85
	},
	{
		8,
		"105:2:50",
		85
	},
	{
		9,
		"105:2:50",
		85
	},
	{
		10,
		"105:2:50",
		85
	}
}
local t_strength_buy = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8],
	dataList[9],
	dataList[10]
}

t_strength_buy.dataList = dataList

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

return t_strength_buy
