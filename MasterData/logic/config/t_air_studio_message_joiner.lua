-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_air_studio_message_joiner.lua

module("logic.config.t_air_studio_message_joiner", package.seeall)

local title = {
	id = 1,
	content = 2
}
local dataList = {
	{
		2001,
		"还有"
	},
	{
		2002,
		"但是"
	},
	{
		2003,
		"否则"
	},
	{
		2004,
		"也许是"
	},
	{
		2005,
		"..嗯.."
	},
	{
		2006,
		"呵"
	},
	{
		2007,
		"请记住"
	},
	{
		2008,
		"然后"
	},
	{
		2009,
		"所以"
	},
	{
		2010,
		"然而"
	},
	{
		2011,
		"原来如此"
	},
	{
		2012,
		"以及"
	},
	{
		2013,
		"下一次"
	},
	{
		2014,
		"务必"
	},
	{
		2015,
		"因此"
	},
	{
		2016,
		"最后一步"
	},
	{
		2017,
		"事实上"
	},
	{
		2018,
		"不要交谈"
	},
	{
		2019,
		"和"
	},
	{
		2020,
		"包括但不限于"
	},
	{
		2021,
		"尽管"
	},
	{
		2022,
		"连同"
	},
	{
		2023,
		"唯有"
	},
	{
		2024,
		"再说"
	},
	{
		2025,
		"却"
	},
	{
		2026,
		"像"
	},
	{
		2027,
		"不但"
	},
	{
		2028,
		"于是"
	},
	{
		2029,
		"首先"
	},
	{
		2030,
		"其次"
	},
	{
		2031,
		"不过"
	},
	{
		2032,
		"即"
	},
	{
		2033,
		"即使"
	},
	{
		2034,
		"哪怕"
	},
	{
		2035,
		"除非"
	},
	{
		2036,
		"只有"
	},
	{
		2037,
		"现在"
	},
	{
		2038,
		"无所谓"
	},
	{
		2039,
		"例如"
	},
	{
		2040,
		"接下来"
	}
}
local t_air_studio_message_joiner = {}

t_air_studio_message_joiner.dataList = dataList

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
	t_air_studio_message_joiner[v[1]] = v

	setmetatable(v, mt)
end

return t_air_studio_message_joiner
