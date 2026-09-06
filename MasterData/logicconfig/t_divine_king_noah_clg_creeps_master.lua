-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_king_noah_clg_creeps_master.lua

module("logicconfig.config.t_divine_king_noah_clg_creeps_master", package.seeall)

local title = {
	formCondition = 9,
	name = 2,
	heavenAwakenSummonPetId = 13,
	skipTime = 3,
	retreatMsgType = 7,
	heavenAwakenMasterId = 12,
	ruleDesc = 11,
	btlMode = 5,
	btlBg = 4,
	selfBuffProviderId = 8,
	winId = 6,
	creepsMasterId = 1,
	heroSkillId = 10
}
local dataList = {
	{
		1001,
		"神曜王雅-1",
		5,
		"",
		"",
		0,
		0,
		396,
		0,
		"",
		"击败敌阵所有精灵即可过关",
		"",
		""
	},
	{
		1002,
		"神曜王雅-2",
		5,
		"",
		"",
		0,
		0,
		396,
		0,
		"",
		"击败敌阵所有精灵即可过关",
		"",
		""
	},
	{
		1003,
		"神曜王雅-3",
		5,
		"",
		"",
		0,
		0,
		396,
		0,
		"",
		"击败敌阵所有精灵即可过关",
		"",
		""
	},
	{
		1004,
		"神曜王雅-4",
		5,
		"",
		"",
		0,
		0,
		396,
		0,
		"",
		"击败敌阵所有精灵即可过关",
		"",
		""
	},
	{
		1005,
		"神曜王雅-5",
		5,
		"",
		"",
		0,
		0,
		396,
		0,
		"",
		"击败敌阵所有精灵即可过关",
		"",
		""
	},
	{
		1006,
		"神曜王雅-6",
		5,
		"",
		"",
		0,
		0,
		396,
		0,
		"",
		"击败敌阵所有精灵即可过关",
		"",
		""
	},
	{
		1007,
		"神曜王雅-7",
		5,
		"",
		"",
		0,
		0,
		396,
		0,
		"413020",
		"击败敌阵所有精灵即可过关",
		"",
		""
	},
	{
		1008,
		"神曜王雅-8",
		5,
		"",
		"",
		0,
		0,
		396,
		0,
		"416028",
		"击败敌阵所有精灵即可过关",
		"",
		""
	},
	{
		1009,
		"神曜王雅-9",
		5,
		"",
		"",
		0,
		0,
		396,
		0,
		"416033",
		"击败敌阵所有精灵即可过关",
		"",
		""
	},
	{
		1010,
		"神曜王雅-10",
		5,
		"",
		"",
		0,
		0,
		396,
		0,
		"414025",
		"击败敌阵所有精灵即可过关",
		"",
		""
	},
	{
		1011,
		"神曜王雅-11",
		5,
		"",
		"",
		0,
		0,
		396,
		0,
		"412029",
		"击败敌阵所有精灵即可过关",
		"",
		""
	},
	{
		1012,
		"神曜王雅-12",
		5,
		"",
		"",
		0,
		0,
		396,
		0,
		"414027",
		"击败敌阵所有精灵即可过关",
		"6",
		"7"
	},
	{
		1013,
		"神曜王雅-13",
		5,
		"",
		"",
		0,
		0,
		396,
		0,
		"412027",
		"击败敌阵所有精灵即可过关",
		"",
		""
	},
	{
		1014,
		"神曜王雅-14",
		5,
		"",
		"",
		0,
		0,
		396,
		0,
		"417016",
		"击败敌阵所有精灵即可过关",
		"",
		""
	},
	{
		1015,
		"神曜王雅-15",
		5,
		"",
		"",
		0,
		0,
		396,
		0,
		"412023",
		"击败敌阵所有精灵即可过关",
		"",
		""
	},
	{
		1016,
		"神曜王雅-16",
		5,
		"",
		"",
		0,
		0,
		396,
		0,
		"415027",
		"击败敌阵所有精灵即可过关",
		"6",
		"7"
	}
}
local t_divine_king_noah_clg_creeps_master = {
	[1001] = dataList[1],
	[1002] = dataList[2],
	[1003] = dataList[3],
	[1004] = dataList[4],
	[1005] = dataList[5],
	[1006] = dataList[6],
	[1007] = dataList[7],
	[1008] = dataList[8],
	[1009] = dataList[9],
	[1010] = dataList[10],
	[1011] = dataList[11],
	[1012] = dataList[12],
	[1013] = dataList[13],
	[1014] = dataList[14],
	[1015] = dataList[15],
	[1016] = dataList[16]
}

t_divine_king_noah_clg_creeps_master.dataList = dataList

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

return t_divine_king_noah_clg_creeps_master
