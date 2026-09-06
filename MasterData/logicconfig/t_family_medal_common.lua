-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_family_medal_common.lua

module("logicconfig.config.t_family_medal_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"RANK_SIZE",
		"500"
	},
	{
		"LABEL_NAME",
		"一星,二星,三星,成就,活动,比赛"
	},
	{
		"RANK_VIEW_SIZE",
		"100"
	}
}
local t_family_medal_common = {
	RANK_SIZE = dataList[1],
	LABEL_NAME = dataList[2],
	RANK_VIEW_SIZE = dataList[3]
}

t_family_medal_common.dataList = dataList

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

return t_family_medal_common
