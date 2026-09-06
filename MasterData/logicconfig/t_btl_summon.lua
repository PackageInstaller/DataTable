-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_btl_summon.lua

module("logicconfig.config.t_btl_summon", package.seeall)

local title = {
	materialsA = 6,
	summonedGroupId = 5,
	masterGroupId = 4,
	summonMasterRaceIds = 2,
	spDesc = 10,
	desc = 9,
	materialsB = 7,
	summonedRaceIds = 3,
	zdlFactor = 8,
	id = 1
}
local dataList = {}
local t_btl_summon = {}

t_btl_summon.dataList = dataList

local multiLanguageCells = {
	spDesc = true
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

return t_btl_summon
