-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_warrior_tower_season.lua

module("logicconfig.config.t_warrior_tower_season", package.seeall)

local title = {
	id = 1,
	startDate = 2,
	endDate = 3
}
local dataList = {
	{
		1,
		"2019-01-01",
		"2019-12-31"
	},
	{
		2,
		"2019-12-31",
		"2020-01-01"
	},
	{
		3,
		"2020-01-01",
		"2020-01-02"
	},
	{
		4,
		"2020-01-02",
		"2020-01-03"
	},
	{
		5,
		"2020-01-03",
		"2020-01-04"
	},
	{
		6,
		"2020-01-04",
		"2222-01-04"
	}
}
local t_warrior_tower_season = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6]
}

t_warrior_tower_season.dataList = dataList

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

return t_warrior_tower_season
