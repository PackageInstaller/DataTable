-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_goddess_competition_double_card.lua

module("logicconfig.config.t_goddess_competition_double_card", package.seeall)

local title = {
	cost = 3,
	cardId = 2,
	ratio = 5,
	cardValue = 4,
	activityId = 1
}
local dataList = {
	{
		453002,
		1,
		"10:453005:1",
		5000,
		2
	},
	{
		453002,
		2,
		"10:453006:1",
		5000,
		3
	},
	{
		453002,
		3,
		"10:453007:1",
		5000,
		4
	}
}
local t_goddess_competition_double_card = {
	[453002] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_goddess_competition_double_card.dataList = dataList

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

return t_goddess_competition_double_card
