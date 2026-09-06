-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_tun_tian_extreme_clg_stage.lua

module("logicconfig.config.t_tun_tian_extreme_clg_stage", package.seeall)

local title = {
	stageId = 3,
	balanceType = 5,
	balancedConvertPlanId = 6,
	picturePath = 7,
	creepsMasterId = 4,
	stageType = 2,
	activityId = 1
}
local dataList = {
	{
		289001,
		1,
		1,
		1001,
		1,
		1,
		"ui/bigbg/pet/img_12007_liexin"
	},
	{
		289001,
		1,
		2,
		1002,
		1,
		1,
		"ui/bigbg/pet/img_17006_xiunuo"
	},
	{
		289001,
		1,
		3,
		1003,
		1,
		1,
		"ui/bigbg/pet/img_16013_yishi"
	},
	{
		289001,
		2,
		1,
		1101,
		2,
		2,
		"ui/bigbg/pet/img_14011_wangzheciyuanlong"
	},
	{
		289001,
		2,
		2,
		1102,
		2,
		2,
		"ui/bigbg/pet/img_12012_yuhui"
	},
	{
		289001,
		2,
		3,
		1103,
		2,
		2,
		"ui/bigbg/pet/img_16003_wangzhezhixu"
	},
	{
		289001,
		3,
		1,
		1201,
		3,
		3,
		"ui/bigbg/pet/img_10181_guangyidatianshi"
	},
	{
		289001,
		3,
		2,
		1202,
		3,
		3,
		"ui/bigbg/pet/img_15006_longzun"
	},
	{
		289001,
		3,
		3,
		1203,
		3,
		3,
		"ui/bigbg/pet/img_11012_teshamu"
	},
	{
		289001,
		4,
		1,
		1301,
		3,
		4,
		"ui/bigbg/pet/img_10144_aruisi"
	},
	{
		289001,
		4,
		2,
		1302,
		3,
		4,
		"ui/bigbg/pet/img_14014_shenyaoshengguangfeilong"
	},
	{
		289001,
		4,
		3,
		1303,
		3,
		4,
		"ui/bigbg/pet/img_11010_wangzhemengmeng"
	},
	{
		289002,
		1,
		1,
		1001,
		1,
		1,
		"ui/bigbg/pet/img_12007_liexin"
	},
	{
		289002,
		1,
		2,
		1002,
		1,
		1,
		"ui/bigbg/pet/img_17006_xiunuo"
	},
	{
		289002,
		1,
		3,
		1003,
		1,
		1,
		"ui/bigbg/pet/img_16013_yishi"
	},
	{
		289002,
		2,
		1,
		1101,
		2,
		2,
		"ui/bigbg/pet/img_14011_wangzheciyuanlong"
	},
	{
		289002,
		2,
		2,
		1102,
		2,
		2,
		"ui/bigbg/pet/img_12012_yuhui"
	},
	{
		289002,
		2,
		3,
		1103,
		2,
		2,
		"ui/bigbg/pet/img_16003_wangzhezhixu"
	},
	{
		289002,
		3,
		1,
		1201,
		3,
		3,
		"ui/bigbg/pet/img_10181_guangyidatianshi"
	},
	{
		289002,
		3,
		2,
		1202,
		3,
		3,
		"ui/bigbg/pet/img_15006_longzun"
	},
	{
		289002,
		3,
		3,
		1203,
		3,
		3,
		"ui/bigbg/pet/img_11012_teshamu"
	},
	{
		289002,
		4,
		1,
		1301,
		3,
		4,
		"ui/bigbg/pet/img_10144_aruisi"
	},
	{
		289002,
		4,
		2,
		1302,
		3,
		4,
		"ui/bigbg/pet/img_14014_shenyaoshengguangfeilong"
	},
	{
		289002,
		4,
		3,
		1303,
		3,
		4,
		"ui/bigbg/pet/img_11010_wangzhemengmeng"
	}
}
local t_tun_tian_extreme_clg_stage = {
	[289001] = {
		{
			dataList[1],
			dataList[2],
			dataList[3]
		},
		{
			dataList[4],
			dataList[5],
			dataList[6]
		},
		{
			dataList[7],
			dataList[8],
			dataList[9]
		},
		{
			dataList[10],
			dataList[11],
			dataList[12]
		}
	},
	[289002] = {
		{
			dataList[13],
			dataList[14],
			dataList[15]
		},
		{
			dataList[16],
			dataList[17],
			dataList[18]
		},
		{
			dataList[19],
			dataList[20],
			dataList[21]
		},
		{
			dataList[22],
			dataList[23],
			dataList[24]
		}
	}
}

t_tun_tian_extreme_clg_stage.dataList = dataList

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

return t_tun_tian_extreme_clg_stage
