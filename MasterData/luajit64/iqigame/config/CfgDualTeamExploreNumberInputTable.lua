-- chunkname: @IQIGame\\Config\\CfgDualTeamExploreNumberInputTable.lua

local CfgDualTeamExploreNumberInputTable = {
	[30270300] = {
		NumberSlots = 4,
		Id = 30270300,
		Describe = getI18NValue(180297420),
		CorrectService = {
			302706,
			302707
		},
		WrongService = {
			302704,
			302705
		},
		Number = {
			{
				2
			},
			{
				4
			},
			{
				4
			},
			{
				6
			},
			{},
			{}
		}
	},
	[30280100] = {
		NumberSlots = 4,
		Id = 30280100,
		Describe = getI18NValue(180297421),
		CorrectService = {
			302804,
			302805
		},
		WrongService = {
			302802,
			302803
		},
		Number = {
			{
				2
			},
			{
				4
			},
			{
				3
			},
			{
				5
			},
			{},
			{}
		}
	},
	[30290100] = {
		NumberSlots = 4,
		Id = 30290100,
		Describe = getI18NValue(180297422),
		CorrectService = {
			302904,
			302905
		},
		WrongService = {
			302902,
			302903
		},
		Number = {
			{
				3
			},
			{
				4
			},
			{
				5
			},
			{
				6
			},
			{},
			{}
		}
	},
	[30300100] = {
		NumberSlots = 4,
		Id = 30300100,
		Describe = getI18NValue(180297423),
		CorrectService = {
			303004,
			303005
		},
		WrongService = {
			303002,
			303003
		},
		Number = {
			{
				5
			},
			{
				6
			},
			{
				0
			},
			{
				9
			},
			{},
			{}
		}
	},
	[30590500] = {
		NumberSlots = 6,
		Id = 30590500,
		Describe = getI18NValue(180297424),
		CorrectService = {
			305906,
			305907,
			305908
		},
		WrongService = {
			305906
		},
		Number = {
			{
				2
			},
			{
				0
			},
			{
				6
			},
			{
				7
			},
			{
				0
			},
			{
				7
			}
		}
	},
	[30600200] = {
		NumberSlots = 6,
		Id = 30600200,
		Describe = getI18NValue(180297425),
		CorrectService = {
			306003,
			305906,
			305908
		},
		WrongService = {
			305906
		},
		Number = {
			{
				2
			},
			{
				0
			},
			{
				6
			},
			{
				7
			},
			{
				0
			},
			{
				2
			}
		}
	},
	[30610200] = {
		NumberSlots = 6,
		Id = 30610200,
		Describe = getI18NValue(180297426),
		CorrectService = {
			306103,
			305906,
			305908
		},
		WrongService = {
			305906
		},
		Number = {
			{
				2
			},
			{
				0
			},
			{
				6
			},
			{
				7
			},
			{
				0
			},
			{
				3
			}
		}
	},
	[30620200] = {
		NumberSlots = 6,
		Id = 30620200,
		Describe = getI18NValue(180297427),
		CorrectService = {
			306203,
			305906,
			305908
		},
		WrongService = {
			305906
		},
		Number = {
			{
				2
			},
			{
				0
			},
			{
				6
			},
			{
				7
			},
			{
				0
			},
			{
				4
			}
		}
	},
	[30630200] = {
		NumberSlots = 6,
		Id = 30630200,
		Describe = getI18NValue(180297428),
		CorrectService = {
			306303,
			305906,
			305908
		},
		WrongService = {
			305906
		},
		Number = {
			{
				2
			},
			{
				0
			},
			{
				6
			},
			{
				7
			},
			{
				0
			},
			{
				6
			}
		}
	},
	[30640200] = {
		NumberSlots = 6,
		Id = 30640200,
		Describe = getI18NValue(180297429),
		CorrectService = {
			306403,
			305906,
			305908
		},
		WrongService = {
			305906
		},
		Number = {
			{
				2
			},
			{
				0
			},
			{
				6
			},
			{
				7
			},
			{
				0
			},
			{
				5
			}
		}
	},
	[30650200] = {
		NumberSlots = 6,
		Id = 30650200,
		Describe = getI18NValue(180297430),
		CorrectService = {
			306503,
			305906,
			305908
		},
		WrongService = {
			305906
		},
		Number = {
			{
				2
			},
			{
				0
			},
			{
				6
			},
			{
				7
			},
			{
				0
			},
			{
				1
			}
		}
	},
	[30680100] = {
		NumberSlots = 4,
		Id = 30680100,
		Describe = getI18NValue(180297431),
		EasterEggNums = {
			6,
			3,
			5,
			7
		},
		EasterEggService = {
			306805
		},
		CorrectService = {
			306802
		},
		WrongService = {
			306804
		},
		Number = {
			{
				6
			},
			{
				3
			},
			{
				5
			},
			{
				8
			},
			{},
			{}
		}
	},
	[50600300] = {
		NumberSlots = 6,
		Id = 50600300,
		Describe = getI18NValue(180297432),
		CorrectService = {
			506004,
			506008
		},
		WrongService = {
			506009,
			506006,
			506004
		},
		Number = {
			{
				1
			},
			{
				2
			},
			{
				2
			},
			{
				6
			},
			{},
			{}
		}
	}
}

setmetatable(CfgDualTeamExploreNumberInputTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgDualTeamExploreNumberInputTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Describe = "",
		NumberSlots = 0,
		EasterEggNums = {},
		WrongService = {},
		Number = {
			{},
			{},
			{},
			{},
			{},
			{}
		},
		EasterEggService = {},
		CorrectService = {}
	}
}

for i, data in pairs(CfgDualTeamExploreNumberInputTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgDualTeamExploreNumberInputTable
