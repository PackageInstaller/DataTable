-- chunkname: @IQIGame\\Config\\CfgPandaActionListTable.lua

local CfgPandaActionListTable = {
	[10001] = {
		AutoAction = true,
		Team = 1,
		CountDown = 10,
		Weight = 4,
		Id = 10001,
		PandaSpine = 900030,
		PandaAction = "idle"
	},
	[10002] = {
		AutoAction = true,
		Team = 1,
		CountDown = 5,
		Weight = 4,
		Id = 10002,
		PandaSpine = 900030,
		PandaAction = "walk"
	},
	[10003] = {
		AutoAction = true,
		Team = 1,
		CountDown = 5,
		Weight = 4,
		Id = 10003,
		PandaSpine = 900030,
		PandaAction = "sit"
	},
	[10004] = {
		Team = 1,
		CountDown = 4,
		Id = 10004,
		PandaSpine = 900030,
		PandaAction = "eat"
	},
	[10005] = {
		AutoAction = true,
		Team = 1,
		CountDown = 60,
		Weight = 1,
		Id = 10005,
		PandaSpine = 900030,
		PandaAction = "sleep"
	},
	[10006] = {
		Team = 1,
		CountDown = 4,
		Id = 10006,
		PandaSpine = 900030,
		PandaAction = "wash"
	},
	[10007] = {
		Team = 1,
		CountDown = 4,
		Id = 10007,
		PandaSpine = 900030,
		PandaAction = "homeInsert01"
	},
	[10008] = {
		Team = 1,
		CountDown = 4,
		Id = 10008,
		PandaSpine = 900030,
		PandaAction = "homeInsert02"
	},
	[10009] = {
		Team = 1,
		CountDown = 4,
		Id = 10009,
		PandaSpine = 900030,
		PandaAction = "homeInsert03"
	}
}

setmetatable(CfgPandaActionListTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgPandaActionListTable]")
	end
})

local defaultMetaTable = {
	__index = {
		AutoAction = false,
		CountDown = 0,
		Weight = 0,
		Team = 0,
		PandaSpine = 0,
		PandaAction = ""
	}
}

for i, data in pairs(CfgPandaActionListTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgPandaActionListTable
