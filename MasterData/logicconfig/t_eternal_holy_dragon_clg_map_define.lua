-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_eternal_holy_dragon_clg_map_define.lua

module("logicconfig.config.t_eternal_holy_dragon_clg_map_define", package.seeall)

local title = {
	c0 = 3,
	c2 = 5,
	rowIndex = 2,
	c3 = 6,
	c6 = 9,
	c7 = 10,
	c8 = 11,
	c5 = 8,
	mapId = 1,
	c1 = 4,
	c4 = 7
}
local dataList = {
	{
		1,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0
	},
	{
		1,
		1,
		3000,
		3000,
		0,
		0,
		3000,
		3013,
		3000,
		0,
		0
	},
	{
		1,
		2,
		0,
		3011,
		2011,
		3000,
		3000,
		2012,
		3000,
		0,
		0
	},
	{
		1,
		3,
		0,
		3000,
		3000,
		3012,
		0,
		0,
		3000,
		3000,
		3019
	},
	{
		1,
		4,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0
	},
	{
		2,
		0,
		3000,
		3000,
		3021,
		0,
		0,
		0,
		3025,
		3000,
		3029
	},
	{
		2,
		1,
		2021,
		2022,
		3000,
		0,
		0,
		0,
		3000,
		2025,
		2026
	},
	{
		2,
		2,
		0,
		0,
		3000,
		0,
		0,
		0,
		3000,
		0,
		0
	},
	{
		2,
		3,
		0,
		0,
		3000,
		2023,
		0,
		2024,
		3000,
		0,
		0
	},
	{
		2,
		4,
		0,
		0,
		3022,
		3000,
		3023,
		3000,
		3024,
		0,
		0
	},
	{
		3,
		0,
		3000,
		3000,
		3000,
		2038,
		3033,
		3000,
		3000,
		3000,
		3037
	},
	{
		3,
		1,
		2031,
		2032,
		3000,
		2037,
		3000,
		2035,
		2034,
		2033,
		3000
	},
	{
		3,
		2,
		3000,
		3000,
		3031,
		2036,
		3036,
		2036,
		3034,
		3000,
		3000
	},
	{
		3,
		3,
		3000,
		2033,
		2034,
		2035,
		3000,
		2037,
		3000,
		2032,
		2031
	},
	{
		3,
		4,
		3035,
		3000,
		3000,
		3000,
		3032,
		2038,
		3000,
		3000,
		3039
	}
}
local t_eternal_holy_dragon_clg_map_define = {
	{
		[0] = dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	},
	{
		[0] = dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	},
	{
		[0] = dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15]
	}
}

t_eternal_holy_dragon_clg_map_define.dataList = dataList

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

return t_eternal_holy_dragon_clg_map_define
