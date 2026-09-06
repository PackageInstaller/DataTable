-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_new_hand_welfare_params.lua

module("logicconfig.config.t_new_hand_welfare_params", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"BUY_ZDL_SUPER_PRIZE_PRICE",
		"rmb_18"
	},
	{
		"UNDER_LEVEL",
		"3"
	},
	{
		"ACTIVE_DATE",
		"2021-12-31"
	},
	{
		"SKIP_TASK_TO",
		"10010,2"
	},
	{
		"ORIGIN_MATERIAL_REOPEN_TIMES",
		"1"
	}
}
local t_new_hand_welfare_params = {
	BUY_ZDL_SUPER_PRIZE_PRICE = dataList[1],
	UNDER_LEVEL = dataList[2],
	ACTIVE_DATE = dataList[3],
	SKIP_TASK_TO = dataList[4],
	ORIGIN_MATERIAL_REOPEN_TIMES = dataList[5]
}

t_new_hand_welfare_params.dataList = dataList

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

return t_new_hand_welfare_params
