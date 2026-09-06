-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_chuang_jing_road_stargod_level.lua

module("logicconfig.config.t_chuang_jing_road_stargod_level", package.seeall)

local title = {
	cost = 4,
	starGodLv = 3,
	activityId = 1,
	level = 2
}
local dataList = {
	{
		396001,
		0,
		1,
		""
	},
	{
		396001,
		1,
		5,
		"10:396001:800"
	},
	{
		396001,
		2,
		10,
		"10:396001:800"
	},
	{
		396001,
		3,
		15,
		"10:396001:1600"
	},
	{
		396001,
		4,
		20,
		"10:396001:1600"
	},
	{
		396001,
		5,
		25,
		"10:396001:2400"
	},
	{
		396001,
		6,
		30,
		"10:396001:2400"
	},
	{
		396001,
		7,
		35,
		"10:396001:3200"
	},
	{
		396001,
		8,
		40,
		"10:396001:3200"
	},
	{
		396001,
		9,
		45,
		"10:396001:4000"
	},
	{
		396001,
		10,
		50,
		"10:396001:4000"
	}
}
local t_chuang_jing_road_stargod_level = {
	[396001] = {
		[0] = dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11]
	}
}

t_chuang_jing_road_stargod_level.dataList = dataList

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

return t_chuang_jing_road_stargod_level
