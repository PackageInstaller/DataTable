-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_money_cat_prize.lua

module("logicconfig.config.t_money_cat_prize", package.seeall)

local title = {
	Id = 1,
	multiple = 2
}
local dataList = {
	{
		1,
		1
	},
	{
		2,
		2
	},
	{
		3,
		3
	},
	{
		4,
		4
	},
	{
		5,
		5
	}
}
local t_money_cat_prize = {
	{
		dataList[1]
	},
	{
		[2] = dataList[2]
	},
	{
		[3] = dataList[3]
	},
	{
		[4] = dataList[4]
	},
	{
		[5] = dataList[5]
	}
}

t_money_cat_prize.dataList = dataList

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

return t_money_cat_prize
