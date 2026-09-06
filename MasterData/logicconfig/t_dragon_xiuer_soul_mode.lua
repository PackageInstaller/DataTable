-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dragon_xiuer_soul_mode.lua

module("logicconfig.config.t_dragon_xiuer_soul_mode", package.seeall)

local title = {
	bossTeamId = 3,
	activityId = 1,
	challengeTimes = 2,
	prize = 4
}
local dataList = {
	{
		323001,
		6,
		1010,
		"4:409:30"
	},
	{
		323002,
		6,
		2010,
		"4:386:30"
	}
}
local t_dragon_xiuer_soul_mode = {
	[323001] = dataList[1],
	[323002] = dataList[2]
}

t_dragon_xiuer_soul_mode.dataList = dataList

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

return t_dragon_xiuer_soul_mode
