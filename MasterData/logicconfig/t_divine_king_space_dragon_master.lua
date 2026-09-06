-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_king_space_dragon_master.lua

module("logicconfig.config.t_divine_king_space_dragon_master", package.seeall)

local title = {
	skipTime = 3,
	name = 2,
	heavenAwakenSummonPetId = 10,
	formCondition = 7,
	retreatMsgType = 5,
	heavenAwakenMasterId = 9,
	ruleDesc = 11,
	selfBuffProviderId = 6,
	winId = 4,
	creepsMasterId = 1,
	heroSkillId = 8
}
local dataList = {
	{
		1001,
		"神曜王时-1",
		5,
		0,
		0,
		411,
		0,
		"",
		"",
		"",
		""
	},
	{
		1002,
		"神曜王时-2",
		5,
		0,
		0,
		411,
		0,
		"",
		"5",
		"6",
		""
	},
	{
		1003,
		"神曜王时-3",
		5,
		0,
		0,
		411,
		0,
		"",
		"",
		"",
		""
	},
	{
		1004,
		"神曜王时-4",
		5,
		0,
		0,
		411,
		0,
		"",
		"",
		"",
		""
	},
	{
		1005,
		"神曜王时-5",
		5,
		0,
		0,
		411,
		0,
		"",
		"",
		"",
		""
	},
	{
		1006,
		"神曜王时-6",
		5,
		0,
		0,
		411,
		0,
		"",
		"",
		"",
		""
	},
	{
		1007,
		"神曜王时-7",
		5,
		0,
		0,
		411,
		0,
		"",
		"5",
		"6",
		""
	},
	{
		1008,
		"神曜王时-8",
		5,
		0,
		0,
		411,
		0,
		"",
		"6",
		"7",
		""
	},
	{
		1009,
		"神曜王时-9",
		5,
		0,
		0,
		411,
		0,
		"",
		"",
		"",
		""
	},
	{
		1010,
		"神曜王时-10",
		5,
		0,
		0,
		411,
		0,
		"",
		"",
		"",
		""
	},
	{
		1011,
		"神曜王时-11",
		5,
		0,
		0,
		411,
		0,
		"",
		"",
		"",
		""
	},
	{
		1012,
		"神曜王时-12",
		5,
		0,
		0,
		411,
		0,
		"",
		"",
		"",
		""
	}
}
local t_divine_king_space_dragon_master = {
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

t_divine_king_space_dragon_master.dataList = dataList

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

return t_divine_king_space_dragon_master
