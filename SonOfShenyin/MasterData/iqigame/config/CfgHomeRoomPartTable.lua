-- chunkname: @IQIGame\\Config\\CfgHomeRoomPartTable.lua

local CfgHomeRoomPartTable = {
	[30401001] = {
		Id = 30401001,
		RoomId = 30300001,
		SkinCid = 30500001,
		Type = 1
	},
	[30401002] = {
		Id = 30401002,
		RoomId = 30300001,
		SkinCid = 30500002,
		Type = 1
	},
	[30401003] = {
		Id = 30401003,
		RoomId = 30300002,
		SkinCid = 30500003,
		Type = 1
	},
	[30401004] = {
		SkinCid = 30500004,
		Type = 1,
		Id = 30401004,
		RoomId = 30300002,
		OpenUI = "HomeLandThemeUI"
	},
	[30401005] = {
		Id = 30401005,
		RoomId = 30300002,
		SkinCid = 30500005,
		Type = 1
	},
	[30401006] = {
		Id = 30401006,
		RoomId = 101001,
		SkinCid = 30500006,
		Type = 1
	},
	[30401007] = {
		Id = 30401007,
		RoomId = 30300001,
		SkinCid = 30500008,
		Type = 1
	},
	[30402001] = {
		SkinCid = 30501001,
		Type = 2,
		Id = 30402001,
		RoomId = 30300001,
		EnterRoom = {
			30300002
		}
	},
	[30402002] = {
		SkinCid = 30501002,
		Type = 2,
		Id = 30402002,
		RoomId = 30300002,
		EnterRoom = {
			30300004,
			30300003,
			30300001
		}
	},
	[30402003] = {
		SkinCid = 30501003,
		Type = 2,
		Id = 30402003,
		RoomId = 30300003,
		EnterRoom = {
			30300006,
			30300002
		}
	},
	[30402004] = {
		SkinCid = 30501004,
		Type = 2,
		Id = 30402004,
		RoomId = 30300004,
		EnterRoom = {
			30300005,
			30300008,
			30300002
		}
	},
	[30402005] = {
		SkinCid = 30501005,
		Type = 2,
		Id = 30402005,
		RoomId = 30300005,
		EnterRoom = {
			30300006,
			30300004
		}
	},
	[30402006] = {
		SkinCid = 30501006,
		Type = 2,
		Id = 30402006,
		RoomId = 30300006,
		EnterRoom = {
			30300002,
			30300007
		}
	},
	[30402007] = {
		SkinCid = 30501007,
		Type = 2,
		Id = 30402007,
		RoomId = 30300007,
		EnterRoom = {
			30300006
		}
	},
	[30402008] = {
		SkinCid = 30501008,
		Type = 2,
		Id = 30402008,
		RoomId = 30300008,
		EnterRoom = {
			30300004
		}
	}
}

setmetatable(CfgHomeRoomPartTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgHomeRoomPartTable]")
	end
})

local defaultMetaTable = {
	__index = {
		RedDotID = 0,
		UnlockCondition = 0,
		FunOpenID = 0,
		UnOpenNoticeID = 0,
		SkinCid = 0,
		Type = 0,
		RoomId = 0,
		OpenUI = "",
		EnterRoom = {}
	}
}

for i, data in pairs(CfgHomeRoomPartTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgHomeRoomPartTable
