-- chunkname: @IQIGame\\Config\\CfgPandaGiftListTable.lua

local CfgPandaGiftListTable = {
	[10001] = {
		FavorNum = 1000,
		Team = 1,
		Id = 10001,
		Size = 100,
		Reward = {
			401,
			2000
		}
	},
	[10002] = {
		FavorNum = 2000,
		Team = 1,
		Id = 10002,
		Size = 115,
		Reward = {
			401,
			2000
		}
	},
	[10003] = {
		FavorNum = 3000,
		Team = 1,
		Id = 10003,
		Size = 130,
		Reward = {
			401,
			2000
		}
	},
	[10004] = {
		FavorNum = 4000,
		Team = 1,
		Id = 10004,
		Size = 145,
		Reward = {
			401,
			2000
		}
	},
	[10005] = {
		FavorNum = 5000,
		Team = 1,
		Id = 10005,
		Size = 160,
		Reward = {
			3000015,
			1
		}
	},
	[10006] = {
		FavorNum = 6000,
		Team = 1,
		Id = 10006,
		Size = 175,
		Reward = {
			401,
			2000
		}
	},
	[10007] = {
		FavorNum = 7000,
		Team = 1,
		Id = 10007,
		Size = 190,
		Reward = {
			401,
			2000
		}
	},
	[10008] = {
		FavorNum = 8000,
		Team = 1,
		Id = 10008,
		Size = 205,
		Reward = {
			401,
			2000
		}
	},
	[10009] = {
		FavorNum = 9000,
		Team = 1,
		Id = 10009,
		Size = 220,
		Reward = {
			401,
			2000
		}
	},
	[10010] = {
		FavorNum = 10000,
		RewardImage = "/Activity/Panda/Panda_01/Panda_Image_02.png",
		Team = 1,
		Id = 10010,
		Size = 235,
		Reward = {
			6051003,
			1
		}
	}
}

setmetatable(CfgPandaGiftListTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgPandaGiftListTable]")
	end
})

local defaultMetaTable = {
	__index = {
		FavorNum = 0,
		RewardImage = "",
		Team = 0,
		Size = 0,
		Reward = {}
	}
}

for i, data in pairs(CfgPandaGiftListTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgPandaGiftListTable
