-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_camera.lua

module("logic.config.t_camera", package.seeall)

local title = {
	cameraMaskMode = 5,
	cameraY = 4,
	id = 1,
	resPath = 2,
	kDragFactor = 3
}
local dataList = {
	{
		1,
		"battle_normal",
		0,
		0,
		0
	},
	{
		2,
		"battle_skill",
		0.02,
		18,
		0
	},
	{
		3,
		"dungeon_2001",
		0.02,
		25,
		0
	},
	{
		4,
		"house",
		0,
		0,
		1
	},
	{
		5,
		"dungeon_2002",
		0.008,
		3.87,
		0
	},
	{
		6,
		"room",
		0.008,
		0,
		1
	},
	{
		7,
		"battle_start",
		0,
		0,
		0
	},
	{
		8,
		"team",
		0,
		0,
		1
	},
	{
		9,
		"rungroup",
		0.02,
		0,
		1
	},
	{
		10,
		"camera_new513",
		0,
		0,
		0
	},
	{
		11,
		"rungroup_judge",
		0,
		0,
		0
	},
	{
		12,
		"battle_skill_right",
		0,
		0,
		0
	},
	{
		13,
		"house_explore_camera",
		0,
		0,
		0
	},
	{
		14,
		"character_preview",
		0,
		0,
		0
	},
	{
		15,
		"lottery",
		0,
		0,
		1
	}
}
local t_camera = {}

t_camera.dataList = dataList

local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			return rawget(t, index)
		else
			error(string.format("the field name [%s] is nonexist!", key))
		end
	end
}

for i, v in ipairs(dataList) do
	t_camera[v[1]] = v

	setmetatable(v, mt)
end

return t_camera
