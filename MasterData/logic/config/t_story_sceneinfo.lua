-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_story_sceneinfo.lua

module("logic.config.t_story_sceneinfo", package.seeall)

local title = {
	name = 2,
	code = 1,
	res = 3,
	scePath = 4
}
local dataList = {
	{
		1008,
		"序章第七幕2",
		11001,
		"chapter0/ani_00_007_1"
	},
	{
		1009,
		"序章第七幕1",
		11001,
		"chapter0/ani_00_007"
	},
	{
		1010,
		"序章第七幕3",
		11001,
		"chapter0/ani_00_007_2"
	},
	{
		1011,
		"序章八九幕",
		11001,
		"chapter0/ani_00_008"
	},
	{
		1012,
		"序章第十幕",
		11001,
		"chapter0/ani_00_010"
	},
	{
		1013,
		"序章十一幕",
		11002,
		"chapter0/ani_00_011"
	}
}
local t_story_sceneinfo = {}

t_story_sceneinfo.dataList = dataList

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
	t_story_sceneinfo[v[1]] = v

	setmetatable(v, mt)
end

return t_story_sceneinfo
