-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_empress_extreme_clg_positive_buff.lua

module("logicconfig.config.t_divine_empress_extreme_clg_positive_buff", package.seeall)

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
		"己阵精灵全属性+50%"
	},
	{
		485001,
		2,
		2,
		"己阵每次免疫时，令战斗力最高且气势未满的精灵获得25气势"
	},
	{
		485001,
		3,
		3,
		"己阵精灵获得10%的免伤"
	},
	{
		485001,
		4,
		4,
		"攻击时，附带自身最大生命值15%的伤害"
	},
	{
		485001,
		5,
		5,
		"站位最靠前的精灵免疫1次攻击"
	},
	{
		485001,
		6,
		6,
		"站位最靠前的精灵获得嘲讽效果，持续2个回合"
	}
}
local t_divine_empress_extreme_clg_positive_buff = {
	[485001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_divine_empress_extreme_clg_positive_buff.dataList = dataList

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

return t_divine_empress_extreme_clg_positive_buff
