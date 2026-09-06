-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_xing_jiang_clg.lua

module("logicconfig.config.t_divine_xing_jiang_clg", package.seeall)

local title = {
	challengeId = 8,
	passClgPrize = 2,
	jumpTo3 = 7,
	jumpTo1 = 5,
	dailyGameCountLimit = 3,
	jumpTo2 = 6,
	activityId = 1,
	maxProgressPerGame = 4
}
local dataList = {
	{
		359001,
		"4:510291:100",
		3,
		8,
		"func#618#11019",
		"mibao#shenyaolibao",
		"mibao#xinqionglongming1",
		163
	}
}
local t_divine_xing_jiang_clg = {
	[359001] = dataList[1]
}

t_divine_xing_jiang_clg.dataList = dataList

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

return t_divine_xing_jiang_clg
