-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_fusion_soul_master.lua

module("logicconfig.config.t_fusion_soul_master", package.seeall)

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
		"普通试炼阵1",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		1002,
		"普通试炼阵2",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		1003,
		"普通试炼阵3",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		1004,
		"普通试炼阵4",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		1005,
		"普通试炼阵5",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		1006,
		"普通试炼阵6",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		1007,
		"普通试炼阵7",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		1008,
		"普通试炼阵8",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		1009,
		"普通试炼阵9",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	},
	{
		1010,
		"普通试炼阵10",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		""
	}
}
local t_fusion_soul_master = {
	[1001] = dataList[1],
	[1002] = dataList[2],
	[1003] = dataList[3],
	[1004] = dataList[4],
	[1005] = dataList[5],
	[1006] = dataList[6],
	[1007] = dataList[7],
	[1008] = dataList[8],
	[1009] = dataList[9],
	[1010] = dataList[10]
}

t_fusion_soul_master.dataList = dataList

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

return t_fusion_soul_master
