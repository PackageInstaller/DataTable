-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_xiu_er_extreme_clg_tier.lua

module("logicconfig.config.t_divine_xiu_er_extreme_clg_tier", package.seeall)

local title = {
	viewParams = 7,
	tierType = 4,
	activityId = 1,
	name = 5,
	viewName = 6,
	openTime = 3,
	tierId = 2
}
local dataList = {
	{
		329001,
		1,
		"2024-06-28T05:00:00",
		"NORMAL_PARALLEL_STAGE",
		"第 <size=36>1</size> 层",
		"divinexiuerclgextparallelview",
		"329001#1#1"
	},
	{
		329001,
		2,
		"2024-06-28T05:00:00",
		"NORMAL_PARALLEL_STAGE",
		"第 <size=36>2</size> 层",
		"divinexiuerclgextparallelview",
		"329001#2#2"
	},
	{
		329001,
		3,
		"2024-06-28T05:00:00",
		"TRUE_FALSE_STAGE",
		"第 <size=36>3</size> 层",
		"divinexiuerclgexttruefalseview",
		"329001#3#1"
	}
}
local t_divine_xiu_er_extreme_clg_tier = {
	[329001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_divine_xiu_er_extreme_clg_tier.dataList = dataList

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

return t_divine_xiu_er_extreme_clg_tier
