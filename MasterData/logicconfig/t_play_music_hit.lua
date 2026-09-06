-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_play_music_hit.lua

module("logicconfig.config.t_play_music_hit", package.seeall)

local title = {
	hitTimeRatioRange = 3,
	isCanCombo = 5,
	hitScore = 4,
	hitPlanId = 1,
	hitId = 2
}
local dataList = {
	{
		1,
		1,
		{
			0,
			100
		},
		3,
		true
	}
}
local t_play_music_hit = {
	{
		dataList[1]
	}
}

t_play_music_hit.dataList = dataList

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

return t_play_music_hit
