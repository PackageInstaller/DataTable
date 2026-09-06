-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_mi_ya_clg_skill_buff.lua

module("logicconfig.config.t_divine_mi_ya_clg_skill_buff", package.seeall)

local title = {
	activityId = 1,
	icon = 4,
	skillUsedCount = 2,
	buffDesc = 3
}
local dataList = {
	{
		399001,
		1,
		"敌阵全属性+5%",
		"icon_expedition_bianyi02"
	},
	{
		399001,
		2,
		"敌阵全属性+10%",
		"icon_expedition_bianyi02"
	},
	{
		399001,
		3,
		"敌阵全属性+15%",
		"icon_expedition_bianyi02"
	},
	{
		399001,
		4,
		"敌阵全属性+20%",
		"icon_expedition_bianyi02"
	},
	{
		399001,
		5,
		"敌阵全属性+25%",
		"icon_expedition_bianyi02"
	},
	{
		399001,
		6,
		"敌阵全属性+30%",
		"icon_expedition_bianyi02"
	},
	{
		399001,
		7,
		"敌阵全属性+35%",
		"icon_expedition_bianyi02"
	},
	{
		399001,
		8,
		"敌阵全属性+40%",
		"icon_expedition_bianyi02"
	},
	{
		399001,
		9,
		"敌阵全属性+45%",
		"icon_expedition_bianyi02"
	},
	{
		399001,
		10,
		"敌阵全属性+50%",
		"icon_expedition_bianyi02"
	}
}
local t_divine_mi_ya_clg_skill_buff = {
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
		dataList[10]
	}
}

t_divine_mi_ya_clg_skill_buff.dataList = dataList

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

return t_divine_mi_ya_clg_skill_buff
