-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_empress_extreme_clg_negative_buff.lua

module("logicconfig.config.t_divine_empress_extreme_clg_negative_buff", package.seeall)

local title = {
	buffScore = 3,
	activityId = 1,
	buffId = 2,
	desc = 4
}
local dataList = {
	{
		485001,
		1,
		1,
		"敌阵所有精灵免疫1次攻击"
	},
	{
		485001,
		2,
		2,
		"敌阵精灵获得25%的免伤和非伤免伤"
	},
	{
		485001,
		3,
		3,
		"敌阵精灵攻击时，附带自身最大生命值15%的伤害"
	},
	{
		485001,
		4,
		4,
		"敌阵站位最靠前的1只精灵获得嘲讽，并获得33%的免伤和非伤免伤，持续2个回合"
	},
	{
		485001,
		5,
		5,
		"敌阵站位最靠前的1只精灵获得嘲讽，并获得66%的免伤和非伤免伤，持续2个回合"
	},
	{
		485001,
		6,
		6,
		"敌阵站位最靠前的1只精灵获得嘲讽，并获得99%的免伤和非伤免伤，持续2个回合"
	}
}
local t_divine_empress_extreme_clg_negative_buff = {
	[485001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_divine_empress_extreme_clg_negative_buff.dataList = dataList

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

return t_divine_empress_extreme_clg_negative_buff
