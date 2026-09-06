-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_cake_sign_in.lua

module("logicconfig.config.t_cake_sign_in", package.seeall)

local title = {
	prizeId = 2,
	prize = 3,
	activityId = 1
}
local dataList = {
	{
		26001,
		1,
		"17:1032301:-1:1"
	},
	{
		26001,
		2,
		"104:2:888"
	},
	{
		26001,
		3,
		"4:31:2"
	},
	{
		26001,
		4,
		"60:1:120"
	},
	{
		26001,
		5,
		"10:21015:200"
	},
	{
		26001,
		6,
		"10:21015:200"
	},
	{
		26001,
		7,
		"10:21015:100"
	},
	{
		26001,
		8,
		"10:21015:100"
	},
	{
		26001,
		9,
		"10:21015:50"
	},
	{
		26001,
		10,
		"10:21015:50"
	}
}
local t_cake_sign_in = {
	[26001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	}
}

t_cake_sign_in.dataList = dataList

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

return t_cake_sign_in
