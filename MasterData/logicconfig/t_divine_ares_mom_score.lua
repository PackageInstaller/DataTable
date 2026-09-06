-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_ares_mom_score.lua

module("logicconfig.config.t_divine_ares_mom_score", package.seeall)

local title = {
	buffCounterId = 4,
	desc = 3,
	passDesc = 6,
	scoreUnit = 5,
	activityId = 1,
	scoreType = 2
}
local dataList = {
	{
		369001,
		1,
		"水能量",
		20055502,
		1,
		"水能量（%s/%s）"
	},
	{
		369001,
		2,
		"火能量",
		20055504,
		1,
		"火能量（%s/%s）"
	},
	{
		369001,
		3,
		"草能量",
		20055506,
		1,
		"草能量（%s/%s）"
	}
}
local t_divine_ares_mom_score = {
	[369001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_divine_ares_mom_score.dataList = dataList

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

return t_divine_ares_mom_score
