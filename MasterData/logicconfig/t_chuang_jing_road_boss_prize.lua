-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_chuang_jing_road_boss_prize.lua

module("logicconfig.config.t_chuang_jing_road_boss_prize", package.seeall)

local title = {
	id = 2,
	damage = 3,
	activityId = 1,
	prize = 4
}
local dataList = {
	{
		396001,
		1,
		1,
		"10:396001:1000"
	},
	{
		396001,
		2,
		1000000,
		"10:396001:1000"
	},
	{
		396001,
		3,
		5000000,
		"10:396001:1000"
	},
	{
		396001,
		4,
		10000000,
		"10:396001:1000"
	},
	{
		396001,
		5,
		20000000,
		"10:396001:1000"
	}
}
local t_chuang_jing_road_boss_prize = {
	[396001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_chuang_jing_road_boss_prize.dataList = dataList

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

return t_chuang_jing_road_boss_prize
