-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_king_dragon_boss_damage.lua

module("logicconfig.config.t_king_dragon_boss_damage", package.seeall)

local title = {
	id = 2,
	gain = 4,
	dmgProgress = 3,
	damageScorePlan = 1
}
local dataList = {
	{
		1,
		1,
		10000000,
		"4:150:400"
	},
	{
		1,
		2,
		50000000,
		"4:150:400"
	},
	{
		1,
		3,
		100000000,
		"4:150:400"
	},
	{
		1,
		4,
		160000000,
		"4:150:400"
	},
	{
		1,
		5,
		220000000,
		"4:150:400"
	},
	{
		1,
		6,
		280000000,
		"4:150:400"
	},
	{
		1,
		7,
		340000000,
		"4:150:400"
	},
	{
		1,
		8,
		400000000,
		"4:150:400"
	},
	{
		2,
		1,
		10000000,
		"4:158:400"
	},
	{
		2,
		2,
		50000000,
		"4:158:400"
	},
	{
		2,
		3,
		100000000,
		"4:158:400"
	},
	{
		2,
		4,
		160000000,
		"4:158:400"
	},
	{
		2,
		5,
		220000000,
		"4:158:400"
	},
	{
		2,
		6,
		280000000,
		"4:158:400"
	},
	{
		2,
		7,
		340000000,
		"4:158:400"
	},
	{
		2,
		8,
		400000000,
		"4:158:400"
	}
}
local t_king_dragon_boss_damage = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	},
	{
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16]
	}
}

t_king_dragon_boss_damage.dataList = dataList

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

return t_king_dragon_boss_damage
