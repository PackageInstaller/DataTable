-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_sourcemon_define.lua

module("logicconfig.config.t_sourcemon_define", package.seeall)

local title = {
	mutateTypeIds = 12,
	levelThreeProps = 15,
	levelFourProps = 16,
	type = 6,
	zdls = 8,
	defineId = 1,
	magicalZdlRatio = 10,
	desc = 5,
	levelEightProps = 20,
	gradeUpValues = 11,
	name = 2,
	LevelTenProps = 22,
	levelOneProps = 13,
	levelNineProps = 21,
	skillIds = 7,
	levelSevenProps = 19,
	levelFiveProps = 17,
	physicalZdlRatio = 9,
	levelTwoProps = 14,
	typeName = 3,
	modelId = 4,
	levelSixProps = 18
}
local dataList = {}
local t_sourcemon_define = {}

t_sourcemon_define.dataList = dataList

local multiLanguageCells = {
	desc = true,
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

return t_sourcemon_define
