-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_wu_di_clg_creeps_master.lua

module("logicconfig.config.t_wu_di_clg_creeps_master", package.seeall)

local title = {
	formCondition = 9,
	name = 2,
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
		101,
		"群攻试炼-1",
		5,
		"",
		"",
		0,
		0,
		206,
		0,
		""
	},
	{
		102,
		"群攻试炼-2",
		5,
		"",
		"",
		0,
		0,
		206,
		0,
		""
	},
	{
		103,
		"群攻试炼-3",
		5,
		"",
		"",
		0,
		0,
		206,
		0,
		""
	},
	{
		104,
		"群攻试炼-4",
		5,
		"",
		"",
		0,
		0,
		206,
		0,
		""
	},
	{
		105,
		"群攻试炼-5",
		5,
		"",
		"",
		0,
		0,
		206,
		0,
		""
	},
	{
		106,
		"群攻试炼-6",
		5,
		"",
		"",
		0,
		0,
		206,
		0,
		""
	},
	{
		107,
		"群攻试炼-7",
		5,
		"",
		"",
		0,
		0,
		206,
		0,
		""
	},
	{
		108,
		"群攻试炼-8",
		5,
		"",
		"",
		0,
		0,
		206,
		0,
		""
	},
	{
		109,
		"群攻试炼-9",
		5,
		"",
		"",
		0,
		0,
		206,
		0,
		""
	},
	{
		110,
		"群攻试炼-10",
		5,
		"",
		"",
		0,
		0,
		206,
		0,
		""
	},
	{
		111,
		"群攻试炼-11",
		5,
		"",
		"",
		0,
		0,
		206,
		0,
		""
	},
	{
		112,
		"群攻试炼-12",
		5,
		"",
		"",
		0,
		0,
		206,
		0,
		""
	},
	{
		1001,
		"极限挑战-1",
		5,
		"",
		"",
		0,
		0,
		144,
		0,
		"416003"
	},
	{
		1002,
		"极限挑战-2",
		5,
		"",
		"",
		0,
		0,
		144,
		0,
		"417006"
	},
	{
		1003,
		"极限挑战-3",
		5,
		"",
		"",
		0,
		0,
		144,
		0,
		"414014"
	},
	{
		1004,
		"极限挑战-4",
		5,
		"",
		"",
		0,
		0,
		144,
		0,
		"416013"
	},
	{
		1005,
		"极限挑战-5",
		5,
		"",
		"",
		0,
		0,
		144,
		0,
		"413009"
	},
	{
		1006,
		"极限挑战-6",
		5,
		"",
		"",
		0,
		0,
		144,
		0,
		"411010"
	},
	{
		1007,
		"极限挑战-7",
		5,
		"",
		"",
		0,
		0,
		144,
		0,
		"412012"
	},
	{
		1008,
		"极限挑战-8",
		5,
		"",
		"",
		0,
		0,
		144,
		0,
		"411012"
	},
	{
		1009,
		"极限挑战-9",
		5,
		"",
		"",
		0,
		0,
		144,
		0,
		"417010"
	}
}
local t_wu_di_clg_creeps_master = {
	[101] = dataList[1],
	[102] = dataList[2],
	[103] = dataList[3],
	[104] = dataList[4],
	[105] = dataList[5],
	[106] = dataList[6],
	[107] = dataList[7],
	[108] = dataList[8],
	[109] = dataList[9],
	[110] = dataList[10],
	[111] = dataList[11],
	[112] = dataList[12],
	[1001] = dataList[13],
	[1002] = dataList[14],
	[1003] = dataList[15],
	[1004] = dataList[16],
	[1005] = dataList[17],
	[1006] = dataList[18],
	[1007] = dataList[19],
	[1008] = dataList[20],
	[1009] = dataList[21]
}

t_wu_di_clg_creeps_master.dataList = dataList

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

return t_wu_di_clg_creeps_master
