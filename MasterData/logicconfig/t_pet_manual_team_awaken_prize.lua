-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pet_manual_team_awaken_prize.lua

module("logicconfig.config.t_pet_manual_team_awaken_prize", package.seeall)

local title = {
	teamId = 1,
	prize = 3,
	needAwakenLv = 2
}
local dataList = {
	{
		0,
		3,
		"4:3:1"
	},
	{
		0,
		6,
		"4:3:2"
	},
	{
		0,
		9,
		"4:3:3"
	}
}
local t_pet_manual_team_awaken_prize = {
	[0] = {
		[3] = dataList[1],
		[6] = dataList[2],
		[9] = dataList[3]
	}
}

t_pet_manual_team_awaken_prize.dataList = dataList

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

return t_pet_manual_team_awaken_prize
