-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pet_manual_team.lua

module("logicconfig.config.t_pet_manual_team", package.seeall)

local title = {
	enterPoster = 6,
	btnIcon = 5,
	needRaceIds = 9,
	teamName = 2,
	prize = 10,
	enterTab = 3,
	enterId = 4,
	teamId = 1,
	posterLogo = 8,
	posterBg = 7
}
local dataList = {
	{
		1,
		"英雄之旅",
		1,
		1,
		"btn_yingxiongzhilv",
		"board_jltd01",
		"tj_yxzl_bg",
		"",
		{
			10084,
			10086,
			10082,
			10083,
			10085
		},
		"104:2:50"
	},
	{
		5,
		"专属女仆",
		1,
		5,
		"btn_zhuanshunvpu",
		"board_jltd05",
		"tj_zsnp_bg",
		"",
		{
			10167,
			10308,
			10309,
			10322,
			10323
		},
		"104:2:50"
	},
	{
		7,
		"红炎",
		2,
		1,
		"btn_hongyan",
		"board_jltd07",
		"tj_hy_bg",
		"",
		{
			10082,
			10143,
			10204,
			10309,
			10337
		},
		"104:2:50"
	},
	{
		8,
		"五王羁绊",
		2,
		2,
		"btn_wuwangjiban",
		"board_jltd08",
		"tj_wwjb_bg",
		"",
		{
			10142,
			10143,
			10144,
			10145,
			10146
		},
		"104:2:50"
	},
	{
		9,
		"暗之试炼",
		2,
		3,
		"btn_anzhishilian",
		"board_jltd09",
		"tj_azsl_bg",
		"",
		{
			10348,
			10035,
			10037,
			10072,
			10020,
			10319,
			10086,
			10205,
			10131,
			10179
		},
		"104:2:50"
	},
	{
		10,
		"火之试炼",
		2,
		4,
		"btn_huozhishilian",
		"board_jltd12",
		"tj_hzsl_bg",
		"tj_hzsl_tuanming",
		{
			10005,
			10018,
			10031,
			10036,
			10082,
			10169,
			10177,
			10204,
			10337,
			10360
		},
		"104:2:50"
	},
	{
		11,
		"草之试炼",
		2,
		5,
		"btn_caozhishilian",
		"board_jltd11",
		"tj_czsl_bg",
		"tj_czsl_tuanming",
		{
			10006,
			10016,
			10030,
			10034,
			10083,
			10129,
			10159,
			10202,
			10318,
			10347
		},
		"104:2:50"
	},
	{
		12,
		"水之试炼",
		2,
		6,
		"btn_shuizhishilian",
		"board_jltd10",
		"tj_szsl_bg",
		"tj_szsl_tuanming",
		{
			10004,
			10017,
			10032,
			10033,
			10084,
			10127,
			10175,
			10203,
			10317,
			10333,
			10335
		},
		"104:2:50"
	},
	{
		14,
		"龙魂",
		3,
		1,
		"btn_longhuen",
		"board_jltd13",
		"tj_lh_bg",
		"",
		{
			10027,
			10127,
			10313,
			10324,
			10326
		},
		"104:2:50"
	},
	{
		13,
		"光之试炼",
		3,
		2,
		"btn_guangzhishilian",
		"board_jltd14",
		"tj_gzsl_bg",
		"tj_gzsl_tuanming",
		{
			10048,
			10085,
			10130,
			10172,
			10206,
			10346,
			10349
		},
		"104:2:50"
	},
	{
		15,
		"女神联盟",
		3,
		3,
		"btn_nvshenlianmeng",
		"board_jltd15",
		"tj_nslm_bg",
		"",
		{
			10327,
			10328,
			10329,
			10316,
			10345,
			10352
		},
		"104:2:50"
	}
}
local t_pet_manual_team = {
	dataList[1],
	[5] = dataList[2],
	[7] = dataList[3],
	[8] = dataList[4],
	[9] = dataList[5],
	[10] = dataList[6],
	[11] = dataList[7],
	[12] = dataList[8],
	[14] = dataList[9],
	[13] = dataList[10],
	[15] = dataList[11]
}

t_pet_manual_team.dataList = dataList

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

return t_pet_manual_team
