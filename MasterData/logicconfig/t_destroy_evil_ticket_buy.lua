-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_destroy_evil_ticket_buy.lua

module("logicconfig.config.t_destroy_evil_ticket_buy", package.seeall)

local title = {
	cost = 4,
	times = 3,
	activityId = 1,
	buyId = 2
}
local dataList = {
	{
		322001,
		1,
		5,
		"105:6093:100"
	},
	{
		322001,
		2,
		10,
		"105:6093:200"
	},
	{
		322001,
		3,
		15,
		"105:6093:300"
	},
	{
		322002,
		1,
		5,
		"105:6093:100"
	},
	{
		322002,
		2,
		10,
		"105:6093:200"
	},
	{
		322003,
		1,
		5,
		"105:6093:100"
	},
	{
		322003,
		2,
		10,
		"105:6093:200"
	}
}
local t_destroy_evil_ticket_buy = {
	[322001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	},
	[322002] = {
		dataList[4],
		dataList[5]
	},
	[322003] = {
		dataList[6],
		dataList[7]
	}
}

t_destroy_evil_ticket_buy.dataList = dataList

local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			return rawget(t, index)
		end
	end
}

for i, v in ipairs(dataList) do
	setmetatable(v, mt)
end

return t_destroy_evil_ticket_buy
