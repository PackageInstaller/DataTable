-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_vip_client_params.lua

module("logicconfig.config.t_vip_client_params", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"VIP0_SKIP_FIGHT_LV_LIMIT_TIPS",
		"<color=#ffa429>【训练师等级达到%d级】</color>或<color=#ffa429>【VIP%d】</color>时\n可在冷却时间结束后跳过战斗"
	},
	{
		"SKIP_FIGHT_COOL_TIME",
		"冷却时间结束后才能跳过哦！"
	},
	{
		"VIP0_SKIP_FIGHT_TIME_LIMIT",
		"15"
	}
}
local t_vip_client_params = {
	VIP0_SKIP_FIGHT_LV_LIMIT_TIPS = dataList[1],
	SKIP_FIGHT_COOL_TIME = dataList[2],
	VIP0_SKIP_FIGHT_TIME_LIMIT = dataList[3]
}

t_vip_client_params.dataList = dataList

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

return t_vip_client_params
