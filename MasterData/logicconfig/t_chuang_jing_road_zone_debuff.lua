-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_chuang_jing_road_zone_debuff.lua

module("logicconfig.config.t_chuang_jing_road_zone_debuff", package.seeall)

local title = {
	zoneNum = 2,
	activityId = 1,
	buffDesc = 3
}
local dataList = {
	{
		396001,
		1,
		"敌阵造成的克制伤害+20%，受到的弱效伤害-20%"
	},
	{
		396001,
		2,
		"敌阵造成的克制伤害+40%，受到的弱效伤害-40%"
	},
	{
		396001,
		3,
		"敌阵造成的克制伤害+60%，受到的弱效伤害-60%"
	},
	{
		396001,
		4,
		"敌阵造成的克制伤害+80%，受到的弱效伤害-80%"
	}
}
local t_chuang_jing_road_zone_debuff = {
	[396001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_chuang_jing_road_zone_debuff.dataList = dataList

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

return t_chuang_jing_road_zone_debuff
