-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_zoo_scene_elems.lua

module("logicconfig.config.t_zoo_scene_elems", package.seeall)

local title = {
	id = 1,
	buildingType = 2
}
local dataList = {
	{
		1001,
		0
	},
	{
		1002,
		0
	},
	{
		1003,
		0
	},
	{
		1004,
		0
	},
	{
		1005,
		0
	},
	{
		1006,
		0
	},
	{
		1008,
		0
	},
	{
		1007,
		0
	},
	{
		1011,
		0
	},
	{
		1010,
		0
	},
	{
		1009,
		0
	},
	{
		2001,
		0
	},
	{
		3001,
		0
	},
	{
		3002,
		0
	},
	{
		3003,
		0
	},
	{
		3004,
		0
	},
	{
		4001,
		0
	}
}
local t_zoo_scene_elems = {
	[1001] = dataList[1],
	[1002] = dataList[2],
	[1003] = dataList[3],
	[1004] = dataList[4],
	[1005] = dataList[5],
	[1006] = dataList[6],
	[1008] = dataList[7],
	[1007] = dataList[8],
	[1011] = dataList[9],
	[1010] = dataList[10],
	[1009] = dataList[11],
	[2001] = dataList[12],
	[3001] = dataList[13],
	[3002] = dataList[14],
	[3003] = dataList[15],
	[3004] = dataList[16],
	[4001] = dataList[17]
}

t_zoo_scene_elems.dataList = dataList

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

return t_zoo_scene_elems
