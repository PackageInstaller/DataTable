-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pet_active_get_common.lua

module("logicconfig.config.t_pet_active_get_common", package.seeall)

local title = {
	ruleKeyMain = 3,
	activityId = 1,
	skinId = 2
}
local dataList = {
	{
		401001,
		17023,
		"huanxinqingmainview_rule_01"
	},
	{
		401002,
		14028,
		"huanxinqingmainview_rule_02"
	},
	{
		401003,
		11033,
		"huanxinqingmainview_rule_03"
	}
}
local t_pet_active_get_common = {
	[401001] = dataList[1],
	[401002] = dataList[2],
	[401003] = dataList[3]
}

t_pet_active_get_common.dataList = dataList

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

return t_pet_active_get_common
