-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_play_music_setting.lua

module("logicconfig.config.t_play_music_setting", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"CUR_GAMEPLANID",
		"2"
	}
}
local t_play_music_setting = {
	CUR_GAMEPLANID = dataList[1]
}

t_play_music_setting.dataList = dataList

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

return t_play_music_setting
