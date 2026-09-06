-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dragon_trial_common_value.lua

module("logicconfig.config.t_dragon_trial_common_value", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"DISCOUNT_SHOW",
		"-40%"
	},
	{
		"BUFF_DESC",
		"战斗开始时，己方所有上阵精灵气势+150。"
	}
}
local t_dragon_trial_common_value = {
	DISCOUNT_SHOW = dataList[1],
	BUFF_DESC = dataList[2]
}

t_dragon_trial_common_value.dataList = dataList

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

return t_dragon_trial_common_value
