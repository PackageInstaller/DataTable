-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dark_dragon_addition.lua

module("logicconfig.config.t_dark_dragon_addition", package.seeall)

local title = {
	stageId = 2,
	addDes = 4,
	seasonId = 1,
	raceIds = 3
}
local dataList = {
	{
		1,
		1,
		{
			10146,
			10308,
			10320,
			10345
		},
		"下列精灵在该挑战中伤害加成35%"
	},
	{
		1,
		2,
		{
			10131,
			10098,
			10313,
			10324
		},
		"下列精灵在该挑战中受伤减少20%"
	},
	{
		1,
		3,
		{
			10167,
			10352,
			10320,
			10345
		},
		"下列精灵在该挑战中伤害加成35%"
	},
	{
		1,
		4,
		{
			10203,
			10098,
			10333,
			10345
		},
		"下列精灵在该挑战中生命上限+35%"
	},
	{
		1,
		5,
		{
			10316,
			10127,
			10308,
			10345
		},
		"下列精灵在该挑战中伤害加成35%"
	},
	{
		1,
		6,
		{
			10131,
			10098,
			10313,
			10324
		},
		"下列精灵在该挑战中受伤减少20%"
	},
	{
		1,
		7,
		{
			10142,
			10146,
			10320,
			10345
		},
		"下列精灵在该挑战中伤害加成35%"
	}
}
local t_dark_dragon_addition = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	}
}

t_dark_dragon_addition.dataList = dataList

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

return t_dark_dragon_addition
