-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_reward_tag.lua

module("logic.config.t_reward_tag", package.seeall)

local title = {
	programming = 2,
	code = 1
}
local dataList = {
	{
		1,
		"REWARD_TAG_1"
	},
	{
		2,
		"REWARD_TAG_2"
	}
}
local t_reward_tag = {
	dataList[1],
	dataList[2]
}

t_reward_tag.dataList = dataList

local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			return rawget(t, index)
		else
			error(string.format("the field name [%s] is nonexist!", key))
		end
	end
}

for i, v in ipairs(dataList) do
	setmetatable(v, mt)
end

return t_reward_tag
