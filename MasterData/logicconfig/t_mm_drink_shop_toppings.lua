-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_mm_drink_shop_toppings.lua

module("logicconfig.config.t_mm_drink_shop_toppings", package.seeall)

local title = {
	price = 4,
	showIcon = 5,
	showPic = 7,
	toppingsId = 2,
	name = 6,
	activityId = 1,
	toppingsType = 3
}
local dataList = {
	{
		596001,
		101,
		1,
		3,
		"icon_mmypd_05",
		82056070,
		"board_mmypd_yl_11"
	},
	{
		596001,
		102,
		1,
		3,
		"icon_mmypd_06",
		82056069,
		"board_mmypd_yl_12"
	},
	{
		596001,
		103,
		1,
		3,
		"icon_mmypd_07",
		82056125,
		"board_mmypd_yl_13"
	},
	{
		596001,
		104,
		1,
		3,
		"icon_mmypd_08",
		82056126,
		"board_mmypd_yl_14"
	},
	{
		596001,
		105,
		1,
		3,
		"icon_mmypd_09",
		82056127,
		"board_mmypd_yl_15"
	},
	{
		596001,
		201,
		2,
		6,
		"icon_mmypd_14",
		82056071,
		"board_mmypd_yl_10"
	},
	{
		596001,
		202,
		2,
		6,
		"icon_mmypd_13",
		82056072,
		"board_mmypd_yl_09"
	},
	{
		596001,
		203,
		2,
		6,
		"icon_mmypd_10",
		82056128,
		"board_mmypd_yl_06"
	},
	{
		596001,
		204,
		2,
		6,
		"icon_mmypd_12",
		82056129,
		"board_mmypd_yl_08"
	},
	{
		596001,
		205,
		2,
		6,
		"icon_mmypd_11",
		82056130,
		"board_mmypd_yl_07"
	},
	{
		596001,
		301,
		3,
		8,
		"icon_mmypd_04",
		82056131,
		"board_mmypd_yl_04"
	},
	{
		596001,
		302,
		3,
		8,
		"icon_mmypd_03",
		82056132,
		"board_mmypd_yl_03"
	},
	{
		596001,
		303,
		3,
		8,
		"icon_mmypd_02",
		82056133,
		"board_mmypd_yl_02"
	},
	{
		596001,
		304,
		3,
		8,
		"icon_mmypd_01",
		82056134,
		"board_mmypd_yl_01"
	}
}
local t_mm_drink_shop_toppings = {
	[596001] = {
		[101] = dataList[1],
		[102] = dataList[2],
		[103] = dataList[3],
		[104] = dataList[4],
		[105] = dataList[5],
		[201] = dataList[6],
		[202] = dataList[7],
		[203] = dataList[8],
		[204] = dataList[9],
		[205] = dataList[10],
		[301] = dataList[11],
		[302] = dataList[12],
		[303] = dataList[13],
		[304] = dataList[14]
	}
}

t_mm_drink_shop_toppings.dataList = dataList

local multiLanguageCells = {
	name = true
}
local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			local value = rawget(t, index)

			if multiLanguageCells[key] then
				value = lang(value)
			end

			return value
		else
			printWarn(string.format("the field name [%s] is nonexist!", key))
		end
	end
}

for i, v in ipairs(dataList) do
	setmetatable(v, mt)
end

return t_mm_drink_shop_toppings
