-- chunkname: @IQIGame\\Config\\CfgWelcomeNewcomersGlobalTable.lua

local CfgWelcomeNewcomersGlobalTable = {
	{
		NewPlayerMail = 35010015,
		Level = 30,
		NewPlayerGiftMail = 35010017,
		Id = 1,
		OldPlayerMail = 35010016,
		Name = getI18NValue(180267990),
		Desc1 = getI18NValue(180267989),
		Desc2 = getI18NValue(180267988),
		InvitedReward = {
			2,
			200,
			80005,
			1
		},
		NewPlayerReward = {
			2,
			800
		}
	}
}

setmetatable(CfgWelcomeNewcomersGlobalTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgWelcomeNewcomersGlobalTable]")
	end
})

local defaultMetaTable = {
	__index = {
		NewPlayerMail = 0,
		Desc1 = "",
		Desc2 = "",
		Name = "",
		NewPlayerGiftMail = 0,
		Level = 0,
		OldPlayerMail = 0,
		InvitedReward = {},
		NewPlayerReward = {}
	}
}

for i, data in pairs(CfgWelcomeNewcomersGlobalTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgWelcomeNewcomersGlobalTable
