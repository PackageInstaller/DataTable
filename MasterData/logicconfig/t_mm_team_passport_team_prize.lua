-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_mm_team_passport_team_prize.lua

module("logicconfig.config.t_mm_team_passport_team_prize", package.seeall)

local title = {
	prizeId = 2,
	memberCount = 3,
	activityId = 1,
	prize = 4
}
local dataList = {
	{
		600001,
		1,
		1,
		"204:2:25"
	},
	{
		600001,
		2,
		2,
		"204:2:25"
	}
}
local t_mm_team_passport_team_prize = {
	[600001] = {
		dataList[1],
		dataList[2]
	}
}

t_mm_team_passport_team_prize.dataList = dataList

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

return t_mm_team_passport_team_prize
