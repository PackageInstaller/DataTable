-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_lottery_pool_detail.lua

module("logic.config.t_lottery_pool_detail", package.seeall)

local title = {
	poolCode = 1,
	quality = 2,
	groupCode = 3
}
local dataList = {
	{
		7,
		1,
		10401
	},
	{
		7,
		2,
		10002
	},
	{
		7,
		2,
		10003
	},
	{
		1001,
		1,
		10001
	},
	{
		1001,
		2,
		10002
	},
	{
		1001,
		2,
		10003
	},
	{
		1002,
		1,
		10001
	},
	{
		1002,
		1,
		10021
	},
	{
		1002,
		2,
		10002
	},
	{
		1002,
		2,
		10003
	},
	{
		1003,
		1,
		10001
	},
	{
		1003,
		1,
		10031
	},
	{
		1003,
		2,
		10002
	},
	{
		1003,
		2,
		10003
	},
	{
		1004,
		1,
		10001
	},
	{
		1004,
		1,
		10041
	},
	{
		1004,
		2,
		10002
	},
	{
		1004,
		2,
		10003
	}
}
local t_lottery_pool_detail = {}

t_lottery_pool_detail.dataList = dataList

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
	local parent1 = t_lottery_pool_detail[v[1]]

	if parent1 == nil then
		parent1 = {}
		t_lottery_pool_detail[v[1]] = parent1
	end

	parent1[v[3]] = v

	setmetatable(v, mt)
end

return t_lottery_pool_detail
