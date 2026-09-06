-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_mi_ya_clg_rule.lua

module("logicconfig.config.t_divine_mi_ya_clg_rule", package.seeall)

local title = {
	res = 3,
	pageId = 2,
	activityId = 1,
	desc = 4
}
local dataList = {
	{
		399001,
		1,
		"board_shenyaomiya_03",
		""
	},
	{
		399001,
		2,
		"board_shenyaomiya_04",
		""
	},
	{
		399001,
		3,
		"board_shenyaomiya_05",
		""
	},
	{
		399001,
		4,
		"board_shenyaomiya_06",
		""
	}
}
local t_divine_mi_ya_clg_rule = {
	[399001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_divine_mi_ya_clg_rule.dataList = dataList

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

return t_divine_mi_ya_clg_rule
