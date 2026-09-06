-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_elf_king_path_master.lua

module("logicconfig.config.t_elf_king_path_master", package.seeall)

local title = {
	skipTime = 3,
	heavenAwakenMasterId = 8,
	heavenAwakenSummonPetId = 9,
	formCondition = 6,
	name = 2,
	ruleDesc = 10,
	selfBuffProviderId = 5,
	winId = 4,
	creepsMasterId = 1,
	heroSkillId = 7
}
local dataList = {
	{
		1001,
		"出手顺序",
		5,
		0,
		0,
		0,
		"",
		"",
		"",
		""
	},
	{
		1002,
		"属性克制",
		5,
		0,
		0,
		0,
		"",
		"",
		"",
		""
	},
	{
		1003,
		"契约召唤",
		5,
		0,
		0,
		0,
		"",
		"",
		"",
		""
	},
	{
		1004,
		"英雄上阵",
		5,
		0,
		0,
		0,
		"",
		"",
		"",
		""
	},
	{
		1005,
		"元素变换",
		5,
		0,
		0,
		0,
		"",
		"",
		"",
		""
	},
	{
		1006,
		"通灵变身",
		5,
		0,
		0,
		0,
		"",
		"",
		"",
		""
	},
	{
		1007,
		"神曜昆仑阵试炼",
		5,
		0,
		0,
		0,
		"",
		"",
		"",
		""
	},
	{
		1008,
		"神曜无敌阵试炼",
		5,
		0,
		0,
		0,
		"",
		"",
		"",
		""
	},
	{
		1009,
		"神曜伏妖阵试炼",
		5,
		0,
		0,
		0,
		"",
		"",
		"",
		""
	},
	{
		1010,
		"神曜圣骑阵试炼",
		5,
		0,
		0,
		0,
		"",
		"",
		"",
		""
	},
	{
		1011,
		"实操一",
		5,
		0,
		0,
		0,
		"",
		"",
		"",
		""
	},
	{
		1012,
		"实操二",
		5,
		0,
		0,
		0,
		"",
		"",
		"",
		""
	},
	{
		1013,
		"实操三",
		5,
		0,
		0,
		0,
		"",
		"",
		"",
		""
	}
}
local t_elf_king_path_master = {
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
	[1013] = dataList[13]
}

t_elf_king_path_master.dataList = dataList

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

return t_elf_king_path_master
