-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_mirror_challenge.lua

module("logicconfig.config.t_mirror_challenge", package.seeall)

local title = {
	desc = 3,
	buffTimes = 4,
	dailyPrize = 5,
	dailyTimesLimit = 6,
	mainView = 7,
	activityId = 1,
	challengePlanId = 2
}
local dataList = {
	{
		67001,
		1,
		"辛西娅的祝福：我方精灵克制效果提高100%",
		1,
		"10:67001:80",
		12,
		"activitymoyanview"
	}
}
local t_mirror_challenge = {
	[67001] = dataList[1]
}

t_mirror_challenge.dataList = dataList

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

return t_mirror_challenge
