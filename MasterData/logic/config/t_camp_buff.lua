-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_camp_buff.lua

module("logic.config.t_camp_buff", package.seeall)

local title = {
	modifications = 3,
	desc = 4,
	count = 2,
	order = 1
}
local dataList = {
	{
		1,
		3,
		"5002#0.1",
		"生命+10%"
	},
	{
		2,
		4,
		"5002#0.15",
		"生命+15%"
	},
	{
		3,
		5,
		"5002#0.2",
		"生命+20%"
	}
}
local t_camp_buff = {}

t_camp_buff.dataList = dataList

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
	t_camp_buff[v[1]] = v

	setmetatable(v, mt)
end

return t_camp_buff
