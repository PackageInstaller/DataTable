-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pay_strengthen_params.lua

module("logicconfig.config.t_pay_strengthen_params", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"STAR_GOD_FILTER_NUM",
		"4"
	},
	{
		"RED_STAR_GOD_RACE_JOB",
		"源起"
	}
}
local t_pay_strengthen_params = {
	STAR_GOD_FILTER_NUM = dataList[1],
	RED_STAR_GOD_RACE_JOB = dataList[2]
}

t_pay_strengthen_params.dataList = dataList

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

return t_pay_strengthen_params
