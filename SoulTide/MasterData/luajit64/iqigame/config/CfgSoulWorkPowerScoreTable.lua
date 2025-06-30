-- chunkname: @IQIGame\\Config\\CfgSoulWorkPowerScoreTable.lua

local CfgSoulWorkPowerScoreTable = {
	{
		Score = 0.25,
		Id = 1,
		Num = {
			-9999,
			-6
		}
	},
	{
		Score = 0.4,
		Id = 2,
		Num = {
			-5,
			-5
		}
	},
	{
		Score = 0.6,
		Id = 3,
		Num = {
			-4,
			-4
		}
	},
	{
		Score = 0.7,
		Id = 4,
		Num = {
			-3,
			-3
		}
	},
	{
		Score = 0.75,
		Id = 5,
		Num = {
			-2,
			-2
		}
	},
	{
		Score = 0.8,
		Id = 6,
		Num = {
			-1,
			-1
		}
	},
	{
		Score = 1,
		Id = 7,
		Num = {
			0,
			0
		}
	},
	{
		Score = 1.05,
		Id = 8,
		Num = {
			1,
			1
		}
	},
	{
		Score = 1.15,
		Id = 9,
		Num = {
			2,
			2
		}
	},
	{
		Score = 1.25,
		Id = 10,
		Num = {
			3,
			3
		}
	},
	{
		Score = 1.4,
		Id = 11,
		Num = {
			4,
			4
		}
	},
	{
		Score = 1.6,
		Id = 12,
		Num = {
			5,
			5
		}
	},
	{
		Score = 2,
		Id = 13,
		Num = {
			6,
			9999
		}
	}
}

setmetatable(CfgSoulWorkPowerScoreTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgSoulWorkPowerScoreTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Score = 0,
		Num = {}
	}
}

for i, data in pairs(CfgSoulWorkPowerScoreTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgSoulWorkPowerScoreTable
