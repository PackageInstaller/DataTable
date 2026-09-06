-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_mi_meng_li_clg_stage.lua

module("logicconfig.config.t_mi_meng_li_clg_stage", package.seeall)

local title = {
	firstPassPrize = 4,
	stageId = 2,
	selectTagCount = 6,
	stageClazz = 3,
	creepsMasterId = 7,
	passScore = 5,
	activityId = 1,
	shopId = 8
}
local dataList = {
	{
		417001,
		1,
		"NormalFight",
		"4:255:5",
		10,
		1,
		1001,
		0
	},
	{
		417001,
		2,
		"NormalFight",
		"4:255:5",
		10,
		1,
		1002,
		0
	},
	{
		417001,
		3,
		"NormalFight",
		"4:255:5",
		10,
		1,
		1003,
		0
	},
	{
		417001,
		4,
		"NormalFight",
		"4:255:5",
		10,
		1,
		1004,
		0
	},
	{
		417001,
		5,
		"Shop",
		"",
		0,
		0,
		0,
		2
	},
	{
		417001,
		6,
		"NormalFight",
		"4:255:5",
		10,
		2,
		1005,
		0
	},
	{
		417001,
		7,
		"NormalFight",
		"4:255:5",
		10,
		2,
		1006,
		0
	},
	{
		417001,
		8,
		"NormalFight",
		"4:255:5",
		10,
		2,
		1007,
		0
	},
	{
		417001,
		9,
		"NormalFight",
		"4:255:5",
		10,
		2,
		1008,
		0
	},
	{
		417001,
		10,
		"Shop",
		"",
		0,
		0,
		0,
		2
	},
	{
		417001,
		11,
		"NormalFight",
		"4:255:5",
		10,
		3,
		1009,
		0
	},
	{
		417001,
		12,
		"NormalFight",
		"4:255:5",
		10,
		3,
		1010,
		0
	},
	{
		417001,
		13,
		"NormalFight",
		"4:255:5",
		10,
		3,
		1011,
		0
	},
	{
		417001,
		14,
		"NormalFight",
		"4:255:5",
		10,
		3,
		1012,
		0
	},
	{
		417001,
		15,
		"Shop",
		"",
		0,
		0,
		0,
		2
	},
	{
		417001,
		16,
		"NormalFight",
		"4:255:10",
		10,
		4,
		1013,
		0
	},
	{
		417001,
		17,
		"NormalFight",
		"4:255:10",
		10,
		4,
		1014,
		0
	},
	{
		417001,
		18,
		"NormalFight",
		"4:255:10",
		10,
		4,
		1015,
		0
	},
	{
		417001,
		19,
		"Shop",
		"",
		0,
		0,
		0,
		1
	},
	{
		417001,
		20,
		"BossFight",
		"4:255:30",
		0,
		0,
		1016,
		0
	}
}
local t_mi_meng_li_clg_stage = {
	[417001] = {
		dataList[1],
		dataList[2],
		dataList[3],
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
		dataList[20]
	}
}

t_mi_meng_li_clg_stage.dataList = dataList

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

return t_mi_meng_li_clg_stage
