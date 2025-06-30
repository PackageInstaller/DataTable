-- chunkname: @IQIGame\\Config\\CfgMazeChallengeBonusTable.lua

local CfgMazeChallengeBonusTable = {
	[1001] = {
		Icon = "/TownLibraryUI/Story/WorldChapter_JMSL_02.png",
		Chapter = 25011001,
		Id = 1001,
		payPoint = 5,
		Quest = {
			20360101
		}
	},
	[1002] = {
		Icon = "/TownLibraryUI/Story/WorldChapter_JMSL_02.png",
		Chapter = 25011002,
		Id = 1002,
		payPoint = 5,
		Quest = {
			20360102
		}
	},
	[1003] = {
		Icon = "/TownLibraryUI/Story/WorldChapter_ZMZD_01.png",
		Chapter = 25011003,
		Id = 1003,
		payPoint = 5,
		Quest = {
			20360103
		}
	},
	[1004] = {
		Icon = "/TownLibraryUI/Story/WorldChapter_ZMZD_01.png",
		Chapter = 25011004,
		Id = 1004,
		payPoint = 5,
		Quest = {
			20360104
		}
	}
}

setmetatable(CfgMazeChallengeBonusTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgMazeChallengeBonusTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Icon = "",
		Chapter = 0,
		payPoint = 0,
		Quest = {}
	}
}

for i, data in pairs(CfgMazeChallengeBonusTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgMazeChallengeBonusTable
