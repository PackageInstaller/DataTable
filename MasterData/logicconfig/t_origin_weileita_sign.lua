-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_weileita_sign.lua

module("logicconfig.config.t_origin_weileita_sign", package.seeall)

local title = {
	scoreType = 5,
	name = 3,
	passDesc = 7,
	iconPath = 6,
	signId = 2,
	effect = 8,
	activityId = 1,
	positionBuff = 4
}
local dataList = {
	{
		561001,
		1,
		"厄运：",
		"20070106:99#20070108:99",
		"ultimateNum",
		"",
		"存活，超杀<color=#FF9F9BFF>≥%s</color>",
		"fx_ui_jinglinggezi/fx_ui_buzhen_08.prefab"
	},
	{
		561001,
		2,
		"烈焰：",
		"20070109:99#20070111:99",
		"killTimes",
		"",
		"存活，击杀<color=#FF9F9BFF>≥%s</color>",
		"fx_ui_jinglinggezi/fx_ui_buzhen_06.prefab"
	}
}
local t_origin_weileita_sign = {
	[561001] = {
		dataList[1],
		dataList[2]
	}
}

t_origin_weileita_sign.dataList = dataList

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

return t_origin_weileita_sign
