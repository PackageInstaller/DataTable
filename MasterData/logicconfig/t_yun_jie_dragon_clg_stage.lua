-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_yun_jie_dragon_clg_stage.lua

module("logicconfig.config.t_yun_jie_dragon_clg_stage", package.seeall)

local title = {
	stageId = 2,
	badgeMatStr = 5,
	phaseId = 3,
	creepsMasterId = 4,
	activityId = 1
}
local dataList = {
	{
		572001,
		1,
		1,
		1001,
		"1004:1619:1"
	},
	{
		572001,
		2,
		1,
		1002,
		"1004:1619:1"
	},
	{
		572001,
		3,
		1,
		1003,
		"1004:1619:1"
	},
	{
		572001,
		4,
		2,
		1004,
		"1004:1619:1"
	},
	{
		572001,
		5,
		2,
		1005,
		"1004:1619:1"
	},
	{
		572001,
		6,
		2,
		1006,
		"1004:1619:1"
	},
	{
		572001,
		7,
		3,
		1007,
		"1004:1619:1"
	},
	{
		572001,
		8,
		3,
		1008,
		"1004:1619:1"
	},
	{
		572001,
		9,
		3,
		1009,
		"1004:1619:1"
	}
}
local t_yun_jie_dragon_clg_stage = {
	[572001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9]
	}
}

t_yun_jie_dragon_clg_stage.dataList = dataList

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

return t_yun_jie_dragon_clg_stage
