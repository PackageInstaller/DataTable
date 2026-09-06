-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_zoo_animal_work_gene.lua

module("logicconfig.config.t_zoo_animal_work_gene", package.seeall)

local title = {
	coffeeShopBenefit = 4,
	name = 6,
	amusementBenefit = 5,
	quarryBenefit = 2,
	id = 1,
	restaurantBenefit = 3,
	desc = 8,
	level = 7
}
local dataList = {
	{
		1001,
		103,
		102,
		100,
		98,
		"挖矿能手",
		"I",
		"化石场增益"
	},
	{
		1002,
		105,
		102,
		100,
		97,
		"挖矿能手",
		"II",
		"化石场增益"
	},
	{
		1003,
		108,
		103,
		100,
		95,
		"挖矿能手",
		"III",
		"化石场增益"
	},
	{
		1004,
		110,
		105,
		100,
		92,
		"挖矿能手",
		"IV",
		"化石场增益"
	},
	{
		1005,
		102,
		103,
		98,
		100,
		"美食家",
		"I",
		"餐厅增益"
	},
	{
		1006,
		102,
		105,
		97,
		100,
		"美食家",
		"II",
		"餐厅增益"
	},
	{
		1007,
		103,
		108,
		95,
		100,
		"美食家",
		"III",
		"餐厅增益"
	},
	{
		1008,
		105,
		110,
		92,
		100,
		"美食家",
		"IV",
		"餐厅增益"
	},
	{
		1009,
		100,
		98,
		103,
		102,
		"还不知道是啥 等待补充",
		"I",
		"咖啡厅增益"
	},
	{
		1010,
		100,
		97,
		105,
		102,
		"还不知道是啥 等待补充",
		"II",
		"咖啡厅增益"
	},
	{
		1011,
		100,
		95,
		108,
		103,
		"还不知道是啥 等待补充",
		"III",
		"咖啡厅增益"
	},
	{
		1012,
		100,
		92,
		110,
		105,
		"还不知道是啥 等待补充",
		"IV",
		"咖啡厅增益"
	},
	{
		1013,
		98,
		100,
		102,
		103,
		"头号玩家",
		"I",
		"游乐场增益"
	},
	{
		1014,
		97,
		100,
		102,
		105,
		"头号玩家",
		"II",
		"游乐场增益"
	},
	{
		1015,
		95,
		100,
		103,
		108,
		"头号玩家",
		"III",
		"游乐场增益"
	},
	{
		1016,
		92,
		100,
		105,
		110,
		"头号玩家",
		"IV",
		"游乐场增益"
	},
	{
		1017,
		102,
		102,
		102,
		102,
		"四项全能",
		"I",
		"通用增益"
	},
	{
		1018,
		102,
		102,
		102,
		102,
		"四项全能",
		"II",
		"通用增益"
	},
	{
		1019,
		103,
		103,
		103,
		103,
		"四项全能",
		"III",
		"通用增益"
	},
	{
		1020,
		105,
		105,
		105,
		105,
		"四项全能",
		"IV",
		"通用增益"
	}
}
local t_zoo_animal_work_gene = {
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
	[1016] = dataList[16],
	[1017] = dataList[17],
	[1018] = dataList[18],
	[1019] = dataList[19],
	[1020] = dataList[20]
}

t_zoo_animal_work_gene.dataList = dataList

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

return t_zoo_animal_work_gene
