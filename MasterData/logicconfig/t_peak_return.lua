-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_peak_return.lua

module("logicconfig.config.t_peak_return", package.seeall)

local title = {
	peakTournamentActId = 2,
	returnPrize = 3,
	conditionTime = 4,
	dfJumpTo = 7,
	timeShow = 5,
	hdJumpTo = 6,
	activityId = 1,
	skinId = 8
}
local dataList = {
	{
		225001,
		217001,
		"204:2:400",
		"2022-12-02T04:59:59",
		"活动时间：11月25日 5:00 -- 12月02日 5:00",
		"func#740#8",
		"func#729",
		1002701
	}
}
local t_peak_return = {
	[225001] = dataList[1]
}

t_peak_return.dataList = dataList

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

return t_peak_return
