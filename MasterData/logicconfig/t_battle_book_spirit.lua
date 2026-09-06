-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_battle_book_spirit.lua

module("logicconfig.config.t_battle_book_spirit", package.seeall)

local title = {
	petRaceId = 2,
	desc = 3,
	masterRaceId = 1
}
local dataList = {
	{
		17027,
		13030,
		82056051
	}
}
local t_battle_book_spirit = {
	[17027] = {
		[13030] = dataList[1]
	}
}

t_battle_book_spirit.dataList = dataList

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

return t_battle_book_spirit
