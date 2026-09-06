-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_golden_diamond_timed_buy.lua

module("logicconfig.config.t_golden_diamond_timed_buy", package.seeall)

local title = {
	tips = 6,
	endTime = 3,
	privilegeDays = 4,
	goodsId = 5,
	timedId = 1,
	startTime = 2
}
local dataList = {
	{
		1,
		"2022-01-28T05:00:00",
		"2022-02-18T05:00:00",
		150,
		"rmb_45",
		"新春金钻卡1月28日05:00至2月18日05:00限时特惠，原价60元，特惠价45元打包购买5个月金钻卡，确定购买吗？"
	},
	{
		2,
		"2022-07-01T05:00:00",
		"2022-07-22T05:00:00",
		150,
		"rmb_45",
		"金钻卡7月1日05:00至7月22日05:00限时特惠，原价60元，特惠价45元打包购买5个月金钻卡，确定购买吗？"
	},
	{
		3,
		"2023-06-02T05:00:00",
		"2023-06-16T05:00:00",
		150,
		"rmb_45",
		"金钻卡6月2日05:00至6月16日05:00限时特惠，原价60元，特惠价45元打包购买5个月金钻卡，确定购买吗？"
	}
}
local t_golden_diamond_timed_buy = {
	dataList[1],
	dataList[2],
	dataList[3]
}

t_golden_diamond_timed_buy.dataList = dataList

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

return t_golden_diamond_timed_buy
