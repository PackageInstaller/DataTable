-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_bounty_pk_battle_buff.lua

module("logicconfig.config.t_bounty_pk_battle_buff", package.seeall)

local title = {
	id = 2,
	validator = 4,
	buffPlan = 1,
	decs = 3
}
local dataList = {
	{
		1,
		1,
		82054002,
		"mainAttr#2"
	},
	{
		1,
		2,
		82054003,
		"mainAttr#3"
	},
	{
		1,
		3,
		82054004,
		"mainAttr#4"
	},
	{
		1,
		4,
		82054005,
		"mainAttr#5"
	},
	{
		2,
		1,
		82054006,
		"sex#2"
	},
	{
		2,
		2,
		82054007,
		"sex#3"
	},
	{
		2,
		3,
		82054008,
		"sex#4"
	},
	{
		2,
		4,
		82054009,
		"sex#5"
	}
}
local t_bounty_pk_battle_buff = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	},
	{
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	}
}

t_bounty_pk_battle_buff.dataList = dataList

local multiLanguageCells = {
	decs = true
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

return t_bounty_pk_battle_buff
