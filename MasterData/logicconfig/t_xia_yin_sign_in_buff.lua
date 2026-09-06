-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_xia_yin_sign_in_buff.lua

module("logicconfig.config.t_xia_yin_sign_in_buff", package.seeall)

local title = {
	desc = 3,
	iconPath = 4,
	signInPlanId = 1,
	level = 2
}
local dataList = {
	{
		1,
		1,
		"全属性\n+10%",
		"expevents/icon_expedition_xieli01"
	},
	{
		1,
		2,
		"全属性\n+30%",
		"expevents/icon_expedition_xieli01"
	},
	{
		1,
		3,
		"全属性\n+80%",
		"expevents/icon_expedition_xieli01"
	},
	{
		1,
		4,
		"全属性\n+200%",
		"expevents/icon_expedition_xieli01"
	},
	{
		1,
		5,
		"全属性\n+400%",
		"expevents/icon_expedition_xieli01"
	},
	{
		1,
		6,
		"全属性\n+600%",
		"expevents/icon_expedition_xieli01"
	},
	{
		1,
		7,
		"全属性\n+1000%",
		"expevents/icon_expedition_xieli01"
	},
	{
		1,
		8,
		"全属性\n+1500%",
		"expevents/icon_expedition_xieli01"
	}
}
local t_xia_yin_sign_in_buff = {
	{
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

t_xia_yin_sign_in_buff.dataList = dataList

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

return t_xia_yin_sign_in_buff
