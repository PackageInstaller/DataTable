-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_wu_di_extreme_clg_stage.lua

module("logicconfig.config.t_wu_di_extreme_clg_stage", package.seeall)

local title = {
	stageId = 2,
	iconPath = 5,
	groupAttackCount = 4,
	pos = 6,
	creepsMasterId = 3,
	activityId = 1
}
local dataList = {
	{
		317001,
		1,
		1001,
		3,
		"ui/icon/character/icon_16003_wangzhezhixu",
		{
			-191,
			230
		}
	},
	{
		317001,
		2,
		1002,
		3,
		"ui/icon/character/icon_17006_xiunuo",
		{
			-17,
			127
		}
	},
	{
		317001,
		3,
		1003,
		3,
		"ui/icon/character/icon_14014_shenyaoshengguangfeilong",
		{
			115,
			-18
		}
	},
	{
		317001,
		4,
		1004,
		4,
		"ui/icon/character/icon_16013_yishi",
		{
			-2,
			-178
		}
	},
	{
		317001,
		5,
		1005,
		4,
		"ui/icon/character/icon_13009_shenyaoaruisi",
		{
			-191,
			-257
		}
	},
	{
		317001,
		6,
		1006,
		4,
		"ui/icon/character/icon_11010_wangzhemengmeng",
		{
			-360,
			-178
		}
	},
	{
		317001,
		7,
		1007,
		5,
		"ui/icon/character/icon_12012_yuhui",
		{
			-490,
			-18
		}
	},
	{
		317001,
		8,
		1008,
		5,
		"ui/icon/character/icon_11012_teshamu",
		{
			-360,
			128
		}
	},
	{
		317001,
		9,
		1009,
		5,
		"ui/icon/character/icon_17010_wangzheji",
		{
			-186,
			-13
		}
	},
	{
		317002,
		1,
		1001,
		3,
		"ui/icon/character/icon_16003_wangzhezhixu",
		{
			-191,
			230
		}
	},
	{
		317002,
		2,
		1002,
		3,
		"ui/icon/character/icon_17006_xiunuo",
		{
			-17,
			127
		}
	},
	{
		317002,
		3,
		1003,
		3,
		"ui/icon/character/icon_14014_shenyaoshengguangfeilong",
		{
			115,
			-18
		}
	},
	{
		317002,
		4,
		1004,
		4,
		"ui/icon/character/icon_16013_yishi",
		{
			-2,
			-178
		}
	},
	{
		317002,
		5,
		1005,
		4,
		"ui/icon/character/icon_13009_shenyaoaruisi",
		{
			-191,
			-257
		}
	},
	{
		317002,
		6,
		1006,
		4,
		"ui/icon/character/icon_11010_wangzhemengmeng",
		{
			-360,
			-178
		}
	},
	{
		317002,
		7,
		1007,
		5,
		"ui/icon/character/icon_12012_yuhui",
		{
			-490,
			-18
		}
	},
	{
		317002,
		8,
		1008,
		5,
		"ui/icon/character/icon_11012_teshamu",
		{
			-360,
			128
		}
	},
	{
		317002,
		9,
		1009,
		5,
		"ui/icon/character/icon_17010_wangzheji",
		{
			-186,
			-13
		}
	}
}
local t_wu_di_extreme_clg_stage = {
	[317001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9]
	},
	[317002] = {
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16],
		dataList[17],
		dataList[18]
	}
}

t_wu_di_extreme_clg_stage.dataList = dataList

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

return t_wu_di_extreme_clg_stage
