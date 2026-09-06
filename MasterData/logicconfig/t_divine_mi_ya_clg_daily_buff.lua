-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_mi_ya_clg_daily_buff.lua

module("logicconfig.config.t_divine_mi_ya_clg_daily_buff", package.seeall)

local title = {
	buffLvl = 2,
	icon = 4,
	activityId = 1,
	buffDesc = 3
}
local dataList = {
	{
		399001,
		1,
		"己阵全属性+10%",
		"icon_expedition_ydnzhufu"
	},
	{
		399001,
		2,
		"己阵全属性+20%",
		"icon_expedition_ydnzhufu"
	},
	{
		399001,
		3,
		"己阵全属性+30%",
		"icon_expedition_ydnzhufu"
	},
	{
		399001,
		4,
		"己阵全属性+50%",
		"icon_expedition_ydnzhufu"
	},
	{
		399001,
		5,
		"己阵全属性+100%",
		"icon_expedition_ydnzhufu"
	},
	{
		399001,
		6,
		"己阵全属性+300%",
		"icon_expedition_ydnzhufu"
	},
	{
		399001,
		7,
		"己阵全属性+500%",
		"icon_expedition_ydnzhufu"
	},
	{
		399001,
		8,
		"己阵全属性+600%",
		"icon_expedition_ydnzhufu"
	},
	{
		399001,
		9,
		"己阵全属性+700%",
		"icon_expedition_ydnzhufu"
	},
	{
		399001,
		10,
		"己阵全属性+800%",
		"icon_expedition_ydnzhufu"
	},
	{
		399001,
		11,
		"己阵全属性+1000%",
		"icon_expedition_ydnzhufu"
	},
	{
		399001,
		12,
		"己阵全属性+1500%",
		"icon_expedition_ydnzhufu"
	}
}
local t_divine_mi_ya_clg_daily_buff = {
	[399001] = {
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
		dataList[12]
	}
}

t_divine_mi_ya_clg_daily_buff.dataList = dataList

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

return t_divine_mi_ya_clg_daily_buff
