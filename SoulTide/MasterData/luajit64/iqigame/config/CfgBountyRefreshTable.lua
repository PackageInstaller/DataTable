-- chunkname: @IQIGame\\Config\\CfgBountyRefreshTable.lua

local CfgBountyRefreshTable = {
	{
		Id = 1,
		QuestType = {
			1,
			2
		},
		TypeOdds = {
			60,
			40
		}
	},
	{
		Id = 2,
		QuestType = {
			2,
			3
		},
		TypeOdds = {
			60,
			40
		}
	},
	{
		Id = 3,
		QuestType = {
			2,
			3
		},
		TypeOdds = {
			40,
			60
		}
	},
	{
		Id = 4,
		QuestType = {
			3
		},
		TypeOdds = {
			100
		}
	},
	{
		Id = 5,
		QuestType = {
			3
		},
		TypeOdds = {
			100
		}
	}
}

setmetatable(CfgBountyRefreshTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgBountyRefreshTable]")
	end
})

local defaultMetaTable = {
	__index = {
		QuestType = {},
		TypeOdds = {}
	}
}

for i, data in pairs(CfgBountyRefreshTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgBountyRefreshTable
