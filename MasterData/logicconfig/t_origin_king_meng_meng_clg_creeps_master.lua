-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_king_meng_meng_clg_creeps_master.lua

module("logicconfig.config.t_origin_king_meng_meng_clg_creeps_master", package.seeall)

local title = {
	skipTime = 3,
	name = 2,
	heavenAwakenSummonPetId = 11,
	formCondition = 7,
	retreatMsgType = 5,
	heavenAwakenMasterId = 10,
	ruleDesc = 9,
	selfBuffProviderId = 6,
	winId = 4,
	creepsMasterId = 1,
	heroSkillId = 8
}
local dataList = {
	{
		1001,
		"源起王者梦梦-1",
		5,
		0,
		0,
		0,
		0,
		"",
		0,
		"",
		""
	},
	{
		1002,
		"源起王者梦梦-2",
		5,
		0,
		0,
		609,
		0,
		"",
		0,
		"",
		""
	},
	{
		1003,
		"源起王者梦梦-3",
		5,
		0,
		0,
		613,
		0,
		"",
		0,
		"",
		""
	},
	{
		1004,
		"源起王者梦梦-4",
		5,
		0,
		0,
		610,
		0,
		"",
		0,
		"",
		""
	},
	{
		1005,
		"源起王者梦梦-5",
		5,
		0,
		0,
		608,
		0,
		"",
		0,
		"",
		""
	},
	{
		1006,
		"源起王者梦梦-6",
		5,
		279,
		0,
		0,
		229,
		"",
		0,
		"",
		""
	},
	{
		1007,
		"源起王者梦梦全民-1",
		5,
		0,
		0,
		0,
		0,
		"",
		0,
		"",
		""
	},
	{
		1008,
		"源起王者梦梦全民-2",
		5,
		0,
		0,
		0,
		0,
		"",
		0,
		"",
		""
	},
	{
		1009,
		"源起王者梦梦全民-3",
		5,
		0,
		0,
		0,
		0,
		"",
		0,
		"",
		""
	},
	{
		1010,
		"源起王者梦梦全民-4",
		5,
		0,
		0,
		0,
		0,
		"",
		0,
		"",
		""
	},
	{
		1011,
		"源起王者梦梦全民-5",
		5,
		0,
		0,
		0,
		0,
		"",
		0,
		"6",
		"7"
	},
	{
		1012,
		"源起王者梦梦全民-6",
		5,
		0,
		0,
		0,
		0,
		"",
		0,
		"5",
		"6"
	}
}
local t_origin_king_meng_meng_clg_creeps_master = {
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

t_origin_king_meng_meng_clg_creeps_master.dataList = dataList

local multiLanguageCells = {
	ruleDesc = true
}
local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			local value = rawget(t, index)

			if multiLanguageCells[key] then
				value = lang(value)
			end

			return value
		else
			printWarn(string.format("the field name [%s] is nonexist!", key))
		end
	end
}

for i, v in ipairs(dataList) do
	setmetatable(v, mt)
end

return t_origin_king_meng_meng_clg_creeps_master
