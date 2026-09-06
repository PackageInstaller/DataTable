-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_alchemy_mm_game_rule.lua

module("logicconfig.config.t_alchemy_mm_game_rule", package.seeall)

local title = {
	resPath = 3,
	pageId = 2,
	ruleId = 1,
	desc = 4
}
local dataList = {
	{
		1,
		1,
		"ui/bigbg/copychapter/board_ljxyx_guize_01.png",
		82056689
	}
}
local t_alchemy_mm_game_rule = {
	{
		dataList[1]
	}
}

t_alchemy_mm_game_rule.dataList = dataList

local multiLanguageCells = {
	desc = true
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

return t_alchemy_mm_game_rule
