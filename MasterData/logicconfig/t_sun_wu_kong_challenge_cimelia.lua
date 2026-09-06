-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_sun_wu_kong_challenge_cimelia.lua

module("logicconfig.config.t_sun_wu_kong_challenge_cimelia", package.seeall)

local title = {
	resName = 6,
	cimeliaPlanId = 1,
	cimeliaId = 2,
	cimeliaBuffPlanId = 5,
	unlockStageId = 3,
	name = 7,
	cimeliaLevelPlanId = 4
}
local dataList = {
	{
		1,
		1,
		1,
		1,
		1,
		"board_jiurixingzhe_13",
		"金箍棒"
	},
	{
		1,
		2,
		6,
		1,
		2,
		"board_jiurixingzhe_15",
		"紧箍咒"
	},
	{
		1,
		3,
		11,
		1,
		3,
		"board_jiurixingzhe_14",
		"蟠桃"
	},
	{
		1,
		4,
		16,
		1,
		4,
		"board_jiurixingzhe_12",
		"筋斗云"
	},
	{
		2,
		1,
		1,
		2,
		5,
		"board_shenyaofeiyin_03",
		"幽骨花"
	},
	{
		2,
		2,
		4,
		2,
		6,
		"board_shenyaofeiyin_04",
		"灵辉骨"
	},
	{
		2,
		3,
		7,
		2,
		7,
		"board_shenyaofeiyin_05",
		"幻猫灵"
	},
	{
		2,
		4,
		10,
		2,
		8,
		"board_shenyaofeiyin_06",
		"十字枷"
	}
}
local t_sun_wu_kong_challenge_cimelia = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	},
	{
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	}
}

t_sun_wu_kong_challenge_cimelia.dataList = dataList

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

return t_sun_wu_kong_challenge_cimelia
