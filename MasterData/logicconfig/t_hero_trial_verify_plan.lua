-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_hero_trial_verify_plan.lua

module("logicconfig.config.t_hero_trial_verify_plan", package.seeall)

local title = {
	level = 5,
	name = 4,
	des = 6,
	bossBuff = 3,
	planId = 1,
	leftZdl = 2
}
local dataList = {
	{
		1,
		0,
		"3727:99",
		"火系伤害<color=#%s>1级</color>",
		1,
		"火系伤害<color=#%s>+100%%</color>"
	},
	{
		1,
		3000,
		"3732:99",
		"火系伤害<color=#%s>2级</color>",
		2,
		"火系伤害<color=#%s>+150%%</color>"
	},
	{
		1,
		6000,
		"3737:99",
		"火系伤害<color=#%s>3级</color>",
		3,
		"火系伤害<color=#%s>+200%%</color>"
	},
	{
		1,
		10500,
		"3742:99",
		"火系伤害<color=#%s>4级</color>",
		4,
		"火系伤害<color=#%s>+250%%</color>"
	},
	{
		1,
		15000,
		"3747:99",
		"火系伤害<color=#%s>5级</color>",
		5,
		"火系伤害<color=#%s>+300%%</color>"
	},
	{
		2,
		0,
		"3727:99",
		"火系伤害<color=#%s>1级</color>",
		1,
		"火系伤害<color=#%s>+100%%</color>"
	},
	{
		2,
		4600,
		"3732:99",
		"火系伤害<color=#%s>2级</color>",
		2,
		"火系伤害<color=#%s>+150%%</color>"
	},
	{
		2,
		9200,
		"3737:99",
		"火系伤害<color=#%s>3级</color>",
		3,
		"火系伤害<color=#%s>+200%%</color>"
	},
	{
		2,
		16100,
		"3742:99",
		"火系伤害<color=#%s>4级</color>",
		4,
		"火系伤害<color=#%s>+250%%</color>"
	},
	{
		2,
		23000,
		"3747:99",
		"火系伤害<color=#%s>5级</color>",
		5,
		"火系伤害<color=#%s>+300%%</color>"
	},
	{
		3,
		0,
		"3697:99",
		"魔法伤害<color=#%s>1级</color>",
		1,
		"魔法伤害<color=#%s>+100%%</color>"
	},
	{
		3,
		5600,
		"3702:99",
		"魔法伤害<color=#%s>2级</color>",
		2,
		"魔法伤害<color=#%s>+150%%</color>"
	},
	{
		3,
		11200,
		"3707:99",
		"魔法伤害<color=#%s>3级</color>",
		3,
		"魔法伤害<color=#%s>+200%%</color>"
	},
	{
		3,
		19600,
		"3712:99",
		"魔法伤害<color=#%s>4级</color>",
		4,
		"魔法伤害<color=#%s>+250%%</color>"
	},
	{
		3,
		28000,
		"3717:99",
		"魔法伤害<color=#%s>5级</color>",
		5,
		"魔法伤害<color=#%s>+300%%</color>"
	},
	{
		4,
		0,
		"3697:99",
		"魔法伤害<color=#%s>1级</color>",
		1,
		"魔法伤害<color=#%s>+100%%</color>"
	},
	{
		4,
		6600,
		"3702:99",
		"魔法伤害<color=#%s>2级</color>",
		2,
		"魔法伤害<color=#%s>+150%%</color>"
	},
	{
		4,
		13200,
		"3707:99",
		"魔法伤害<color=#%s>3级</color>",
		3,
		"魔法伤害<color=#%s>+200%%</color>"
	},
	{
		4,
		23100,
		"3712:99",
		"魔法伤害<color=#%s>4级</color>",
		4,
		"魔法伤害<color=#%s>+250%%</color>"
	},
	{
		4,
		33000,
		"3717:99",
		"魔法伤害<color=#%s>5级</color>",
		5,
		"魔法伤害<color=#%s>+300%%</color>"
	}
}
local t_hero_trial_verify_plan = {
	{
		[0] = dataList[1],
		[3000] = dataList[2],
		[6000] = dataList[3],
		[10500] = dataList[4],
		[15000] = dataList[5]
	},
	{
		[0] = dataList[6],
		[4600] = dataList[7],
		[9200] = dataList[8],
		[16100] = dataList[9],
		[23000] = dataList[10]
	},
	{
		[0] = dataList[11],
		[5600] = dataList[12],
		[11200] = dataList[13],
		[19600] = dataList[14],
		[28000] = dataList[15]
	},
	{
		[0] = dataList[16],
		[6600] = dataList[17],
		[13200] = dataList[18],
		[23100] = dataList[19],
		[33000] = dataList[20]
	}
}

t_hero_trial_verify_plan.dataList = dataList

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

return t_hero_trial_verify_plan
