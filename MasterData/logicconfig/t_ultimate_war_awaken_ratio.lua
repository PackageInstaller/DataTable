-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ultimate_war_awaken_ratio.lua

module("logicconfig.config.t_ultimate_war_awaken_ratio", package.seeall)

local title = {
	awakenLv = 2,
	addScoreRatio = 3,
	activityId = 1
}
local dataList = {
	{
		434001,
		1,
		1
	},
	{
		434001,
		2,
		2
	},
	{
		434001,
		3,
		3
	},
	{
		434001,
		4,
		4
	},
	{
		434001,
		5,
		5
	},
	{
		434001,
		6,
		6
	}
}
local t_ultimate_war_awaken_ratio = {
	[434001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_ultimate_war_awaken_ratio.dataList = dataList

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

return t_ultimate_war_awaken_ratio
