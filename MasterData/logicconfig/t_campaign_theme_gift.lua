-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_campaign_theme_gift.lua

module("logicconfig.config.t_campaign_theme_gift", package.seeall)

local title = {
	giftType = 4,
	payGoodsId = 3,
	giftContent = 5,
	giftId = 2,
	activityId = 1
}
local dataList = {
	{
		16001,
		1,
		"",
		1,
		"8:1:1000#4:2:5"
	},
	{
		16001,
		2,
		"rmb_1",
		2,
		"4:63:1#104:2:10#8:1:5000"
	},
	{
		16001,
		3,
		"rmb_3",
		2,
		"4:36:1#104:2:30#4:3:2"
	},
	{
		16001,
		4,
		"rmb_6",
		2,
		"4:100007:1#104:2:60#4:502:1"
	},
	{
		16001,
		5,
		"rmb_60",
		3,
		"1:10004:-1:1#1:10005:-1:1#1:10006:-1:1#1:11004:-1:1#1:11005:-1:1#1:11006:-1:1"
	}
}
local t_campaign_theme_gift = {
	[16001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_campaign_theme_gift.dataList = dataList

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

return t_campaign_theme_gift
