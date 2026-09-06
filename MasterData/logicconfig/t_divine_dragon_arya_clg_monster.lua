-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_dragon_arya_clg_monster.lua

module("logicconfig.config.t_divine_dragon_arya_clg_monster", package.seeall)

local title = {
	skipTime = 10,
	name = 2,
	formCondition = 8,
	retreatMsgType = 6,
	btlMode = 4,
	btlBg = 3,
	selfBuffProviderId = 7,
	winId = 5,
	creepsMasterId = 1,
	heroSkillId = 9
}
local dataList = {
	{
		1001,
		"超神时空（空）",
		"",
		"",
		0,
		0,
		0,
		0,
		"415020",
		5
	},
	{
		1002,
		"无烬时空（火）",
		"",
		"",
		0,
		0,
		0,
		0,
		"412012",
		5
	},
	{
		1003,
		"秩序时空（水）",
		"",
		"",
		0,
		0,
		0,
		0,
		"411012",
		5
	},
	{
		1004,
		"王者时空（创）",
		"",
		"",
		0,
		0,
		0,
		0,
		"417010",
		5
	},
	{
		1005,
		"次元时空（光）",
		"",
		"",
		0,
		0,
		0,
		0,
		"414020",
		5
	},
	{
		1006,
		"永恒时空（草）",
		"",
		"",
		0,
		0,
		0,
		0,
		"413009",
		5
	}
}
local t_divine_dragon_arya_clg_monster = {
	[1001] = dataList[1],
	[1002] = dataList[2],
	[1003] = dataList[3],
	[1004] = dataList[4],
	[1005] = dataList[5],
	[1006] = dataList[6]
}

t_divine_dragon_arya_clg_monster.dataList = dataList

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

return t_divine_dragon_arya_clg_monster
