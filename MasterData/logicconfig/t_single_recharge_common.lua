-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_single_recharge_common.lua

module("logicconfig.config.t_single_recharge_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"SHOW_RACE_ID",
		"10309"
	}
}
local t_single_recharge_common = {
	SHOW_RACE_ID = dataList[1]
}

t_single_recharge_common.dataList = dataList

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

return t_single_recharge_common
