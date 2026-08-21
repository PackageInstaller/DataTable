-- chunkname: @IQIGame\\Config\\CfgLoginBGTable.lua

local CfgLoginBGTable = {
	[42000001] = {
		Id = 42000001,
		PrefabUrl = "/_LoginUI/Login_Background_01.prefab",
		LockDescribtion = getI18NValue(180082258)
	},
	[42000002] = {
		Id = 42000002,
		PrefabUrl = "/_LoginUI/Login_Background_02.prefab",
		LockDescribtion = getI18NValue(180082259)
	},
	[42000003] = {
		Id = 42000003,
		PrefabUrl = "/_LoginUI/Login_Background_03.prefab",
		LockDescribtion = getI18NValue(180082260)
	}
}

setmetatable(CfgLoginBGTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgLoginBGTable]")
	end
})

local defaultMetaTable = {
	__index = {
		IsLock = 0,
		LockDescribtion = "",
		PrefabUrl = ""
	}
}

for i, data in pairs(CfgLoginBGTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgLoginBGTable
