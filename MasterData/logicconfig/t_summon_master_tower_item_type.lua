-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_summon_master_tower_item_type.lua

module("logicconfig.config.t_summon_master_tower_item_type", package.seeall)

local title = {
	itemId = 3,
	itemType = 1,
	name = 2
}
local dataList = {
	{
		1,
		82001743,
		1203
	},
	{
		2,
		82001744,
		1204
	},
	{
		3,
		82037502,
		0
	},
	{
		4,
		82001745,
		1205
	},
	{
		5,
		82001746,
		1206
	},
	{
		6,
		82001747,
		1207
	},
	{
		7,
		82037503,
		0
	},
	{
		8,
		82037504,
		0
	}
}
local t_summon_master_tower_item_type = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8]
}

t_summon_master_tower_item_type.dataList = dataList

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

return t_summon_master_tower_item_type
