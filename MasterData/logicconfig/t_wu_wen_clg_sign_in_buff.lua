-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_wu_wen_clg_sign_in_buff.lua

module("logicconfig.config.t_wu_wen_clg_sign_in_buff", package.seeall)

local title = {
	desc = 3,
	iconPath = 4,
	activityId = 1,
	level = 2
}
local dataList = {
	{
		374002,
		1,
		"全属性\n+10%",
		"expevents/icon_expedition_xieli01"
	},
	{
		374002,
		2,
		"全属性\n+30%",
		"expevents/icon_expedition_xieli01"
	},
	{
		374002,
		3,
		"全属性\n+50%",
		"expevents/icon_expedition_xieli01"
	},
	{
		374002,
		4,
		"全属性\n+150%",
		"expevents/icon_expedition_xieli01"
	},
	{
		374002,
		5,
		"全属性\n+300%",
		"expevents/icon_expedition_xieli01"
	},
	{
		374002,
		6,
		"全属性\n+500%",
		"expevents/icon_expedition_xieli01"
	},
	{
		374002,
		7,
		"全属性\n+800%",
		"expevents/icon_expedition_xieli01"
	},
	{
		374002,
		8,
		"全属性\n+1200%",
		"expevents/icon_expedition_xieli01"
	},
	{
		374003,
		1,
		"全属性\n+10%",
		"expevents/icon_expedition_xieli01"
	},
	{
		374003,
		2,
		"全属性\n+30%",
		"expevents/icon_expedition_xieli01"
	},
	{
		374003,
		3,
		"全属性\n+50%",
		"expevents/icon_expedition_xieli01"
	},
	{
		374003,
		4,
		"全属性\n+150%",
		"expevents/icon_expedition_xieli01"
	},
	{
		374003,
		5,
		"全属性\n+300%",
		"expevents/icon_expedition_xieli01"
	},
	{
		374003,
		6,
		"全属性\n+500%",
		"expevents/icon_expedition_xieli01"
	},
	{
		374003,
		7,
		"全属性\n+800%",
		"expevents/icon_expedition_xieli01"
	},
	{
		374003,
		8,
		"全属性\n+1200%",
		"expevents/icon_expedition_xieli01"
	}
}
local t_wu_wen_clg_sign_in_buff = {
	[374002] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	},
	[374003] = {
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16]
	}
}

t_wu_wen_clg_sign_in_buff.dataList = dataList

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

return t_wu_wen_clg_sign_in_buff
