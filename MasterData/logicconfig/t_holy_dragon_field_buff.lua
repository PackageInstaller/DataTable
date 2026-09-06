-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_holy_dragon_field_buff.lua

module("logicconfig.config.t_holy_dragon_field_buff", package.seeall)

local title = {
	desc = 7,
	name = 5,
	unlockCost = 4,
	fieldId = 2,
	icon = 6,
	activityId = 1,
	level = 3
}
local dataList = {
	{
		611001,
		1,
		1,
		"",
		82056732,
		"icon/skill/skill_shenglongzhili_02",
		82056709
	},
	{
		611001,
		1,
		2,
		"10:611002:20",
		82056732,
		"icon/skill/skill_shenglongzhili_02",
		82056710
	},
	{
		611001,
		1,
		3,
		"10:611002:20",
		82056732,
		"icon/skill/skill_shenglongzhili_02",
		82056711
	},
	{
		611001,
		1,
		4,
		"10:611002:20",
		82056732,
		"icon/skill/skill_shenglongzhili_02",
		82056712
	},
	{
		611001,
		2,
		1,
		"",
		82056733,
		"icon/skill/skill_shenglongzhili_01",
		82056705
	},
	{
		611001,
		2,
		2,
		"10:611001:20",
		82056733,
		"icon/skill/skill_shenglongzhili_01",
		82056706
	},
	{
		611001,
		2,
		3,
		"10:611001:20",
		82056733,
		"icon/skill/skill_shenglongzhili_01",
		82056707
	},
	{
		611001,
		2,
		4,
		"10:611001:20",
		82056733,
		"icon/skill/skill_shenglongzhili_01",
		82056708
	},
	{
		611001,
		3,
		1,
		"",
		82057454,
		"icon/skill/skill_shenglongzhili_03",
		82056713
	},
	{
		611001,
		3,
		2,
		"10:611003:20",
		82057454,
		"icon/skill/skill_shenglongzhili_03",
		82056714
	},
	{
		611001,
		3,
		3,
		"10:611003:20",
		82057454,
		"icon/skill/skill_shenglongzhili_03",
		82056715
	},
	{
		611001,
		3,
		4,
		"10:611003:20",
		82057454,
		"icon/skill/skill_shenglongzhili_03",
		82056716
	}
}
local t_holy_dragon_field_buff = {
	[611001] = {
		{
			dataList[1],
			dataList[2],
			dataList[3],
			dataList[4]
		},
		{
			dataList[5],
			dataList[6],
			dataList[7],
			dataList[8]
		},
		{
			dataList[9],
			dataList[10],
			dataList[11],
			dataList[12]
		}
	}
}

t_holy_dragon_field_buff.dataList = dataList

local multiLanguageCells = {
	desc = true,
	name = true
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

return t_holy_dragon_field_buff
