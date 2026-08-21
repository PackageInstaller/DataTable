-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_buff_effect.lua

module("logic.config.t_buff_effect", package.seeall)

local title = {
	dispelable = 5,
	code = 1,
	roundModifiable = 6,
	decrOccasion = 3,
	composition = 4,
	programming = 2
}
local dataList = {
	{
		1,
		"ModifyAttribute",
		1,
		1,
		1,
		1
	},
	{
		2,
		"MaxHpDamage",
		2,
		2,
		1,
		1
	},
	{
		3,
		"NormalDamage",
		2,
		2,
		1,
		1
	},
	{
		4,
		"MaxHpCure",
		2,
		1,
		1,
		1
	},
	{
		5,
		"NormalCure",
		2,
		1,
		1,
		1
	},
	{
		6,
		"AddState,CANNOT_NORMAL_ATTACK",
		1,
		1,
		1,
		1
	},
	{
		7,
		"AddState,CANNOT_MOVE",
		1,
		1,
		1,
		1
	},
	{
		8,
		"ModifyAttribute",
		1,
		3,
		1,
		1
	},
	{
		9,
		"Godlike",
		1,
		1,
		0,
		0
	},
	{
		10,
		"AddState,COUNTER_BEFORE_ATTACK",
		1,
		1,
		1,
		1
	},
	{
		11,
		"AddState,IGNORE_DISTANCE_WHEN_COUNTER",
		1,
		1,
		1,
		1
	},
	{
		12,
		"AddState,ALWAYS_CRITICAL",
		1,
		1,
		1,
		1
	},
	{
		13,
		"AddState,SILENT",
		1,
		1,
		1,
		1
	},
	{
		14,
		"IncrSanity",
		2,
		2,
		1,
		1
	},
	{
		15,
		"DecrSanity",
		2,
		2,
		1,
		1
	},
	{
		16,
		"AddState,CANNOT_INCR_HP",
		1,
		1,
		1,
		1
	},
	{
		17,
		"Sleep",
		1,
		1,
		1,
		1
	},
	{
		18,
		"DizzyOrSleep",
		1,
		1,
		1,
		1
	},
	{
		19,
		"AddSkill",
		1,
		1,
		0,
		0
	},
	{
		20,
		"AddState,PHYSICAL_DAMAGING_ONE_HP",
		1,
		1,
		0,
		1
	},
	{
		21,
		"AddState,MAGICAL_DAMAGING_ONE_HP",
		1,
		1,
		0,
		1
	},
	{
		22,
		"DamageLink",
		2,
		1,
		1,
		1
	},
	{
		23,
		"ModifyAttribute",
		1,
		2,
		1,
		1
	},
	{
		24,
		"Pierced,1",
		3,
		2,
		1,
		0
	},
	{
		25,
		"NormalDamage",
		1,
		2,
		1,
		1
	},
	{
		101,
		"AddState,CANNOT_MOVE",
		3,
		1,
		1,
		0
	},
	{
		102,
		"MaxHpDamage",
		3,
		1,
		1,
		0
	},
	{
		103,
		"DizzyOrSleep",
		1,
		1,
		0,
		0
	},
	{
		104,
		"AddSkill",
		2,
		1,
		1,
		0
	},
	{
		201,
		"AddState,CANNOT_INCR_HP",
		1,
		1,
		0,
		0
	}
}
local t_buff_effect = {}

t_buff_effect.dataList = dataList

local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			return rawget(t, index)
		else
			error(string.format("the field name [%s] is nonexist!", key))
		end
	end
}

for i, v in ipairs(dataList) do
	t_buff_effect[v[1]] = v

	setmetatable(v, mt)
end

return t_buff_effect
