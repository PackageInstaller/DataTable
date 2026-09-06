-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_wishing_well_shop.lua

module("logicconfig.config.t_wishing_well_shop", package.seeall)

local title = {
	itemId = 2,
	sellContent = 5,
	sellPrice = 3,
	itemIcon = 7,
	goodsId = 4,
	dailyLimitTimes = 6,
	planId = 1,
	itemName = 8
}
local dataList = {
	{
		1,
		1,
		"",
		"",
		"10:7001:3",
		1,
		"icon_wuwang_lihe04",
		"每日免费礼包"
	},
	{
		1,
		2,
		"105:145:20",
		"",
		"10:7001:2",
		20,
		"icon_wuwang_lihe05",
		"许愿礼包"
	},
	{
		1,
		3,
		"",
		"rmb_3",
		"10:7001:10#10:7101:100",
		20,
		"icon_wuwang_lihe06",
		"许愿特惠礼包"
	},
	{
		1,
		4,
		"",
		"rmb_12",
		"10:7001:40#10:7101:300",
		10,
		"icon_wuwang_lihe07",
		"许愿超值礼包"
	},
	{
		2,
		1,
		"",
		"",
		"10:7002:3",
		1,
		"icon_wuwang_lihe04",
		"每日免费礼包"
	},
	{
		2,
		2,
		"105:145:20",
		"",
		"10:7002:2",
		20,
		"icon_wuwang_lihe05",
		"许愿礼包"
	},
	{
		2,
		3,
		"",
		"rmb_1",
		"10:7002:10#10:7102:100",
		99,
		"icon_wuwang_lihe06",
		"许愿特惠礼包"
	},
	{
		2,
		4,
		"",
		"rmb_3",
		"10:7002:20#10:7102:200",
		99,
		"icon_wuwang_lihe07",
		"许愿超值礼包"
	},
	{
		3,
		1,
		"",
		"",
		"10:7003:3",
		1,
		"icon_wuwang_lihe04",
		"每日免费礼包"
	},
	{
		3,
		2,
		"105:145:20",
		"",
		"10:7003:2",
		20,
		"icon_wuwang_lihe05",
		"许愿礼包"
	},
	{
		3,
		3,
		"",
		"rmb_1",
		"10:7003:10#10:7103:100",
		99,
		"icon_wuwang_lihe06",
		"许愿特惠礼包"
	},
	{
		3,
		4,
		"",
		"rmb_3",
		"10:7003:20#10:7103:200",
		99,
		"icon_wuwang_lihe07",
		"许愿超值礼包"
	}
}
local t_wishing_well_shop = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	},
	{
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	},
	{
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12]
	}
}

t_wishing_well_shop.dataList = dataList

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

return t_wishing_well_shop
