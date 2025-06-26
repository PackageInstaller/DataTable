-- chunkname: @IQIGame\\Config\\CfgExclusiveAwardTable.lua

local CfgExclusiveAwardTable = {
	[20010001] = {
		Id = 20010001,
		RewardWeight = {
			500,
			500,
			500
		},
		Reward = {
			{
				11001,
				1
			},
			{
				11001,
				1
			},
			{
				11001,
				1
			}
		}
	},
	[20010002] = {
		Id = 20010002,
		RewardWeight = {
			500,
			500,
			500
		},
		Reward = {
			{
				11002,
				1
			},
			{
				11002,
				1
			},
			{
				11002,
				1
			}
		}
	},
	[20010003] = {
		Id = 20010003,
		RewardWeight = {
			500,
			500,
			500
		},
		Reward = {
			{
				11003,
				1
			},
			{
				11003,
				1
			},
			{
				11003,
				1
			}
		}
	},
	[20010004] = {
		Id = 20010004,
		RewardWeight = {
			500,
			500,
			500
		},
		Reward = {
			{
				11004,
				1
			},
			{
				11004,
				1
			},
			{
				11004,
				1
			}
		}
	},
	[20010005] = {
		Id = 20010005,
		RewardWeight = {
			500,
			500,
			500
		},
		Reward = {
			{
				11005,
				1
			},
			{
				11005,
				1
			},
			{
				11005,
				1
			}
		}
	},
	[20010006] = {
		Id = 20010006,
		RewardWeight = {
			500,
			500,
			500
		},
		Reward = {
			{
				11006,
				1
			},
			{
				11006,
				1
			},
			{
				11006,
				1
			}
		}
	},
	[20010007] = {
		Id = 20010007,
		RewardWeight = {
			500,
			500,
			500
		},
		Reward = {
			{
				11007,
				1
			},
			{
				11007,
				1
			},
			{
				11007,
				1
			}
		}
	},
	[20010008] = {
		Id = 20010008,
		RewardWeight = {
			500,
			500,
			500
		},
		Reward = {
			{
				11008,
				1
			},
			{
				11008,
				1
			},
			{
				11008,
				1
			}
		}
	},
	[20010009] = {
		Id = 20010009,
		RewardWeight = {
			500,
			500,
			500
		},
		Reward = {
			{
				11009,
				1
			},
			{
				11009,
				1
			},
			{
				11009,
				1
			}
		}
	},
	[20010010] = {
		Id = 20010010,
		RewardWeight = {
			500,
			500,
			500
		},
		Reward = {
			{
				11010,
				1
			},
			{
				11010,
				1
			},
			{
				11010,
				1
			}
		}
	},
	[20010011] = {
		Id = 20010011,
		RewardWeight = {
			500,
			500,
			500
		},
		Reward = {
			{
				11011,
				1
			},
			{
				11011,
				1
			},
			{
				11011,
				1
			}
		}
	},
	[20010012] = {
		Id = 20010012,
		RewardWeight = {
			500,
			500,
			500
		},
		Reward = {
			{
				11012,
				1
			},
			{
				11012,
				1
			},
			{
				11012,
				1
			}
		}
	},
	[20010013] = {
		Id = 20010013,
		RewardWeight = {
			500,
			500,
			500
		},
		Reward = {
			{
				11013,
				1
			},
			{
				11013,
				1
			},
			{
				11013,
				1
			}
		}
	},
	[20010014] = {
		Id = 20010014,
		RewardWeight = {
			500,
			500,
			500
		},
		Reward = {
			{
				11014,
				1
			},
			{
				11014,
				1
			},
			{
				11014,
				1
			}
		}
	},
	[20010015] = {
		Id = 20010015,
		RewardWeight = {
			500,
			500,
			500
		},
		Reward = {
			{
				11015,
				1
			},
			{
				11015,
				1
			},
			{
				11015,
				1
			}
		}
	}
}

setmetatable(CfgExclusiveAwardTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgExclusiveAwardTable]")
	end
})

local defaultMetaTable = {
	__index = {
		RewardWeight = {
			0,
			0,
			0
		},
		Reward = {
			{},
			{},
			{}
		}
	}
}

for i, data in pairs(CfgExclusiveAwardTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgExclusiveAwardTable
