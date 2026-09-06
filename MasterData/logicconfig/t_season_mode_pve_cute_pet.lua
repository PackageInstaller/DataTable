-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_season_mode_pve_cute_pet.lua

module("logicconfig.config.t_season_mode_pve_cute_pet", package.seeall)

local title = {
	cutePetName = 3,
	openCampLv = 2,
	cutePetJob = 6,
	cutePetType = 1,
	cutePetIcon = 5,
	cutePetDesc = 4
}
local dataList = {
	{
		7001,
		3,
		"小伏妖",
		"我也不知道这个描述是干啥用的，随便填一个1",
		"icon_mengchong_04",
		"1"
	},
	{
		7002,
		3,
		"爆爆龙",
		"我也不知道这个描述是干啥用的，随便填一个2",
		"icon_mengchong_01",
		"1"
	},
	{
		7003,
		3,
		"勇者小炎",
		"我也不知道这个描述是干啥用的，随便填一个3",
		"icon_mengchong_10",
		"1"
	},
	{
		7004,
		6,
		"波波鸟",
		"我也不知道这个描述是干啥用的，随便填一个4",
		"icon_mengchong_02",
		"2"
	},
	{
		7005,
		6,
		"战士小诺",
		"我也不知道这个描述是干啥用的，随便填一个5",
		"icon_mengchong_07",
		"2"
	},
	{
		7006,
		6,
		"学生小诺",
		"我也不知道这个描述是干啥用的，随便填一个6",
		"icon_mengchong_08",
		"2"
	},
	{
		7007,
		9,
		"海龙兽",
		"我也不知道这个描述是干啥用的，随便填一个7",
		"icon_mengchong_05",
		"2"
	},
	{
		7008,
		9,
		"小妖王",
		"我也不知道这个描述是干啥用的，随便填一个8",
		"icon_mengchong_03",
		"3"
	},
	{
		7009,
		9,
		"西装小炎",
		"我也不知道这个描述是干啥用的，随便填一个9",
		"icon_mengchong_11",
		"4"
	},
	{
		7010,
		12,
		"运动小炎",
		"我也不知道这个描述是干啥用的，随便填一个10",
		"icon_mengchong_12",
		"4"
	},
	{
		7011,
		12,
		"三叶兽",
		"我也不知道这个描述是干啥用的，随便填一个11",
		"icon_mengchong_06",
		"4"
	},
	{
		7012,
		12,
		"滑板小诺",
		"我也不知道这个描述是干啥用的，随便填一个12",
		"icon_mengchong_09",
		"4"
	}
}
local t_season_mode_pve_cute_pet = {
	[7001] = dataList[1],
	[7002] = dataList[2],
	[7003] = dataList[3],
	[7004] = dataList[4],
	[7005] = dataList[5],
	[7006] = dataList[6],
	[7007] = dataList[7],
	[7008] = dataList[8],
	[7009] = dataList[9],
	[7010] = dataList[10],
	[7011] = dataList[11],
	[7012] = dataList[12]
}

t_season_mode_pve_cute_pet.dataList = dataList

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

return t_season_mode_pve_cute_pet
