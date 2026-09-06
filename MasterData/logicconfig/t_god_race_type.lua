-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_god_race_type.lua

module("logicconfig.config.t_god_race_type", package.seeall)

local title = {
	desc2 = 6,
	oneKeyWakePrice = 9,
	raceIdBefore = 1,
	desc1 = 5,
	isOnline = 10,
	leftPetExpress = 3,
	oneKeyLeftPrice = 7,
	oneKeyRigthPrice = 8,
	raceIdAfter = 2,
	rightPetExpress = 4
}
local dataList = {
	{
		10014,
		10004,
		"Race$10026",
		"Race$10009",
		82000339,
		82000340,
		10,
		50,
		55,
		true
	},
	{
		10001,
		10002,
		"Job$魔法&Level$大于等于,80",
		"Race$10001",
		82000341,
		82000343,
		10,
		50,
		55,
		true
	}
}
local t_god_race_type = {
	[10014] = dataList[1],
	[10001] = dataList[2]
}

t_god_race_type.dataList = dataList

local multiLanguageCells = {
	desc2 = true,
	desc1 = true
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

return t_god_race_type
