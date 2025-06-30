-- chunkname: @IQIGame\\Config\\CfgMiningLayerTable.lua

local CfgMiningLayerTable = {
	{
		GridNumY = 7,
		Id = 1,
		GridNumX = 20,
		BGM = 36,
		Cost = {
			311,
			3
		},
		LandSkinID = {
			101,
			103
		},
		Element = {
			{},
			{
				2,
				1,
				1
			},
			{
				3,
				29,
				39
			},
			{
				201,
				3,
				5
			},
			{
				202,
				1,
				2
			},
			{
				203,
				0,
				1
			},
			{
				101,
				12,
				15
			},
			{
				102,
				12,
				15
			},
			{
				103,
				12,
				15
			},
			{
				104,
				12,
				15
			},
			{
				301,
				1,
				1
			},
			{
				1011,
				1,
				2
			},
			{
				1012,
				1,
				2
			},
			{
				1013,
				1,
				2
			},
			{
				401,
				3,
				4
			}
		}
	},
	{
		GridNumY = 7,
		Id = 2,
		GridNumX = 20,
		BGM = 36,
		Cost = {
			311,
			3
		},
		LandSkinID = {
			104,
			106
		},
		Element = {
			{
				1,
				1,
				1
			},
			{
				2,
				1,
				1
			},
			{
				3,
				28,
				38
			},
			{
				201,
				3,
				5
			},
			{
				202,
				1,
				2
			},
			{
				203,
				0,
				1
			},
			{
				101,
				12,
				15
			},
			{
				102,
				12,
				15
			},
			{
				103,
				12,
				15
			},
			{
				104,
				12,
				15
			},
			{
				301,
				1,
				1
			},
			{
				1021,
				1,
				2
			},
			{
				1022,
				1,
				2
			},
			{
				1023,
				1,
				2
			},
			{
				401,
				3,
				4
			}
		}
	},
	{
		GridNumY = 7,
		Id = 3,
		GridNumX = 20,
		BGM = 36,
		Cost = {
			311,
			3
		},
		LandSkinID = {
			108,
			109,
			110
		},
		Element = {
			{
				1,
				1,
				1
			},
			{
				2,
				1,
				1
			},
			{
				3,
				28,
				38
			},
			{
				201,
				3,
				5
			},
			{
				202,
				1,
				2
			},
			{
				203,
				0,
				1
			},
			{
				101,
				12,
				15
			},
			{
				102,
				12,
				15
			},
			{
				103,
				12,
				15
			},
			{
				104,
				12,
				15
			},
			{
				301,
				1,
				1
			},
			{
				1031,
				1,
				2
			},
			{
				1032,
				1,
				2
			},
			{
				1033,
				1,
				2
			},
			{
				401,
				3,
				4
			}
		}
	},
	{
		GridNumY = 7,
		Id = 4,
		GridNumX = 20,
		BGM = 36,
		Cost = {
			311,
			3
		},
		LandSkinID = {
			112,
			114,
			115
		},
		Element = {
			{
				1,
				1,
				1
			},
			{
				2,
				1,
				1
			},
			{
				3,
				28,
				38
			},
			{
				201,
				3,
				5
			},
			{
				202,
				1,
				2
			},
			{
				203,
				0,
				1
			},
			{
				101,
				12,
				15
			},
			{
				102,
				12,
				15
			},
			{
				103,
				12,
				15
			},
			{
				104,
				12,
				15
			},
			{
				301,
				1,
				1
			},
			{
				1041,
				1,
				2
			},
			{
				1042,
				1,
				2
			},
			{
				1043,
				1,
				2
			},
			{
				401,
				3,
				4
			}
		}
	},
	{
		GridNumY = 7,
		Id = 5,
		GridNumX = 20,
		BGM = 36,
		Cost = {
			311,
			3
		},
		LandSkinID = {
			117,
			119
		},
		Element = {
			{
				1,
				1,
				1
			},
			{},
			{
				3,
				29,
				39
			},
			{
				201,
				3,
				5
			},
			{
				202,
				1,
				2
			},
			{
				203,
				0,
				1
			},
			{
				101,
				12,
				15
			},
			{
				102,
				12,
				15
			},
			{
				103,
				12,
				15
			},
			{
				104,
				12,
				15
			},
			{
				301,
				1,
				1
			},
			{
				1051,
				1,
				2
			},
			{
				1052,
				1,
				2
			},
			{
				1053,
				1,
				2
			},
			{
				401,
				3,
				4
			}
		}
	}
}

setmetatable(CfgMiningLayerTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgMiningLayerTable]")
	end
})

local defaultMetaTable = {
	__index = {
		GridNumY = 0,
		GridNumX = 0,
		BGM = 0,
		LandSkinID = {},
		Element = {
			{},
			{},
			{},
			{},
			{},
			{},
			{},
			{},
			{},
			{},
			{},
			{},
			{},
			{},
			{}
		},
		Cost = {}
	}
}

for i, data in pairs(CfgMiningLayerTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgMiningLayerTable
