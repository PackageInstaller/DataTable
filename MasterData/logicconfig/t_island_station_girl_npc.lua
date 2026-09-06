-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_island_station_girl_npc.lua

module("logicconfig.config.t_island_station_girl_npc", package.seeall)

local title = {
	name = 2,
	npcId = 1,
	iconPath = 3
}
local dataList = {
	{
		1,
		"奥奇",
		"icon_common_aoqi"
	},
	{
		2,
		"海隅风情·音织",
		"icon_16038_yinzhi01"
	},
	{
		3,
		"朗日晴风·龙尊神女",
		"icon_17015_shenyaolongzunshengzhu03"
	},
	{
		4,
		"碧浪柔波·空灵神女",
		"icon_16039_linghailong01"
	},
	{
		5,
		"汐光海浴·斐妮娅",
		"icon_18021_feixisi03"
	},
	{
		6,
		"盛夏留影·誓祖神女",
		"icon_12037_shizushenglong01"
	},
	{
		7,
		"日暮海潮·无烬神女",
		"icon_12027_wangzhewujin02"
	}
}
local t_island_station_girl_npc = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7]
}

t_island_station_girl_npc.dataList = dataList

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

return t_island_station_girl_npc
