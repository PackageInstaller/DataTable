-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_summer_treasure_snatch_camp.lua

module("logicconfig.config.t_summer_treasure_snatch_camp", package.seeall)

local title = {
	teamId = 2,
	name = 3,
	activityId = 1
}
local dataList = {
	{
		623001,
		1,
		82056724
	},
	{
		623001,
		2,
		82056725
	}
}
local t_summer_treasure_snatch_camp = {
	[623001] = {
		dataList[1],
		dataList[2]
	}
}

t_summer_treasure_snatch_camp.dataList = dataList

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

return t_summer_treasure_snatch_camp
