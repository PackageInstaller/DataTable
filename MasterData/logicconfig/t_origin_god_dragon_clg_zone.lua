-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_god_dragon_clg_zone.lua

module("logicconfig.config.t_origin_god_dragon_clg_zone", package.seeall)

local title = {
	activityId = 1,
	name = 3,
	zoneId = 2,
	circleLimit = 4
}
local dataList = {
	{
		545001,
		1,
		"区域1",
		3
	},
	{
		545001,
		2,
		"区域2",
		6
	},
	{
		545001,
		3,
		"区域3",
		6
	}
}
local t_origin_god_dragon_clg_zone = {
	[545001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_origin_god_dragon_clg_zone.dataList = dataList

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

return t_origin_god_dragon_clg_zone
