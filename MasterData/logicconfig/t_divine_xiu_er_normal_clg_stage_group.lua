-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_xiu_er_normal_clg_stage_group.lua

module("logicconfig.config.t_divine_xiu_er_normal_clg_stage_group", package.seeall)

local title = {
	dataBitId = 3,
	creepsMasterId = 5,
	iconPath = 7,
	pos = 8,
	groupId = 2,
	stageType = 4,
	activityId = 1,
	desc = 6
}
local dataList = {
	{
		329001,
		1,
		1,
		1,
		101,
		"是之力：%s",
		"ui/icon/character/icon_16003_wangzhezhixu",
		{
			-456,
			56
		}
	},
	{
		329001,
		1,
		2,
		1,
		102,
		"是之力：%s",
		"ui/icon/character/icon_17006_xiunuo",
		{
			-558,
			-60
		}
	},
	{
		329001,
		1,
		3,
		1,
		103,
		"是之力：%s",
		"ui/icon/character/icon_14014_shenyaoshengguangfeilong",
		{
			-348,
			-60
		}
	},
	{
		329001,
		1,
		4,
		0,
		104,
		"非之力：%s",
		"ui/icon/character/icon_16013_yishi",
		{
			444,
			56
		}
	},
	{
		329001,
		1,
		5,
		0,
		105,
		"非之力：%s",
		"ui/icon/character/icon_13009_shenyaoaruisi",
		{
			353,
			-60
		}
	},
	{
		329001,
		1,
		6,
		0,
		106,
		"非之力：%s",
		"ui/icon/character/icon_11010_wangzhemengmeng",
		{
			555,
			-60
		}
	},
	{
		329001,
		2,
		1,
		1,
		107,
		"是之力：%s",
		"ui/icon/character/icon_16003_wangzhezhixu",
		{
			-456,
			56
		}
	},
	{
		329001,
		2,
		2,
		1,
		108,
		"是之力：%s",
		"ui/icon/character/icon_17006_xiunuo",
		{
			-558,
			-60
		}
	},
	{
		329001,
		2,
		3,
		1,
		109,
		"是之力：%s",
		"ui/icon/character/icon_14014_shenyaoshengguangfeilong",
		{
			-348,
			-60
		}
	},
	{
		329001,
		2,
		4,
		0,
		110,
		"非之力：%s",
		"ui/icon/character/icon_16013_yishi",
		{
			444,
			56
		}
	},
	{
		329001,
		2,
		5,
		0,
		111,
		"非之力：%s",
		"ui/icon/character/icon_13009_shenyaoaruisi",
		{
			353,
			-60
		}
	},
	{
		329001,
		2,
		6,
		0,
		112,
		"非之力：%s",
		"ui/icon/character/icon_11010_wangzhemengmeng",
		{
			555,
			-60
		}
	},
	{
		329001,
		3,
		1,
		1,
		113,
		"是之力：%s",
		"ui/icon/character/icon_16003_wangzhezhixu",
		{
			-456,
			56
		}
	},
	{
		329001,
		3,
		2,
		1,
		114,
		"是之力：%s",
		"ui/icon/character/icon_17006_xiunuo",
		{
			-558,
			-60
		}
	},
	{
		329001,
		3,
		3,
		1,
		115,
		"是之力：%s",
		"ui/icon/character/icon_14014_shenyaoshengguangfeilong",
		{
			-348,
			-60
		}
	},
	{
		329001,
		3,
		4,
		0,
		116,
		"非之力：%s",
		"ui/icon/character/icon_16013_yishi",
		{
			444,
			56
		}
	},
	{
		329001,
		3,
		5,
		0,
		117,
		"非之力：%s",
		"ui/icon/character/icon_13009_shenyaoaruisi",
		{
			353,
			-60
		}
	},
	{
		329001,
		3,
		6,
		0,
		118,
		"非之力：%s",
		"ui/icon/character/icon_11010_wangzhemengmeng",
		{
			555,
			-60
		}
	}
}
local t_divine_xiu_er_normal_clg_stage_group = {
	[329001] = {
		{
			dataList[1],
			dataList[2],
			dataList[3],
			dataList[4],
			dataList[5],
			dataList[6]
		},
		{
			dataList[7],
			dataList[8],
			dataList[9],
			dataList[10],
			dataList[11],
			dataList[12]
		},
		{
			dataList[13],
			dataList[14],
			dataList[15],
			dataList[16],
			dataList[17],
			dataList[18]
		}
	}
}

t_divine_xiu_er_normal_clg_stage_group.dataList = dataList

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

return t_divine_xiu_er_normal_clg_stage_group
