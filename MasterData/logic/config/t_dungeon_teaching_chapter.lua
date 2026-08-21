-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_dungeon_teaching_chapter.lua

module("logic.config.t_dungeon_teaching_chapter", package.seeall)

local title = {
	name = 2,
	dungeonIds = 4,
	level = 6,
	chapterId = 1,
	rate = 7,
	chapterReward = 5,
	preChapter = 3
}
local dataList = {
	{
		1001,
		"C级同步档案",
		0,
		{
			166301,
			166302,
			166303,
			166304,
			166305,
			166306,
			166307,
			166308,
			166309,
			166310,
			166311,
			166312,
			166313,
			166314,
			166315,
			166316,
			166317,
			166318
		},
		{
			{
				reward = 1900102,
				count = 6
			},
			{
				reward = 1900101,
				count = 12
			},
			{
				reward = 1900102,
				count = 18
			}
		},
		"密级：C",
		"60%"
	},
	{
		1002,
		"B级同步档案",
		1001,
		{
			166321,
			166322,
			166323,
			166324,
			166325,
			166326,
			166327,
			166328,
			166329,
			166330,
			166331,
			166332,
			166333,
			166334,
			166335,
			166336,
			166337,
			166338,
			166339,
			166340,
			166341,
			166342,
			166343,
			166344,
			166345,
			166346,
			166347,
			166348,
			166349,
			166350,
			166351,
			166352
		},
		{
			{
				reward = 1900102,
				count = 8
			},
			{
				reward = 1900101,
				count = 16
			},
			{
				reward = 1900102,
				count = 24
			},
			{
				reward = 1900101,
				count = 32
			}
		},
		"密级：A",
		"10%"
	},
	{
		1003,
		"A级同步档案",
		1002,
		{
			166381
		},
		nil,
		"密级：S",
		"???"
	}
}
local t_dungeon_teaching_chapter = {}

t_dungeon_teaching_chapter.dataList = dataList

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
	t_dungeon_teaching_chapter[v[1]] = v

	setmetatable(v, mt)
end

return t_dungeon_teaching_chapter
