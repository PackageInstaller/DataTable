-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_material_game_wave_ext_prize.lua

module("logicconfig.config.t_origin_material_game_wave_ext_prize", package.seeall)

local title = {
	waveId = 2,
	prizeId = 1,
	prize = 3
}
local dataList = {
	{
		1,
		1,
		"8:1:1"
	},
	{
		2,
		5,
		"8:1:2"
	},
	{
		3,
		10,
		"8:1:3"
	},
	{
		4,
		20,
		"8:1:4"
	}
}
local t_origin_material_game_wave_ext_prize = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4]
}

t_origin_material_game_wave_ext_prize.dataList = dataList

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

return t_origin_material_game_wave_ext_prize
