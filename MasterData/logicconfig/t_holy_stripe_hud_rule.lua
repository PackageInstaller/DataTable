-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_holy_stripe_hud_rule.lua

module("logicconfig.config.t_holy_stripe_hud_rule", package.seeall)

local title = {
	resName = 2,
	id = 1,
	desc = 3
}
local dataList = {
	{
		1,
		"board_lw_05",
		"1.精灵镶嵌灵纹后，可以增加精灵的出战属性。\r\n2.同时也带来精灵定位的多样性，通过灵纹，使输出精灵的生存能力更强，肉盾精灵也有输出。"
	},
	{
		2,
		"board_lw_01",
		"1.每个精灵可以镶嵌5个灵纹，镶嵌后可以增加属性。\r\n2.灵纹需要根据部位镶嵌，每个灵纹拥有1条基础属性和不超过5条淬灵属性。"
	},
	{
		3,
		"board_lw_02",
		"同类型的灵纹镶嵌达到2件和4件时，可触发灵纹套装效果，获得额外属性和技能效果加成。"
	},
	{
		4,
		"board_lw_04",
		"1.获得灵纹时，默认解锁两条淬灵属性。\r\n2.当灵纹强化至10级、15级、20级可额外解锁一条淬灵属性。"
	}
}
local t_holy_stripe_hud_rule = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4]
}

t_holy_stripe_hud_rule.dataList = dataList

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

return t_holy_stripe_hud_rule
