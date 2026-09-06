-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_days_recharge_common.lua

module("logicconfig.config.t_days_recharge_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"SHOW_RACE_ID",
		"17011"
	},
	{
		"CONTIMUOUSRE_ACTID",
		"79004"
	},
	{
		"DAY_ACTID",
		"79005"
	}
}
local t_days_recharge_common = {
	SHOW_RACE_ID = dataList[1],
	CONTIMUOUSRE_ACTID = dataList[2],
	DAY_ACTID = dataList[3]
}

t_days_recharge_common.dataList = dataList

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

return t_days_recharge_common
