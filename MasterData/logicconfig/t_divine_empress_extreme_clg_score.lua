-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_empress_extreme_clg_score.lua

module("logicconfig.config.t_divine_empress_extreme_clg_score", package.seeall)

local title = {
	scoreRange = 2,
	immunityTimes = 3,
	activityId = 1
}
local dataList = {
	{
		485001,
		2,
		9
	},
	{
		485001,
		4,
		8
	},
	{
		485001,
		6,
		7
	},
	{
		485001,
		8,
		6
	},
	{
		485001,
		9,
		5
	},
	{
		485001,
		10,
		4
	},
	{
		485001,
		12,
		3
	}
}
local t_divine_empress_extreme_clg_score = {
	[485001] = {
		[2] = dataList[1],
		[4] = dataList[2],
		[6] = dataList[3],
		[8] = dataList[4],
		[9] = dataList[5],
		[10] = dataList[6],
		[12] = dataList[7]
	}
}

t_divine_empress_extreme_clg_score.dataList = dataList

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

return t_divine_empress_extreme_clg_score
