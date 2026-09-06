-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_alchemy_meng_meng_compound.lua

module("logicconfig.config.t_origin_alchemy_meng_meng_compound", package.seeall)

local title = {
	materialStr = 4,
	compoundName = 3,
	compoundId = 2,
	activityId = 1,
	desc = 5
}
local dataList = {
	{
		601001,
		1,
		82056080,
		"1004:1652",
		82056379
	},
	{
		601001,
		2,
		82056082,
		"1004:1653",
		82056380
	},
	{
		601001,
		3,
		82056084,
		"1004:1654",
		82056381
	}
}
local t_origin_alchemy_meng_meng_compound = {
	[601001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_origin_alchemy_meng_meng_compound.dataList = dataList

local multiLanguageCells = {
	desc = true,
	compoundName = true
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

return t_origin_alchemy_meng_meng_compound
