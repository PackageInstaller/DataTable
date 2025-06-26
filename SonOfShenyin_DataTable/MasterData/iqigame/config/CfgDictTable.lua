-- chunkname: @IQIGame\\Config\\CfgDictTable.lua

local CfgDictTable = {
	{
		GroupId = 1,
		TypeId = 1,
		Id = 1,
		TipsId = 1000001
	},
	{
		GroupId = 1,
		TypeId = 2,
		Id = 2,
		TipsId = 1000002
	},
	{
		GroupId = 1,
		TypeId = 3,
		Id = 3,
		TipsId = 1000003
	},
	{
		GroupId = 4,
		TypeId = 1,
		Id = 4,
		TipsId = 2002001
	},
	{
		GroupId = 4,
		TypeId = 2,
		Id = 5,
		TipsId = 2002002
	},
	{
		GroupId = 4,
		TypeId = 3,
		Id = 6,
		TipsId = 2002003
	},
	{
		GroupId = 4,
		TypeId = 4,
		Id = 7,
		TipsId = 2002004
	},
	{
		GroupId = 4,
		TypeId = 5,
		Id = 8,
		TipsId = 2002005
	},
	{
		GroupId = 4,
		TypeId = 6,
		Id = 9,
		TipsId = 2002006
	},
	[101] = {
		GroupId = 5,
		TypeId = 1,
		Id = 101
	},
	[102] = {
		GroupId = 5,
		TypeId = 2,
		Id = 102
	},
	[103] = {
		GroupId = 5,
		TypeId = 3,
		Id = 103
	},
	[104] = {
		GroupId = 5,
		TypeId = 4,
		Id = 104
	},
	[105] = {
		GroupId = 6,
		TypeId = 1,
		Id = 105,
		TipsId = 2001001
	},
	[106] = {
		GroupId = 6,
		TypeId = 2,
		Id = 106,
		TipsId = 2001002
	},
	[107] = {
		GroupId = 6,
		TypeId = 3,
		Id = 107,
		TipsId = 2001003
	},
	[108] = {
		GroupId = 6,
		TypeId = 4,
		Id = 108,
		TipsId = 2001004
	},
	[109] = {
		GroupId = 6,
		TypeId = 5,
		Id = 109,
		TipsId = 2001005
	},
	[201] = {
		GroupId = 7,
		TypeId = 1,
		Id = 201,
		TipsId = 1600016
	},
	[202] = {
		GroupId = 7,
		TypeId = 2,
		Id = 202,
		TipsId = 1600017
	},
	[203] = {
		GroupId = 7,
		TypeId = 3,
		Id = 203,
		TipsId = 1600018
	},
	[204] = {
		GroupId = 7,
		TypeId = 4,
		Id = 204,
		TipsId = 1600019
	},
	[205] = {
		GroupId = 7,
		TypeId = 5,
		Id = 205,
		TipsId = 1600020
	},
	[301] = {
		GroupId = 8,
		TypeId = 1,
		Id = 301,
		TipsId = 1600009
	},
	[302] = {
		GroupId = 8,
		TypeId = 2,
		Id = 302,
		TipsId = 1600010
	},
	[303] = {
		GroupId = 8,
		TypeId = 3,
		Id = 303,
		TipsId = 1600011
	},
	[304] = {
		GroupId = 8,
		TypeId = 4,
		Id = 304,
		TipsId = 1600012
	},
	[401] = {
		GroupId = 9,
		TypeId = 1,
		Id = 401,
		TipsId = 1800006
	},
	[402] = {
		GroupId = 9,
		TypeId = 2,
		Id = 402,
		TipsId = 1800001
	},
	[403] = {
		GroupId = 9,
		TypeId = 3,
		Id = 403,
		TipsId = 1800002
	},
	[404] = {
		GroupId = 9,
		TypeId = 4,
		Id = 404,
		TipsId = 1800003
	},
	[405] = {
		GroupId = 9,
		TypeId = 5,
		Id = 405,
		TipsId = 1800004
	},
	[406] = {
		GroupId = 9,
		TypeId = 6,
		Id = 406,
		TipsId = 1800005
	},
	[501] = {
		GroupId = 10,
		TypeId = 1,
		Id = 501,
		TipsId = 2000001
	},
	[502] = {
		GroupId = 10,
		TypeId = 2,
		Id = 502,
		TipsId = 2000002
	},
	[503] = {
		GroupId = 10,
		TypeId = 3,
		Id = 503,
		TipsId = 2000003
	},
	[504] = {
		GroupId = 10,
		TypeId = 4,
		Id = 504,
		TipsId = 2000004
	},
	[505] = {
		GroupId = 10,
		TypeId = 5,
		Id = 505,
		TipsId = 2000005
	},
	[506] = {
		GroupId = 11,
		TypeId = 1,
		Id = 506,
		TipsId = 3000001
	},
	[507] = {
		GroupId = 11,
		TypeId = 2,
		Id = 507,
		TipsId = 3000002
	}
}

setmetatable(CfgDictTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgDictTable]")
	end
})

local defaultMetaTable = {
	__index = {
		TipsId = 0,
		TypeId = 0,
		GroupId = 0
	}
}

for i, data in pairs(CfgDictTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgDictTable
