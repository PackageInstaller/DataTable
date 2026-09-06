-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_audio_battle_bgm.lua

module("logicconfig.config.t_audio_battle_bgm", package.seeall)

local title = {
	id = 1,
	taskId = 3,
	audio = 2
}
local dataList = {
	{
		1,
		10002,
		0
	},
	{
		2,
		10000,
		10011
	},
	{
		3,
		13003,
		0
	},
	{
		4,
		13001,
		0
	},
	{
		5,
		13002,
		0
	}
}
local t_audio_battle_bgm = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5]
}

t_audio_battle_bgm.dataList = dataList

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

return t_audio_battle_bgm
