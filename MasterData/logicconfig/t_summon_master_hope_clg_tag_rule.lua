-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_summon_master_hope_clg_tag_rule.lua

module("logicconfig.config.t_summon_master_hope_clg_tag_rule", package.seeall)

local title = {
	tagType = 2,
	name = 3,
	activityId = 1
}
local dataList = {
	{
		403001,
		1,
		"生命印记"
	},
	{
		403001,
		2,
		"力量印记"
	},
	{
		403001,
		3,
		"勇气印记"
	}
}
local t_summon_master_hope_clg_tag_rule = {
	[403001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_summon_master_hope_clg_tag_rule.dataList = dataList

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

return t_summon_master_hope_clg_tag_rule
