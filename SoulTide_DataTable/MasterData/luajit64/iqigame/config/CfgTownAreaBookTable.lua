-- chunkname: @IQIGame\\Config\\CfgTownAreaBookTable.lua

local CfgTownAreaBookTable = {
	[10010] = {
		IsUnlock = true,
		Id = 10010,
		Name = getI18NValue(180131765),
		SiteImgePosition = {
			-906,
			157,
			0
		},
		CollectTime = {
			3,
			6,
			10
		},
		CollectReward = {
			{
				2,
				10
			},
			{
				2,
				10
			},
			{
				2,
				10
			}
		},
		PatrolAward = {
			11802,
			11911,
			11801,
			11810
		}
	},
	[10020] = {
		IsUnlock = true,
		Id = 10020,
		Name = getI18NValue(180131766),
		SiteImgePosition = {
			-711,
			-55,
			0
		},
		CollectTime = {
			4,
			7,
			11
		},
		CollectReward = {
			{
				2,
				10
			},
			{
				2,
				10
			},
			{
				2,
				10
			}
		},
		PatrolAward = {
			11804,
			11901,
			11803,
			11805
		}
	},
	[10030] = {
		IsUnlock = true,
		Id = 10030,
		Name = getI18NValue(180131767),
		SiteImgePosition = {
			-332,
			248,
			0
		},
		CollectTime = {
			3,
			5,
			8
		},
		CollectReward = {
			{
				2,
				10
			},
			{
				2,
				10
			},
			{
				2,
				10
			}
		},
		PatrolAward = {
			11813,
			11921,
			11811,
			11815
		}
	},
	[10040] = {
		IsUnlock = true,
		Id = 10040,
		Name = getI18NValue(180131768),
		SiteImgePosition = {
			-220,
			122,
			0
		},
		CollectTime = {
			4,
			7,
			11
		},
		CollectReward = {
			{
				2,
				10
			},
			{
				2,
				10
			},
			{
				2,
				10
			}
		},
		PatrolAward = {
			11816,
			11911,
			11810,
			11812
		}
	},
	[10050] = {
		IsUnlock = true,
		Id = 10050,
		Name = getI18NValue(180131769),
		SiteImgePosition = {
			328,
			-55,
			0
		},
		CollectTime = {
			2,
			4,
			6
		},
		CollectReward = {
			{
				2,
				10
			},
			{
				2,
				10
			},
			{
				2,
				10
			}
		},
		PatrolAward = {
			11807,
			11901,
			11806,
			11805
		}
	},
	[10060] = {
		IsUnlock = true,
		Id = 10060,
		Name = getI18NValue(180131770),
		SiteImgePosition = {
			-209,
			-55,
			0
		},
		CollectTime = {
			2,
			4,
			6
		},
		CollectReward = {
			{
				2,
				10
			},
			{
				2,
				10
			},
			{
				2,
				10
			}
		},
		PatrolAward = {
			11814,
			11921,
			11815,
			11801
		}
	},
	[10070] = {
		IsUnlock = true,
		Id = 10070,
		Name = getI18NValue(180131771),
		SiteImgePosition = {
			100,
			144,
			0
		},
		CollectTime = {
			3,
			6,
			9
		},
		CollectReward = {
			{
				2,
				10
			},
			{
				2,
				10
			},
			{
				2,
				10
			}
		},
		PatrolAward = {
			11813,
			11911,
			11812,
			11811
		}
	},
	[10080] = {
		IsUnlock = true,
		Id = 10080,
		Name = getI18NValue(180131772),
		SiteImgePosition = {
			406,
			113,
			0
		},
		CollectTime = {
			4,
			7,
			11
		},
		CollectReward = {
			{
				2,
				10
			},
			{
				2,
				10
			},
			{
				2,
				10
			}
		},
		PatrolAward = {
			11808,
			11901,
			11806,
			11809
		}
	},
	[10090] = {
		IsUnlock = true,
		Id = 10090,
		Name = getI18NValue(180131773),
		SiteImgePosition = {
			1048,
			-1,
			0
		},
		CollectTime = {
			2,
			4,
			6
		},
		CollectReward = {
			{
				2,
				10
			},
			{
				2,
				10
			},
			{
				2,
				10
			}
		},
		PatrolAward = {
			11814,
			11921,
			11809,
			11803
		}
	}
}

setmetatable(CfgTownAreaBookTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgTownAreaBookTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Name = "",
		TabImge = "",
		IsUnlock = false,
		SiteImge = "",
		CollectTime = {
			0,
			0,
			0
		},
		CollectReward = {
			{},
			{},
			{}
		},
		SiteImgePosition = {},
		PatrolAward = {}
	}
}

for i, data in pairs(CfgTownAreaBookTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgTownAreaBookTable
