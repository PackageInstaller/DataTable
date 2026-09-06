-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pet_manual_team_collect_prize.lua

module("logicconfig.config.t_pet_manual_team_collect_prize", package.seeall)

local title = {
	needCollectNum = 2,
	teamId = 1,
	prize = 3
}
local dataList = {
	{
		0,
		1,
		"4:3:1"
	},
	{
		0,
		2,
		"4:3:2"
	},
	{
		0,
		3,
		"4:3:3"
	}
}
local t_pet_manual_team_collect_prize = {
	[0] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_pet_manual_team_collect_prize.dataList = dataList

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

return t_pet_manual_team_collect_prize
