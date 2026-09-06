-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_tour_arena_zone.lua

module("logicconfig.config.t_tour_arena_zone", package.seeall)

local title = {
	provinces = 3,
	name = 2,
	zoneId = 1
}
local dataList = {
	{
		1,
		"全服",
		{
			"北京",
			"天津",
			"河北",
			"山西",
			"内蒙古",
			"辽宁",
			"吉林",
			"黑龙江",
			"上海",
			"江苏",
			"浙江",
			"安徽",
			"福建",
			"江西",
			"山东",
			"台湾",
			"河南",
			"湖北",
			"湖南",
			"海南",
			"广东",
			"广西",
			"香港",
			"澳门",
			"重庆",
			"四川",
			"贵州",
			"云南",
			"西藏",
			"陕西",
			"甘肃",
			"青海",
			"宁夏",
			"新疆"
		}
	}
}
local t_tour_arena_zone = {
	dataList[1]
}

t_tour_arena_zone.dataList = dataList

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

return t_tour_arena_zone
