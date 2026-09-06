-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ashless_long_yan_buff.lua

module("logicconfig.config.t_ashless_long_yan_buff", package.seeall)

local title = {
	desc = 5,
	effPath = 4,
	buffPlanId = 1,
	index = 2,
	fireCount = 3
}
local dataList = {
	{
		1,
		1,
		1,
		"20241220/wujinlongyantiaozhan/fx_ui_huotui_xiao",
		"每当敌阵进行第5次攻击时该次攻击附带虚无效果"
	},
	{
		1,
		2,
		2,
		"20241220/wujinlongyantiaozhan/fx_ui_huotui_zhong",
		"每当敌阵进行第4次攻击时该次攻击附带虚无效果"
	},
	{
		1,
		3,
		3,
		"20241220/wujinlongyantiaozhan/fx_ui_huotui_da",
		"每当敌阵进行第3次攻击时该次攻击附带虚无效果"
	}
}
local t_ashless_long_yan_buff = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_ashless_long_yan_buff.dataList = dataList

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

return t_ashless_long_yan_buff
