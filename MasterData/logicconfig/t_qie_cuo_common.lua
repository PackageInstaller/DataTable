-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_qie_cuo_common.lua

module("logicconfig.config.t_qie_cuo_common", package.seeall)

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
		"DEFENSE_FORMATION_TIME",
		"120"
	},
	{
		"ATTACK_READY_TIME",
		"60"
	},
	{
		"MATCH_TIME",
		"30"
	}
}
local t_qie_cuo_common = {
	DEFENSE_READY_TIME = dataList[1],
	DEFENSE_FORMATION_TIME = dataList[2],
	ATTACK_READY_TIME = dataList[3],
	MATCH_TIME = dataList[4]
}

t_qie_cuo_common.dataList = dataList

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

return t_qie_cuo_common
