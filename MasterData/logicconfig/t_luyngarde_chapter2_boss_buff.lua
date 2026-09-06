-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_luyngarde_chapter2_boss_buff.lua

module("logicconfig.config.t_luyngarde_chapter2_boss_buff", package.seeall)

local title = {
	bossId = 2,
	raceId = 3,
	activityId = 1,
	buffDesc = 4
}
local dataList = {
	{
		466001,
		1,
		18001,
		"伤害+100%"
	}
}
local t_luyngarde_chapter2_boss_buff = {
	[466001] = {
		{
			[18001] = dataList[1]
		}
	}
}

t_luyngarde_chapter2_boss_buff.dataList = dataList

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

return t_luyngarde_chapter2_boss_buff
