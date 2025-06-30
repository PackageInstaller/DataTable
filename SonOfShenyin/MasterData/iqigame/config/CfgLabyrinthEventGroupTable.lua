-- chunkname: @IQIGame\\Config\\CfgLabyrinthEventGroupTable.lua

local CfgLabyrinthEventGroupTable = {
	[101] = {
		Id = 101,
		GroupHeavy = {
			20,
			25,
			30
		}
	},
	[102] = {
		Id = 102,
		GroupHeavy = {
			0,
			0,
			10
		}
	},
	[103] = {
		Id = 103,
		GroupHeavy = {
			10,
			15,
			15
		}
	},
	[104] = {
		Id = 104,
		GroupHeavy = {
			0,
			0,
			0
		}
	},
	[105] = {
		Id = 105,
		GroupHeavy = {
			0,
			0,
			0
		}
	},
	[201] = {
		Id = 201,
		GroupHeavy = {
			30,
			20,
			20
		}
	},
	[202] = {
		Id = 202,
		GroupHeavy = {
			10,
			15,
			5
		}
	},
	[205] = {
		Id = 205,
		GroupHeavy = {
			10,
			15,
			25
		}
	},
	[204] = {
		Id = 204,
		GroupHeavy = {
			0,
			0,
			0
		}
	},
	[401] = {
		Id = 401,
		GroupHeavy = {
			5,
			5,
			10
		}
	},
	[601] = {
		Id = 601,
		GroupHeavy = {
			25,
			20,
			15
		}
	},
	[602] = {
		Id = 602,
		GroupHeavy = {
			15,
			15,
			15
		}
	},
	[603] = {
		Id = 603,
		GroupHeavy = {
			10,
			15,
			20
		}
	},
	[801] = {
		Id = 801,
		GroupHeavy = {
			0,
			0,
			0
		}
	},
	[802] = {
		Id = 802,
		GroupHeavy = {
			0,
			0,
			0
		}
	},
	[10001] = {
		Id = 10001,
		GroupHeavy = {
			50,
			50,
			50
		}
	},
	[10002] = {
		Id = 10002,
		IsNecessary = true,
		GroupHeavy = {
			1,
			1,
			1
		},
		GroupCondition = {
			30065103
		}
	},
	[10003] = {
		Id = 10003,
		IsNecessary = true,
		GroupHeavy = {
			1,
			1,
			1
		},
		GroupCondition = {
			30065104
		}
	},
	[10004] = {
		Id = 10004,
		IsNecessary = true,
		GroupHeavy = {
			1,
			1,
			1
		},
		GroupCondition = {
			30065105
		}
	},
	[10005] = {
		Id = 10005,
		IsNecessary = true,
		GroupHeavy = {
			1,
			1,
			1
		},
		GroupCondition = {
			30065106
		}
	},
	[10006] = {
		Id = 10006,
		IsNecessary = true,
		GroupHeavy = {
			1,
			1,
			1
		},
		GroupCondition = {
			30065107
		}
	},
	[10007] = {
		Id = 10007,
		IsNecessary = true,
		GroupHeavy = {
			1,
			1,
			1
		},
		GroupCondition = {
			30065108
		}
	},
	[10008] = {
		Id = 10008,
		IsNecessary = true,
		GroupHeavy = {
			1,
			1,
			1
		},
		GroupCondition = {
			30065109
		}
	},
	[10009] = {
		Id = 10009,
		IsNecessary = true,
		GroupHeavy = {
			1,
			1,
			1
		},
		GroupCondition = {
			30065110
		}
	},
	[19999] = {
		Id = 19999,
		GroupHeavy = {
			0,
			0,
			0
		}
	}
}

setmetatable(CfgLabyrinthEventGroupTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgLabyrinthEventGroupTable]")
	end
})

local defaultMetaTable = {
	__index = {
		IsNecessary = false,
		GroupHeavy = {
			0,
			0,
			0
		},
		GroupCondition = {}
	}
}

for i, data in pairs(CfgLabyrinthEventGroupTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgLabyrinthEventGroupTable
