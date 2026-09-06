-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pet_notice_small_tab.lua

module("logicconfig.config.t_pet_notice_small_tab", package.seeall)

local title = {
	config_name = 5,
	name = 2,
	index = 1,
	viewName = 3,
	listIndex = 4,
	reportBehavior = 6
}
local dataList = {
	{
		1,
		"最新精灵",
		"",
		1,
		"new_pet",
		200528
	},
	{
		2,
		"限时回归",
		"",
		1,
		"regression_pet",
		200529
	},
	{
		3,
		"最新皮肤",
		"",
		1,
		"new_skin",
		200528
	},
	{
		4,
		"回归皮肤",
		"",
		1,
		"regression_skin",
		200529
	},
	{
		5,
		"阵容推荐",
		"RecommendFmt",
		0,
		"",
		200530
	},
	{
		6,
		"技能调整",
		"petskilladjustview",
		0,
		"",
		200531
	},
	{
		7,
		"神器觉醒",
		"petartifactawakenview",
		0,
		"",
		0
	},
	{
		8,
		"精灵契约",
		"",
		2,
		"",
		200639
	},
	{
		9,
		"圣骑回归",
		"",
		1,
		"regression_pet_3",
		200529
	},
	{
		10,
		"传说精灵",
		"",
		1,
		"regression_pet_2",
		200529
	},
	{
		11,
		"即将回归",
		"",
		1,
		"regression_pet_4",
		200529
	},
	{
		12,
		"8.26回归精灵",
		"",
		1,
		"regression_pet_5",
		200529
	},
	{
		13,
		"通灵师阵容",
		"recommendphychicfmtview",
		0,
		"",
		200529
	},
	{
		14,
		"神曜精灵",
		"",
		1,
		"regression_pet_6",
		200529
	},
	{
		15,
		"时空之门",
		"timegatemainview",
		0,
		"",
		0
	},
	{
		16,
		"源起精灵",
		"",
		1,
		"regression_pet_7",
		200529
	},
	{
		17,
		"大神榜挑战",
		"",
		1,
		"regression_pet_8",
		200529
	},
	{
		18,
		"第一周回归",
		"",
		1,
		"regression_pet_9",
		200529
	},
	{
		19,
		"第二周回归",
		"",
		1,
		"regression_pet_10",
		200529
	},
	{
		20,
		"第三周回归",
		"",
		1,
		"regression_pet_11",
		200529
	},
	{
		21,
		"第四周回归",
		"",
		1,
		"regression_pet_12",
		200529
	}
}
local t_pet_notice_small_tab = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8],
	dataList[9],
	dataList[10],
	dataList[11],
	dataList[12],
	dataList[13],
	dataList[14],
	dataList[15],
	dataList[16],
	dataList[17],
	dataList[18],
	dataList[19],
	dataList[20],
	dataList[21]
}

t_pet_notice_small_tab.dataList = dataList

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

return t_pet_notice_small_tab
