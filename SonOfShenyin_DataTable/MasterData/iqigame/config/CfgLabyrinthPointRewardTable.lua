-- chunkname: @IQIGame\\Config\\CfgLabyrinthPointRewardTable.lua

local CfgLabyrinthPointRewardTable = {
	[40050000] = {
		Id = 40050000,
		PointMail = 40000001,
		PointNum = 10000
	},
	[40050001] = {
		Id = 40050001,
		PointMail = 40000002,
		PointNum = 20000
	},
	[40050002] = {
		Id = 40050002,
		PointMail = 40000003,
		PointNum = 30000
	},
	[40050003] = {
		Id = 40050003,
		PointMail = 40000004,
		PointNum = 40000
	}
}

setmetatable(CfgLabyrinthPointRewardTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgLabyrinthPointRewardTable]")
	end
})

local defaultMetaTable = {
	__index = {
		PointNum = 0,
		PointMail = 0
	}
}

for i, data in pairs(CfgLabyrinthPointRewardTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgLabyrinthPointRewardTable
