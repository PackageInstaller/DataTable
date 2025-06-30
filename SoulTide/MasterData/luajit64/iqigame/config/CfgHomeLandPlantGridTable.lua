-- chunkname: @IQIGame\\Config\\CfgHomeLandPlantGridTable.lua

local CfgHomeLandPlantGridTable = {
	[36300001] = {
		Id = 36300001,
		Decorate = 501052
	},
	[36300002] = {
		Id = 36300002,
		Decorate = 501060
	},
	[36300003] = {
		Id = 36300003,
		Decorate = 501061
	},
	[36300004] = {
		Id = 36300004,
		Decorate = 501062
	},
	[36300005] = {
		ConditionId = 26050230,
		IsLock = true,
		Id = 36300005,
		Decorate = 501064,
		OpenCost = {
			2,
			1000
		}
	},
	[36300006] = {
		ConditionId = 26050230,
		IsLock = true,
		Id = 36300006,
		Decorate = 501065,
		OpenCost = {
			2,
			1000
		}
	},
	[36300007] = {
		ConditionId = 26050230,
		IsLock = true,
		OpenCostPayPoint = 5,
		Id = 36300007,
		Decorate = 501066
	},
	[36300008] = {
		ConditionId = 26050230,
		IsLock = true,
		OpenCostPayPoint = 5,
		Id = 36300008,
		Decorate = 501067
	}
}

setmetatable(CfgHomeLandPlantGridTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgHomeLandPlantGridTable]")
	end
})

local defaultMetaTable = {
	__index = {
		ConditionId = 0,
		IsLock = false,
		OpenCostPayPoint = 0,
		Decorate = 0,
		OpenCost = {}
	}
}

for i, data in pairs(CfgHomeLandPlantGridTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgHomeLandPlantGridTable
