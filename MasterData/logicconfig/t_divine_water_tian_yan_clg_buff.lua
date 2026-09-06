-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_water_tian_yan_clg_buff.lua

module("logicconfig.config.t_divine_water_tian_yan_clg_buff", package.seeall)

local title = {
	iconRes = 5,
	buffId = 2,
	costFire = 3,
	activityId = 1,
	desc = 4
}
local dataList = {
	{
		513001,
		1,
		5,
		"己方全属性+10%",
		"ui/icon/expevents/icon_expedition_6huihezhongjie"
	},
	{
		513001,
		2,
		5,
		"己方全属性+30%",
		"ui/icon/expevents/icon_expedition_6huihezhongjie"
	},
	{
		513001,
		3,
		10,
		"己方全属性+50%",
		"ui/icon/expevents/icon_expedition_6huihezhongjie"
	},
	{
		513001,
		4,
		20,
		"己方全属性+100%",
		"ui/icon/expevents/icon_expedition_6huihezhongjie"
	},
	{
		513001,
		5,
		5,
		"敌方最大血量-5%",
		"ui/icon/expevents/icon_expedition_shayi01"
	},
	{
		513001,
		6,
		10,
		"敌方最大血量-8%",
		"ui/icon/expevents/icon_expedition_shayi01"
	},
	{
		513001,
		7,
		10,
		"敌方最大血量-10%",
		"ui/icon/expevents/icon_expedition_shayi01"
	},
	{
		513001,
		8,
		15,
		"敌方最大血量-12%",
		"ui/icon/expevents/icon_expedition_shayi01"
	}
}
local t_divine_water_tian_yan_clg_buff = {
	[513001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	}
}

t_divine_water_tian_yan_clg_buff.dataList = dataList

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

return t_divine_water_tian_yan_clg_buff
