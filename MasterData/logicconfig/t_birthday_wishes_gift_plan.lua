-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_birthday_wishes_gift_plan.lua

module("logicconfig.config.t_birthday_wishes_gift_plan", package.seeall)

local title = {
	lotteryMaxNum = 4,
	giftIcon = 3,
	giftType = 2,
	cost = 5,
	lotteryPlan = 6,
	giftPlan = 1,
	tagTxt = 7
}
local dataList = {
	{
		1,
		1,
		"icon_sryw_04",
		15,
		"10:223001:1#10:223002:1#10:223003:1",
		1,
		"啊"
	},
	{
		1,
		2,
		"icon_sryw_02",
		15,
		"10:223001:1",
		2,
		"0"
	},
	{
		1,
		3,
		"icon_sryw_03",
		15,
		"10:223002:1",
		3,
		"哦"
	},
	{
		1,
		4,
		"icon_sryw_01",
		15,
		"10:223003:1",
		4,
		""
	},
	{
		2,
		5,
		"icon_sryw_04",
		15,
		"10:223004:1#10:223005:1#10:223006:1",
		1,
		"啊"
	},
	{
		2,
		6,
		"icon_sryw_02",
		15,
		"10:223004:1",
		2,
		"0"
	},
	{
		2,
		7,
		"icon_sryw_03",
		15,
		"10:223005:1",
		3,
		"哦"
	},
	{
		2,
		8,
		"icon_sryw_01",
		15,
		"10:223006:1",
		4,
		""
	},
	{
		3,
		9,
		"icon_sryw_01",
		25,
		"10:223007:1#10:223008:1#10:223009:1#10:223010:1#10:223011:1",
		1,
		""
	},
	{
		4,
		10,
		"icon_sryw_01",
		150,
		"10:223012:1#10:223013:1#10:223014:1#10:223015:1#10:223016:1",
		1,
		""
	},
	{
		5,
		10,
		"icon_sryw_01",
		150,
		"10:223017:1#10:223018:1#10:223019:1#10:223020:1#10:223021:1",
		1,
		""
	},
	{
		6,
		11,
		"icon_sryw_01",
		75,
		"10:223022:1#10:223023:1#10:223024:1#10:223025:1#10:223026:1",
		1,
		""
	},
	{
		7,
		12,
		"icon_sryw_11",
		25,
		"10:223027:1#10:223028:1#10:223029:1",
		12,
		"啊"
	},
	{
		7,
		13,
		"icon_sryw_08",
		20,
		"10:223027:1",
		13,
		"0"
	},
	{
		7,
		14,
		"icon_sryw_09",
		20,
		"10:223028:1",
		14,
		"哦"
	},
	{
		7,
		15,
		"icon_sryw_10",
		20,
		"10:223029:1",
		15,
		""
	},
	{
		8,
		16,
		"icon_sryw_01",
		75,
		"10:223047:1#10:223048:1#10:223049:1#10:223050:1#10:223051:1",
		1,
		""
	},
	{
		9,
		17,
		"icon_sryw_01",
		75,
		"10:223055:1#10:223053:1#10:223052:1#10:223054:1#10:223056:1",
		1,
		""
	}
}
local t_birthday_wishes_gift_plan = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	},
	{
		[5] = dataList[5],
		[6] = dataList[6],
		[7] = dataList[7],
		[8] = dataList[8]
	},
	{
		[9] = dataList[9]
	},
	{
		[10] = dataList[10]
	},
	{
		[10] = dataList[11]
	},
	{
		[11] = dataList[12]
	},
	{
		[12] = dataList[13],
		[13] = dataList[14],
		[14] = dataList[15],
		[15] = dataList[16]
	},
	{
		[16] = dataList[17]
	},
	{
		[17] = dataList[18]
	}
}

t_birthday_wishes_gift_plan.dataList = dataList

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

return t_birthday_wishes_gift_plan
