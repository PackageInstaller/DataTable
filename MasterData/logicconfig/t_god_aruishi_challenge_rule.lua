-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_god_aruishi_challenge_rule.lua

module("logicconfig.config.t_god_aruishi_challenge_rule", package.seeall)

local title = {
	resName = 3,
	desc = 4,
	ruleId = 1,
	tabId = 2
}
local dataList = {
	{
		1,
		1,
		"board_shenqiaruisi_09",
		"1.精灵镶嵌灵纹后，可以增加精灵的出战属性。\r\n2.同时也带来精灵定位的多样性，通过灵纹，使输出精灵的生存能力更强，肉盾精灵也有输出。"
	},
	{
		1,
		2,
		"board_shenqiaruisi_11",
		""
	},
	{
		2,
		1,
		"board_shenqiaruisi_10",
		""
	},
	{
		2,
		2,
		"board_shenqiaruisi_12",
		"1.获得灵纹时，默认解锁两条淬灵属性。\r\n2.当灵纹强化至10级、15级、20级可额外解锁一条淬灵属性。"
	}
}
local t_god_aruishi_challenge_rule = {
	{
		dataList[1],
		dataList[2]
	},
	{
		dataList[3],
		dataList[4]
	}
}

t_god_aruishi_challenge_rule.dataList = dataList

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

return t_god_aruishi_challenge_rule
