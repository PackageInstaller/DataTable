-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_character_sound_sort.lua

module("logic.config.t_character_sound_sort", package.seeall)

local title = {
	id = 1,
	sort_id = 2
}
local dataList = {
	{
		1,
		1
	},
	{
		2,
		2
	},
	{
		3,
		3
	},
	{
		4,
		4
	},
	{
		5,
		5
	},
	{
		6,
		8
	},
	{
		7,
		9
	},
	{
		8,
		10
	},
	{
		9,
		11
	},
	{
		10,
		12
	},
	{
		11,
		14
	},
	{
		12,
		15
	},
	{
		13,
		16
	},
	{
		14,
		17
	},
	{
		15,
		18
	},
	{
		16,
		19
	},
	{
		17,
		20
	},
	{
		18,
		21
	},
	{
		19,
		22
	},
	{
		20,
		23
	},
	{
		21,
		24
	},
	{
		22,
		25
	},
	{
		23,
		26
	},
	{
		24,
		27
	},
	{
		25,
		28
	},
	{
		26,
		29
	},
	{
		27,
		52
	},
	{
		28,
		30
	},
	{
		29,
		31
	},
	{
		30,
		32
	},
	{
		31,
		33
	},
	{
		32,
		34
	},
	{
		33,
		35
	},
	{
		34,
		36
	},
	{
		35,
		37
	},
	{
		36,
		38
	},
	{
		37,
		39
	},
	{
		38,
		40
	},
	{
		39,
		41
	},
	{
		40,
		42
	},
	{
		41,
		6
	},
	{
		42,
		7
	},
	{
		43,
		13
	},
	{
		44,
		43
	},
	{
		45,
		44
	},
	{
		46,
		45
	},
	{
		47,
		46
	},
	{
		48,
		47
	},
	{
		49,
		48
	},
	{
		50,
		49
	},
	{
		51,
		50
	},
	{
		52,
		51
	}
}
local t_character_sound_sort = {}

t_character_sound_sort.dataList = dataList

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
	t_character_sound_sort[v[1]] = v

	setmetatable(v, mt)
end

return t_character_sound_sort
