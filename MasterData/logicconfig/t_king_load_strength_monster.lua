-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_king_load_strength_monster.lua

module("logicconfig.config.t_king_load_strength_monster", package.seeall)

local title = {
	btlBg = 3,
	name = 2,
	enableGainExp = 7,
	formationId = 4,
	changeLevel = 1,
	heroSkillId = 5,
	recommendZdl = 6,
	btlMode = 8
}
local dataList = {
	{
		1,
		"王者之路修炼挑战难1",
		"",
		1,
		"",
		0,
		false,
		""
	},
	{
		2,
		"王者之路修炼挑战难2",
		"",
		2,
		"",
		0,
		false,
		""
	},
	{
		3,
		"王者之路修炼挑战难3",
		"",
		4,
		"",
		0,
		false,
		""
	},
	{
		4,
		"王者之路修炼挑战难4",
		"",
		8,
		"",
		0,
		false,
		""
	},
	{
		5,
		"王者之路修炼挑战难5",
		"",
		7,
		"",
		0,
		false,
		""
	},
	{
		6,
		"王者之路修炼挑战难6",
		"",
		5,
		"",
		0,
		false,
		""
	},
	{
		7,
		"王者之路修炼挑战难7",
		"",
		3,
		"",
		0,
		false,
		""
	},
	{
		8,
		"王者之路修炼挑战难8",
		"",
		6,
		"",
		0,
		false,
		""
	}
}
local t_king_load_strength_monster = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8]
}

t_king_load_strength_monster.dataList = dataList

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

return t_king_load_strength_monster
