-- chunkname: @IQIGame\\Config\\CfgPushNoticeTable.lua

local CfgPushNoticeTable = {
	[1000000] = {
		Id = 1000000,
		Title = getI18NValue(180010284),
		Text = getI18NValue(180010285)
	},
	[1000001] = {
		Id = 1000001,
		Title = getI18NValue(180010286),
		Text = getI18NValue(180010287)
	},
	[1000002] = {
		Id = 1000002,
		Title = getI18NValue(180010288),
		Text = getI18NValue(180010289)
	},
	[1000003] = {
		Id = 1000003,
		Title = getI18NValue(180010290),
		Text = getI18NValue(180010291)
	},
	[1000004] = {
		Id = 1000004,
		Title = getI18NValue(180010292),
		Text = getI18NValue(180010293)
	},
	[1000005] = {
		Id = 1000005,
		Title = getI18NValue(180010294),
		Text = getI18NValue(180010295)
	},
	[1000006] = {
		Id = 1000006,
		Title = getI18NValue(180010296),
		Text = getI18NValue(180010297)
	},
	[1000007] = {
		Id = 1000007,
		Title = getI18NValue(180010298),
		Text = getI18NValue(180010299)
	},
	[1000008] = {
		Id = 1000008,
		Title = getI18NValue(180010300),
		Text = getI18NValue(180010301)
	}
}

setmetatable(CfgPushNoticeTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgPushNoticeTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Text = "",
		Title = "",
		Type = 0
	}
}

for i, data in pairs(CfgPushNoticeTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgPushNoticeTable
