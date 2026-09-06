-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_popularity_list_common.lua

module("logicconfig.config.t_popularity_list_common", package.seeall)

local title = {
	ruleKeyMain = 2,
	comPlanId = 1,
	ruleKeyRecord = 3
}
local dataList = {
	{
		1,
		"popularitylist",
		"nianzhongdashiji_rule"
	}
}
local t_popularity_list_common = {
	dataList[1]
}

t_popularity_list_common.dataList = dataList

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

return t_popularity_list_common
