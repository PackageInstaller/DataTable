-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_house_atmosphere.lua

module("logic.config.t_house_atmosphere", package.seeall)

local title = {
	moodConsume = 4,
	rankNum = 2,
	moodRecover = 3,
	level = 1
}
local dataList = {
	{
		1,
		0,
		0,
		0
	},
	{
		2,
		1000,
		0.0033,
		0
	},
	{
		3,
		2000,
		0.0067,
		0
	},
	{
		4,
		4000,
		0.0092,
		0
	},
	{
		5,
		7000,
		0.0117,
		0
	},
	{
		6,
		10000,
		0.0142,
		0
	},
	{
		7,
		13000,
		0.0158,
		0
	},
	{
		8,
		16000,
		0.0175,
		0
	},
	{
		9,
		18000,
		0.0192,
		0
	},
	{
		10,
		20000,
		0.02,
		0
	}
}
local t_house_atmosphere = {}

t_house_atmosphere.dataList = dataList

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
	t_house_atmosphere[v[1]] = v

	setmetatable(v, mt)
end

return t_house_atmosphere
