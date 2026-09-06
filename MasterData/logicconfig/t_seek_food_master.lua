-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_seek_food_master.lua

module("logicconfig.config.t_seek_food_master", package.seeall)

local title = {
	description = 7,
	video = 8,
	name = 2,
	skipTime = 3,
	perfectWinId = 11,
	formCondition = 12,
	btlMode = 6,
	btlBg = 4,
	selfBuffProviderId = 13,
	enableGainExp = 14,
	winId = 10,
	creepsMasterId = 1,
	heroSkillId = 5,
	introdRaceId = 9
}
local dataList = {
	{
		101,
		"裁决圣者·谜",
		5,
		"",
		"",
		"",
		"",
		false,
		0,
		0,
		0,
		0,
		0,
		false
	},
	{
		102,
		"焚世·赤焰龙皇",
		5,
		"",
		"",
		"",
		"",
		false,
		0,
		0,
		0,
		0,
		0,
		false
	},
	{
		103,
		"疾风匕隐·卡索",
		5,
		"",
		"",
		"",
		"",
		false,
		0,
		0,
		0,
		0,
		0,
		false
	},
	{
		104,
		"石姬新娘·镭拉",
		5,
		"",
		"",
		"",
		"",
		false,
		0,
		0,
		0,
		0,
		0,
		false
	},
	{
		105,
		"千钧万盾·尤烈",
		5,
		"",
		"",
		"",
		"",
		false,
		0,
		0,
		0,
		0,
		0,
		false
	},
	{
		106,
		"无间魔焰·瞳",
		5,
		"",
		"",
		"",
		"",
		false,
		0,
		0,
		0,
		0,
		0,
		false
	},
	{
		107,
		"龙女·耶梦加得",
		5,
		"",
		"",
		"",
		"",
		false,
		0,
		0,
		0,
		0,
		0,
		false
	},
	{
		108,
		"天女武神·狄丝",
		5,
		"",
		"",
		"",
		"",
		false,
		0,
		0,
		0,
		0,
		0,
		false
	}
}
local t_seek_food_master = {
	[101] = dataList[1],
	[102] = dataList[2],
	[103] = dataList[3],
	[104] = dataList[4],
	[105] = dataList[5],
	[106] = dataList[6],
	[107] = dataList[7],
	[108] = dataList[8]
}

t_seek_food_master.dataList = dataList

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

return t_seek_food_master
