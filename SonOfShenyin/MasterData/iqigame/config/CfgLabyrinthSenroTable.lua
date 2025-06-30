-- chunkname: @IQIGame\\Config\\CfgLabyrinthSenroTable.lua

local CfgLabyrinthSenroTable = {
	[40030001] = {
		Id = 40030001,
		Level = 1,
		ConditionIds = {
			30069001
		},
		LevelDes = getI18NValue(180217145)
	},
	[40030002] = {
		Id = 40030002,
		Level = 2,
		ConditionIds = {
			30069002
		},
		SenroCore = {
			40041002,
			40041003,
			40041004,
			40041005,
			40042002,
			40042003,
			40042004,
			40042005,
			40042006
		},
		LevelDes = getI18NValue(180217146)
	},
	[40030003] = {
		Id = 40030003,
		Level = 3,
		SenroCore = {
			40041006,
			40041007,
			40041008,
			40042007,
			40042008
		},
		LevelDes = getI18NValue(180217147)
	}
}

setmetatable(CfgLabyrinthSenroTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgLabyrinthSenroTable]")
	end
})

local defaultMetaTable = {
	__index = {
		LevelDes = "",
		Level = 0,
		SenroCore = {},
		ConditionIds = {},
		ItemID = {},
		Cost = {}
	}
}

for i, data in pairs(CfgLabyrinthSenroTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgLabyrinthSenroTable
