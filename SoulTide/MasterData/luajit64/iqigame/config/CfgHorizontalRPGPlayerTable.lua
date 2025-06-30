-- chunkname: @IQIGame\\Config\\CfgHorizontalRPGPlayerTable.lua

local CfgHorizontalRPGPlayerTable = {
	{
		JumpHight = 200,
		Gravity = 35,
		Bullet = 1,
		FlyGravity = 5,
		IsJump = true,
		JumpNum = 1,
		JumpMonster = 120,
		Drag = 35,
		Element = 874300,
		IsAttack = true,
		Id = 1,
		MoveDistance = 150
	}
}

setmetatable(CfgHorizontalRPGPlayerTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgHorizontalRPGPlayerTable]")
	end
})

local defaultMetaTable = {
	__index = {
		JumpHight = 0,
		FlyGravity = 0,
		Bullet = 0,
		JumpNum = 0,
		IsGlide = false,
		IsJump = false,
		JumpMonster = 0,
		Drag = 0,
		Gravity = 0,
		Element = 0,
		IsAttack = false,
		MoveDistance = 0
	}
}

for i, data in pairs(CfgHorizontalRPGPlayerTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgHorizontalRPGPlayerTable
