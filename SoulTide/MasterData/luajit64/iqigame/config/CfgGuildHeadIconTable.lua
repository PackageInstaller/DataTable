-- chunkname: @IQIGame\\Config\\CfgGuildHeadIconTable.lua

local CfgGuildHeadIconTable = {
	{
		IsLockShow = true,
		Sort = 1,
		Url = "/GuildPortrait/Portrait_Guild_01.png",
		Id = 1,
		Default = true,
		Name = getI18NValue(180500162),
		Desc = getI18NValue(180500161)
	},
	{
		IsLockShow = true,
		Sort = 2,
		Url = "/GuildPortrait/Portrait_Guild_02.png",
		Id = 2,
		Name = getI18NValue(180500164),
		Desc = getI18NValue(180500163)
	},
	{
		IsLockShow = true,
		Sort = 3,
		Url = "/GuildPortrait/Portrait_Guild_03.png",
		Id = 3,
		Name = getI18NValue(180521173),
		Desc = getI18NValue(180521172)
	},
	{
		IsLockShow = true,
		Sort = 4,
		Url = "/GuildPortrait/Portrait_Guild_04.png",
		Id = 4,
		Name = getI18NValue(180521175),
		Desc = getI18NValue(180521174)
	},
	{
		IsLockShow = true,
		Sort = 5,
		Url = "/GuildPortrait/Portrait_Guild_05.png",
		Id = 5,
		Name = getI18NValue(180521177),
		Desc = getI18NValue(180521176)
	},
	{
		IsLockShow = true,
		IsLock = 1,
		Url = "/GuildPortrait/Portrait_Guild_06.png",
		Sort = 6,
		Id = 6,
		Name = getI18NValue(180521179),
		Desc = getI18NValue(180521178),
		NeedBuildingLv = {
			1001,
			2
		},
		LockDescribtion = getI18NValue(180538542)
	},
	{
		IsLockShow = true,
		IsLock = 1,
		Url = "/GuildPortrait/Portrait_Guild_07.png",
		Sort = 7,
		Id = 7,
		Name = getI18NValue(180521181),
		Desc = getI18NValue(180521180),
		NeedBuildingLv = {
			1001,
			3
		},
		LockDescribtion = getI18NValue(180533723)
	},
	{
		IsLockShow = true,
		IsLock = 1,
		Url = "/GuildPortrait/Portrait_Guild_08.png",
		Sort = 8,
		Id = 8,
		Name = getI18NValue(180521183),
		Desc = getI18NValue(180521182),
		NeedBuildingLv = {
			1001,
			3
		},
		LockDescribtion = getI18NValue(180533724)
	},
	{
		IsLockShow = true,
		IsLock = 1,
		Url = "/GuildPortrait/Portrait_Guild_09.png",
		Sort = 9,
		Id = 9,
		Name = getI18NValue(180521185),
		Desc = getI18NValue(180521184),
		NeedBuildingLv = {
			1001,
			4
		},
		LockDescribtion = getI18NValue(180533725)
	},
	{
		IsLockShow = true,
		IsLock = 1,
		Url = "/GuildPortrait/Portrait_Guild_10.png",
		Sort = 10,
		Id = 10,
		Name = getI18NValue(180521187),
		Desc = getI18NValue(180521186),
		NeedBuildingLv = {
			1001,
			4
		},
		LockDescribtion = getI18NValue(180533726)
	},
	{
		IsLockShow = true,
		IsLock = 1,
		Url = "/GuildPortrait/Portrait_Guild_11.png",
		Sort = 11,
		Id = 11,
		Name = getI18NValue(180533517),
		Desc = getI18NValue(180533516),
		NeedBuildingLv = {
			1001,
			4
		},
		LockDescribtion = getI18NValue(180533727)
	},
	{
		IsLockShow = true,
		IsLock = 1,
		Url = "/GuildPortrait/Portrait_Guild_12.png",
		Sort = 12,
		Id = 12,
		Name = getI18NValue(180533519),
		Desc = getI18NValue(180533518),
		NeedBuildingLv = {
			1001,
			5
		},
		LockDescribtion = getI18NValue(180533728)
	},
	{
		IsLockShow = true,
		IsLock = 1,
		Url = "/GuildPortrait/Portrait_Guild_13.png",
		Sort = 13,
		Id = 13,
		Name = getI18NValue(180533521),
		Desc = getI18NValue(180533520),
		NeedBuildingLv = {
			1001,
			5
		},
		LockDescribtion = getI18NValue(180533729)
	},
	{
		IsLockShow = true,
		IsLock = 1,
		Url = "/GuildPortrait/Portrait_Guild_14.png",
		Sort = 14,
		Id = 14,
		Name = getI18NValue(180533523),
		Desc = getI18NValue(180533522),
		NeedBuildingLv = {
			1001,
			5
		},
		LockDescribtion = getI18NValue(180533730)
	}
}

setmetatable(CfgGuildHeadIconTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgGuildHeadIconTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Default = false,
		LimitiedDuration = 0,
		Url = "",
		IsLockShow = false,
		IsLock = 0,
		LockDescribtion = "",
		Sort = 0,
		Name = "",
		Desc = "",
		NeedBuildingLv = {}
	}
}

for i, data in pairs(CfgGuildHeadIconTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgGuildHeadIconTable
