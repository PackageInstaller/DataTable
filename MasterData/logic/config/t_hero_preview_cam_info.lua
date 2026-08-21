-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_hero_preview_cam_info.lua

module("logic.config.t_hero_preview_cam_info", package.seeall)

local title = {
	pos = 2,
	name = 5,
	rot = 3,
	id = 1,
	fov = 4
}
local dataList = {
	{
		1,
		{
			z = 0,
			x = -17.421,
			y = 0.876
		},
		{
			z = 0,
			x = 0,
			y = 96
		},
		18,
		"兵长视角-相机"
	},
	{
		2,
		{
			z = 0,
			x = -17.421,
			y = 0.986
		},
		{
			z = 0,
			x = 0,
			y = 96
		},
		18,
		"浮空-相机"
	},
	{
		3,
		{
			z = 0,
			x = -17.421,
			y = 0.953
		},
		{
			z = 0,
			x = 0,
			y = 96
		},
		18,
		"较高视角-相机"
	},
	{
		4,
		{
			z = 0,
			x = -17.421,
			y = 1.003
		},
		{
			z = 0,
			x = 0,
			y = 96
		},
		18,
		"欧几里得视角-相机"
	},
	{
		5,
		{
			z = 0,
			x = -17.421,
			y = 0.907
		},
		{
			z = 0,
			x = 0,
			y = 96
		},
		18,
		"正常人-相机"
	}
}
local t_hero_preview_cam_info = {}

t_hero_preview_cam_info.dataList = dataList

local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			return rawget(t, index)
		else
			error(string.format("the field name[%s] is nonexist!", key))
		end
	end
}

for i, v in ipairs(dataList) do
	t_hero_preview_cam_info[v[1]] = v

	setmetatable(v, mt)
end

return t_hero_preview_cam_info
