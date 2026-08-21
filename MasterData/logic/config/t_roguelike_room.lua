-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_roguelike_room.lua

module("logic.config.t_roguelike_room", package.seeall)

local title = {
	iconOffset = 6,
	name = 3,
	model = 5,
	type = 2,
	id = 1,
	icon = 4,
	initialState = 8,
	effect = 7
}
local dataList = {
	{
		1001,
		1,
		"初始房间",
		"rungroup_point3",
		"",
		nil,
		0,
		0
	},
	{
		2001,
		2,
		"事件房间",
		"rungroup_point2",
		"",
		nil,
		0,
		0
	},
	{
		3001,
		3,
		"战斗房间",
		"rungroup_point4",
		"",
		nil,
		0,
		0
	},
	{
		4001,
		4,
		"道具房间",
		"rungroup_point6",
		"606_prop",
		{
			0.7,
			0.7,
			0,
			-0.4
		},
		0,
		0
	},
	{
		5001,
		5,
		"商店房间",
		"rungroup_point5",
		"606_shop",
		{
			0.5,
			0.5,
			0,
			-0.8
		},
		0,
		0
	},
	{
		6002,
		6,
		"落骰子",
		"rungroup_point7",
		"606_game_machines",
		{
			0.5,
			0.5,
			0,
			-0.8
		},
		0,
		0
	},
	{
		7001,
		7,
		"下层房间",
		"rungroup_point3",
		"",
		nil,
		0,
		2
	},
	{
		8001,
		8,
		"关底房间",
		"rungroup_point8",
		"",
		nil,
		0,
		2
	},
	{
		9001,
		9,
		"出入口房间",
		"rungroup_point3",
		"",
		nil,
		0,
		0
	}
}
local t_roguelike_room = {}

t_roguelike_room.dataList = dataList

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
	t_roguelike_room[v[1]] = v

	setmetatable(v, mt)
end

return t_roguelike_room
