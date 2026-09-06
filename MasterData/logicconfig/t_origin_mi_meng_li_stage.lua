-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_mi_meng_li_stage.lua

module("logicconfig.config.t_origin_mi_meng_li_stage", package.seeall)

local title = {
	stageId = 2,
	passCount = 6,
	fmtTipsDesc = 7,
	creepsMasterId = 3,
	DreamPosIds = 4,
	activityId = 1,
	MemoryPosIds = 5
}
local dataList = {
	{
		621001,
		1,
		1001,
		{
			4
		},
		{
			2,
			5
		},
		1,
		"金色光圈为梦境（超杀），紫色光圈为记忆（复活），需两者数值相等且 ≥1"
	},
	{
		621001,
		2,
		1002,
		{
			1
		},
		{
			4,
			5
		},
		1,
		"金色光圈为梦境（超杀），紫色光圈为记忆（复活），需两者数值相等且 ≥1"
	},
	{
		621001,
		3,
		1003,
		{
			8
		},
		{
			1,
			3
		},
		2,
		"金色光圈为梦境（超杀），紫色光圈为记忆（复活），需两者数值相等且 ≥2"
	},
	{
		621001,
		4,
		1004,
		{
			4,
			6
		},
		{
			2,
			5,
			7
		},
		2,
		"金色光圈为梦境（超杀），紫色光圈为记忆（复活），需两者数值相等且 ≥2"
	},
	{
		621001,
		5,
		1005,
		{
			1,
			8
		},
		{
			4,
			5,
			6
		},
		3,
		"金色光圈为梦境（超杀），紫色光圈为记忆（复活），需两者数值相等且 ≥3"
	},
	{
		621001,
		6,
		1006,
		{
			6,
			7
		},
		{
			1,
			3,
			4
		},
		4,
		"金色光圈为梦境（超杀），紫色光圈为记忆（复活），需两者数值相等且 ≥4"
	},
	{
		621001,
		7,
		1007,
		{
			5,
			8
		},
		{
			2,
			4,
			6
		},
		5,
		"金色光圈为梦境（超杀），紫色光圈为记忆（复活），需两者数值相等且 ≥5"
	},
	{
		621001,
		8,
		1008,
		{
			2,
			3
		},
		{
			1,
			4,
			5
		},
		6,
		"金色光圈为梦境（超杀），紫色光圈为记忆（复活），需两者数值相等且 ≥6"
	},
	{
		621001,
		9,
		1009,
		{
			7,
			9
		},
		{
			1,
			3,
			5
		},
		8,
		"金色光圈为梦境（超杀），紫色光圈为记忆（复活），需两者数值相等且 ≥8"
	}
}
local t_origin_mi_meng_li_stage = {
	[621001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9]
	}
}

t_origin_mi_meng_li_stage.dataList = dataList

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

return t_origin_mi_meng_li_stage
