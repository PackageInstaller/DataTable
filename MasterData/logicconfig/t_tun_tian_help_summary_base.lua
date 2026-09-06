-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_tun_tian_help_summary_base.lua

module("logicconfig.config.t_tun_tian_help_summary_base", package.seeall)

local title = {
	jumpPlanId = 1,
	startTime = 3,
	endTime = 4,
	funcId = 2
}
local dataList = {
	{
		1,
		922,
		"2023-07-28T05:00:00",
		"2023-08-11T05:00:00"
	},
	{
		2,
		922,
		"2023-09-01T05:00:00",
		"2023-10-27T05:00:00"
	}
}
local t_tun_tian_help_summary_base = {
	dataList[1],
	dataList[2]
}

t_tun_tian_help_summary_base.dataList = dataList

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

return t_tun_tian_help_summary_base
