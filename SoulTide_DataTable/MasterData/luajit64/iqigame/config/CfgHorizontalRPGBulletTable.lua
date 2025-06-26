-- chunkname: @IQIGame\\Config\\CfgHorizontalRPGBulletTable.lua

local CfgHorizontalRPGBulletTable = {
	{
		Id = 1,
		ShootCd = 1,
		ShootSpeed = 120,
		ShootBulletNum = 1
	},
	{
		Id = 2,
		ShootCd = 1,
		ShootSpeed = 160,
		ShootBulletNum = 1
	},
	[101] = {
		ShootCd = 1,
		ShootBulletNum = 1,
		ShootSpeed = 100,
		IsLoop = true,
		Id = 101
	},
	[102] = {
		ShootCd = 1,
		ShootBulletNum = 3,
		ShootSpeed = 100,
		IsLoop = true,
		Id = 102,
		Angle = 90,
		Shoot = 20
	},
	[103] = {
		ShootCd = 1,
		Angle = 90,
		ShootSpeed = 100,
		ShootBulletNum = 1,
		Id = 103
	},
	[8822] = {
		ShootCd = 4,
		ShootBulletNum = 1,
		ShootSpeed = 100,
		IsLoop = true,
		Id = 8822
	},
	[8823] = {
		ShootCd = 4,
		ShootBulletNum = 1,
		ShootSpeed = 100,
		IsLoop = true,
		Id = 8823,
		Angle = 180
	},
	[8824] = {
		ShootCd = 4,
		ShootBulletNum = 1,
		ShootSpeed = 100,
		IsLoop = true,
		Id = 8824,
		Angle = 90
	},
	[8825] = {
		ShootCd = 4,
		ShootBulletNum = 1,
		ShootSpeed = 100,
		IsLoop = true,
		Id = 8825,
		Angle = 90,
		Shoot = 180
	},
	[8826] = {
		ShootCd = 4,
		ShootBulletNum = 1,
		ShootSpeed = 100,
		IsLoop = true,
		Id = 8826,
		Angle = 45
	},
	[8827] = {
		ShootCd = 4,
		ShootBulletNum = 1,
		ShootSpeed = 100,
		IsLoop = true,
		Id = 8827,
		Angle = 135
	},
	[8911] = {
		ShootCd = 3,
		ShootBulletNum = 1,
		ShootSpeed = 100,
		IsLoop = true,
		Id = 8911,
		Angle = 90
	},
	[8912] = {
		ShootCd = 4,
		ShootBulletNum = 1,
		ShootSpeed = 100,
		IsLoop = true,
		Id = 8912,
		Angle = 90
	},
	[8913] = {
		ShootCd = 5,
		ShootBulletNum = 1,
		ShootSpeed = 100,
		IsLoop = true,
		Id = 8913,
		Angle = 90
	}
}

setmetatable(CfgHorizontalRPGBulletTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgHorizontalRPGBulletTable]")
	end
})

local defaultMetaTable = {
	__index = {
		ShootCd = 0,
		Angle = 0,
		ShootSpeed = 0,
		IsLoop = false,
		Shoot = 0,
		ShootBulletNum = 0
	}
}

for i, data in pairs(CfgHorizontalRPGBulletTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgHorizontalRPGBulletTable
