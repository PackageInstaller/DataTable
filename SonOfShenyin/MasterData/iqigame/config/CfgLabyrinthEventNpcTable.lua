-- chunkname: @IQIGame\\Config\\CfgLabyrinthEventNpcTable.lua

local CfgLabyrinthEventNpcTable = {
	[41500001] = {
		DialogueID = 20202,
		Id = 41500001,
		NpcShow = 10815040,
		DefaultAnimation = "idle",
		LastDialogueID = 20205
	},
	[41500002] = {
		DialogueID = 20301,
		Id = 41500002,
		NpcShow = 10815040,
		DefaultAnimation = "idle",
		LastDialogueID = 20311
	},
	[41500003] = {
		DialogueID = 30001,
		Id = 41500003,
		NpcShow = 10815040,
		DefaultAnimation = "idle",
		LastDialogueID = 30002
	},
	[41500004] = {
		DialogueID = 30101,
		Id = 41500004,
		NpcShow = 10815040,
		DefaultAnimation = "idle",
		LastDialogueID = 30113
	},
	[41500005] = {
		DialogueID = 30201,
		Id = 41500005,
		NpcShow = 10815040,
		DefaultAnimation = "idle",
		LastDialogueID = 30202
	},
	[41500006] = {
		DialogueID = 30301,
		Id = 41500006,
		NpcShow = 10815040,
		DefaultAnimation = "idle",
		LastDialogueID = 30304
	},
	[41500007] = {
		DialogueID = 30401,
		Id = 41500007,
		NpcShow = 10815040,
		DefaultAnimation = "idle",
		LastDialogueID = 30405
	},
	[41500008] = {
		DialogueID = 30531,
		Id = 41500008,
		NpcShow = 10815040,
		DefaultAnimation = "idle",
		LastDialogueID = 30535
	},
	[41500009] = {
		DialogueID = 40001,
		Id = 41500009,
		NpcShow = 10815040,
		DefaultAnimation = "idle",
		LastDialogueID = 40043
	},
	[41500010] = {
		DialogueID = 40001,
		Id = 41500010,
		NpcShow = 10815040,
		DefaultAnimation = "idle",
		LastDialogueID = 40043
	},
	[41500011] = {
		DialogueID = 40001,
		Id = 41500011,
		NpcShow = 10815040,
		DefaultAnimation = "idle",
		LastDialogueID = 40043
	},
	[41500012] = {
		DialogueID = 40001,
		Id = 41500012,
		NpcShow = 10815040,
		DefaultAnimation = "idle",
		LastDialogueID = 40043
	},
	[41500013] = {
		DialogueID = 40001,
		Id = 41500013,
		NpcShow = 10815040,
		DefaultAnimation = "idle",
		LastDialogueID = 40043
	},
	[41500014] = {
		DialogueID = 40001,
		Id = 41500014,
		NpcShow = 10815040,
		DefaultAnimation = "idle",
		LastDialogueID = 40043
	},
	[41500015] = {
		DialogueID = 50001,
		Id = 41500015,
		NpcShow = 10815040,
		DefaultAnimation = "idle",
		LastDialogueID = 50001
	},
	[41500016] = {
		DialogueID = 50001,
		Id = 41500016,
		NpcShow = 10815040,
		DefaultAnimation = "idle",
		LastDialogueID = 50001
	},
	[41500017] = {
		DialogueID = 50001,
		Id = 41500017,
		NpcShow = 10815040,
		DefaultAnimation = "idle",
		LastDialogueID = 50001
	},
	[41500018] = {
		DialogueID = 50001,
		Id = 41500018,
		NpcShow = 10815040,
		DefaultAnimation = "idle",
		LastDialogueID = 50001
	},
	[41550008] = {
		DefaultAnimation = "idle",
		LastDialogueID = 30521,
		DialogueID = 30501,
		Id = 41550008
	},
	[41550009] = {
		DefaultAnimation = "idle",
		LastDialogueID = 30603,
		DialogueID = 30601,
		Id = 41550009
	},
	[41590001] = {
		DialogueID = 40001,
		LastDialogueID = 40043,
		Id = 41590001
	}
}

setmetatable(CfgLabyrinthEventNpcTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgLabyrinthEventNpcTable]")
	end
})

local defaultMetaTable = {
	__index = {
		DialogueID = 0,
		DefaultAnimation = "",
		NpcAction = 0,
		NpcShow = 0,
		LastDialogueID = 0,
		DefaultEffect = {},
		NpcActionParams = {}
	}
}

for i, data in pairs(CfgLabyrinthEventNpcTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgLabyrinthEventNpcTable
