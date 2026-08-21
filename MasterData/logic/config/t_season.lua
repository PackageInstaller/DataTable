-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_season.lua

module("logic.config.t_season", package.seeall)

local title = {
	id = 1,
	name = 2,
	finalRewardLv = 9,
	loopStartLv = 4,
	finalRewardContent = 8,
	art = 3,
	rewardId2 = 7,
	previewRewrad = 5,
	rewardId1 = 6
}
local dataList = {
	{
		10000,
		"评议记录",
		"",
		50,
		{
			{
				num = 3,
				code = 1013001
			},
			{
				num = 1,
				code = 1011001
			}
		},
		2012006,
		2012007,
		"",
		50
	}
}
local t_season = {}

t_season.dataList = dataList

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
	t_season[v[1]] = v

	setmetatable(v, mt)
end

return t_season
