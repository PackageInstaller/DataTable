-- chunkname: @IQIGame\\Config\\CfgEventTable.lua

local CfgEventTable = {
	{
		Quality = 1,
		Count = 1,
		StarLevel = 1,
		Id = 1,
		Name = getI18NValue(180078671),
		Describe = getI18NValue(180078669),
		RewardDescribe = getI18NValue(180078670)
	},
	[51420100] = {
		Quality = 2,
		Count = 1,
		StarLevel = 2,
		Id = 51420100,
		Name = getI18NValue(180078674),
		Describe = getI18NValue(180078672),
		RewardDescribe = getI18NValue(180078673)
	},
	[51420200] = {
		Quality = 2,
		Count = 1,
		StarLevel = 2,
		Id = 51420200,
		Name = getI18NValue(180078677),
		Describe = getI18NValue(180078675),
		RewardDescribe = getI18NValue(180078676)
	},
	[51420300] = {
		Quality = 2,
		Count = 1,
		StarLevel = 2,
		Id = 51420300,
		Name = getI18NValue(180078680),
		Describe = getI18NValue(180078678),
		RewardDescribe = getI18NValue(180078679)
	},
	[51420500] = {
		Quality = 2,
		Count = 1,
		StarLevel = 2,
		Id = 51420500,
		Name = getI18NValue(180078683),
		Describe = getI18NValue(180078681),
		RewardDescribe = getI18NValue(180078682)
	}
}

setmetatable(CfgEventTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgEventTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Quality = 0,
		Describe = "",
		StarLevel = 0,
		RewardDescribe = "",
		EventIcon = "",
		Name = "",
		Count = 0,
		Type = 0,
		Reward = {},
		EventTaG = {}
	}
}

for i, data in pairs(CfgEventTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgEventTable
