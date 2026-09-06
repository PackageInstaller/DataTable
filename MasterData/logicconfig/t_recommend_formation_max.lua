-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_recommend_formation_max.lua

module("logicconfig.config.t_recommend_formation_max", package.seeall)

local title = {
	showFaceId = 4,
	name = 2,
	skipTime = 7,
	retreatMsgType = 6,
	btlMode = 10,
	btlBg = 5,
	rankPrize = 3,
	creepsMasterId = 1,
	heroSkillId = 8,
	recommendZdl = 9,
	extraGainExp = 11
}
local dataList = {
	{
		70001,
		"逐月巅峰最强阵容",
		"2:43:1",
		10196,
		"yongzhezhita",
		2,
		0,
		"410334",
		0,
		"",
		0
	},
	{
		70002,
		"止战之殇最强阵容",
		"2:47:1",
		10196,
		"yongzhezhita",
		2,
		0,
		"414004",
		0,
		"",
		0
	},
	{
		70003,
		"空属性最强阵容",
		"14:81:1",
		10196,
		"yongzhezhita",
		2,
		0,
		"416003",
		0,
		"",
		0
	}
}
local t_recommend_formation_max = {
	[70001] = dataList[1],
	[70002] = dataList[2],
	[70003] = dataList[3]
}

t_recommend_formation_max.dataList = dataList

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

return t_recommend_formation_max
