-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_family_level_config.lua

module("logicconfig.config.t_family_level_config", package.seeall)

local title = {
	guildAvatar = 10,
	maxCount1 = 3,
	maxCount2 = 4,
	openPartyCostMoney = 9,
	upgradeConstruction = 6,
	maxCount3 = 5,
	decrMoneyDaily = 8,
	maxAllMemberCount = 2,
	maxMoney = 7,
	level = 1
}
local dataList = {
	{
		1,
		30,
		1,
		0,
		6,
		0,
		200000,
		1,
		50000,
		"guild_icon_1,guild_icon_2,guild_icon_3,guild_icon_4,guild_icon_5,guild_icon_6"
	},
	{
		2,
		35,
		1,
		1,
		7,
		100000,
		400000,
		500,
		50000,
		"guild_icon_1,guild_icon_2,guild_icon_3,guild_icon_4,guild_icon_5,guild_icon_6"
	},
	{
		3,
		40,
		1,
		2,
		8,
		500000,
		600000,
		2000,
		50000,
		"guild_icon_1,guild_icon_2,guild_icon_3,guild_icon_4,guild_icon_5,guild_icon_6"
	},
	{
		4,
		45,
		2,
		3,
		9,
		1000000,
		800000,
		5000,
		50000,
		"guild_icon_1,guild_icon_2,guild_icon_3,guild_icon_4,guild_icon_5,guild_icon_6"
	},
	{
		5,
		50,
		2,
		4,
		10,
		3000000,
		1000000,
		10000,
		50000,
		"guild_icon_1,guild_icon_2,guild_icon_3,guild_icon_4,guild_icon_5,guild_icon_6"
	}
}
local t_family_level_config = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5]
}

t_family_level_config.dataList = dataList

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

return t_family_level_config
