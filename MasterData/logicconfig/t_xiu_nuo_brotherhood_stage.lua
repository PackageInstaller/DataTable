-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_xiu_nuo_brotherhood_stage.lua

module("logicconfig.config.t_xiu_nuo_brotherhood_stage", package.seeall)

local title = {
	stageId = 2,
	bossPlanId = 3,
	endPos = 5,
	buffTypes = 4,
	name = 6,
	stagePreview = 9,
	prize = 8,
	buffMax = 7,
	activityId = 1
}
local dataList = {
	{
		208001,
		1,
		1,
		{
			10001,
			10002,
			10003,
			10004
		},
		30,
		"第一关",
		2,
		"4:153:20#8:1:400000",
		"board_tzxn_04"
	},
	{
		208001,
		2,
		2,
		{
			20001,
			20002,
			20003,
			20004
		},
		30,
		"第二关",
		2,
		"4:153:25#8:1:450000",
		"board_tzxn_04"
	},
	{
		208001,
		3,
		3,
		{
			30001,
			30002,
			30003,
			30004,
			30005
		},
		30,
		"第三关",
		2,
		"4:153:35#8:1:550000",
		"board_tzxn_05"
	},
	{
		208001,
		4,
		4,
		{
			30001,
			30002,
			30003,
			30004,
			30005
		},
		30,
		"第四关",
		2,
		"4:153:40#8:1:600000",
		"board_tzxn_05"
	},
	{
		208002,
		1,
		5,
		{
			10001,
			10002,
			10003,
			10004
		},
		30,
		"第一关",
		2,
		"4:167:20#8:1:400000",
		"board_tzxn_04"
	},
	{
		208002,
		2,
		6,
		{
			20001,
			20002,
			20003,
			20004
		},
		30,
		"第二关",
		2,
		"4:167:25#8:1:450000",
		"board_tzxn_04"
	},
	{
		208002,
		3,
		7,
		{
			30001,
			30002,
			30003,
			30004,
			30005
		},
		30,
		"第三关",
		2,
		"4:167:35#8:1:550000",
		"board_tzxn_05"
	},
	{
		208002,
		4,
		8,
		{
			30001,
			30002,
			30003,
			30004,
			30005
		},
		30,
		"第四关",
		2,
		"4:167:40#8:1:600000",
		"board_tzxn_05"
	},
	{
		208003,
		1,
		9,
		{
			10011,
			10012,
			10013,
			10014
		},
		30,
		"第一关",
		2,
		"4:416:20#8:1:400000",
		"board_tzxn_04"
	},
	{
		208003,
		2,
		10,
		{
			20011,
			20012,
			20013,
			20014
		},
		30,
		"第二关",
		2,
		"4:416:25#8:1:450000",
		"board_tzxn_04"
	},
	{
		208003,
		3,
		11,
		{
			30011,
			30012,
			30013,
			30014,
			30015
		},
		30,
		"第三关",
		2,
		"4:416:35#8:1:550000",
		"board_tzxn_05"
	},
	{
		208003,
		4,
		12,
		{
			30011,
			30012,
			30013,
			30014,
			30015
		},
		30,
		"第四关",
		2,
		"4:416:40#8:1:600000",
		"board_tzxn_05"
	},
	{
		208004,
		1,
		13,
		{
			10011,
			10012,
			10013,
			10014
		},
		30,
		"第一关",
		2,
		"4:275:10",
		"board_tzxn_04"
	},
	{
		208004,
		2,
		14,
		{
			20011,
			20012,
			20013,
			20014
		},
		30,
		"第二关",
		2,
		"4:275:15",
		"board_tzxn_04"
	},
	{
		208004,
		3,
		15,
		{
			30011,
			30012,
			30013,
			30014,
			30015
		},
		30,
		"第三关",
		2,
		"4:275:25",
		"board_tzxn_05"
	},
	{
		208004,
		4,
		16,
		{
			30011,
			30012,
			30013,
			30014,
			30015
		},
		30,
		"第四关",
		2,
		"4:275:50",
		"board_tzxn_05"
	}
}
local t_xiu_nuo_brotherhood_stage = {
	[208001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	},
	[208002] = {
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	},
	[208003] = {
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12]
	},
	[208004] = {
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16]
	}
}

t_xiu_nuo_brotherhood_stage.dataList = dataList

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

return t_xiu_nuo_brotherhood_stage
