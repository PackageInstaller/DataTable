-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_king_order_clg_creeps_master.lua

module("logicconfig.config.t_divine_king_order_clg_creeps_master", package.seeall)

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
		"关卡-1",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		""
	},
	{
		102,
		"关卡-2",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		""
	},
	{
		103,
		"关卡-3",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		""
	},
	{
		104,
		"关卡-4",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		""
	},
	{
		105,
		"关卡-5",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		""
	},
	{
		106,
		"关卡-6",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		""
	},
	{
		107,
		"关卡-7",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		""
	},
	{
		108,
		"关卡-8",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		""
	},
	{
		109,
		"关卡-9",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"416020"
	},
	{
		110,
		"关卡-10",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"414024"
	},
	{
		111,
		"关卡-11",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"417010"
	},
	{
		112,
		"关卡-12",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"411012"
	}
}
local t_divine_king_order_clg_creeps_master = {
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
	[112] = dataList[12]
}

t_divine_king_order_clg_creeps_master.dataList = dataList

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

return t_divine_king_order_clg_creeps_master
