-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_eternal_city_boss.lua

module("logicconfig.config.t_eternal_city_boss", package.seeall)

local title = {
	progressPlan = 4,
	ruleDesc = 6,
	bossId = 2,
	skinId = 5,
	creepsMasterId = 3,
	activityId = 1
}
local dataList = {
	{
		557001,
		1,
		1101,
		1,
		"13026",
		"根据单次最高伤害获得物资奖励"
	},
	{
		557001,
		2,
		1102,
		1,
		"13027",
		"根据单次最高伤害获得物资奖励"
	},
	{
		557001,
		3,
		1103,
		1,
		"13028",
		"根据单次最高伤害获得物资奖励"
	}
}
local t_eternal_city_boss = {
	[557001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_eternal_city_boss.dataList = dataList

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

return t_eternal_city_boss
