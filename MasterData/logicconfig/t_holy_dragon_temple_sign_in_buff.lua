-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_holy_dragon_temple_sign_in_buff.lua

module("logicconfig.config.t_holy_dragon_temple_sign_in_buff", package.seeall)

local title = {
	floorId = 2,
	buffId = 3,
	signInDays = 4,
	decComboTimes = 5,
	desc = 8,
	icon = 7,
	activityId = 1,
	decCircleTimes = 6
}
local dataList = {
	{
		609001,
		1,
		1,
		1,
		0,
		1,
		"skill/skill_yq_ph_05",
		82057658
	},
	{
		609001,
		1,
		2,
		2,
		0,
		2,
		"skill/skill_yq_ph_07",
		82057659
	},
	{
		609001,
		1,
		3,
		3,
		0,
		3,
		"skill/skill_yq_ph_08",
		82057660
	},
	{
		609001,
		1,
		4,
		4,
		0,
		3,
		"skill/skill_yq_ph_09",
		82057661
	},
	{
		609001,
		1,
		5,
		5,
		0,
		3,
		"skill/skill_yq_ph_02",
		82057662
	},
	{
		609001,
		2,
		1,
		1,
		1,
		0,
		"skill/skill_yq_lz_01",
		82057663
	},
	{
		609001,
		2,
		2,
		2,
		2,
		0,
		"skill/skill_yq_lz_05",
		82057664
	},
	{
		609001,
		2,
		3,
		3,
		3,
		0,
		"skill/skill_yq_lz_06",
		82057665
	},
	{
		609001,
		2,
		4,
		4,
		4,
		0,
		"skill/skill_yq_lz_07",
		82057666
	},
	{
		609001,
		2,
		5,
		5,
		5,
		0,
		"skill/skill_yq_lz_08",
		82057667
	},
	{
		609001,
		3,
		1,
		1,
		0,
		0,
		"skill/skill_yq_rd_06",
		82057668
	},
	{
		609001,
		3,
		2,
		2,
		0,
		0,
		"skill/skill_yq_rd_09",
		82057669
	},
	{
		609001,
		3,
		3,
		3,
		0,
		0,
		"skill/skill_yq_rd_04",
		82057670
	},
	{
		609001,
		3,
		4,
		4,
		0,
		0,
		"skill/skill_yq_rd_08",
		82057671
	},
	{
		609001,
		3,
		5,
		5,
		0,
		0,
		"skill/skill_cs_5",
		82057672
	}
}
local t_holy_dragon_temple_sign_in_buff = {
	[609001] = {
		{
			dataList[1],
			dataList[2],
			dataList[3],
			dataList[4],
			dataList[5]
		},
		{
			dataList[6],
			dataList[7],
			dataList[8],
			dataList[9],
			dataList[10]
		},
		{
			dataList[11],
			dataList[12],
			dataList[13],
			dataList[14],
			dataList[15]
		}
	}
}

t_holy_dragon_temple_sign_in_buff.dataList = dataList

local multiLanguageCells = {
	desc = true
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

return t_holy_dragon_temple_sign_in_buff
