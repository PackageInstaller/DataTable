-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_jiu_clg.lua

module("logicconfig.config.t_jiu_clg", package.seeall)

local title = {
	challengeId = 2,
	jumpTo2 = 4,
	jumpTo1 = 3,
	mainRuleKey = 6,
	activityId = 1,
	jumpTo3 = 5
}
local dataList = {
	{
		386001,
		179,
		"func#618#17018",
		"mibao#zhigaoshenlin4",
		"func#43",
		"jiuclgmainview_rule01"
	},
	{
		386002,
		179,
		"func#618#17018",
		"mibao#zhigaoshenlin4",
		"func#43",
		"jiuclgmainview_rule01"
	}
}
local t_jiu_clg = {
	[386001] = dataList[1],
	[386002] = dataList[2]
}

t_jiu_clg.dataList = dataList

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

return t_jiu_clg
