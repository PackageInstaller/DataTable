-- chunkname: @IQIGame\\Config\\CfgGuildAvatarFrameTable.lua

local CfgGuildAvatarFrameTable = {
	{
		IsLockShow = true,
		Sort = 101,
		Url = "/GuildAvatarFrame/AvatarFrame_Guild_01.png",
		Id = 1,
		Default = true,
		Name = getI18NValue(180500107),
		Desc = getI18NValue(180500106)
	},
	{
		IsLockShow = true,
		IsLock = true,
		Url = "/GuildAvatarFrame/AvatarFrame_Guild_02.png",
		Sort = 102,
		Id = 2,
		Name = getI18NValue(180500109),
		Desc = getI18NValue(180500108),
		NeedBuildingLv = {
			1001,
			2
		},
		LockDesc = getI18NValue(180538540)
	},
	{
		IsLockShow = true,
		IsLock = true,
		Url = "/GuildAvatarFrame/AvatarFrame_Guild_03.png",
		Sort = 103,
		Id = 3,
		Name = getI18NValue(180521157),
		Desc = getI18NValue(180521156),
		NeedBuildingLv = {
			1001,
			3
		},
		LockDesc = getI18NValue(180538541)
	},
	{
		IsLockShow = true,
		IsLock = true,
		Url = "/GuildAvatarFrame/AvatarFrame_Guild_04.png",
		Sort = 104,
		Id = 4,
		Name = getI18NValue(180521159),
		Desc = getI18NValue(180521158),
		NeedBuildingLv = {
			1001,
			4
		},
		LockDesc = getI18NValue(180533509)
	},
	{
		IsLockShow = true,
		IsLock = true,
		Url = "/GuildAvatarFrame/AvatarFrame_Guild_05.png",
		Sort = 105,
		Id = 5,
		Name = getI18NValue(180521161),
		Desc = getI18NValue(180521160),
		NeedBuildingLv = {
			1001,
			5
		},
		LockDesc = getI18NValue(180533510)
	}
}

setmetatable(CfgGuildAvatarFrameTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgGuildAvatarFrameTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Default = false,
		IsLockShow = false,
		Url = "",
		LockDesc = "",
		LimitiedDuration = 0,
		IsLock = false,
		Sort = 0,
		Name = "",
		Desc = "",
		NeedBuildingLv = {}
	}
}

for i, data in pairs(CfgGuildAvatarFrameTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgGuildAvatarFrameTable
