-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_parallel_king_dragon_master.lua

module("logicconfig.config.t_parallel_king_dragon_master", package.seeall)

local title = {
	formCondition = 9,
	name = 2,
	heavenAwakenSummonPetId = 12,
	skipTime = 3,
	retreatMsgType = 7,
	heavenAwakenMasterId = 11,
	ruleDesc = 13,
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
		"耀穹尊主•王者圣龙-1",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"",
		"",
		"",
		"击败敌阵所有精灵并获取所有宝物即可过关"
	},
	{
		1002,
		"耀穹尊主•王者圣龙-2",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"",
		"",
		"",
		"击败敌阵所有精灵并获取所有宝物即可过关"
	},
	{
		1003,
		"耀穹尊主•王者圣龙-3",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"",
		"",
		"",
		"击败敌阵所有精灵并获取所有宝物即可过关"
	},
	{
		1004,
		"耀穹尊主•王者圣龙-4",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"",
		"",
		"",
		"击败敌阵所有精灵并获取所有宝物即可过关"
	},
	{
		1005,
		"耀穹尊主•王者圣龙-5",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"",
		"",
		"",
		"击败敌阵所有精灵并获取所有宝物即可过关"
	},
	{
		1006,
		"耀穹尊主•王者圣龙-6",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"",
		"",
		"",
		"击败敌阵所有精灵并获取所有宝物即可过关"
	},
	{
		1007,
		"耀穹尊主•王者圣龙-7",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"",
		"",
		"",
		"击败敌阵所有精灵并获取所有宝物即可过关"
	},
	{
		1008,
		"耀穹尊主•王者圣龙-8",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"",
		"",
		"",
		"击败敌阵所有精灵并获取所有宝物即可过关"
	},
	{
		1009,
		"耀穹尊主•王者圣龙-9",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"412027",
		"",
		"",
		"击败敌阵所有精灵并获取所有宝物即可过关"
	},
	{
		1010,
		"耀穹尊主•王者圣龙-10",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"411032",
		"",
		"",
		"击败敌阵所有精灵并获取所有宝物即可过关"
	},
	{
		1011,
		"耀穹尊主•王者圣龙-11",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"417010",
		"3",
		"7",
		"击败敌阵所有精灵并获取所有宝物即可过关"
	},
	{
		1012,
		"耀穹尊主•王者圣龙-12",
		5,
		"",
		"",
		0,
		0,
		411,
		0,
		"416036",
		"",
		"",
		"击败敌阵所有精灵并获取所有宝物即可过关"
	}
}
local t_parallel_king_dragon_master = {
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
	[1012] = dataList[12]
}

t_parallel_king_dragon_master.dataList = dataList

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

return t_parallel_king_dragon_master
