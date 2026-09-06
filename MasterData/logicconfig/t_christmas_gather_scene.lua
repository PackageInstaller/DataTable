-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_christmas_gather_scene.lua

module("logicconfig.config.t_christmas_gather_scene", package.seeall)

local title = {
	npcId = 3,
	npcIndex = 2,
	npcPlanId = 1
}
local dataList = {
	{
		1,
		1,
		10011047
	},
	{
		1,
		2,
		10011048
	},
	{
		1,
		3,
		1061029
	},
	{
		1,
		4,
		1061030
	},
	{
		1,
		5,
		1141039
	},
	{
		1,
		6,
		1171038
	},
	{
		1,
		7,
		1181027
	},
	{
		1,
		8,
		1191016
	},
	{
		1,
		9,
		1201020
	},
	{
		1,
		10,
		1261011
	}
}
local t_christmas_gather_scene = {
	{
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

t_christmas_gather_scene.dataList = dataList

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

return t_christmas_gather_scene
