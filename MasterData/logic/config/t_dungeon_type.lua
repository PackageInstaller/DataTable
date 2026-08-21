-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_dungeon_type.lua

module("logic.config.t_dungeon_type", package.seeall)

local title = {
	reChallenge = 3,
	name = 2,
	type = 1
}
local dataList = {
	{
		0,
		"任意",
		0
	},
	{
		1,
		"主线",
		0
	},
	{
		2,
		"默契",
		0
	},
	{
		4,
		"测验点",
		1
	},
	{
		5,
		"序章",
		0
	},
	{
		6,
		"战术培训",
		0
	},
	{
		7,
		"红雾地区",
		1
	},
	{
		8,
		"序列矿场",
		1
	},
	{
		9,
		"夸克制药",
		1
	},
	{
		10,
		"月相计划-明面",
		0
	},
	{
		11,
		"月相计划-暗面",
		0
	},
	{
		12,
		"断章",
		0
	},
	{
		13,
		"厄运预告",
		0
	},
	{
		14,
		"雕像",
		0
	},
	{
		15,
		"钢琴",
		0
	},
	{
		16,
		"守秘人体验",
		0
	}
}
local t_dungeon_type = {}

t_dungeon_type.dataList = dataList

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
	t_dungeon_type[v[1]] = v

	setmetatable(v, mt)
end

return t_dungeon_type
