-- chunkname: @IQIGame\\Config\\CfgAmusementParkDollMachineControlTable.lua

local CfgAmusementParkDollMachineControlTable = {
	{
		Group = 1,
		ClawSpeed = 1,
		ExtraScore = 50,
		ChallengeCount = 6,
		Id = 1,
		Level = 1,
		RoleNum = 20,
		RoleRareNum = {
			3,
			5,
			6,
			6
		},
		RoleRareSpeed = {
			3,
			2,
			1,
			1
		},
		RoleRareScore = {
			1000,
			500,
			200,
			100
		},
		BuildingLevel = {
			12,
			1
		}
	},
	{
		Group = 1,
		ClawSpeed = 1,
		ExtraScore = 50,
		ChallengeCount = 7,
		Id = 2,
		Level = 2,
		RoleNum = 32,
		RoleRareNum = {
			6,
			8,
			9,
			9
		},
		RoleRareSpeed = {
			3,
			2,
			1,
			1
		},
		RoleRareScore = {
			1000,
			500,
			200,
			100
		},
		BuildingLevel = {
			12,
			5
		}
	},
	{
		Group = 1,
		ClawSpeed = 1,
		ExtraScore = 50,
		ChallengeCount = 8,
		Id = 3,
		Level = 3,
		RoleNum = 44,
		RoleRareNum = {
			9,
			11,
			12,
			12
		},
		RoleRareSpeed = {
			3,
			2,
			1,
			1
		},
		RoleRareScore = {
			1000,
			500,
			200,
			100
		},
		BuildingLevel = {
			12,
			10
		}
	}
}

setmetatable(CfgAmusementParkDollMachineControlTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgAmusementParkDollMachineControlTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Group = 0,
		ClawSpeed = 0,
		ChallengeCount = 0,
		Level = 0,
		ExtraScore = 0,
		RoleNum = 0,
		RoleRareNum = {},
		BuildingLevel = {},
		RoleRareSpeed = {},
		RoleRareScore = {}
	}
}

for i, data in pairs(CfgAmusementParkDollMachineControlTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgAmusementParkDollMachineControlTable
