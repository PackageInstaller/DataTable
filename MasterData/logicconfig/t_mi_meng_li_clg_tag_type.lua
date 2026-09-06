-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_mi_meng_li_clg_tag_type.lua

module("logicconfig.config.t_mi_meng_li_clg_tag_type", package.seeall)

local title = {
	iconPath = 5,
	name = 4,
	job = 7,
	tagType = 2,
	shortName = 6,
	activityId = 1,
	desc = 3
}
local dataList = {
	{
		417001,
		1,
		"战斗获胜得记忆碎片*40",
		"财富印记",
		"",
		"财富",
		""
	},
	{
		417001,
		2,
		"存活精灵中带有生命印记的精灵将额外获得记忆碎片*10",
		"生命印记",
		"",
		"生命",
		"治疗#肉盾"
	},
	{
		417001,
		3,
		"存活精灵中带有力量印记的精灵将额外获得记忆碎片*20",
		"力量印记",
		"",
		"力量",
		"魔法#利爪"
	},
	{
		417001,
		4,
		"存活精灵中带有勇气印记的精灵将额外获得记忆碎片*20",
		"勇气印记",
		"",
		"勇气",
		"疾速#平衡"
	}
}
local t_mi_meng_li_clg_tag_type = {
	[417001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_mi_meng_li_clg_tag_type.dataList = dataList

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

return t_mi_meng_li_clg_tag_type
