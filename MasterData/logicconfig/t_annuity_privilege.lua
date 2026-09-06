-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_annuity_privilege.lua

module("logicconfig.config.t_annuity_privilege", package.seeall)

local title = {
	sweepPlanId = 4,
	privilegeStartTime = 2,
	annuityActivityId = 1,
	privilegeEndTime = 3
}
local dataList = {
	{
		8005,
		"2025-01-01T00:00:00",
		"2026-01-01T00:00:00",
		1
	},
	{
		8006,
		"2026-01-01T05:00:00",
		"2026-12-31T05:00:00",
		1
	}
}
local t_annuity_privilege = {
	[8005] = dataList[1],
	[8006] = dataList[2]
}

t_annuity_privilege.dataList = dataList

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

return t_annuity_privilege
