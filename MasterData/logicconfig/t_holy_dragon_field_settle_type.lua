-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_holy_dragon_field_settle_type.lua

module("logicconfig.config.t_holy_dragon_field_settle_type", package.seeall)

local title = {
	settleTypeParam = 3,
	name = 4,
	settleType = 2,
	activityId = 1
}
local dataList = {
	{
		611001,
		1,
		"ActiveCount",
		82056462
	},
	{
		611001,
		2,
		"CircleCount",
		82056463
	},
	{
		611001,
		3,
		"ComboCount",
		82056464
	},
	{
		611001,
		4,
		"KillCount",
		82056465
	},
	{
		611001,
		5,
		"Alive",
		82057455
	},
	{
		611001,
		6,
		"BossDamage",
		82057456
	},
	{
		611001,
		7,
		"Alive",
		82057457
	},
	{
		611001,
		8,
		"BossDamage",
		82057458
	},
	{
		611001,
		9,
		"BossDamage",
		82057459
	},
	{
		611001,
		10,
		"MaxDamageBossDamage",
		82057460
	}
}
local t_holy_dragon_field_settle_type = {
	[611001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	}
}

t_holy_dragon_field_settle_type.dataList = dataList

local multiLanguageCells = {
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

return t_holy_dragon_field_settle_type
