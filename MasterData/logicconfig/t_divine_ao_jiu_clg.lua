-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_ao_jiu_clg.lua

module("logicconfig.config.t_divine_ao_jiu_clg", package.seeall)

local title = {
	buyNormalStagePassCost = 7,
	jumpTo = 9,
	extremeClgActivePetCount = 4,
	dailyNormalClgTimes = 5,
	extremeClgFirstPassPrize = 2,
	normalClgTimesLimit = 6,
	extremeClgBuffTypeNeed = 3,
	raceId = 8,
	activityId = 1
}
local dataList = {
	{
		511001,
		"4:391:100",
		{
			4,
			4,
			4,
			4
		},
		100,
		2,
		6,
		"105:6113:500",
		16040,
		{
			"func#618#16040",
			"ui#lottery",
			"mibao#shenyaolibao",
			"func#545#25"
		}
	}
}
local t_divine_ao_jiu_clg = {
	[511001] = dataList[1]
}

t_divine_ao_jiu_clg.dataList = dataList

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

return t_divine_ao_jiu_clg
