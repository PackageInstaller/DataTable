-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_ashless_dragon_debuff.lua

module("logicconfig.config.t_origin_ashless_dragon_debuff", package.seeall)

local title = {
	name = 3,
	buffId = 5,
	risk = 2,
	activityId = 1,
	desc = 4
}
local dataList = {
	{
		564001,
		50,
		"进入战斗时，己阵战力最高的1只精灵获得虚无（1回合）",
		"进入战斗时，己阵战力最高的1只精灵获得虚无（1回合）",
		"3672:99"
	},
	{
		564001,
		100,
		"进入战斗时，己阵全属性-10%并令己阵战力最高的1只精灵获得虚无（1回合）",
		"进入战斗时，己阵全属性-10%并令己阵战力最高的1只精灵获得虚无（1回合）",
		"3672:99"
	},
	{
		564001,
		150,
		"进入战斗时，己阵全属性-20%并令己阵战力最高的2只精灵获得虚无（1回合）",
		"进入战斗时，己阵全属性-20%并令己阵战力最高的2只精灵获得虚无（1回合）",
		"3672:99"
	},
	{
		564001,
		200,
		"进入战斗时，己阵全属性-30%并令己阵战力最高的3只精灵获得虚无（1回合）",
		"进入战斗时，己阵全属性-30%并令己阵战力最高的3只精灵获得虚无（1回合）",
		"3672:99"
	},
	{
		564001,
		250,
		"进入战斗时，己阵全属性-50%并令己阵战力最高的3只精灵获得虚无（1回合）",
		"进入战斗时，己阵全属性-50%并令己阵战力最高的3只精灵获得虚无（1回合）",
		"3672:99"
	}
}
local t_origin_ashless_dragon_debuff = {
	[564001] = {
		[50] = dataList[1],
		[100] = dataList[2],
		[150] = dataList[3],
		[200] = dataList[4],
		[250] = dataList[5]
	}
}

t_origin_ashless_dragon_debuff.dataList = dataList

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

return t_origin_ashless_dragon_debuff
