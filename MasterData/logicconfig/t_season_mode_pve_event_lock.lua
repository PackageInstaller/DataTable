-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_season_mode_pve_event_lock.lua

module("logicconfig.config.t_season_mode_pve_event_lock", package.seeall)

local title = {
	id = 2,
	seasonId = 1,
	desc = 3
}
local dataList = {
	{
		1,
		1,
		"可以驱散地图上的某一片迷雾"
	},
	{
		1,
		2,
		"可以驱散地图上的某一片迷雾"
	},
	{
		1,
		3,
		"可以驱散地图上的某一片迷雾"
	},
	{
		1,
		4,
		"可以驱散地图上的某一片迷雾"
	},
	{
		1,
		5,
		"可以驱散地图上的某一片迷雾"
	},
	{
		1,
		6,
		"影子圣殿解锁中央圣殿的机关"
	},
	{
		2,
		1,
		"可以驱散地图上的某一片迷雾"
	},
	{
		2,
		2,
		"可以驱散地图上的某一片迷雾"
	},
	{
		2,
		3,
		"可以驱散地图上的某一片迷雾"
	},
	{
		2,
		4,
		"可以驱散地图上的某一片迷雾"
	},
	{
		2,
		5,
		"可以驱散地图上的某一片迷雾"
	},
	{
		2,
		6,
		"可以解锁地图上的对应的醒狮机关"
	},
	{
		3,
		1,
		"可以驱散地图上的某一片迷雾"
	},
	{
		3,
		2,
		"可以驱散地图上的某一片迷雾"
	},
	{
		3,
		3,
		"可以驱散地图上的某一片迷雾"
	},
	{
		3,
		4,
		"可以驱散地图上的某一片迷雾"
	},
	{
		3,
		5,
		"可以驱散地图上的某一片迷雾"
	},
	{
		3,
		6,
		"影子圣殿解锁中央圣殿的机关"
	}
}
local t_season_mode_pve_event_lock = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	},
	{
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12]
	},
	{
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16],
		dataList[17],
		dataList[18]
	}
}

t_season_mode_pve_event_lock.dataList = dataList

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

return t_season_mode_pve_event_lock
