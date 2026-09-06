-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_kindergarten_facility_plan.lua

module("logicconfig.config.t_kindergarten_facility_plan", package.seeall)

local title = {
	cost = 5,
	facilityId = 2,
	strengthPoint = 6,
	classroomLv = 4,
	desc = 3,
	facilityPlanId = 1,
	imgRes = 10,
	intellectPoint = 8,
	artPoint = 7,
	kindergartenLvLimit = 9
}
local dataList = {
	{
		1,
		1,
		"小提琴",
		2,
		"10:353002:100",
		0,
		25,
		0,
		1,
		"board_aoqiyoueryuanz_23"
	},
	{
		1,
		2,
		"绘画板",
		3,
		"10:353002:200",
		0,
		35,
		0,
		1,
		"board_aoqiyoueryuanz_17"
	},
	{
		1,
		3,
		"电子琴",
		4,
		"10:353002:400",
		0,
		40,
		0,
		2,
		"board_aoqiyoueryuanz_24"
	},
	{
		1,
		4,
		"高级小提琴",
		5,
		"10:353002:800",
		0,
		50,
		0,
		2,
		"board_aoqiyoueryuanz_23"
	},
	{
		1,
		5,
		"高级绘画板",
		6,
		"10:353002:1500",
		0,
		80,
		0,
		3,
		"board_aoqiyoueryuanz_17"
	},
	{
		1,
		6,
		"高级电子琴",
		7,
		"10:353002:3000",
		0,
		150,
		0,
		3,
		"board_aoqiyoueryuanz_24"
	},
	{
		2,
		1,
		"试剂瓶",
		2,
		"10:353002:100",
		0,
		0,
		25,
		1,
		"board_aoqiyoueryuanz_22"
	},
	{
		2,
		2,
		"望远镜",
		3,
		"10:353002:200",
		0,
		0,
		35,
		1,
		"board_aoqiyoueryuanz_18"
	},
	{
		2,
		3,
		"地球仪",
		4,
		"10:353002:400",
		0,
		0,
		40,
		2,
		"board_aoqiyoueryuanz_20"
	},
	{
		2,
		4,
		"高级试剂瓶",
		5,
		"10:353002:800",
		0,
		0,
		50,
		2,
		"board_aoqiyoueryuanz_22"
	},
	{
		2,
		5,
		"高级望远镜",
		6,
		"10:353002:1500",
		0,
		0,
		80,
		3,
		"board_aoqiyoueryuanz_18"
	},
	{
		2,
		6,
		"高级地球仪",
		7,
		"10:353002:3000",
		0,
		0,
		150,
		3,
		"board_aoqiyoueryuanz_20"
	},
	{
		3,
		1,
		"弹珠",
		2,
		"10:353002:100",
		25,
		0,
		0,
		1,
		"board_aoqiyoueryuanz_15"
	},
	{
		3,
		2,
		"足球",
		3,
		"10:353002:200",
		35,
		0,
		0,
		1,
		"board_aoqiyoueryuanz_16"
	},
	{
		3,
		3,
		"篮球",
		4,
		"10:353002:400",
		40,
		0,
		0,
		2,
		"board_aoqiyoueryuanz_21"
	},
	{
		3,
		4,
		"高级弹珠",
		5,
		"10:353002:800",
		50,
		0,
		0,
		2,
		"board_aoqiyoueryuanz_15"
	},
	{
		3,
		5,
		"高级足球",
		6,
		"10:353002:1500",
		80,
		0,
		0,
		3,
		"board_aoqiyoueryuanz_16"
	},
	{
		3,
		6,
		"高级篮球",
		7,
		"10:353002:3000",
		150,
		0,
		0,
		3,
		"board_aoqiyoueryuanz_21"
	}
}
local t_kindergarten_facility_plan = {
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

t_kindergarten_facility_plan.dataList = dataList

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

return t_kindergarten_facility_plan
