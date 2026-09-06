-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_holy_dragon_temple_floor.lua

module("logicconfig.config.t_holy_dragon_temple_floor", package.seeall)

local title = {
	formConditionId = 8,
	name = 3,
	floorId = 2,
	supportPetPlan = 6,
	openTime = 4,
	relevantFieldId = 9,
	endTime = 5,
	activityId = 1,
	lockHeroSkill = 7
}
local dataList = {
	{
		609001,
		1,
		82057645,
		"2026-06-26T05:00:00",
		"2026-07-24T05:00:00",
		0,
		0,
		0,
		1
	},
	{
		609001,
		2,
		82057646,
		"2026-07-03T05:00:00",
		"2026-07-24T05:00:00",
		0,
		0,
		0,
		2
	},
	{
		609001,
		3,
		82057647,
		"2026-07-10T05:00:00",
		"2026-07-24T05:00:00",
		1,
		414049,
		0,
		3
	}
}
local t_holy_dragon_temple_floor = {
	[609001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_holy_dragon_temple_floor.dataList = dataList

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

return t_holy_dragon_temple_floor
