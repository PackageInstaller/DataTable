-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_equipment_race_type_stone.lua

module("logicconfig.config.t_equipment_race_type_stone", package.seeall)

local title = {
	cost = 4,
	providePercent = 5,
	id = 2,
	raceType = 3,
	planId = 1
}
local dataList = {
	{
		1,
		1,
		"草",
		"4:7001:1",
		100
	},
	{
		1,
		2,
		"水",
		"4:7002:1",
		100
	},
	{
		1,
		3,
		"火",
		"4:7003:1",
		100
	},
	{
		1,
		4,
		"光",
		"4:7004:1",
		100
	},
	{
		1,
		5,
		"暗",
		"4:7005:1",
		100
	},
	{
		1,
		6,
		"空",
		"4:7006:1",
		100
	},
	{
		1,
		7,
		"创",
		"4:7007:1",
		100
	},
	{
		2,
		1,
		"草",
		"4:7101:1",
		100
	},
	{
		2,
		2,
		"水",
		"4:7102:1",
		100
	},
	{
		2,
		3,
		"火",
		"4:7103:1",
		100
	},
	{
		2,
		4,
		"光",
		"4:7104:1",
		100
	},
	{
		2,
		5,
		"暗",
		"4:7105:1",
		100
	},
	{
		2,
		6,
		"空",
		"4:7106:1",
		100
	},
	{
		2,
		7,
		"创",
		"4:7107:1",
		100
	},
	{
		3,
		1,
		"草",
		"4:7201:1",
		100
	},
	{
		3,
		2,
		"水",
		"4:7202:1",
		100
	},
	{
		3,
		3,
		"火",
		"4:7203:1",
		100
	},
	{
		3,
		4,
		"光",
		"4:7204:1",
		100
	},
	{
		3,
		5,
		"暗",
		"4:7205:1",
		100
	},
	{
		3,
		6,
		"空",
		"4:7206:1",
		100
	},
	{
		3,
		7,
		"创",
		"4:7207:1",
		100
	}
}
local t_equipment_race_type_stone = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	},
	{
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14]
	},
	{
		dataList[15],
		dataList[16],
		dataList[17],
		dataList[18],
		dataList[19],
		dataList[20],
		dataList[21]
	}
}

t_equipment_race_type_stone.dataList = dataList

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

return t_equipment_race_type_stone
