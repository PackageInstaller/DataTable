-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_summer_holidays_check_in.lua

module("logicconfig.config.t_summer_holidays_check_in", package.seeall)

local title = {
	activityType = 2,
	Locationusage = 5,
	redPointId = 3,
	bg = 6,
	dailyCheckInLimit = 4,
	activityId = 1
}
local dataList = {
	{
		283001,
		283,
		492,
		1,
		0,
		""
	},
	{
		283002,
		283,
		492,
		1,
		0,
		""
	},
	{
		283003,
		283,
		492,
		1,
		0,
		""
	},
	{
		283004,
		283,
		492,
		1,
		0,
		""
	},
	{
		283005,
		283,
		492,
		1,
		0,
		""
	},
	{
		283006,
		283,
		492,
		1,
		0,
		""
	},
	{
		283007,
		283,
		492,
		1,
		1,
		""
	},
	{
		283008,
		283,
		492,
		1,
		0,
		""
	},
	{
		283009,
		283,
		492,
		1,
		0,
		""
	},
	{
		283010,
		283,
		492,
		1,
		1,
		""
	},
	{
		283011,
		283,
		492,
		1,
		0,
		""
	},
	{
		283012,
		283,
		492,
		1,
		0,
		""
	},
	{
		283013,
		283,
		492,
		1,
		0,
		""
	},
	{
		283014,
		283,
		492,
		1,
		0,
		"bg_qd_sqkbfl_symy"
	},
	{
		283015,
		283,
		492,
		1,
		0,
		"bg_kuaniandengluli_wujinshennv_01"
	},
	{
		283016,
		283,
		492,
		1,
		0,
		"bg_kuaniandengluli_nimengli_01"
	},
	{
		283017,
		283,
		492,
		1,
		0,
		"bg_kuaniandengluli_jinlongzun_01"
	},
	{
		283018,
		283,
		492,
		1,
		0,
		"bg_kuaniandengluli_luoshiqi_01"
	},
	{
		283019,
		283,
		492,
		1,
		0,
		"bg_kuaniandengluli_liansongxuyan"
	},
	{
		283020,
		283,
		492,
		1,
		0,
		"bg_kuaniandengluli_lingkongshennv_01"
	},
	{
		283021,
		283,
		492,
		1,
		0,
		"bg_kuaniandengluli_shizushennv_01"
	},
	{
		283022,
		283,
		492,
		1,
		0,
		"bg_kuaniandengluli_aojiu_01"
	},
	{
		283023,
		283,
		492,
		1,
		0,
		"bg_kuaniandengluli_xiwangshennv_01"
	},
	{
		283024,
		283,
		492,
		1,
		0,
		"bg_qd_nanguajie"
	},
	{
		283025,
		283,
		492,
		1,
		0,
		"bg_qd_yuanqishidaidenglu_01"
	},
	{
		283026,
		283,
		492,
		1,
		0,
		"bg_qd_shuangdankuanghuandenglu"
	},
	{
		283027,
		283,
		492,
		1,
		0,
		"bg_qd_xianshikuanghuandll"
	},
	{
		283028,
		283,
		492,
		1,
		0,
		"bg_qd_26xinchunkuanghuan"
	},
	{
		283029,
		283,
		492,
		1,
		1,
		"bg_qd_nvshenkh"
	},
	{
		283030,
		283,
		492,
		1,
		0,
		"bg_qd_zhouniankuanghuan"
	},
	{
		283031,
		283,
		492,
		1,
		0,
		"bg_qd_yqsklsn"
	},
	{
		283032,
		283,
		492,
		1,
		0,
		"bg_kuaniandengluli_yqwangzhemengmeng"
	},
	{
		283033,
		283,
		492,
		1,
		0,
		"bg_qd_yqsslnp"
	}
}
local t_summer_holidays_check_in = {
	[283001] = dataList[1],
	[283002] = dataList[2],
	[283003] = dataList[3],
	[283004] = dataList[4],
	[283005] = dataList[5],
	[283006] = dataList[6],
	[283007] = dataList[7],
	[283008] = dataList[8],
	[283009] = dataList[9],
	[283010] = dataList[10],
	[283011] = dataList[11],
	[283012] = dataList[12],
	[283013] = dataList[13],
	[283014] = dataList[14],
	[283015] = dataList[15],
	[283016] = dataList[16],
	[283017] = dataList[17],
	[283018] = dataList[18],
	[283019] = dataList[19],
	[283020] = dataList[20],
	[283021] = dataList[21],
	[283022] = dataList[22],
	[283023] = dataList[23],
	[283024] = dataList[24],
	[283025] = dataList[25],
	[283026] = dataList[26],
	[283027] = dataList[27],
	[283028] = dataList[28],
	[283029] = dataList[29],
	[283030] = dataList[30],
	[283031] = dataList[31],
	[283032] = dataList[32],
	[283033] = dataList[33]
}

t_summer_holidays_check_in.dataList = dataList

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

return t_summer_holidays_check_in
