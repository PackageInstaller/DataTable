-- chunkname: @IQIGame\\Config\\CfgWelcomeTaskListTable.lua

local CfgWelcomeTaskListTable = {
	[1001] = {
		NeedNum = 1,
		Parameter = 1,
		Team = 1,
		Type = 1,
		Id = 1001,
		Condition = getI18NValue(180267991),
		Reward = {
			116,
			20
		}
	},
	[1002] = {
		NeedNum = 3,
		Parameter = 1,
		Team = 1,
		Type = 1,
		Id = 1002,
		Condition = getI18NValue(180267992),
		Reward = {
			116,
			20
		}
	},
	[1003] = {
		NeedNum = 5,
		Parameter = 1,
		Team = 1,
		Type = 1,
		Id = 1003,
		Condition = getI18NValue(180267993),
		Reward = {
			116,
			20
		}
	},
	[1004] = {
		NeedNum = 7,
		Parameter = 1,
		Team = 1,
		Type = 1,
		Id = 1004,
		Condition = getI18NValue(180267994),
		Reward = {
			116,
			20
		}
	},
	[1005] = {
		NeedNum = 10,
		Parameter = 1,
		Team = 1,
		Type = 1,
		Id = 1005,
		Condition = getI18NValue(180267995),
		Reward = {
			116,
			20,
			80006,
			1
		}
	},
	[1006] = {
		NeedNum = 1,
		Parameter = 25020215,
		Team = 1,
		Type = 2,
		Id = 1006,
		Condition = getI18NValue(180267996),
		Reward = {
			117,
			10
		}
	},
	[1007] = {
		NeedNum = 3,
		Parameter = 25020215,
		Team = 1,
		Type = 2,
		Id = 1007,
		Condition = getI18NValue(180267997),
		Reward = {
			117,
			20
		}
	},
	[1008] = {
		NeedNum = 5,
		Parameter = 25020215,
		Team = 1,
		Type = 2,
		Id = 1008,
		Condition = getI18NValue(180267998),
		Reward = {
			117,
			20
		}
	},
	[1009] = {
		NeedNum = 7,
		Parameter = 25020215,
		Team = 1,
		Type = 2,
		Id = 1009,
		Condition = getI18NValue(180267999),
		Reward = {
			117,
			20
		}
	},
	[1010] = {
		NeedNum = 10,
		Parameter = 25020215,
		Team = 1,
		Type = 2,
		Id = 1010,
		Condition = getI18NValue(180268000),
		Reward = {
			117,
			30
		}
	},
	[1011] = {
		NeedNum = 1,
		Parameter = 30,
		Team = 1,
		Type = 3,
		Id = 1011,
		Condition = getI18NValue(180268001),
		Reward = {
			11501,
			100
		}
	},
	[1012] = {
		NeedNum = 3,
		Parameter = 30,
		Team = 1,
		Type = 3,
		Id = 1012,
		Condition = getI18NValue(180268002),
		Reward = {
			11501,
			200
		}
	},
	[1013] = {
		NeedNum = 5,
		Parameter = 30,
		Team = 1,
		Type = 3,
		Id = 1013,
		Condition = getI18NValue(180272718),
		Reward = {
			11501,
			200
		}
	},
	[1014] = {
		NeedNum = 7,
		Parameter = 30,
		Team = 1,
		Type = 3,
		Id = 1014,
		Condition = getI18NValue(180272719),
		Reward = {
			11501,
			200
		}
	},
	[1015] = {
		NeedNum = 10,
		Parameter = 30,
		Team = 1,
		Type = 3,
		Id = 1015,
		Condition = getI18NValue(180272720),
		Reward = {
			11501,
			300
		}
	},
	[1016] = {
		NeedNum = 1,
		Parameter = 1,
		Team = 1,
		Type = 4,
		Id = 1016,
		Condition = getI18NValue(180272721),
		Reward = {
			2,
			200
		}
	},
	[1017] = {
		NeedNum = 3,
		Parameter = 1,
		Team = 1,
		Type = 4,
		Id = 1017,
		Condition = getI18NValue(180272722),
		Reward = {
			2,
			400
		}
	},
	[1018] = {
		NeedNum = 5,
		Parameter = 1,
		Team = 1,
		Type = 4,
		Id = 1018,
		Condition = getI18NValue(180272723),
		Reward = {
			2,
			400
		}
	},
	[1019] = {
		NeedNum = 7,
		Parameter = 1,
		Team = 1,
		Type = 4,
		Id = 1019,
		Condition = getI18NValue(180272724),
		Reward = {
			2,
			400
		}
	},
	[1020] = {
		NeedNum = 10,
		Parameter = 1,
		Team = 1,
		Type = 4,
		Id = 1020,
		Condition = getI18NValue(180272725),
		Reward = {
			2,
			600
		}
	}
}

setmetatable(CfgWelcomeTaskListTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgWelcomeTaskListTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Parameter = 0,
		NeedNum = 0,
		Type = 0,
		Team = 0,
		Condition = "",
		Reward = {}
	}
}

for i, data in pairs(CfgWelcomeTaskListTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgWelcomeTaskListTable
