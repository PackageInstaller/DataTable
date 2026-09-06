-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_survival_king_level_buff_cost.lua

module("logicconfig.config.t_survival_king_level_buff_cost", package.seeall)

local title = {
	cost = 3,
	activityId = 1,
	level = 2
}
local dataList = {
	{
		529002,
		1,
		""
	},
	{
		529002,
		2,
		"10:529003:200"
	},
	{
		529002,
		3,
		"10:529003:250"
	},
	{
		529002,
		4,
		"10:529003:300"
	},
	{
		529002,
		5,
		"10:529003:350"
	}
}
local t_survival_king_level_buff_cost = {
	[529002] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_survival_king_level_buff_cost.dataList = dataList

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

return t_survival_king_level_buff_cost
