-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_vip.lua

module("logicconfig.config.t_vip", package.seeall)

local title = {
	arenaHolidayChallengeTime = 5,
	name = 2,
	arenaDailyChallengeTime = 4,
	id = 1,
	hatchNum = 3
}
local dataList = {
	{
		0,
		"普通",
		2,
		10,
		10
	},
	{
		1,
		"小月卡",
		2,
		10,
		10
	},
	{
		2,
		"大月卡",
		2,
		10,
		10
	}
}
local t_vip = {
	[0] = dataList[1],
	dataList[2],
	dataList[3]
}

t_vip.dataList = dataList

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

return t_vip
