-- chunkname: @IQIGame\\Config\\CfgGalgameMonsterDialogTable.lua

local CfgGalgameMonsterDialogTable = {
	[1001] = {
		Id = 1001
	},
	[1002] = {
		Id = 1002
	},
	[1003] = {
		Id = 1003
	},
	[1004] = {
		Id = 1004
	}
}

setmetatable(CfgGalgameMonsterDialogTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgGalgameMonsterDialogTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Speaker = 0,
		JumpCondition = {
			{},
			{}
		},
		Contents = {},
		JumpID = {},
		NextDialogName = {},
		JumService = {
			{},
			{}
		}
	}
}

for i, data in pairs(CfgGalgameMonsterDialogTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgGalgameMonsterDialogTable
