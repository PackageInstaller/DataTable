-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_king_ji_courier_stage.lua

module("logicconfig.config.t_king_ji_courier_stage", package.seeall)

local title = {
	stageId = 2,
	desc = 4,
	iconName = 6,
	raceId = 7,
	creepsMasterId = 5,
	actId = 1,
	stageName = 3
}
local dataList = {
	{
		308001,
		1,
		"水元素使者",
		"挑战者上阵的水系精灵攻击+300%",
		101,
		"board_wangzheji_06",
		90142
	},
	{
		308001,
		2,
		"火元素使者",
		"挑战者上阵的火系精灵攻击+300%",
		102,
		"board_wangzheji_05",
		90143
	},
	{
		308001,
		3,
		"草元素使者",
		"挑战者上阵的草系精灵攻击+300%",
		103,
		"board_wangzheji_07",
		90144
	},
	{
		308001,
		4,
		"光元素使者",
		"挑战者上阵的光系精灵攻击+300%",
		104,
		"board_wangzheji_04",
		90145
	},
	{
		308001,
		5,
		"暗元素使者",
		"挑战者上阵的暗系精灵攻击+300%",
		105,
		"board_wangzheji_08",
		90146
	},
	{
		308002,
		1,
		"水元素使者",
		"挑战者上阵的水系精灵攻击+300%",
		101,
		"board_wangzheji_06",
		90142
	},
	{
		308002,
		2,
		"火元素使者",
		"挑战者上阵的火系精灵攻击+300%",
		102,
		"board_wangzheji_05",
		90143
	},
	{
		308002,
		3,
		"草元素使者",
		"挑战者上阵的草系精灵攻击+300%",
		103,
		"board_wangzheji_07",
		90144
	},
	{
		308002,
		4,
		"光元素使者",
		"挑战者上阵的光系精灵攻击+300%",
		104,
		"board_wangzheji_04",
		90145
	},
	{
		308002,
		5,
		"暗元素使者",
		"挑战者上阵的暗系精灵攻击+300%",
		105,
		"board_wangzheji_08",
		90146
	}
}
local t_king_ji_courier_stage = {
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

t_king_ji_courier_stage.dataList = dataList

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

return t_king_ji_courier_stage
