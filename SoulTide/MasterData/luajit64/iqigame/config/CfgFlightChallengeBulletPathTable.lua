-- chunkname: @IQIGame\\Config\\CfgFlightChallengeBulletPathTable.lua

local CfgFlightChallengeBulletPathTable = {
	{
		Id = 1,
		BulletNum = 3,
		Angle = 20,
		BulletSpeed = 10
	},
	{
		Id = 2,
		BulletNum = 3,
		Angle = 20,
		BulletSpeed = 10
	},
	{
		Id = 3,
		BulletNum = 3,
		Angle = 20,
		BulletSpeed = 10
	},
	[101] = {
		Id = 101,
		BulletNum = 36,
		Angle = 10,
		BulletSpeed = 10
	},
	[102] = {
		Id = 102,
		BulletNum = 7,
		BulletSpeed = 10
	},
	[103] = {
		Id = 103,
		BulletNum = 7,
		Angle = 8,
		BulletSpeed = 10
	},
	[201] = {
		Angle = 15,
		BulletNum = 5,
		BulletSpeed = 8,
		BulletEffect = 1,
		Id = 201
	},
	[202] = {
		Angle = 12,
		BulletNum = 3,
		BulletSpeed = 8,
		BulletEffect = 2,
		Id = 202
	},
	[203] = {
		Angle = 9,
		BulletNum = 4,
		BulletSpeed = 8,
		BulletEffect = 3,
		Id = 203
	},
	[204] = {
		Angle = 12,
		BulletNum = 3,
		BulletSpeed = 8,
		BulletEffect = 4,
		Id = 204
	},
	[205] = {
		Angle = 12,
		BulletNum = 3,
		BulletSpeed = 8,
		BulletEffect = 5,
		Id = 205
	},
	[206] = {
		Angle = 15,
		BulletNum = 4,
		BulletSpeed = 8,
		BulletEffect = 6,
		Id = 206
	},
	[301] = {
		Angle = 12,
		BulletNum = 3,
		BulletSpeed = 8,
		BulletEffect = 7,
		Id = 301
	},
	[302] = {
		Angle = 12,
		BulletNum = 3,
		BulletSpeed = 8,
		BulletEffect = 8,
		Id = 302
	},
	[303] = {
		Angle = 12,
		BulletNum = 3,
		BulletSpeed = 8,
		BulletEffect = 9,
		Id = 303
	},
	[311] = {
		Angle = 12,
		BulletNum = 2,
		BulletSpeed = 10,
		BulletEffect = 10,
		Id = 311
	},
	[312] = {
		Angle = 12,
		BulletNum = 2,
		BulletSpeed = 10,
		BulletEffect = 11,
		Id = 312
	},
	[313] = {
		Angle = 12,
		BulletNum = 2,
		BulletSpeed = 10,
		BulletEffect = 12,
		Id = 313
	},
	[401] = {
		Angle = 12,
		BulletNum = 5,
		BulletSpeed = 10,
		BulletEffect = 10,
		Id = 401
	},
	[402] = {
		Angle = 12,
		BulletNum = 5,
		BulletSpeed = 10,
		BulletEffect = 11,
		Id = 402
	},
	[403] = {
		Angle = 12,
		BulletNum = 5,
		BulletSpeed = 10,
		BulletEffect = 9,
		Id = 403
	},
	[411] = {
		Angle = 12,
		BulletNum = 4,
		BulletSpeed = 7,
		BulletEffect = 7,
		Id = 411
	},
	[412] = {
		Angle = 12,
		BulletNum = 4,
		BulletSpeed = 10,
		BulletEffect = 5,
		Id = 412
	},
	[413] = {
		Angle = 12,
		BulletNum = 6,
		BulletSpeed = 10,
		BulletEffect = 12,
		Id = 413
	},
	[501] = {
		Angle = 45,
		BulletNum = 8,
		BulletSpeed = 18,
		BulletEffect = 1,
		Id = 501
	},
	[502] = {
		Angle = 36,
		BulletNum = 10,
		BulletSpeed = 16,
		BulletEffect = 4,
		Id = 502
	},
	[503] = {
		Angle = 24,
		BulletNum = 15,
		BulletSpeed = 14,
		BulletEffect = 5,
		Id = 503
	},
	[504] = {
		Angle = 15,
		BulletNum = 24,
		BulletSpeed = 12,
		BulletEffect = 11,
		Id = 504
	},
	[505] = {
		Angle = 10,
		BulletNum = 36,
		BulletSpeed = 10,
		BulletEffect = 12,
		Id = 505
	}
}

setmetatable(CfgFlightChallengeBulletPathTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgFlightChallengeBulletPathTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Angle = 0,
		BulletNum = 0,
		BulletSpeed = 0,
		BulletEffect = 0
	}
}

for i, data in pairs(CfgFlightChallengeBulletPathTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgFlightChallengeBulletPathTable
