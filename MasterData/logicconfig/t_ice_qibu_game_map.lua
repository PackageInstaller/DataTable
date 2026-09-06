-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ice_qibu_game_map.lua

module("logicconfig.config.t_ice_qibu_game_map", package.seeall)

local title = {
	jsonDataPath = 2,
	mapId = 1,
	maxGameTime = 3
}
local dataList = {
	{
		1,
		"scene/iceqibugame/bqbmap01.txt",
		60
	},
	{
		2,
		"scene/iceqibugame/bqbmap02.txt",
		60
	},
	{
		3,
		"scene/iceqibugame/bqbmap03.txt",
		60
	},
	{
		4,
		"scene/iceqibugame/bqbmap04.txt",
		60
	},
	{
		5,
		"scene/iceqibugame/bqbmap05.txt",
		60
	},
	{
		6,
		"scene/iceqibugame/bqbmap06.txt",
		60
	},
	{
		7,
		"scene/iceqibugame/bqbmap07.txt",
		60
	},
	{
		8,
		"scene/iceqibugame/bqbmap08.txt",
		60
	},
	{
		9,
		"scene/iceqibugame/bqbmap09.txt",
		60
	},
	{
		10,
		"scene/iceqibugame/bqbmap10.txt",
		60
	},
	{
		11,
		"scene/iceqibugame/bqbmap11.txt",
		60
	},
	{
		12,
		"scene/iceqibugame/bqbmap12.txt",
		60
	},
	{
		13,
		"scene/iceqibugame/bqbmap13.txt",
		60
	},
	{
		14,
		"scene/iceqibugame/bqbmap14.txt",
		60
	},
	{
		15,
		"scene/iceqibugame/bqbmap15.txt",
		60
	}
}
local t_ice_qibu_game_map = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8],
	dataList[9],
	dataList[10],
	dataList[11],
	dataList[12],
	dataList[13],
	dataList[14],
	dataList[15]
}

t_ice_qibu_game_map.dataList = dataList

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

return t_ice_qibu_game_map
