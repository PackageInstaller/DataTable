-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_chuang_zhengli_clg_monster.lua

module("logicconfig.config.t_chuang_zhengli_clg_monster", package.seeall)

local title = {
	formCondition = 9,
	name = 2,
	ruleDesc = 11,
	skipTime = 3,
	retreatMsgType = 7,
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
		"创正理1-1",
		3,
		"",
		"",
		0,
		0,
		321,
		0,
		"",
		"击破轮回印记获得奇迹印记"
	},
	{
		1002,
		"创正理1-2",
		3,
		"",
		"",
		0,
		0,
		321,
		0,
		"",
		"击破轮回印记获得奇迹印记"
	},
	{
		1003,
		"创正理1-3",
		3,
		"",
		"",
		0,
		0,
		321,
		0,
		"",
		"击破轮回印记获得奇迹印记"
	},
	{
		1004,
		"创正理1-4",
		3,
		"",
		"",
		0,
		0,
		321,
		0,
		"",
		"击破轮回印记获得奇迹印记"
	},
	{
		1005,
		"创正理1-5",
		3,
		"",
		"",
		0,
		0,
		321,
		0,
		"",
		"击破轮回印记获得奇迹印记"
	},
	{
		1006,
		"创正理2-5",
		3,
		"",
		"",
		0,
		0,
		321,
		0,
		"",
		"击破轮回印记获得奇迹印记"
	},
	{
		1007,
		"创正理1-6",
		3,
		"",
		"",
		0,
		0,
		321,
		0,
		"",
		"击破轮回印记获得奇迹印记"
	},
	{
		1008,
		"创正理2-6",
		3,
		"",
		"",
		0,
		0,
		321,
		0,
		"",
		"击破轮回印记获得奇迹印记"
	},
	{
		1009,
		"创正理1-7",
		3,
		"",
		"",
		0,
		0,
		321,
		0,
		"",
		"击破轮回印记获得奇迹印记"
	},
	{
		1010,
		"创正理2-7",
		3,
		"",
		"",
		0,
		0,
		321,
		0,
		"411012",
		"击破轮回印记获得奇迹印记"
	},
	{
		1011,
		"创正理1-8",
		3,
		"",
		"",
		0,
		0,
		321,
		0,
		"",
		"击破轮回印记获得奇迹印记"
	},
	{
		1012,
		"创正理2-8",
		3,
		"",
		"",
		0,
		0,
		321,
		0,
		"",
		"击破轮回印记获得奇迹印记"
	},
	{
		1013,
		"创正理1-9",
		3,
		"",
		"",
		0,
		0,
		321,
		0,
		"",
		"击破轮回印记获得奇迹印记"
	},
	{
		1014,
		"创正理2-9",
		3,
		"",
		"",
		0,
		0,
		321,
		0,
		"",
		"击破轮回印记获得奇迹印记"
	}
}
local t_chuang_zhengli_clg_monster = {
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
	[1014] = dataList[14]
}

t_chuang_zhengli_clg_monster.dataList = dataList

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

return t_chuang_zhengli_clg_monster
