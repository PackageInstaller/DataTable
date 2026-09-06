-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_season_mode_pve_event_convey.lua

module("logicconfig.config.t_season_mode_pve_event_convey", package.seeall)

local title = {
	lockPointId = 5,
	seasonId = 1,
	id = 2,
	isLock = 4,
	desc = 3
}
local dataList = {
	{
		1,
		1,
		"通过这个地方，可以传送到(%s,%s)坐标点",
		true,
		1354
	},
	{
		1,
		2,
		"通过这个地方，可以传送到(%s,%s)坐标点",
		true,
		764
	},
	{
		1,
		3,
		"通过这个地方，可以传送到(%s,%s)坐标点",
		true,
		1934
	},
	{
		2,
		1,
		"通过这个地方，可以传送到(%s,%s)坐标点",
		false,
		0
	},
	{
		2,
		2,
		"通过这个地方，可以传送到(%s,%s)坐标点",
		false,
		0
	},
	{
		2,
		3,
		"通过这个地方，可以传送到(%s,%s)坐标点",
		false,
		0
	},
	{
		2,
		4,
		"通过这个地方，可以传送到(%s,%s)坐标点",
		false,
		0
	},
	{
		2,
		5,
		"通过这个地方，可以传送到(%s,%s)坐标点",
		false,
		0
	},
	{
		2,
		6,
		"通过这个地方，可以传送到(%s,%s)坐标点",
		false,
		0
	},
	{
		2,
		7,
		"通过这个地方，可以传送到(%s,%s)坐标点",
		false,
		0
	},
	{
		2,
		8,
		"通过这个地方，可以传送到(%s,%s)坐标点",
		false,
		0
	},
	{
		2,
		9,
		"通过这个地方，可以传送到(%s,%s)坐标点",
		false,
		0
	},
	{
		2,
		10,
		"通过这个地方，可以传送到(%s,%s)坐标点",
		false,
		0
	},
	{
		2,
		11,
		"通过这个地方，可以传送到(%s,%s)坐标点",
		false,
		0
	},
	{
		2,
		12,
		"通过这个地方，可以传送到(%s,%s)坐标点",
		false,
		0
	},
	{
		2,
		13,
		"通过这个地方，可以传送到(%s,%s)坐标点",
		false,
		0
	},
	{
		2,
		14,
		"通过这个地方，可以传送到(%s,%s)坐标点",
		false,
		0
	},
	{
		2,
		15,
		"通过这个地方，可以传送到(%s,%s)坐标点",
		false,
		0
	},
	{
		2,
		16,
		"通过这个地方，可以传送到(%s,%s)坐标点",
		false,
		0
	},
	{
		2,
		17,
		"通过这个地方，可以传送到(%s,%s)坐标点",
		false,
		0
	},
	{
		2,
		18,
		"通过这个地方，可以传送到(%s,%s)坐标点",
		false,
		0
	},
	{
		2,
		19,
		"通过这个地方，可以传送到(%s,%s)坐标点",
		false,
		0
	},
	{
		2,
		20,
		"通过这个地方，可以传送到(%s,%s)坐标点",
		false,
		0
	},
	{
		2,
		21,
		"通过这个地方，可以传送到(%s,%s)坐标点",
		false,
		0
	},
	{
		2,
		22,
		"通过这个地方，可以传送到(%s,%s)坐标点",
		false,
		0
	},
	{
		3,
		1,
		"通过这个地方，可以传送到(%s,%s)坐标点",
		true,
		1354
	},
	{
		3,
		2,
		"通过这个地方，可以传送到(%s,%s)坐标点",
		true,
		764
	},
	{
		3,
		3,
		"通过这个地方，可以传送到(%s,%s)坐标点",
		true,
		1934
	}
}
local t_season_mode_pve_event_convey = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	},
	{
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16],
		dataList[17],
		dataList[18],
		dataList[19],
		dataList[20],
		dataList[21],
		dataList[22],
		dataList[23],
		dataList[24],
		dataList[25]
	},
	{
		dataList[26],
		dataList[27],
		dataList[28]
	}
}

t_season_mode_pve_event_convey.dataList = dataList

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

return t_season_mode_pve_event_convey
