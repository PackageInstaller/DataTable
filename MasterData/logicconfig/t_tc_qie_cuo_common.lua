-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_tc_qie_cuo_common.lua

module("logicconfig.config.t_tc_qie_cuo_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"DEFENSE_READY_TIME",
		"60"
	},
	{
		"ATTACK_READY_TIME",
		"60"
	},
	{
		"FORM_MAX_TIME",
		"3600"
	},
	{
		"PVE_NAME",
		"电脑"
	},
	{
		"BEINVATE_STAND_TIME",
		"20"
	},
	{
		"PVE_PER_PET_MIN_POWER",
		"20000"
	},
	{
		"PVE_PER_PET_MAX_POWER",
		"800000"
	},
	{
		"PVE_PER_STEP_POWER",
		"10000"
	},
	{
		"Break_recommend_zdl_range",
		"10000"
	},
	{
		"DEFENSE_FORM_MIN_PET_COUNT",
		"5"
	},
	{
		"RECORD_EXPIRED_DAYS",
		"7"
	},
	{
		"Mode_Break_Desc",
		"自选切磋模式下玩家需要先设置自己的守阵，方可在守阵列表中找到与自己战力差距较大或相近的玩家守阵列表；可自行选择挑战的玩家对其发起进攻"
	}
}
local t_tc_qie_cuo_common = {
	DEFENSE_READY_TIME = dataList[1],
	ATTACK_READY_TIME = dataList[2],
	FORM_MAX_TIME = dataList[3],
	PVE_NAME = dataList[4],
	BEINVATE_STAND_TIME = dataList[5],
	PVE_PER_PET_MIN_POWER = dataList[6],
	PVE_PER_PET_MAX_POWER = dataList[7],
	PVE_PER_STEP_POWER = dataList[8],
	Break_recommend_zdl_range = dataList[9],
	DEFENSE_FORM_MIN_PET_COUNT = dataList[10],
	RECORD_EXPIRED_DAYS = dataList[11],
	Mode_Break_Desc = dataList[12]
}

t_tc_qie_cuo_common.dataList = dataList

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

return t_tc_qie_cuo_common
