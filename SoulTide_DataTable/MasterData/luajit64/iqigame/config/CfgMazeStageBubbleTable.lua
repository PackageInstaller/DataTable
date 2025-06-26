-- chunkname: @IQIGame\\Config\\CfgMazeStageBubbleTable.lua

local CfgMazeStageBubbleTable = {
	{
		Id = 1,
		Text = getI18NValue(180087668)
	},
	[4000001] = {
		Id = 4000001,
		Text = getI18NValue(180087669)
	},
	[4000002] = {
		Id = 4000002,
		Text = getI18NValue(180087670)
	},
	[4000003] = {
		Id = 4000003,
		Text = getI18NValue(180087671)
	},
	[4000004] = {
		Id = 4000004,
		Text = getI18NValue(180087672)
	},
	[4000005] = {
		Id = 4000005,
		Text = getI18NValue(180087673)
	},
	[4000006] = {
		Id = 4000006,
		Text = getI18NValue(180087674)
	},
	[4000007] = {
		Id = 4000007,
		Text = getI18NValue(180087675)
	},
	[4000008] = {
		Id = 4000008,
		Text = getI18NValue(180087676)
	},
	[4000009] = {
		Id = 4000009
	},
	[4000010] = {
		Id = 4000010
	}
}

setmetatable(CfgMazeStageBubbleTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgMazeStageBubbleTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Text = ""
	}
}

for i, data in pairs(CfgMazeStageBubbleTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgMazeStageBubbleTable
