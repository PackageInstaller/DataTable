-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ace_team_level.lua

module("logicconfig.config.t_ace_team_level", package.seeall)

local title = {
	openStrengthenLvUp = 4,
	name = 3,
	titlePrize = 5,
	lockTips = 6,
	medal = 2,
	level = 1
}
local dataList = {
	{
		1,
		0,
		82007965,
		0,
		"",
		"战队等级不足哦"
	},
	{
		2,
		100,
		82007966,
		3,
		"",
		"在本玩法中获得<color=#ebad32>100</color>荣耀勋章，升级到<color=#ebad32>白板战队</color>，开启"
	},
	{
		3,
		500,
		82007967,
		1,
		"",
		"在本玩法中获得<color=#ebad32>500</color>荣耀勋章，升级到<color=#ebad32>青铜战队</color>，开启"
	},
	{
		4,
		1000,
		82007968,
		2,
		"2:44:1",
		"在本玩法中获得<color=#ebad32>1000</color>荣耀勋章，升级到<color=#ebad32>白银战队</color>，开启"
	},
	{
		5,
		1500,
		82007969,
		5,
		"2:45:1",
		"在本玩法中获得<color=#ebad32>1500</color>荣耀勋章，升级到<color=#ebad32>黄金战队</color>，开启"
	},
	{
		6,
		2000,
		82007970,
		4,
		"2:46:1",
		"在本玩法中获得<color=#ebad32>2000</color>荣耀勋章，升级到<color=#ebad32>王牌战队</color>，开启"
	}
}
local t_ace_team_level = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6]
}

t_ace_team_level.dataList = dataList

local multiLanguageCells = {
	name = true
}
local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			local value = rawget(t, index)

			if multiLanguageCells[key] then
				value = lang(value)
			end

			return value
		else
			printWarn(string.format("the field name [%s] is nonexist!", key))
		end
	end
}

for i, v in ipairs(dataList) do
	setmetatable(v, mt)
end

return t_ace_team_level
