-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ultimate_trial_score_rank_type.lua

module("logicconfig.config.t_ultimate_trial_score_rank_type", package.seeall)

local title = {
	scoreRankType = 2,
	clgActType = 1
}
local dataList = {
	{
		469,
		"asc"
	},
	{
		471,
		"desc"
	},
	{
		473,
		"desc"
	}
}
local t_ultimate_trial_score_rank_type = {
	[469] = dataList[1],
	[471] = dataList[2],
	[473] = dataList[3]
}

t_ultimate_trial_score_rank_type.dataList = dataList

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

return t_ultimate_trial_score_rank_type
