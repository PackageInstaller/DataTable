-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_activitysetview.lua

module("logicconfig.config.t_activitysetview", package.seeall)

local title = {
	unselectIcon = 9,
	reportBehavior = 10,
	selectedIcon = 8,
	tagColor = 4,
	redpointId = 7,
	title = 2,
	parameter = 11,
	viewname = 5,
	funcId = 6,
	id = 1,
	tagName = 3
}
local dataList = {
	{
		1,
		"通行证",
		"新活动",
		2,
		"passportwpview",
		113,
		"51",
		"btn_flzx12_pre",
		"btn_flzx12_nor",
		0,
		""
	},
	{
		2,
		"飞龙挑战",
		"",
		0,
		"holyentrance",
		181,
		"75",
		"btn_flzx10_pre",
		"btn_flzx10_nor",
		0,
		""
	},
	{
		3,
		"飞龙完美觉醒",
		"",
		0,
		"excellentclass",
		108,
		"42",
		"btn_flzx01_pre",
		"btn_flzx01_nor",
		200236,
		""
	},
	{
		4,
		"明星战队计划",
		"",
		0,
		"starteamview",
		107,
		"41",
		"btn_flzx02_pre",
		"btn_flzx02_nor",
		200237,
		""
	},
	{
		5,
		"光轮夺宝",
		"",
		0,
		"jackpotview",
		109,
		"-18",
		"",
		"",
		20235,
		""
	},
	{
		6,
		"遗迹通行证",
		"",
		0,
		"passportyzview",
		114,
		"52",
		"btn_flzx12_pre",
		"btn_flzx12_nor",
		0,
		""
	},
	{
		7,
		"勇者战令",
		"热门",
		2,
		"passportshowview",
		115,
		"53",
		"btn_flzx12_pre",
		"btn_flzx12_nor",
		0,
		"3"
	},
	{
		8,
		"冒险战令",
		"",
		0,
		"passportshowview1",
		116,
		"54",
		"btn_flzx11_pre",
		"btn_flzx11_nor",
		0,
		"4"
	},
	{
		9,
		"招财诺",
		"",
		0,
		"solicitwealthview",
		232,
		"92",
		"btn_flzx10_pre",
		"btn_flzx10_nor",
		0,
		""
	},
	{
		10,
		"投资返利",
		"热门",
		2,
		"passportdatesignview",
		416,
		"175",
		"btn_flzx12_pre",
		"btn_flzx12_nor",
		0,
		"5"
	}
}
local t_activitysetview = {
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

t_activitysetview.dataList = dataList

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

return t_activitysetview
