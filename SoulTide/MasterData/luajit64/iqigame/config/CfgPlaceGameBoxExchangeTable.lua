-- chunkname: @IQIGame\\Config\\CfgPlaceGameBoxExchangeTable.lua

local CfgPlaceGameBoxExchangeTable = {
	[10001] = {
		Group = 1,
		Reward = 11126001,
		Id = 10001,
		BoxEnity = 814201,
		Name = getI18NValue(180868558),
		Cost = {
			342,
			100
		},
		Desc = getI18NValue(180868567)
	},
	[10002] = {
		Group = 1,
		NeedTower = 10,
		Id = 10002,
		Reward = 11126002,
		BoxEnity = 814201,
		Name = getI18NValue(180868559),
		Cost = {
			342,
			200
		},
		Desc = getI18NValue(180868568)
	},
	[10003] = {
		Group = 1,
		NeedTower = 20,
		Id = 10003,
		Reward = 11126003,
		BoxEnity = 814202,
		Name = getI18NValue(180868560),
		Cost = {
			342,
			300
		},
		Desc = getI18NValue(180868569)
	},
	[10004] = {
		Group = 1,
		NeedTower = 30,
		Id = 10004,
		Reward = 11126004,
		BoxEnity = 814202,
		Name = getI18NValue(180868561),
		Cost = {
			342,
			500
		},
		Desc = getI18NValue(180868570)
	},
	[10005] = {
		Group = 1,
		NeedTower = 40,
		Id = 10005,
		Reward = 11126005,
		BoxEnity = 814203,
		Name = getI18NValue(180868562),
		Cost = {
			342,
			800
		},
		Desc = getI18NValue(180868571)
	},
	[10006] = {
		Group = 1,
		NeedTower = 50,
		Id = 10006,
		Reward = 11126006,
		BoxEnity = 814203,
		Name = getI18NValue(180868563),
		Cost = {
			342,
			1300
		},
		Desc = getI18NValue(180868572)
	},
	[10007] = {
		Group = 1,
		NeedTower = 60,
		Id = 10007,
		Reward = 11126007,
		BoxEnity = 814204,
		Name = getI18NValue(180868564),
		Cost = {
			342,
			1800
		},
		Desc = getI18NValue(180868573)
	},
	[10008] = {
		Group = 1,
		NeedTower = 70,
		Id = 10008,
		Reward = 11126008,
		BoxEnity = 814204,
		Name = getI18NValue(180868565),
		Cost = {
			342,
			2300
		},
		Desc = getI18NValue(180868574)
	},
	[10009] = {
		Group = 1,
		NeedTower = 80,
		Id = 10009,
		Reward = 11126009,
		BoxEnity = 814205,
		Name = getI18NValue(180874664),
		Cost = {
			342,
			2800
		},
		Desc = getI18NValue(180874663)
	},
	[10010] = {
		Group = 1,
		NeedTower = 90,
		Id = 10010,
		Reward = 11126010,
		BoxEnity = 814205,
		Name = getI18NValue(180874666),
		Cost = {
			342,
			3300
		},
		Desc = getI18NValue(180874665)
	}
}

setmetatable(CfgPlaceGameBoxExchangeTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgPlaceGameBoxExchangeTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Reward = 0,
		BoxEnity = 0,
		Group = 0,
		NeedTower = 0,
		Name = "",
		Desc = "",
		Cost = {}
	}
}

for i, data in pairs(CfgPlaceGameBoxExchangeTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgPlaceGameBoxExchangeTable
