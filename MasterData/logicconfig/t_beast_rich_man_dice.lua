-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_beast_rich_man_dice.lua

module("logicconfig.config.t_beast_rich_man_dice", package.seeall)

local title = {
	param = 3,
	activityId = 1,
	diceType = 2,
	cost = 4
}
local dataList = {
	{
		558001,
		1,
		"1,6",
		"10:558002:1"
	},
	{
		558001,
		2,
		"1,6",
		"10:558003:1"
	}
}
local t_beast_rich_man_dice = {
	[558001] = {
		dataList[1],
		dataList[2]
	}
}

t_beast_rich_man_dice.dataList = dataList

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

return t_beast_rich_man_dice
