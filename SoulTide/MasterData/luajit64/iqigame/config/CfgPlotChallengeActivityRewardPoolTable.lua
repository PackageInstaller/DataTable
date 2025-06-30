-- chunkname: @IQIGame\\Config\\CfgPlotChallengeActivityRewardPoolTable.lua

local CfgPlotChallengeActivityRewardPoolTable = {
	{
		Id = 1,
		ItemID = {
			1,
			2,
			101
		},
		ItemNum = {
			100,
			10,
			10
		},
		ItemTime = {
			10,
			10,
			10
		},
		ItemWeight = {
			1,
			1,
			1
		}
	},
	{
		Id = 2,
		ItemID = {
			1,
			2,
			101
		},
		ItemNum = {
			200,
			10,
			10
		},
		ItemTime = {
			20,
			10,
			10
		},
		ItemWeight = {
			1,
			1,
			1
		}
	},
	{
		Id = 3,
		ItemID = {
			1,
			2,
			101
		},
		ItemNum = {
			300,
			10,
			10
		},
		ItemTime = {
			25,
			10,
			10
		},
		ItemWeight = {
			1,
			1,
			1
		}
	},
	{
		Id = 4,
		ItemID = {
			1,
			2,
			101
		},
		ItemNum = {
			400,
			10,
			10
		},
		ItemTime = {
			30,
			10,
			10
		},
		ItemWeight = {
			1,
			1,
			1
		}
	}
}

setmetatable(CfgPlotChallengeActivityRewardPoolTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgPlotChallengeActivityRewardPoolTable]")
	end
})

local defaultMetaTable = {
	__index = {
		ItemNum = {},
		ItemTime = {},
		ItemWeight = {},
		ItemID = {}
	}
}

for i, data in pairs(CfgPlotChallengeActivityRewardPoolTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgPlotChallengeActivityRewardPoolTable
