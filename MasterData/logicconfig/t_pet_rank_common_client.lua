-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pet_rank_common_client.lua

module("logicconfig.config.t_pet_rank_common_client", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"default_strengthen_func",
		"5086"
	},
	{
		"default_reward_icon",
		"4:90259:1"
	}
}
local t_pet_rank_common_client = {
	default_strengthen_func = dataList[1],
	default_reward_icon = dataList[2]
}

t_pet_rank_common_client.dataList = dataList

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

return t_pet_rank_common_client
