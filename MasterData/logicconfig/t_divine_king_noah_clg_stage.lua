-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_king_noah_clg_stage.lua

module("logicconfig.config.t_divine_king_noah_clg_stage", package.seeall)

local title = {
	stageId = 2,
	stagePlanId = 1,
	creepsMasterId = 3,
	desc = 4
}
local dataList = {
	{
		1,
		1,
		1001,
		"挑战关卡1"
	},
	{
		1,
		2,
		1002,
		"挑战关卡2"
	},
	{
		1,
		3,
		1003,
		"挑战关卡3"
	},
	{
		1,
		4,
		1004,
		"挑战关卡4"
	},
	{
		1,
		5,
		1005,
		"挑战关卡5"
	},
	{
		1,
		6,
		1006,
		"挑战关卡6"
	},
	{
		1,
		7,
		1007,
		"挑战关卡7"
	},
	{
		1,
		8,
		1008,
		"挑战关卡8"
	},
	{
		1,
		9,
		1009,
		"挑战关卡9"
	},
	{
		1,
		10,
		1010,
		"挑战关卡10"
	},
	{
		1,
		11,
		1011,
		"挑战关卡11"
	},
	{
		1,
		12,
		1012,
		"挑战关卡12"
	},
	{
		1,
		13,
		1013,
		"挑战关卡13"
	},
	{
		1,
		14,
		1014,
		"挑战关卡14"
	},
	{
		1,
		15,
		1015,
		"挑战关卡15"
	},
	{
		1,
		16,
		1016,
		"挑战关卡16"
	}
}
local t_divine_king_noah_clg_stage = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16]
	}
}

t_divine_king_noah_clg_stage.dataList = dataList

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

return t_divine_king_noah_clg_stage
