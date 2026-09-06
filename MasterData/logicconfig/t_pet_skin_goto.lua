-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pet_skin_goto.lua

module("logicconfig.config.t_pet_skin_goto", package.seeall)

local title = {
	sloganImg1 = 16,
	bgPos = 15,
	skinId = 7,
	isShowRole = 8,
	sloganPos1 = 17,
	btnGotoTip = 4,
	camScale = 9,
	endTime = 13,
	sloganImg2 = 18,
	sloganPos2 = 19,
	tabImg = 6,
	txtTimePos = 5,
	gotoParam = 2,
	btnGotoPos = 3,
	btnSkillPos = 11,
	id = 1,
	bgImg = 14,
	rolePos = 10,
	startTime = 12
}
local dataList = {
	{
		1,
		"func#495",
		{
			455,
			-220
		},
		"前往",
		{
			470,
			-265
		},
		"btn_pfhd_22",
		1600301,
		true,
		1,
		{
			-1800,
			-1800
		},
		{
			400,
			-80
		},
		"2022-01-28T05:00:00",
		"2022-02-18T05:00:00",
		"board_pfhd_30",
		nil,
		"",
		nil,
		""
	},
	{
		2,
		"func#491",
		{
			455,
			-220
		},
		"前往",
		{
			470,
			-265
		},
		"btn_pfhd_23",
		1034201,
		true,
		1,
		{
			-1800,
			-1800
		},
		{
			400,
			-80
		},
		"2022-01-28T05:00:00",
		"2022-02-18T05:00:00",
		"board_pfhd_29",
		nil,
		"",
		nil,
		""
	},
	{
		3,
		"func#245",
		{
			455,
			-220
		},
		"前往",
		{
			470,
			-265
		},
		"btn_pfhd_26",
		1033801,
		true,
		1,
		{
			-1800,
			-1800
		},
		{
			400,
			-80
		},
		"2022-01-28T05:00:00",
		"2022-02-18T05:00:00",
		"board_pfhd_31",
		nil,
		"",
		nil,
		""
	},
	{
		4,
		"func#119",
		{
			455,
			-220
		},
		"前往",
		{
			470,
			-265
		},
		"btn_pfhd_27",
		1034101,
		true,
		1,
		{
			-1800,
			-1800
		},
		{
			400,
			-80
		},
		"2022-02-01T05:00:00",
		"2022-02-18T05:00:00",
		"board_pfhd_32",
		nil,
		"",
		nil,
		""
	},
	{
		5,
		"func#524",
		{
			455,
			-220
		},
		"前往",
		{
			470,
			-265
		},
		"btn_pfhd_31",
		1600601,
		true,
		1,
		{
			-1800,
			-1800
		},
		{
			400,
			-80
		},
		"2021-03-18T05:00:00",
		"2021-04-01T05:00:00",
		"board_pfhd_34",
		nil,
		"",
		nil,
		""
	},
	{
		6,
		"func#524",
		{
			455,
			-220
		},
		"前往",
		{
			470,
			-265
		},
		"btn_pfhd_28",
		1600501,
		true,
		1,
		{
			-1800,
			-1800
		},
		{
			400,
			-80
		},
		"2021-03-11T05:00:00",
		"2021-04-01T05:00:00",
		"board_pfhd_35",
		nil,
		"",
		nil,
		""
	},
	{
		7,
		"func#515",
		{
			455,
			-220
		},
		"前往",
		{
			470,
			-265
		},
		"btn_pfhd_30",
		1600401,
		true,
		1,
		{
			-1800,
			-1800
		},
		{
			400,
			-80
		},
		"2021-03-04T05:00:00",
		"2021-04-01T05:00:00",
		"board_pfhd_33",
		nil,
		"",
		nil,
		""
	},
	{
		8,
		"func#485",
		{
			455,
			-220
		},
		"前往",
		{
			470,
			-265
		},
		"btn_pfhd_29",
		1500601,
		true,
		1,
		{
			-1800,
			-1800
		},
		{
			400,
			-80
		},
		"2021-03-04T05:00:00",
		"2021-04-01T05:00:00",
		"board_pfhd_36",
		nil,
		"",
		nil,
		""
	}
}
local t_pet_skin_goto = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8]
}

t_pet_skin_goto.dataList = dataList

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

return t_pet_skin_goto
