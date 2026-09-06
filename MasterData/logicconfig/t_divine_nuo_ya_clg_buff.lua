-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_nuo_ya_clg_buff.lua

module("logicconfig.config.t_divine_nuo_ya_clg_buff", package.seeall)

local title = {
	des = 3,
	buffIcon = 4,
	activityId = 1,
	level = 2
}
local dataList = {
	{
		316001,
		1,
		"己方精灵全属性+10%",
		"icon_expedition_ydnzhufu"
	},
	{
		316001,
		2,
		"己方精灵全属性+30%",
		"icon_expedition_ydnzhufu"
	},
	{
		316001,
		3,
		"己方精灵全属性+50%",
		"icon_expedition_ydnzhufu"
	},
	{
		316001,
		4,
		"己方精灵全属性+70%",
		"icon_expedition_ydnzhufu"
	},
	{
		316001,
		5,
		"己方精灵全属性+90%",
		"icon_expedition_ydnzhufu"
	},
	{
		316001,
		6,
		"己方精灵全属性+120%",
		"icon_expedition_ydnzhufu"
	},
	{
		316001,
		7,
		"己方精灵全属性+150%",
		"icon_expedition_ydnzhufu"
	},
	{
		316001,
		8,
		"己方精灵全属性+200%",
		"icon_expedition_ydnzhufu"
	},
	{
		316001,
		9,
		"己方精灵全属性+250%",
		"icon_expedition_ydnzhufu"
	},
	{
		316001,
		10,
		"己方精灵全属性+300%",
		"icon_expedition_ydnzhufu"
	},
	{
		316001,
		11,
		"己方精灵全属性+400%",
		"icon_expedition_ydnzhufu"
	},
	{
		316001,
		12,
		"己方精灵全属性+525%",
		"icon_expedition_ydnzhufu"
	},
	{
		316001,
		13,
		"己方精灵全属性+650%",
		"icon_expedition_ydnzhufu"
	},
	{
		316001,
		14,
		"己方精灵全属性+800%",
		"icon_expedition_ydnzhufu"
	}
}
local t_divine_nuo_ya_clg_buff = {
	[316001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14]
	}
}

t_divine_nuo_ya_clg_buff.dataList = dataList

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

return t_divine_nuo_ya_clg_buff
