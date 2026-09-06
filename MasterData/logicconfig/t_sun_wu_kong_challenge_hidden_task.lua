-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_sun_wu_kong_challenge_hidden_task.lua

module("logicconfig.config.t_sun_wu_kong_challenge_hidden_task", package.seeall)

local title = {
	taskDatail = 8,
	name = 6,
	taskDemand = 7,
	prizePlanId = 4,
	faceId = 9,
	simplyName = 5,
	taskType = 2,
	taskParams = 3,
	hiddenTaskId = 1
}
local dataList = {
	{
		1001,
		"SmallGame",
		{
			planId = "3",
			type = "2"
		},
		1,
		"翻牌",
		"敖九翻牌子",
		"敖九请你翻翻牌",
		"完成游戏获得奖励",
		16010
	},
	{
		1002,
		"VerifyPet",
		{
			pet = "Race$14013&Level$大于等于,100"
		},
		2,
		"验证",
		"唐僧的考验",
		"唐僧要看看你有没有黄金龙",
		"神曜寰宇·黄金圣龙达到100级",
		10181
	},
	{
		1003,
		"CollectMaterials",
		{
			materials = "4:2:20"
		},
		3,
		"捐献",
		"投喂猪八戒",
		"八戒需要20个经验果",
		"",
		10360
	},
	{
		1004,
		"Battle",
		{
			creepsMasterId = "1099"
		},
		5,
		"战斗",
		"真假孙悟空",
		"悟空要你帮忙打假",
		"击败敌阵即可获得胜利",
		12010
	},
	{
		1005,
		"SmallGame",
		{
			planId = "1",
			type = "1"
		},
		4,
		"气球",
		"悟净吹气球",
		"悟净要吹几个气球",
		"气球越大奖励越好",
		10333
	},
	{
		2001,
		"SmallGame",
		{
			planId = "3",
			type = "2"
		},
		6,
		"翻牌",
		"命途的牌面",
		"",
		"完成游戏获得奖励",
		16035
	},
	{
		2002,
		"VerifyPet",
		{
			pet = "Race$14013&Level$大于等于,100"
		},
		7,
		"验证",
		"圣灵的考验",
		"",
		"神曜寰宇·黄金圣龙达到100级",
		16039
	},
	{
		2003,
		"CollectMaterials",
		{
			materials = "4:2:20"
		},
		8,
		"捐献",
		"投喂小幽灵",
		"",
		"",
		16038
	},
	{
		2004,
		"Battle",
		{
			creepsMasterId = "1099"
		},
		10,
		"战斗",
		"击碎幻象",
		"",
		"击败敌阵即可获得胜利",
		18014
	},
	{
		2005,
		"SmallGame",
		{
			planId = "1",
			type = "1"
		},
		9,
		"气球",
		"吹气球",
		"",
		"气球越大奖励越好",
		16036
	}
}
local t_sun_wu_kong_challenge_hidden_task = {
	[1001] = dataList[1],
	[1002] = dataList[2],
	[1003] = dataList[3],
	[1004] = dataList[4],
	[1005] = dataList[5],
	[2001] = dataList[6],
	[2002] = dataList[7],
	[2003] = dataList[8],
	[2004] = dataList[9],
	[2005] = dataList[10]
}

t_sun_wu_kong_challenge_hidden_task.dataList = dataList

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

return t_sun_wu_kong_challenge_hidden_task
