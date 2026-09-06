-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_xia_yin_tier.lua

module("logicconfig.config.t_xia_yin_tier", package.seeall)

local title = {
	stageDesc = 5,
	name = 4,
	activityId = 1,
	stages = 3,
	tierId = 2
}
local dataList = {
	{
		336001,
		1,
		{
			1001,
			1002,
			1003,
			1004,
			1005
		},
		"第一层",
		"击杀敌阵带标记的精灵即可获得该标记，后续对敌阵中<color=#96fa73>相同标记</color>的精灵<color=#96fa73>正常造成伤害</color>，对<color=#96fa73>不同标记</color>精灵造成的<color=#96fa73>伤害会降低50%</color>"
	},
	{
		336001,
		2,
		{
			1006,
			1007,
			1008,
			1009,
			1010
		},
		"第二层",
		"击杀敌阵带标记的精灵即可获得该标记，后续对敌阵中<color=#96fa73>相同标记</color>的精灵<color=#96fa73>正常造成伤害</color>，对<color=#96fa73>不同标记</color>精灵造成伤害时<color=#96fa73>伤害降为0</color>"
	},
	{
		336001,
		3,
		{
			1011,
			1012,
			1013,
			1014,
			1015
		},
		"第三层",
		"击杀敌阵带标记的精灵即可获得该标记，后续对敌阵中<color=#96fa73>相同标记</color>的精灵<color=#96fa73>正常造成伤害</color>，对<color=#96fa73>不同标记</color>精灵造成伤害时，<color=#96fa73>先反弹50%伤害并且敌阵精灵伤害降为0</color>"
	},
	{
		336002,
		1,
		{
			2001,
			2002,
			2003,
			2004,
			2005
		},
		"第一层",
		"击杀敌阵带标记的精灵即可获得该标记，后续对敌阵中<color=#96fa73>相同标记</color>的精灵<color=#96fa73>正常造成伤害</color>，对<color=#96fa73>不同标记</color>精灵造成的<color=#96fa73>伤害会降低50%</color>"
	},
	{
		336002,
		2,
		{
			2006,
			2007,
			2008,
			2009,
			2010
		},
		"第二层",
		"击杀敌阵带标记的精灵即可获得该标记，后续对敌阵中<color=#96fa73>相同标记</color>的精灵<color=#96fa73>正常造成伤害</color>，对<color=#96fa73>不同标记</color>精灵造成伤害时<color=#96fa73>伤害降为0</color>"
	},
	{
		336002,
		3,
		{
			2011,
			2012,
			2013,
			2014,
			2015
		},
		"第三层",
		"击杀敌阵带标记的精灵即可获得该标记，后续对敌阵中<color=#96fa73>相同标记</color>的精灵<color=#96fa73>正常造成伤害</color>，对<color=#96fa73>不同标记</color>精灵造成伤害时，<color=#96fa73>先反弹50%伤害并且敌阵精灵伤害降为0</color>"
	},
	{
		336003,
		1,
		{
			1001,
			1002,
			1003,
			1004,
			1005
		},
		"第一层",
		"击杀敌阵带标记的精灵即可获得该标记，后续对敌阵中<color=#96fa73>相同标记</color>的精灵<color=#96fa73>正常造成伤害</color>，对<color=#96fa73>不同标记</color>精灵造成的<color=#96fa73>伤害会降低50%</color>"
	},
	{
		336003,
		2,
		{
			1006,
			1007,
			1008,
			1009,
			1010
		},
		"第二层",
		"击杀敌阵带标记的精灵即可获得该标记，后续对敌阵中<color=#96fa73>相同标记</color>的精灵<color=#96fa73>正常造成伤害</color>，对<color=#96fa73>不同标记</color>精灵造成伤害时<color=#96fa73>伤害降为0</color>"
	},
	{
		336003,
		3,
		{
			1011,
			1012,
			1013,
			1014,
			1015
		},
		"第三层",
		"击杀敌阵带标记的精灵即可获得该标记，后续对敌阵中<color=#96fa73>相同标记</color>的精灵<color=#96fa73>正常造成伤害</color>，对<color=#96fa73>不同标记</color>精灵造成伤害时，<color=#96fa73>先反弹50%伤害并且敌阵精灵伤害降为0</color>"
	}
}
local t_xia_yin_tier = {
	[336001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	},
	[336002] = {
		dataList[4],
		dataList[5],
		dataList[6]
	},
	[336003] = {
		dataList[7],
		dataList[8],
		dataList[9]
	}
}

t_xia_yin_tier.dataList = dataList

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

return t_xia_yin_tier
