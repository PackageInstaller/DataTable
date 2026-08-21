-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_gallery_echo_item.lua

module("logic.config.t_gallery_echo_item", package.seeall)

local title = {
	id = 1,
	sortType = 2
}
local dataList = {
	{
		1303002,
		999
	},
	{
		1303003,
		998
	},
	{
		1303004,
		997
	},
	{
		1303005,
		996
	},
	{
		1303006,
		995
	},
	{
		1303007,
		994
	},
	{
		1303008,
		993
	},
	{
		1314001,
		992
	},
	{
		1314002,
		991
	},
	{
		1314003,
		990
	},
	{
		1315003,
		989
	},
	{
		1324001,
		988
	},
	{
		1324002,
		987
	},
	{
		1325001,
		986
	},
	{
		1334001,
		985
	},
	{
		1334002,
		984
	},
	{
		1335001,
		983
	},
	{
		1344001,
		982
	},
	{
		1344002,
		981
	},
	{
		1345003,
		980
	},
	{
		1354001,
		979
	},
	{
		1354002,
		978
	},
	{
		1355002,
		977
	},
	{
		1364002,
		976
	},
	{
		1364003,
		975
	},
	{
		1365002,
		974
	},
	{
		1365003,
		973
	}
}
local t_gallery_echo_item = {}

t_gallery_echo_item.dataList = dataList

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
	t_gallery_echo_item[v[1]] = v

	setmetatable(v, mt)
end

return t_gallery_echo_item
