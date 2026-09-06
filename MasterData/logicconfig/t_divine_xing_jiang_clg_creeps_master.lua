-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_xing_jiang_clg_creeps_master.lua

module("logicconfig.config.t_divine_xing_jiang_clg_creeps_master", package.seeall)

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
		"摩羯座",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"411010"
	},
	{
		102,
		"水瓶座",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"412012"
	},
	{
		103,
		"双鱼座",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"413009"
	},
	{
		104,
		"白羊座",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"415020"
	},
	{
		105,
		"金牛座",
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
		106,
		"双子座",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"417006"
	},
	{
		107,
		"巨蟹座",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"414020"
	},
	{
		108,
		"狮子座",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"416013"
	},
	{
		109,
		"处女座",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"414018"
	},
	{
		110,
		"天秤座",
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
		111,
		"天蝎座",
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
		112,
		"射手座",
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
local t_divine_xing_jiang_clg_creeps_master = {
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

t_divine_xing_jiang_clg_creeps_master.dataList = dataList

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

return t_divine_xing_jiang_clg_creeps_master
