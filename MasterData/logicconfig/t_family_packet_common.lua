-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_family_packet_common.lua

module("logicconfig.config.t_family_packet_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"FAMILY_PACKET_STORE_LIMIT",
		"10"
	},
	{
		"USER_CONTRIBUTION_LIMIT",
		"500"
	},
	{
		"USER_PACKET_RECORD_LIMIT",
		"20"
	},
	{
		"DELETE_RULE_AFTER_FINISH",
		"3"
	}
}
local t_family_packet_common = {
	FAMILY_PACKET_STORE_LIMIT = dataList[1],
	USER_CONTRIBUTION_LIMIT = dataList[2],
	USER_PACKET_RECORD_LIMIT = dataList[3],
	DELETE_RULE_AFTER_FINISH = dataList[4]
}

t_family_packet_common.dataList = dataList

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

return t_family_packet_common
