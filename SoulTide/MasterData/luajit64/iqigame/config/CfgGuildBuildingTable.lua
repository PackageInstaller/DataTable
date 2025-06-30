-- chunkname: @IQIGame\\Config\\CfgGuildBuildingTable.lua

local CfgGuildBuildingTable = {
	[1001] = {
		Sort = 1,
		Url = "/Guild/GuildDevelopUI/GuildDevelop_Icon_01.png",
		Id = 1001,
		IsShow = true,
		BuildingType = 1,
		Name = getI18NValue(180500110)
	},
	[1002] = {
		Sort = 2,
		Url = "/Guild/GuildDevelopUI/GuildDevelop_Icon_02.png",
		Id = 1002,
		IsShow = true,
		BuildingType = 1,
		Name = getI18NValue(180500111)
	},
	[1003] = {
		Sort = 3,
		Url = "/Guild/GuildDevelopUI/GuildDevelop_Icon_03.png",
		Id = 1003,
		IsShow = true,
		BuildingType = 1,
		Name = getI18NValue(180500112)
	},
	[2001] = {
		Sort = 1,
		Url = "/Guild/GuildDevelopUI/GuildDevelop_Icon_04.png",
		Id = 2001,
		IsShow = true,
		BuildingType = 2,
		Name = getI18NValue(180825932)
	},
	[2002] = {
		Sort = 2,
		Url = "/Guild/GuildDevelopUI/GuildDevelop_Icon_05.png",
		Id = 2002,
		IsShow = true,
		BuildingType = 2,
		Name = getI18NValue(180825933)
	},
	[2003] = {
		Sort = 3,
		Url = "/Guild/GuildDevelopUI/GuildDevelop_Icon_06.png",
		Id = 2003,
		IsShow = true,
		BuildingType = 2,
		Name = getI18NValue(180825934)
	},
	[2004] = {
		Sort = 4,
		Url = "/Guild/GuildDevelopUI/GuildDevelop_Icon_07.png",
		Id = 2004,
		IsShow = true,
		BuildingType = 2,
		Name = getI18NValue(180825935)
	}
}

setmetatable(CfgGuildBuildingTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgGuildBuildingTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Sort = 0,
		Name = "",
		Url = "",
		IsShow = false,
		BuildingType = 0
	}
}

for i, data in pairs(CfgGuildBuildingTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgGuildBuildingTable
