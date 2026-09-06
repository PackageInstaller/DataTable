-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_scuffle_season.lua

module("logicconfig.config.t_scuffle_season", package.seeall)

local title = {
	activityId = 1,
	seasonName = 3,
	seasonId = 2
}
local dataList = {
	{
		37001,
		1,
		""
	},
	{
		37002,
		2,
		""
	},
	{
		37003,
		3,
		""
	},
	{
		37004,
		4,
		""
	},
	{
		37005,
		5,
		""
	},
	{
		37006,
		6,
		""
	},
	{
		37007,
		7,
		""
	},
	{
		37008,
		8,
		""
	},
	{
		37009,
		9,
		""
	},
	{
		37010,
		10,
		""
	},
	{
		37011,
		11,
		""
	},
	{
		37012,
		12,
		""
	},
	{
		37013,
		13,
		""
	},
	{
		37014,
		14,
		"元宵大乱斗"
	},
	{
		37015,
		15,
		"女神大乱斗"
	},
	{
		37016,
		16,
		"精灵大乱斗"
	},
	{
		37017,
		17,
		"中秋大乱斗"
	},
	{
		37018,
		18,
		"精灵大乱斗"
	},
	{
		37019,
		19,
		"精灵大乱斗"
	},
	{
		37020,
		20,
		"精灵大乱斗"
	},
	{
		37021,
		21,
		"精灵大乱斗"
	},
	{
		37022,
		22,
		"精灵大乱斗"
	},
	{
		37023,
		23,
		"精灵大乱斗"
	},
	{
		37024,
		24,
		"精灵大乱斗"
	},
	{
		37025,
		25,
		"精灵大乱斗"
	},
	{
		37026,
		26,
		"精灵大乱斗"
	},
	{
		37027,
		27,
		"精灵大乱斗"
	},
	{
		37028,
		28,
		"精灵大乱斗"
	},
	{
		37029,
		29,
		"精灵大乱斗"
	},
	{
		37030,
		30,
		"精灵大乱斗"
	},
	{
		37031,
		31,
		"精灵大乱斗"
	},
	{
		37032,
		32,
		"精灵大乱斗"
	}
}
local t_scuffle_season = {
	[37001] = dataList[1],
	[37002] = dataList[2],
	[37003] = dataList[3],
	[37004] = dataList[4],
	[37005] = dataList[5],
	[37006] = dataList[6],
	[37007] = dataList[7],
	[37008] = dataList[8],
	[37009] = dataList[9],
	[37010] = dataList[10],
	[37011] = dataList[11],
	[37012] = dataList[12],
	[37013] = dataList[13],
	[37014] = dataList[14],
	[37015] = dataList[15],
	[37016] = dataList[16],
	[37017] = dataList[17],
	[37018] = dataList[18],
	[37019] = dataList[19],
	[37020] = dataList[20],
	[37021] = dataList[21],
	[37022] = dataList[22],
	[37023] = dataList[23],
	[37024] = dataList[24],
	[37025] = dataList[25],
	[37026] = dataList[26],
	[37027] = dataList[27],
	[37028] = dataList[28],
	[37029] = dataList[29],
	[37030] = dataList[30],
	[37031] = dataList[31],
	[37032] = dataList[32]
}

t_scuffle_season.dataList = dataList

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

return t_scuffle_season
