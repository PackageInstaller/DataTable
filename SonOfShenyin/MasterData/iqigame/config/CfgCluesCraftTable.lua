-- chunkname: @IQIGame\\Config\\CfgCluesCraftTable.lua

local CfgCluesCraftTable = {
	[10101] = {
		Id = 10101,
		Display = 1,
		CreateParam = "11034",
		ComposeID = 11034,
		StoryDataID = {
			1010601
		},
		CluesID = {
			11033,
			11036
		},
		CarftDes = getI18NValue(180035862)
	},
	[10301] = {
		Id = 10301,
		Display = 1,
		ComposeID = 13003,
		StoryDataID = {
			1050101
		},
		CluesID = {
			13001,
			13002
		},
		CarftDes = getI18NValue(180035863)
	},
	[10302] = {
		Id = 10302,
		Display = 2,
		ComposeID = 13005,
		StoryDataID = {
			1050101
		},
		CluesID = {
			13003,
			13004
		},
		CarftDes = getI18NValue(180035864)
	},
	[10303] = {
		Id = 10303,
		Display = 1,
		CreateParam = "13012",
		ComposeID = 13012,
		StoryDataID = {
			1050403
		},
		CluesID = {
			13009,
			13010
		},
		CarftDes = getI18NValue(180035865)
	},
	[10304] = {
		Id = 10304,
		Display = 1,
		CreateParam = "13022",
		ComposeID = 13022,
		StoryDataID = {
			1060302
		},
		CluesID = {
			13020,
			13021
		},
		CarftDes = getI18NValue(180035866)
	},
	[14005] = {
		Id = 14005,
		Display = 1,
		CreateParam = "14005",
		ComposeID = 14005,
		StoryDataID = {
			1040201
		},
		CluesID = {
			14001,
			14004
		}
	},
	[40101] = {
		Id = 40101,
		Display = 1,
		CreateParam = "40108",
		ComposeID = 40108,
		StoryDataID = {
			4010701
		},
		CluesID = {
			40106,
			40107
		},
		CarftDes = getI18NValue(180131393)
	}
}

setmetatable(CfgCluesCraftTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgCluesCraftTable]")
	end
})

local defaultMetaTable = {
	__index = {
		CreateParam = "",
		Display = 0,
		CarftDes = "",
		ComposeID = 0,
		CluesID = {},
		StoryDataID = {}
	}
}

for i, data in pairs(CfgCluesCraftTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgCluesCraftTable
