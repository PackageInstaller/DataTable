-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_passport_permanent_activity.lua

module("logicconfig.config.t_passport_permanent_activity", package.seeall)

local title = {
	thirdGoodsId = 7,
	name = 3,
	vipGoodsId = 5,
	buyEndTime = 10,
	discountGoodsId = 8,
	additonalGoodsId = 6,
	funcId = 2,
	goodsId = 4,
	actId = 1,
	discountTime = 9
}
local dataList = {
	{
		1,
		3,
		"勇者之塔投资",
		"rmb_98",
		"rmb_98",
		"",
		"",
		"",
		"",
		"2024-09-27T05:00:00"
	},
	{
		2,
		4,
		"主线章节投资",
		"rmb_98",
		"rmb_98",
		"",
		"",
		"",
		"",
		"2024-09-27T05:00:00"
	},
	{
		3,
		6,
		"灵纹幻境投资",
		"rmb_68",
		"rmb_68",
		"",
		"",
		"",
		"",
		"2024-09-27T05:00:00"
	},
	{
		4,
		23,
		"勇者之塔投资plus",
		"rmb_68",
		"rmb_68",
		"",
		"",
		"",
		""
	},
	{
		5,
		24,
		"主线章节投资plus",
		"rmb_68",
		"rmb_68",
		"",
		"",
		"",
		""
	},
	{
		6,
		25,
		"灵纹幻境投资plus",
		"rmb_68",
		"rmb_68",
		"",
		"",
		"",
		""
	}
}
local t_passport_permanent_activity = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6]
}

t_passport_permanent_activity.dataList = dataList

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

return t_passport_permanent_activity
