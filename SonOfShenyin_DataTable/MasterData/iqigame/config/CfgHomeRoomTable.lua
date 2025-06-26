-- chunkname: @IQIGame\\Config\\CfgHomeRoomTable.lua

local CfgHomeRoomTable = {
	[30300001] = {
		Id = 30300001,
		DefSceneId = 605001,
		Name = getI18NValue(180132672)
	},
	[30300002] = {
		Id = 30300002,
		DefSceneId = 605002,
		Name = getI18NValue(180132673)
	},
	[30300003] = {
		Id = 30300003,
		DefSceneId = 605003,
		Name = getI18NValue(180132674)
	},
	[30300004] = {
		Id = 30300004,
		DefSceneId = 605004,
		Name = getI18NValue(180132675)
	},
	[30300005] = {
		Id = 30300005,
		DefSceneId = 605005,
		Name = getI18NValue(180132676)
	},
	[30300006] = {
		Id = 30300006,
		DefSceneId = 605006,
		Name = getI18NValue(180132677)
	},
	[30300007] = {
		Id = 30300007,
		DefSceneId = 605007,
		Name = getI18NValue(180132678)
	},
	[30300008] = {
		Id = 30300008,
		DefSceneId = 605008,
		Name = getI18NValue(180132679)
	}
}

setmetatable(CfgHomeRoomTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgHomeRoomTable]")
	end
})

local defaultMetaTable = {
	__index = {
		MiniMapRes = "",
		UnlockCondition = 0,
		Name = "",
		DefSceneId = 0
	}
}

for i, data in pairs(CfgHomeRoomTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgHomeRoomTable
