-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_xiao_nuo_summary_artifact.lua

module("logicconfig.config.t_xiao_nuo_summary_artifact", package.seeall)

local title = {
	items = 7,
	titleBg = 6,
	raceId = 2,
	txtJump = 8,
	jumpTo = 9,
	infoPos = 3,
	imgBg = 5,
	id = 1,
	startTime = 4
}
local dataList = {
	{
		1,
		{
			14008,
			11007
		},
		"-425,-90#75,-90",
		"2022-07-29 05:00:00",
		"bg_hdhz_sqdc_01",
		"",
		"7:211007109:5:1#7:211007209:5:1#7:214008109:5:1#7:214008209:5:1",
		"前往购买#前往兑换",
		"mibao#shengqituandui1;func#470#ExchangeExpedition_High"
	},
	{
		2,
		{
			12007,
			13001
		},
		"-425,-90#75,-90",
		"2022-08-05 05:00:00",
		"bg_hdhz_sqdc_02",
		"",
		"7:212007109:5:1#7:212007209:5:1#7:213001109:5:1#7:213001209:5:1",
		"前往购买#前往兑换",
		"mibao#shengqituandui3;func#470#ExchangeExpedition_High"
	},
	{
		3,
		{
			12008
		},
		"75,-90",
		"2022-08-12 05:00:00",
		"bg_hdhz_sqdc_03",
		"",
		"7:212008109:5:1#7:212008209:5:1",
		"前往购买#前往兑换",
		"mibao#shengqituandui5;func#470#ExchangeExpedition_High"
	},
	{
		4,
		{
			15011
		},
		"75,-90",
		"2022-08-19 05:00:00",
		"bg_hdhz_sqdc_04",
		"",
		"7:215011109:5:1#7:215011209:5:1",
		"前往购买#前往兑换",
		"mibao#shengqituandui6;func#470#ExchangeExpedition_High"
	},
	{
		5,
		{
			10100
		},
		"75,-90",
		"2023-01-06 05:00:00",
		"bg_hanjia_2",
		"",
		"7:210100109:5:1#7:210100209:5:1",
		"猜炸弹#前往兑换",
		"func#287;func#470#ExchangeExpedition_High"
	},
	{
		6,
		{
			16015
		},
		"75,-90",
		"2023-04-14 05:00:00",
		"bg_hdhz_sqdc_05",
		"",
		"7:216015109:5:1#7:216015209:5:1",
		"页游签到#手游签到",
		"mibao#shengqituandui6;func#861"
	},
	{
		7,
		{
			12009
		},
		"75,-90",
		"2023-04-28 05:00:00",
		"bg_hdhz_sqdc_05",
		"",
		"7:216015109:5:1#7:216015209:5:1",
		"前往替换#前往兑换",
		"mibao#shengqituandui6;func#470#ExchangeExpedition_High"
	},
	{
		8,
		{
			15017
		},
		"75,-90",
		"2023-12-22 05:00:00",
		"bg_syyyw",
		"",
		"4:215:100#7:215017109:5:1#7:215017209:5:1",
		"神曜材料#神器获得",
		"func#5085;itemsource#4:510245"
	},
	{
		9,
		{
			15023
		},
		"75,-90",
		"2024-01-19 05:00:00",
		"bg_minghuang",
		"",
		"100:15023:1:1#4:84427:6",
		"全民挑战#满觉醒魂",
		"func#5090;itemsource#4:84427"
	},
	{
		10,
		{
			16018
		},
		"75,-90",
		"2024-02-08 05:00:00",
		"bg_hdhz_sqdc_08",
		"",
		"7:216018109:5:1#7:216018209:5:1",
		"正义挑战#神器获得",
		"func#5094;func#1015"
	},
	{
		11,
		{
			16021
		},
		"75,-90",
		"2024-03-08 05:00:00",
		"bg_hdhz_sqdc_10",
		"",
		"4:510260:100#7:216021109:5:1#7:216021209:5:1",
		"全民挑战#神器获得",
		"func#5097;itemsource#4:510263"
	},
	{
		12,
		{
			16021
		},
		"75,-90",
		"2024-04-03 05:00:00",
		"bg_hdhz_sqdc_16",
		"",
		"4:1036:1#4:90091:4#4:84439:6#4:510280:100",
		"属性坐骑#养成好礼",
		"func#545#16;func#1056"
	},
	{
		13,
		{
			11022
		},
		"75,-90",
		"2024-04-30 05:00:00",
		"bg_hdhz_weiduoliya",
		"",
		"4:510290:100#7:211022108:5:1#7:211022208:5:1",
		"全民挑战#神器获得",
		"func#5108;func#1071"
	},
	{
		14,
		{
			13016
		},
		"75,-90",
		"2024-05-31 05:00:00",
		"bg_hdhz_panduola",
		"",
		"4:510301:100#7:213016108:5:1#7:213016208:5:1",
		"全民挑战#神器获得",
		"func#5114;func#1076"
	},
	{
		15,
		{
			14029
		},
		"75,-90",
		"2024-09-27 05:00:00",
		"bg_hdhz_sqdc_17",
		"",
		"7:214029108:5:1#7:214029208:5:1",
		"神器获得",
		"itemsource#4:510362"
	},
	{
		16,
		{
			15028
		},
		"75,-90",
		"2024-10-25 05:00:00",
		"bg_hdhz_sqdc_17",
		"",
		"7:215028108:5:1#7:215028208:5:1",
		"神器获得",
		"itemsource#4:510369"
	},
	{
		17,
		{
			12025
		},
		"75,-90",
		"2024-12-27 05:00:00",
		"bg_hdhz_sqdc_17",
		"",
		"4:510397:8#4:510399:8#4:510394:8",
		"神器获得",
		"itemsource#1004:1433"
	},
	{
		18,
		{
			13021
		},
		"75,-90",
		"2025-01-24 05:00:00",
		"bg_hdhz_sqdc_17",
		"",
		"7:213021109:5:1#7:213021209:5:1",
		"神器获得",
		"itemsource#4:510428"
	},
	{
		19,
		{
			14031
		},
		"75,-90",
		"2025-02-28 05:00:00",
		"bg_hdhz_sqdc_17",
		"",
		"7:215031109:5:1#7:215031209:5:1#7:214031109:5:1#7:214031209:5:1",
		"光龙神器#末炎神器",
		"itemsource#4:510451;itemsource#4:510449"
	},
	{
		20,
		{
			14034
		},
		"75,-90",
		"2025-04-30 05:00:00",
		"bg_shenqihuode_loshiqi_01",
		"",
		"7:214034109:5:1#7:214034209:5:1#7:215034109:5:1#7:215034209:5:1",
		"洛世琦神器#星洛神器",
		"itemsource#4:510489;itemsource#4:510491"
	},
	{
		21,
		{
			15038
		},
		"75,-90",
		"2025-10-24 05:00:00",
		"bg_shenqihuode_miuke_01",
		"",
		"7:215038109:5:1#7:215038209:5:1",
		"神器获得",
		"itemsource#4:510605"
	}
}
local t_xiao_nuo_summary_artifact = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8],
	dataList[9],
	dataList[10],
	dataList[11],
	dataList[12],
	dataList[13],
	dataList[14],
	dataList[15],
	dataList[16],
	dataList[17],
	dataList[18],
	dataList[19],
	dataList[20],
	dataList[21]
}

t_xiao_nuo_summary_artifact.dataList = dataList

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

return t_xiao_nuo_summary_artifact
