-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ling_shen_convene_prize.lua

module("logicconfig.config.t_ling_shen_convene_prize", package.seeall)

local title = {
	prizeId = 2,
	prize = 4,
	tabTips = 5,
	unlockCount = 3,
	iconPath = 6,
	detailDesc = 7,
	activityId = 1
}
local dataList = {
	{
		376001,
		1,
		1,
		"8:1:1000000",
		"何为领神",
		"icon_binglingwang",
		"1.神域的联合统治者\r\n2.拥有各自的统治区域，持有的元素火种会为该区域提供元素之力\r\n3.参与共议会，与其他领神共同协商神域事务"
	},
	{
		376001,
		2,
		3,
		"4:36:5",
		"如何成为领神",
		"icon_binglingwang_01",
		"1.至少持有一份元素火种\r\n2.成为一片领地的王者，获得民众臣服\r\n3.获得神殿主祭的认可\r\n4.在共议会上得到其他领神的三票赞成"
	},
	{
		376001,
		3,
		5,
		"4:36:5",
		"领神等级划分",
		"icon_binglingwang_01",
		"1.初代领神：四祖神陨落后，元素火种争夺战的十位胜利者\r\n2.二代领神：旷世之战中，成功抢夺初代领神元素火种的胜利者\r\n3.三代领神：获得二代领神的元素火种，并达成条件成为领神者"
	}
}
local t_ling_shen_convene_prize = {
	[376001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_ling_shen_convene_prize.dataList = dataList

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

return t_ling_shen_convene_prize
