-- chunkname: @IQIGame\\Config\\CfgLabyrinthEventTraderTable.lua

local CfgLabyrinthEventTraderTable = {
	[41400001] = {
		EventAction = 33,
		DefaultAnimation = "S_welcome_2",
		ShopNum = 4,
		TraderShow = 10815057,
		Id = 41400001,
		DefaultEffect = {
			10029,
			10001
		},
		EventActionParams = {
			2,
			2,
			1,
			30
		},
		BuffGroup = {
			501,
			502,
			503
		},
		RefreshCost = {
			20,
			100
		}
	},
	[41400002] = {
		EventAction = 33,
		DefaultAnimation = "S_welcome_2",
		ShopNum = 6,
		TraderShow = 10815057,
		Id = 41400002,
		DefaultEffect = {
			10029,
			10001
		},
		EventActionParams = {
			2,
			2,
			1,
			30
		},
		BuffGroup = {
			501,
			502,
			503
		},
		RefreshCost = {
			20,
			100
		}
	},
	[41400003] = {
		EventAction = 33,
		DefaultAnimation = "S_welcome_2",
		ShopNum = 5,
		TraderShow = 10815057,
		Id = 41400003,
		DefaultEffect = {
			10029,
			10001
		},
		EventActionParams = {
			2,
			2,
			1,
			30
		},
		BuffGroup = {
			501,
			502,
			503
		},
		RefreshCost = {
			20,
			100
		}
	},
	[41400004] = {
		EventAction = 33,
		DefaultAnimation = "S_welcome_2",
		ShopNum = 3,
		TraderShow = 10815057,
		Id = 41400004,
		DefaultEffect = {
			10029,
			10001
		},
		EventActionParams = {
			2,
			2,
			1,
			30
		},
		BuffGroup = {
			501,
			502,
			503
		},
		RefreshCost = {
			20,
			100
		}
	}
}

setmetatable(CfgLabyrinthEventTraderTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgLabyrinthEventTraderTable]")
	end
})

local defaultMetaTable = {
	__index = {
		TraderShow = 0,
		DefaultAnimation = "",
		EventAction = 0,
		ShopNum = 0,
		EventActionParams = {},
		DefaultEffect = {},
		RefreshCost = {},
		BuffGroup = {}
	}
}

for i, data in pairs(CfgLabyrinthEventTraderTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgLabyrinthEventTraderTable
