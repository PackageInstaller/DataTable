-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_beast_rich_man_zone.lua

module("logicconfig.config.t_beast_rich_man_zone", package.seeall)

local title = {
	zoneWidth = 5,
	name = 3,
	zoneId = 2,
	skinId = 8,
	zoneImgName = 10,
	storyId = 11,
	openDateTime = 7,
	zoneHeight = 6,
	size = 4,
	activityId = 1,
	posAndSize = 9
}
local dataList = {
	{
		558001,
		1,
		"青丘国",
		{
			21,
			18
		},
		148,
		72,
		"2026-02-13T05:00:00",
		1604503,
		{
			-570,
			-430,
			0.8
		},
		"bg_ruishoudamaoxian_qingqiu",
		4820059
	},
	{
		558001,
		2,
		"扶桑树",
		{
			21,
			18
		},
		148,
		72,
		"2026-02-20T05:00:00",
		1302803,
		{
			-525,
			-615,
			1
		},
		"bg_ruishoudamaoxian_fusang",
		4820060
	},
	{
		558001,
		3,
		"昆仑墟",
		{
			21,
			18
		},
		148,
		72,
		"2026-02-27T05:00:00",
		1204402,
		{
			-470,
			-625,
			1
		},
		"bg_ruishoudamaoxian_kunlunxu",
		4820061
	}
}
local t_beast_rich_man_zone = {
	[558001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_beast_rich_man_zone.dataList = dataList

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

return t_beast_rich_man_zone
