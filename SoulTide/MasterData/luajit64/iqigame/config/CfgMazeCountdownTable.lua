-- chunkname: @IQIGame\\Config\\CfgMazeCountdownTable.lua

local CfgMazeCountdownTable = {
	[52130400] = {
		Id = 52130400,
		TimeLimit = 180,
		Describe = getI18NValue(180833908),
		FinishService = {
			52130403,
			52130405
		}
	},
	[52131400] = {
		Id = 52131400,
		TimeLimit = 240,
		Describe = getI18NValue(180833909),
		FinishService = {
			52131403,
			52131405
		}
	},
	[85000480] = {
		Id = 85000480,
		TimeLimit = 60,
		Describe = getI18NValue(180436251),
		FinishService = {
			85000559,
			85000491,
			85000492,
			85000493,
			85000494,
			85000495,
			85000556
		}
	},
	[85000481] = {
		Id = 85000481,
		TimeLimit = 60,
		Describe = getI18NValue(180436252),
		FinishService = {
			85000559,
			85000496,
			85000556
		}
	},
	[85000482] = {
		Id = 85000482,
		TimeLimit = 60,
		Describe = getI18NValue(180436253),
		FinishService = {
			85000559,
			85000497,
			85000556
		}
	},
	[86091800] = {
		Id = 86091800,
		TimeLimit = 90,
		Describe = getI18NValue(180833910),
		FinishService = {
			86091802,
			86091803,
			86091804,
			86091805
		}
	},
	[87280000] = {
		Id = 87280000,
		TimeLimit = 12,
		Describe = getI18NValue(180551835),
		FinishService = {
			87280024,
			87280021,
			87280014,
			87280015,
			87280016,
			87280017
		}
	},
	[87280001] = {
		Id = 87280001,
		TimeLimit = 8,
		Describe = getI18NValue(180551836),
		FinishService = {
			87280024,
			87280021,
			87280014,
			87280015,
			87280016,
			87280017
		}
	},
	[87280002] = {
		Id = 87280002,
		TimeLimit = 6,
		Describe = getI18NValue(180551837),
		FinishService = {
			87280024,
			87280021,
			87280014,
			87280015,
			87280016,
			87280017
		}
	},
	[87570700] = {
		Id = 87570700,
		TimeLimit = 120,
		Describe = getI18NValue(180563161),
		FinishService = {
			87570705
		}
	}
}

setmetatable(CfgMazeCountdownTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgMazeCountdownTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Describe = "",
		TimeLimit = 0,
		RemainService = {
			{},
			{},
			{},
			{},
			{},
			{}
		},
		FinishService = {},
		IntervalService = {}
	}
}

for i, data in pairs(CfgMazeCountdownTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgMazeCountdownTable
