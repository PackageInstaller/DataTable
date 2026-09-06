-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_scene_monster_master.lua

module("logicconfig.config.t_scene_monster_master", package.seeall)

local title = {
	creepsMasterId = 1,
	name = 2,
	limitClazz = 6,
	limitParams = 7,
	raceId = 3,
	heroSkillId = 4,
	limitTips = 8,
	mission = 5
}
local dataList = {
	{
		2,
		"三叶兽",
		10046,
		"",
		true,
		"",
		"",
		82007971
	},
	{
		3,
		"海布蓝",
		10047,
		"",
		true,
		"",
		"",
		82007971
	},
	{
		4,
		"咕噜牦牛",
		10048,
		"",
		true,
		"",
		"",
		82007971
	},
	{
		5,
		"怒火蜘蛛",
		10049,
		"",
		true,
		"",
		"",
		82007971
	},
	{
		6,
		"刺锥蝎",
		10050,
		"",
		true,
		"",
		"",
		82007971
	},
	{
		7,
		"水怪怪",
		10193,
		"",
		true,
		"",
		"",
		82007971
	},
	{
		8,
		"火怪怪",
		10194,
		"",
		true,
		"",
		"",
		82007971
	},
	{
		9,
		"草怪怪",
		10195,
		"",
		true,
		"",
		"",
		82007971
	},
	{
		10,
		"暗怪怪",
		10196,
		"",
		true,
		"",
		"",
		82007971
	},
	{
		11,
		"光怪怪",
		10197,
		"",
		true,
		"",
		"",
		82007971
	},
	{
		12,
		"小飞龙",
		10026,
		"",
		true,
		"",
		"",
		82007971
	},
	{
		13,
		"小蓝龙",
		10122,
		"",
		true,
		"",
		"",
		82007971
	},
	{
		14,
		"曙光树精",
		10350,
		"",
		true,
		"",
		"",
		82007971
	},
	{
		15,
		"破空鹰卫",
		10349,
		"",
		true,
		"",
		"",
		82007971
	},
	{
		16,
		"三叶兽",
		10046,
		"",
		true,
		"",
		"",
		82007971
	},
	{
		17,
		"海布蓝",
		10047,
		"",
		true,
		"",
		"",
		82007971
	},
	{
		18,
		"咕噜牦牛",
		10048,
		"",
		true,
		"",
		"",
		82007971
	},
	{
		19,
		"怒火蜘蛛",
		10049,
		"",
		true,
		"",
		"",
		82007971
	},
	{
		20,
		"刺锥蝎",
		10050,
		"",
		true,
		"",
		"",
		82007971
	},
	{
		21,
		"火箭鸡",
		10361,
		"",
		true,
		"",
		"",
		82007971
	},
	{
		22,
		"呆头鸭",
		10362,
		"",
		true,
		"",
		"",
		82007971
	},
	{
		23,
		"极冰鸟",
		10363,
		"",
		true,
		"",
		"",
		82007971
	},
	{
		24,
		"犀利哥",
		10364,
		"",
		true,
		"",
		"",
		82007971
	},
	{
		25,
		"胖噜噜",
		10365,
		"",
		true,
		"",
		"",
		82007971
	},
	{
		26,
		"小梦",
		10344,
		"",
		true,
		"",
		"",
		82007971
	}
}
local t_scene_monster_master = {
	[2] = dataList[1],
	[3] = dataList[2],
	[4] = dataList[3],
	[5] = dataList[4],
	[6] = dataList[5],
	[7] = dataList[6],
	[8] = dataList[7],
	[9] = dataList[8],
	[10] = dataList[9],
	[11] = dataList[10],
	[12] = dataList[11],
	[13] = dataList[12],
	[14] = dataList[13],
	[15] = dataList[14],
	[16] = dataList[15],
	[17] = dataList[16],
	[18] = dataList[17],
	[19] = dataList[18],
	[20] = dataList[19],
	[21] = dataList[20],
	[22] = dataList[21],
	[23] = dataList[22],
	[24] = dataList[23],
	[25] = dataList[24],
	[26] = dataList[25]
}

t_scene_monster_master.dataList = dataList

local multiLanguageCells = {
	limitTips = true
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

return t_scene_monster_master
