-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_phantom_space_common.lua

module("logicconfig.config.t_phantom_space_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"MAIN_PRIZE_DESC",
		"通关领橙+1/金星/淬源晶石"
	},
	{
		"INFINITE_RULE_TIP",
		"仅设置1个敌阵作为第1关，玩家挑战成功第1关后，己阵通关阵容成为第2关的敌阵；玩家挑战成功第2关后，己阵通关阵容成为第3关的敌阵，以此类推。永恒境指定关卡后，会有敌阵全属性增益buff。"
	}
}
local t_phantom_space_common = {
	MAIN_PRIZE_DESC = dataList[1],
	INFINITE_RULE_TIP = dataList[2]
}

t_phantom_space_common.dataList = dataList

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

return t_phantom_space_common
