-- chunkname: @IQIGame\\Config\\CfgCardGroupTable.lua

local CfgCardGroupTable = {
	[101] = {
		CardLabel = 1,
		Id = 101,
		ShowPrefab = "Assets/03_Prefabs/UI/_Lottery/LotteryNew_Appointed.prefab",
		Name = getI18NValue(180260088),
		CardJackpotID = {
			50300301,
			50300302
		},
		ShowCard = {
			10000001,
			10000007
		}
	},
	[102] = {
		CardLabel = 1,
		Id = 102,
		ShowPrefab = "Assets/03_Prefabs/UI/_Lottery/LotteryNew_Appointed_1.prefab",
		Name = getI18NValue(180262607),
		CardJackpotID = {
			50300303,
			50300304,
			50300305
		},
		ShowCard = {
			10000002,
			10000004,
			10000020
		}
	},
	[103] = {
		CardLabel = 1,
		Id = 103,
		ShowPrefab = "Assets/03_Prefabs/UI/_Lottery/LotteryNew_Appointed_2.prefab",
		Name = getI18NValue(180264468),
		CardJackpotID = {
			50300306,
			50300307
		},
		ShowCard = {
			10000005,
			10000024
		}
	}
}

setmetatable(CfgCardGroupTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgCardGroupTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Name = "",
		CardLabel = 0,
		ShowPrefab = "",
		CardJackpotID = {},
		ShowCard = {}
	}
}

for i, data in pairs(CfgCardGroupTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgCardGroupTable
