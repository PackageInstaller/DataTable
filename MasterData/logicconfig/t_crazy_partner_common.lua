-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_crazy_partner_common.lua

module("logicconfig.config.t_crazy_partner_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"STORY_ID",
		"4230003"
	},
	{
		"MAIN_RULE_KEY",
		"crazypartnermainview_rule"
	},
	{
		"LEVEL_RULE_KEY",
		"crazypartnermainview1_rule"
	},
	{
		"LEVEL_PET_RACE_ID",
		"12002"
	},
	{
		"LEVEL_BUBBLE",
		"引爆力量，解救暴走的伙伴！\n激发潜能，酣畅淋漓大战一场！"
	}
}
local t_crazy_partner_common = {
	STORY_ID = dataList[1],
	MAIN_RULE_KEY = dataList[2],
	LEVEL_RULE_KEY = dataList[3],
	LEVEL_PET_RACE_ID = dataList[4],
	LEVEL_BUBBLE = dataList[5]
}

t_crazy_partner_common.dataList = dataList

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

return t_crazy_partner_common
