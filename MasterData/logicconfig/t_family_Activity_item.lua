-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_family_activity_item.lua

module("logicconfig.config.t_family_activity_item", package.seeall)

local title = {
	titleStr = 10,
	name = 3,
	jumpTo = 9,
	isHide = 4,
	params = 11,
	planId = 1,
	redIds = 7,
	actType = 5,
	id = 2,
	grpIndex = 8,
	sort = 6
}
local dataList = {
	{
		1,
		1,
		"家族围剿",
		true,
		1,
		7,
		"100",
		3,
		"func#252",
		"次  数",
		""
	},
	{
		1,
		2,
		"家族Boss",
		true,
		4,
		6,
		"33",
		1,
		"ui#familybossview",
		"",
		""
	},
	{
		1,
		3,
		"家族护送",
		false,
		5,
		4,
		"-226",
		2,
		"",
		"次  数",
		""
	},
	{
		1,
		4,
		"神柱之战",
		true,
		6,
		5,
		"",
		5,
		"",
		"次  数",
		""
	},
	{
		1,
		5,
		"家族围剿",
		false,
		9,
		2,
		"548",
		8,
		"",
		"次  数",
		""
	},
	{
		1,
		6,
		"家族宴会",
		false,
		10,
		1,
		"",
		9,
		"",
		"本  周",
		""
	},
	{
		1,
		7,
		"神柱之战",
		false,
		12,
		3,
		"",
		5,
		"event#entergodstatueswar",
		"次  数",
		""
	},
	{
		2,
		1,
		"家族任务",
		false,
		2,
		1,
		"246",
		4,
		"ui#familytask",
		"",
		""
	},
	{
		2,
		2,
		"家族捐献",
		false,
		3,
		2,
		"28#c14",
		0,
		"ui#familycontribution",
		"次  数",
		""
	},
	{
		3,
		1,
		"家族红包",
		false,
		7,
		1,
		"405#423",
		7,
		"ui#familyredpack",
		"",
		""
	},
	{
		3,
		2,
		"家族商店",
		false,
		8,
		2,
		"",
		6,
		"func#470#ExchangeFamily",
		"",
		""
	},
	{
		3,
		3,
		"家族图腾",
		false,
		11,
		3,
		"",
		10,
		"",
		"",
		""
	}
}
local t_family_activity_item = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	},
	{
		dataList[8],
		dataList[9]
	},
	{
		dataList[10],
		dataList[11],
		dataList[12]
	}
}

t_family_activity_item.dataList = dataList

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

return t_family_activity_item
