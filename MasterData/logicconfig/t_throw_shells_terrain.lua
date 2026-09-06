-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_throw_shells_terrain.lua

module("logicconfig.config.t_throw_shells_terrain", package.seeall)

local title = {
	terrainId = 1,
	terrainName = 2,
	isSingle = 4,
	monsterPlanId = 3
}
local dataList = {
	{
		1,
		"throwshellsscene_1",
		1,
		true
	},
	{
		2,
		"throwshellsscene_2",
		2,
		true
	},
	{
		3,
		"throwshellsscene_3",
		3,
		true
	},
	{
		4,
		"throwshellsscene_4",
		4,
		true
	},
	{
		5,
		"throwshellsscene_5",
		8,
		false
	},
	{
		6,
		"throwshellsscene_6",
		4,
		false
	},
	{
		7,
		"throwshellsscene_7",
		7,
		false
	},
	{
		8,
		"throwshellsscene_8",
		3,
		false
	},
	{
		9,
		"throwshellsscene_9",
		5,
		true
	},
	{
		10,
		"throwshellsscene_10",
		9,
		true
	}
}
local t_throw_shells_terrain = {
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

t_throw_shells_terrain.dataList = dataList

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

return t_throw_shells_terrain
