-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_control_action_const.lua

module("logic.config.t_control_action_const", package.seeall)

local title = {
	numValue = 2,
	keyName = 1
}
local dataList = {
	{
		"MinPrimarchPostReplyInterval",
		600
	},
	{
		"MaxPrimarchPostReplyInterval",
		1800
	},
	{
		"MinPrimarchPostMeaninglessReplyInterval",
		600
	},
	{
		"MaxPrimarchPostMeaninglessReplyInterval",
		1800
	},
	{
		"MinMeaninglessPostInterval",
		2400
	},
	{
		"MaxMeaninglessPostInterval",
		4800
	},
	{
		"MinMeaninglessPostReplyInterval",
		1200
	},
	{
		"MaxMeaninglessPostReplyInterval",
		3600
	},
	{
		"MaxPost",
		6
	},
	{
		"MinNewPrimarchPostTime",
		30
	},
	{
		"MaxNewPrimarchPostTime",
		60
	},
	{
		"WeekLimitTime",
		5
	}
}
local t_control_action_const = {}

t_control_action_const.dataList = dataList

local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			return rawget(t, index)
		else
			error(string.format("the field name [%s] is nonexist!", key))
		end
	end
}

for i, v in ipairs(dataList) do
	t_control_action_const[v[1]] = v

	setmetatable(v, mt)
end

return t_control_action_const
