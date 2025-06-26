-- chunkname: @IQIGame\\Config\\CfgGhostGameBuffTable.lua

local CfgGhostGameBuffTable = {
	[60200201] = {
		Scope = 1,
		Type = 1,
		Id = 60200201,
		TriggerParams = 5,
		Name = getI18NValue(180190631)
	},
	[60200202] = {
		DurationTime = 10,
		Scope = 1,
		Type = 2,
		Id = 60200202,
		Icon = "Assets/05_Images/Icon/Attribute/Buff_Atk_Up.png",
		TriggerParams = 0.5,
		Name = getI18NValue(180190632)
	},
	[60200203] = {
		DurationTime = 10,
		Scope = 1,
		Type = 3,
		Id = 60200203,
		Icon = "Assets/05_Images/Icon/Attribute/Buff_Normal_Up.png",
		TriggerParams = 0.2,
		Name = getI18NValue(180190633)
	},
	[60200204] = {
		DurationTime = 10,
		Scope = 2,
		Type = 4,
		Id = 60200204,
		Icon = "Assets/05_Images/Icon/Attribute/Buff_YaY_Sijie.png",
		TriggerParams = 0.5,
		Name = getI18NValue(180190634)
	},
	[60200205] = {
		Id = 60200205,
		Type = 5,
		DurationTime = 3,
		Icon = "Assets/05_Images/Icon/Attribute/Buff_ChunRX_Xuezhen.png",
		Scope = 2,
		Name = getI18NValue(180190635)
	}
}

setmetatable(CfgGhostGameBuffTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgGhostGameBuffTable]")
	end
})

local defaultMetaTable = {
	__index = {
		TriggerParams = 0,
		Name = "",
		Type = 0,
		DurationTime = 0,
		Icon = "",
		Scope = 0
	}
}

for i, data in pairs(CfgGhostGameBuffTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgGhostGameBuffTable
