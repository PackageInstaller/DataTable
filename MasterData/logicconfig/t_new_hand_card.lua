-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_new_hand_card.lua

module("logicconfig.config.t_new_hand_card", package.seeall)

local title = {
	name = 2,
	openTime = 8,
	payGoodsId = 4,
	oldPrice = 3,
	closeTime = 9,
	desc = 11,
	onceGain = 5,
	openHours = 10,
	dailyGain = 6,
	id = 1,
	duration = 7
}
local dataList = {
	{
		1,
		"新手卡",
		11500,
		"rmb_12",
		"4:36:3",
		"104:2:100",
		7,
		"2020-11-13T01:00:00",
		"2020-11-20T05:00:00",
		168,
		"新手福利回馈\n仅限创角后7日\n不要错过哦~"
	}
}
local t_new_hand_card = {
	dataList[1]
}

t_new_hand_card.dataList = dataList

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

return t_new_hand_card
