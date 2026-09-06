-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_tutor_activity_common.lua

module("logicconfig.config.t_tutor_activity_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"TUTOR_FORM_PRIZE",
		"4:111:10"
	},
	{
		"TUTOP_TIME_SHOW",
		"领取奖励时间：\n2022.07.08-2022.07.29"
	}
}
local t_tutor_activity_common = {
	TUTOR_FORM_PRIZE = dataList[1],
	TUTOP_TIME_SHOW = dataList[2]
}

t_tutor_activity_common.dataList = dataList

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

return t_tutor_activity_common
