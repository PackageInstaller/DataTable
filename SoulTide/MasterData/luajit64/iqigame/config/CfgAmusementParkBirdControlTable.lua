-- chunkname: @IQIGame\\Config\\CfgAmusementParkBirdControlTable.lua

local CfgAmusementParkBirdControlTable = {
	{
		Group = 1,
		VerticalDownAcceleration = 15,
		BalkCoolDown = 250,
		VerticalUpAcceleration = -15,
		HorizontalSpeed = 5,
		Id = 1,
		Level = 1,
		VerticalUpSpeed = 300,
		BalkGroup = {
			10,
			10,
			11,
			11,
			12,
			12,
			13,
			13,
			14,
			14,
			15,
			16,
			17,
			18
		},
		BuildingLevel = {
			2,
			1
		}
	},
	{
		Group = 1,
		VerticalDownAcceleration = 15,
		BalkCoolDown = 250,
		VerticalUpAcceleration = -15,
		HorizontalSpeed = 5,
		Id = 2,
		Level = 2,
		VerticalUpSpeed = 300,
		BalkGroup = {
			1,
			2,
			3,
			4,
			5,
			6,
			7,
			8,
			9
		},
		BuildingLevel = {
			2,
			5
		}
	},
	{
		Group = 1,
		VerticalDownAcceleration = 15,
		BalkCoolDown = 250,
		VerticalUpAcceleration = -15,
		HorizontalSpeed = 5,
		Id = 3,
		Level = 3,
		VerticalUpSpeed = 300,
		BalkGroup = {
			21,
			22,
			23,
			24,
			25,
			26,
			27,
			28,
			29
		},
		BuildingLevel = {
			2,
			10
		}
	}
}

setmetatable(CfgAmusementParkBirdControlTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgAmusementParkBirdControlTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Group = 0,
		BalkCoolDown = 0,
		VerticalUpAcceleration = 0,
		VerticalDownAcceleration = 0,
		HorizontalSpeed = 0,
		Level = 0,
		VerticalUpSpeed = 0,
		BuildingLevel = {},
		BalkGroup = {}
	}
}

for i, data in pairs(CfgAmusementParkBirdControlTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgAmusementParkBirdControlTable
