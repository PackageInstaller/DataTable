-- chunkname: @IQIGame\\Config\\CfgWorldBossSeasonTable.lua

local CfgWorldBossSeasonTable = {
	{
		Id = 1,
		ChapterCid = 1011
	},
	{
		Id = 2,
		ChapterCid = 1001
	},
	{
		Id = 3,
		ChapterCid = 1003
	},
	{
		Id = 4,
		ChapterCid = 1004
	},
	{
		Id = 5,
		ChapterCid = 1005
	},
	{
		Id = 6,
		ChapterCid = 1006
	},
	{
		Id = 7,
		ChapterCid = 1007
	},
	{
		Id = 8,
		ChapterCid = 1008
	},
	{
		Id = 9,
		ChapterCid = 1002
	},
	{
		Id = 10,
		ChapterCid = 1009
	},
	{
		Id = 11,
		ChapterCid = 1010
	},
	{
		Id = 12,
		ChapterCid = 1011
	},
	{
		Id = 13,
		ChapterCid = 1012
	},
	{
		Id = 14,
		ChapterCid = 1013
	},
	{
		Id = 15,
		ChapterCid = 1014
	},
	{
		Id = 16,
		ChapterCid = 1015
	},
	{
		Id = 17,
		ChapterCid = 1016
	},
	{
		Id = 18,
		ChapterCid = 1017
	},
	{
		Id = 19,
		ChapterCid = 1018
	},
	{
		Id = 20,
		ChapterCid = 1019
	},
	{
		Id = 21,
		ChapterCid = 1020
	},
	{
		Id = 22
	},
	{
		Id = 23
	},
	{
		Id = 24
	},
	{
		Id = 25
	}
}

setmetatable(CfgWorldBossSeasonTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgWorldBossSeasonTable]")
	end
})

local defaultMetaTable = {
	__index = {
		ChapterCid = 0
	}
}

for i, data in pairs(CfgWorldBossSeasonTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgWorldBossSeasonTable
