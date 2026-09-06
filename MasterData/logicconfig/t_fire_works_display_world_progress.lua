-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_fire_works_display_world_progress.lua

module("logicconfig.config.t_fire_works_display_world_progress", package.seeall)

local title = {
	id = 2,
	worldProgressPlanId = 1,
	name = 3,
	progressPlanId = 4
}
local dataList = {
	{
		1,
		1,
		"战力暴涨",
		1
	},
	{
		1,
		2,
		"欧皇降临",
		2
	},
	{
		1,
		3,
		"水逆退散",
		3
	},
	{
		1,
		4,
		"一夜暴富",
		4
	},
	{
		1,
		5,
		"考神附体",
		5
	},
	{
		2,
		1,
		"战力暴涨",
		6
	},
	{
		2,
		2,
		"欧皇降临",
		7
	},
	{
		2,
		3,
		"水逆退散",
		8
	},
	{
		2,
		4,
		"一夜暴富",
		9
	},
	{
		2,
		5,
		"考神附体",
		10
	},
	{
		3,
		1,
		"战力暴涨",
		6
	},
	{
		3,
		2,
		"欧皇降临",
		7
	},
	{
		3,
		3,
		"水逆退散",
		8
	},
	{
		3,
		4,
		"一夜暴富",
		9
	},
	{
		3,
		5,
		"考神附体",
		10
	},
	{
		4,
		1,
		"战力暴涨",
		6
	},
	{
		4,
		2,
		"欧皇降临",
		7
	},
	{
		4,
		3,
		"水逆退散",
		8
	},
	{
		4,
		4,
		"一夜暴富",
		9
	},
	{
		4,
		5,
		"考神附体",
		10
	},
	{
		5,
		1,
		"战力暴涨",
		6
	},
	{
		5,
		2,
		"欧皇降临",
		7
	},
	{
		5,
		3,
		"水逆退散",
		8
	},
	{
		5,
		4,
		"一夜暴富",
		9
	},
	{
		5,
		5,
		"考神附体",
		10
	}
}
local t_fire_works_display_world_progress = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	},
	{
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	},
	{
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15]
	},
	{
		dataList[16],
		dataList[17],
		dataList[18],
		dataList[19],
		dataList[20]
	},
	{
		dataList[21],
		dataList[22],
		dataList[23],
		dataList[24],
		dataList[25]
	}
}

t_fire_works_display_world_progress.dataList = dataList

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

return t_fire_works_display_world_progress
