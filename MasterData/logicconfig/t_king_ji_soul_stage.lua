-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_king_ji_soul_stage.lua

module("logicconfig.config.t_king_ji_soul_stage", package.seeall)

local title = {
	stagePlanId = 4,
	stageId = 2,
	stageDesc = 6,
	btnIcon = 5,
	actId = 1,
	stageName = 3
}
local dataList = {
	{
		308001,
		1,
		"水之魂",
		1,
		"board_wangzheji_06",
		"击败守卫即可增加通关数\r\n通关数达到目标后可领奖励"
	},
	{
		308001,
		2,
		"火之魂",
		2,
		"board_wangzheji_05",
		"击败守卫即可增加通关数\r\n通关数达到目标后可领奖励"
	},
	{
		308001,
		3,
		"草之魂",
		3,
		"board_wangzheji_07",
		"击败守卫即可增加通关数\r\n通关数达到目标后可领奖励"
	},
	{
		308001,
		4,
		"光之魂",
		4,
		"board_wangzheji_04",
		"击败守卫即可增加通关数\r\n通关数达到目标后可领奖励"
	},
	{
		308001,
		5,
		"暗之魂",
		5,
		"board_wangzheji_08",
		"击败守卫即可增加通关数\r\n通关数达到目标后可领奖励"
	},
	{
		308002,
		1,
		"水之魂",
		1,
		"board_wangzheji_06",
		"击败守卫即可增加通关数\r\n通关数达到目标后可领奖励"
	},
	{
		308002,
		2,
		"火之魂",
		2,
		"board_wangzheji_05",
		"击败守卫即可增加通关数\r\n通关数达到目标后可领奖励"
	},
	{
		308002,
		3,
		"草之魂",
		3,
		"board_wangzheji_07",
		"击败守卫即可增加通关数\r\n通关数达到目标后可领奖励"
	},
	{
		308002,
		4,
		"光之魂",
		4,
		"board_wangzheji_04",
		"击败守卫即可增加通关数\r\n通关数达到目标后可领奖励"
	},
	{
		308002,
		5,
		"暗之魂",
		5,
		"board_wangzheji_08",
		"击败守卫即可增加通关数\r\n通关数达到目标后可领奖励"
	}
}
local t_king_ji_soul_stage = {
	[308001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	},
	[308002] = {
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	}
}

t_king_ji_soul_stage.dataList = dataList

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

return t_king_ji_soul_stage
