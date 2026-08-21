-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_gallery_music.lua

module("logic.config.t_gallery_music", package.seeall)

local title = {
	id = 1,
	name = 2,
	res = 3,
	sortType = 4
}
local dataList = {
	{
		1001,
		"曲目1",
		"amb_battle_city",
		999
	},
	{
		1002,
		"曲目2",
		"amb_spaces_room",
		998
	},
	{
		1003,
		"曲目3",
		"amb_juqing_OADzhukong",
		997
	},
	{
		1004,
		"曲目4",
		"amb_juqing_aerfadibiao",
		996
	},
	{
		1005,
		"曲目3",
		"amb_juqing_OADzhukong",
		995
	},
	{
		1006,
		"曲目3",
		"amb_juqing_OADzhukong",
		994
	},
	{
		1007,
		"曲目3",
		"amb_juqing_OADzhukong",
		993
	},
	{
		1008,
		"曲目3",
		"amb_juqing_OADzhukong",
		992
	},
	{
		1009,
		"曲目3",
		"amb_juqing_OADzhukong",
		991
	},
	{
		1010,
		"曲目3",
		"music_juqing_dangerous",
		990
	},
	{
		1011,
		"曲目3",
		"music_juqing_untildawn",
		989
	},
	{
		1012,
		"曲目3",
		"music_juqing_sad",
		988
	},
	{
		1013,
		"曲目3",
		"music_juqing_shikong",
		987
	},
	{
		1014,
		"曲目3",
		"music_juqing_qingsong",
		986
	},
	{
		1015,
		"测试曲目",
		"music_tujian_battle_shenhua_buxiu",
		985
	}
}
local t_gallery_music = {}

t_gallery_music.dataList = dataList

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
	t_gallery_music[v[1]] = v

	setmetatable(v, mt)
end

return t_gallery_music
