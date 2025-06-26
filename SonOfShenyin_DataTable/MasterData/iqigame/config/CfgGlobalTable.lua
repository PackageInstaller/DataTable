-- chunkname: @IQIGame\\Config\\CfgGlobalTable.lua

local CfgGlobalTable = {
	[1002] = {
		Id = 1002,
		Parameter = "Assets/13_Lua"
	},
	[1004] = {
		Id = 1004,
		Parameter = "/02_Scripts/Runtime/Game/Config"
	},
	[1005] = {
		Id = 1005,
		Parameter = "/02_Scripts/Editor/ConfigGenerator/Template"
	},
	[1007] = {
		Id = 1007,
		Parameter = "/02_Scripts/Editor/UI/Template/Script.template"
	},
	[1008] = {
		Id = 1008,
		Parameter = "/02_Scripts/Runtime/Game/UI/Core/UIControllerName.cs"
	},
	[1009] = {
		Id = 1009,
		Parameter = "/11_Tables/Csv"
	},
	[1010] = {
		Id = 1010,
		Parameter = "Assets/11_Tables/Csv/{0}.csv"
	},
	[1011] = {
		Id = 1011,
		Parameter = "Assets/03_Prefabs/UI/{0}.prefab"
	},
	[1012] = {
		Id = 1012,
		Parameter = "Assets/07_Animations/UI/{0}.anim"
	},
	[1013] = {
		Id = 1013,
		Parameter = "Assets/06_Sounds"
	},
	[1014] = {
		Id = 1014,
		Parameter = "Assets/01_Scenes/{0}.unity"
	},
	[1015] = {
		Id = 1015,
		Parameter = "Assets/03_Prefabs/Scene/{0}.prefab"
	},
	[1018] = {
		Id = 1018,
		Parameter = "Assets/03_Prefabs/{0}.prefab"
	},
	[1019] = {
		Id = 1019,
		Parameter = "Assets/03_Prefabs/Entity/MainCity/{0}.prefab"
	},
	[1021] = {
		Id = 1021,
		Parameter = "Assets/11_Tables/Vs/{0}.xml"
	},
	[1022] = {
		Id = 1022,
		Parameter = "Assets/07_Animations/{0}.controller"
	},
	[1023] = {
		Id = 1023,
		Parameter = "Assets/03_Prefabs/{0}.prefab"
	},
	[1044] = {
		Id = 1044,
		Parameter = "Assets/05_Images{0}"
	}
}

setmetatable(CfgGlobalTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgGlobalTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Parameter = ""
	}
}

for i, data in pairs(CfgGlobalTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgGlobalTable
