-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_immortal_movement_master.lua

module("logicconfig.config.t_immortal_movement_master", package.seeall)

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
		"乐章-1",
		5,
		0,
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
		"乐章-2",
		5,
		0,
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
		"乐章-3",
		5,
		0,
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
		"乐章-4",
		5,
		0,
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
		"乐章-5",
		5,
		0,
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
		"乐章-6",
		5,
		0,
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
		"乐章-7",
		5,
		0,
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
		"乐章-8",
		5,
		0,
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
		"乐章-9",
		5,
		0,
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
		"乐章-10",
		5,
		0,
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
		"乐章-11",
		5,
		0,
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
		"乐章-12",
		5,
		0,
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
		"乐章-13",
		5,
		0,
		0,
		0,
		0,
		"",
		"",
		"",
		""
	},
	{
		1014,
		"乐章-14",
		5,
		0,
		0,
		0,
		0,
		"",
		"",
		"",
		""
	},
	{
		1015,
		"乐章-15",
		5,
		0,
		0,
		0,
		0,
		"",
		"",
		"",
		""
	}
}
local t_immortal_movement_master = {
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
	[1015] = dataList[15]
}

t_immortal_movement_master.dataList = dataList

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

return t_immortal_movement_master
