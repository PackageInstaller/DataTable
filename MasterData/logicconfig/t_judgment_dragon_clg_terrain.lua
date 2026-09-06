-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_judgment_dragon_clg_terrain.lua

module("logicconfig.config.t_judgment_dragon_clg_terrain", package.seeall)

local title = {
	terrainPlanId = 1,
	name = 3,
	count = 4,
	terrainId = 2,
	desc = 5
}
local dataList = {
	{
		1,
		1,
		"漩涡",
		1,
		"己阵所有精灵-10%伤害（不叠加）"
	},
	{
		1,
		2,
		"漩涡",
		2,
		"己阵所有精灵-20%伤害（不叠加）"
	},
	{
		1,
		3,
		"漩涡",
		3,
		"己阵所有精灵-30%伤害（不叠加）"
	},
	{
		1,
		4,
		"引雷",
		1,
		"己阵所有精灵受到伤害+20%（不叠加）"
	},
	{
		1,
		5,
		"引雷",
		2,
		"己阵所有精灵受到伤害+30%（不叠加）"
	},
	{
		1,
		6,
		"引雷",
		3,
		"己阵所有精灵受到伤害+50%（不叠加）"
	},
	{
		1,
		7,
		"熔浆",
		1,
		"己阵所有精灵气势-20"
	},
	{
		1,
		8,
		"熔浆",
		2,
		"己阵所有精灵气势-40"
	},
	{
		1,
		9,
		"熔浆",
		3,
		"己阵所有精灵气势-60"
	}
}
local t_judgment_dragon_clg_terrain = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9]
	}
}

t_judgment_dragon_clg_terrain.dataList = dataList

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

return t_judgment_dragon_clg_terrain
