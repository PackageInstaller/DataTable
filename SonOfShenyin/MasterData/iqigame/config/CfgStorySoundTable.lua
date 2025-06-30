-- chunkname: @IQIGame\\Config\\CfgStorySoundTable.lua

local CfgStorySoundTable = {
	[1001] = {
		NeedStopOnChange = true,
		SoundID = 22000011,
		Id = 1001,
		Animation = "S_move",
		CharacterID = {
			0
		}
	},
	[1002] = {
		NeedStopOnChange = true,
		SoundID = 22000020,
		Id = 1002,
		Animation = "S_run",
		CharacterID = {
			0
		}
	},
	[1003] = {
		NeedStopOnChange = true,
		SoundID = 22000011,
		Id = 1003,
		Animation = "S_B_move",
		CharacterID = {
			0
		}
	},
	[1004] = {
		NeedStopOnChange = true,
		SoundID = 22000020,
		Id = 1004,
		Animation = "S_B_run",
		CharacterID = {
			0
		}
	},
	[1005] = {
		NeedStopOnChange = true,
		SoundID = 22000207,
		Id = 1005,
		Animation = "S_move_cloud",
		CharacterID = {
			0
		}
	}
}

setmetatable(CfgStorySoundTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgStorySoundTable]")
	end
})

local defaultMetaTable = {
	__index = {
		NeedStopOnChange = false,
		SoundID = 0,
		Animation = "",
		CharacterID = {}
	}
}

for i, data in pairs(CfgStorySoundTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgStorySoundTable
