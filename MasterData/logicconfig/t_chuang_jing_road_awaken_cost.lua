-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_chuang_jing_road_awaken_cost.lua

module("logicconfig.config.t_chuang_jing_road_awaken_cost", package.seeall)

local title = {
	cost = 3,
	activityId = 1,
	level = 2
}
local dataList = {
	{
		396001,
		0,
		""
	},
	{
		396001,
		1,
		"10:396001:1000"
	},
	{
		396001,
		2,
		"10:396001:2000"
	},
	{
		396001,
		3,
		"10:396001:3000"
	},
	{
		396001,
		4,
		"10:396001:4000"
	},
	{
		396001,
		5,
		"10:396001:5000"
	},
	{
		396001,
		6,
		"10:396001:6000"
	}
}
local t_chuang_jing_road_awaken_cost = {
	[396001] = {
		[0] = dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	}
}

t_chuang_jing_road_awaken_cost.dataList = dataList

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

return t_chuang_jing_road_awaken_cost
