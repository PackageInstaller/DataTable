-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_family_battle_nest_monster.lua

module("logicconfig.config.t_family_battle_nest_monster", package.seeall)

local title = {
	nestMonsterId = 2,
	nestMonsterPlanId = 1,
	creepsMasterId = 3
}
local dataList = {
	{
		1,
		1,
		200001
	},
	{
		1,
		2,
		200002
	},
	{
		1,
		3,
		200003
	},
	{
		1,
		4,
		200004
	},
	{
		1,
		5,
		200005
	},
	{
		2,
		1,
		200006
	},
	{
		2,
		2,
		200007
	},
	{
		2,
		3,
		200008
	},
	{
		2,
		4,
		200009
	},
	{
		2,
		5,
		200010
	},
	{
		3,
		1,
		200011
	},
	{
		3,
		2,
		200012
	},
	{
		3,
		3,
		200013
	},
	{
		3,
		4,
		200014
	},
	{
		3,
		5,
		200015
	},
	{
		4,
		1,
		200016
	},
	{
		4,
		2,
		200017
	},
	{
		4,
		3,
		200018
	},
	{
		4,
		4,
		200019
	},
	{
		4,
		5,
		200020
	}
}
local t_family_battle_nest_monster = {
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
	},
	{
		dataList[16],
		dataList[17],
		dataList[18],
		dataList[19],
		dataList[20]
	}
}

t_family_battle_nest_monster.dataList = dataList

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

return t_family_battle_nest_monster
