-- chunkname: @IQIGame\\Config\\CfgHelpTipsTable.lua

local CfgHelpTipsTable = {
	[1000000] = {
		Id = 1000000,
		Text = getI18NValue(180023135)
	},
	[1010000] = {
		Id = 1010000,
		Text = getI18NValue(180023136)
	},
	[2000000] = {
		Id = 2000000,
		Text = getI18NValue(180023137)
	},
	[3000000] = {
		Id = 3000000,
		Text = getI18NValue(180028300)
	},
	[3000001] = {
		Id = 3000001,
		Text = getI18NValue(180028301)
	},
	[3000002] = {
		Id = 3000002,
		Text = getI18NValue(180028302)
	},
	[3000003] = {
		Id = 3000003,
		Text = getI18NValue(180028303)
	}
}

setmetatable(CfgHelpTipsTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgHelpTipsTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Text = ""
	}
}

for i, data in pairs(CfgHelpTipsTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgHelpTipsTable
