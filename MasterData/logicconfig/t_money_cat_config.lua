-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_money_cat_config.lua

module("logicconfig.config.t_money_cat_config", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"MAX_TIMES",
		"50"
	},
	{
		"SINGLE_COST",
		"105:45:10"
	},
	{
		"TEN_COST",
		"105:45:90"
	},
	{
		"NONE_TIMES_TIP",
		"招财次数不足"
	},
	{
		"ANIMATION_TIP",
		"招财诺正在招财中，请等待招财诺结算哦~"
	},
	{
		"VIP_TIP",
		"今日已获得免费次数%d次"
	}
}
local t_money_cat_config = {
	MAX_TIMES = dataList[1],
	SINGLE_COST = dataList[2],
	TEN_COST = dataList[3],
	NONE_TIMES_TIP = dataList[4],
	ANIMATION_TIP = dataList[5],
	VIP_TIP = dataList[6]
}

t_money_cat_config.dataList = dataList

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

return t_money_cat_config
