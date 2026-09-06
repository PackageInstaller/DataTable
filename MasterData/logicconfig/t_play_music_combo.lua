-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_play_music_combo.lua

module("logicconfig.config.t_play_music_combo", package.seeall)

local title = {
	comboCount = 3,
	comboId = 2,
	comboPlanId = 1,
	exFixedScore = 4
}
local dataList = {
	{
		1,
		1,
		0,
		0
	},
	{
		2,
		1,
		0,
		0
	},
	{
		2,
		2,
		1,
		1
	},
	{
		2,
		3,
		3,
		2
	},
	{
		2,
		4,
		5,
		3
	},
	{
		2,
		5,
		7,
		4
	},
	{
		2,
		6,
		9,
		5
	},
	{
		2,
		7,
		10,
		6
	}
}
local t_play_music_combo = {
	{
		dataList[1]
	},
	{
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	}
}

t_play_music_combo.dataList = dataList

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

return t_play_music_combo
