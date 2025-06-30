-- chunkname: @IQIGame\\Config\\CfgFishingJudgeTable.lua

local CfgFishingJudgeTable = {
	[100001] = {
		Speed = 3,
		Id = 100001,
		NormalInterval = {
			900,
			1000
		},
		PerfectInterval = {
			950,
			990
		}
	},
	[100002] = {
		Speed = 3,
		Id = 100002,
		NormalInterval = {
			800,
			900
		},
		PerfectInterval = {
			850,
			880
		}
	},
	[100003] = {
		Speed = 3,
		Id = 100003,
		NormalInterval = {
			700,
			800
		},
		PerfectInterval = {
			720,
			750
		}
	},
	[100004] = {
		Speed = 3,
		Id = 100004,
		NormalInterval = {
			600,
			900
		},
		PerfectInterval = {
			700,
			800
		}
	},
	[100005] = {
		Speed = 3,
		Id = 100005,
		NormalInterval = {
			500,
			700
		},
		PerfectInterval = {
			600,
			650
		}
	},
	[100006] = {
		Speed = 3,
		Id = 100006,
		NormalInterval = {
			400,
			800
		},
		PerfectInterval = {
			450,
			600
		}
	}
}

setmetatable(CfgFishingJudgeTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgFishingJudgeTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Speed = 0,
		PerfectInterval = {},
		NormalInterval = {}
	}
}

for i, data in pairs(CfgFishingJudgeTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgFishingJudgeTable
