-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_linkage_lottery_buy.lua

module("logicconfig.config.t_linkage_lottery_buy", package.seeall)

local title = {
	buyDec = 3,
	buyPlanId = 1,
	hasBuyTime = 2
}
local dataList = {
	{
		1,
		0,
		"204:163:50"
	},
	{
		1,
		1,
		"204:163:50"
	},
	{
		1,
		2,
		"204:163:50"
	},
	{
		1,
		3,
		"204:163:50"
	},
	{
		1,
		4,
		"204:163:50"
	}
}
local t_linkage_lottery_buy = {
	{
		[0] = dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_linkage_lottery_buy.dataList = dataList

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

return t_linkage_lottery_buy
