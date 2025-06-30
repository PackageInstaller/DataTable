-- chunkname: @IQIGame\\Config\\CfgVotingOptionsTable.lua

local CfgVotingOptionsTable = {
	[10001] = {
		Group = 1,
		Id = 10001,
		Title = getI18NValue(180247374)
	},
	[10002] = {
		Group = 1,
		Id = 10002,
		Title = getI18NValue(180247375)
	},
	[10003] = {
		Group = 1,
		Id = 10003,
		Title = getI18NValue(180247376)
	},
	[10004] = {
		Group = 1,
		Id = 10004,
		Title = getI18NValue(180247377)
	},
	[10005] = {
		Group = 1,
		Id = 10005,
		Title = getI18NValue(180247378)
	},
	[10006] = {
		Group = 1,
		Id = 10006,
		Title = getI18NValue(180247379)
	},
	[10007] = {
		Group = 1,
		Id = 10007,
		Title = getI18NValue(180247380)
	},
	[10008] = {
		Group = 1,
		Id = 10008,
		Title = getI18NValue(180247381)
	},
	[10009] = {
		Group = 1,
		Id = 10009,
		Title = getI18NValue(180247382)
	},
	[10010] = {
		Group = 1,
		Id = 10010,
		Title = getI18NValue(180247383)
	}
}

setmetatable(CfgVotingOptionsTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgVotingOptionsTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Group = 0,
		Title = ""
	}
}

for i, data in pairs(CfgVotingOptionsTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgVotingOptionsTable
