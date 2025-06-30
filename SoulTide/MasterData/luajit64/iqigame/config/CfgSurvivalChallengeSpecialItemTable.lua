-- chunkname: @IQIGame\\Config\\CfgSurvivalChallengeSpecialItemTable.lua

local CfgSurvivalChallengeSpecialItemTable = {
	{
		Group = 2,
		Parameter = 30,
		Type = 2,
		Id = 1,
		Weight = 100,
		ItemSpine = 815307,
		AttType = {
			6
		},
		AttValue = {
			1.5
		}
	},
	{
		Group = 2,
		Parameter = 200,
		Type = 5,
		Id = 2,
		Weight = 100,
		ItemSpine = 815302,
		AttType = {
			6
		},
		AttValue = {
			1.5
		}
	}
}

setmetatable(CfgSurvivalChallengeSpecialItemTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgSurvivalChallengeSpecialItemTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Group = 0,
		BuffIcon = "",
		Parameter = 0,
		ItemSpine = 0,
		Type = 0,
		Duration = 0,
		Weight = 0,
		AttType = {
			0
		},
		AttValue = {
			0
		}
	}
}

for i, data in pairs(CfgSurvivalChallengeSpecialItemTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgSurvivalChallengeSpecialItemTable
