-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_ares_mom_monster.lua

module("logicconfig.config.t_divine_ares_mom_monster", package.seeall)

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
		101,
		"第1关",
		5,
		"",
		"",
		0,
		0,
		284,
		0,
		"",
		""
	},
	{
		102,
		"第2关",
		5,
		"",
		"",
		0,
		0,
		284,
		0,
		"",
		""
	},
	{
		103,
		"第3关",
		5,
		"",
		"",
		0,
		0,
		284,
		0,
		"",
		""
	},
	{
		104,
		"第4关",
		5,
		"",
		"",
		0,
		0,
		284,
		0,
		"",
		""
	},
	{
		105,
		"第5关",
		5,
		"",
		"",
		0,
		0,
		284,
		0,
		"",
		""
	},
	{
		106,
		"第6关",
		5,
		"",
		"",
		0,
		0,
		284,
		0,
		"",
		""
	},
	{
		107,
		"第7关",
		5,
		"",
		"",
		0,
		0,
		284,
		0,
		"",
		""
	},
	{
		108,
		"第8关",
		5,
		"",
		"",
		0,
		0,
		284,
		0,
		"",
		""
	},
	{
		109,
		"第9关",
		5,
		"",
		"",
		0,
		0,
		284,
		0,
		"",
		""
	},
	{
		110,
		"第10关",
		5,
		"",
		"",
		0,
		0,
		284,
		0,
		"",
		""
	},
	{
		111,
		"第11关",
		5,
		"",
		"",
		0,
		0,
		284,
		0,
		"",
		""
	},
	{
		112,
		"第12关",
		5,
		"",
		"",
		0,
		0,
		284,
		0,
		"",
		""
	},
	{
		113,
		"第13关",
		5,
		"",
		"",
		0,
		0,
		284,
		0,
		"",
		""
	},
	{
		114,
		"第14关",
		5,
		"",
		"",
		0,
		0,
		284,
		0,
		"",
		""
	},
	{
		115,
		"第15关",
		5,
		"",
		"",
		0,
		0,
		284,
		0,
		"",
		""
	}
}
local t_divine_ares_mom_monster = {
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
	[113] = dataList[13],
	[114] = dataList[14],
	[115] = dataList[15]
}

t_divine_ares_mom_monster.dataList = dataList

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

return t_divine_ares_mom_monster
