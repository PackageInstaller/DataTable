-- chunkname: @IQIGame\\Config\\CfgTransferResourceTable.lua

local CfgTransferResourceTable = {
	[0] = {
		Id = 0,
		Path = "Assets/22_Render/TransferConfig/BattleSpineTransfer.asset"
	},
	{
		Group = "ChoosenOne",
		Overlay = true,
		PlayMode = 2,
		Id = 1,
		Operation = 1,
		Path = "Assets/22_Render/TransferConfig/BattleSpineTransfer.asset"
	},
	{
		Group = "AttackTarget",
		Overlay = true,
		PlayMode = 2,
		Id = 2,
		Operation = 1,
		Path = "Assets/22_Render/TransferConfig/BattleSpineTransfer.asset"
	},
	{
		Group = "FriendTarget",
		Overlay = true,
		PlayMode = 2,
		Id = 3,
		Operation = 1,
		Path = "Assets/22_Render/TransferConfig/BattleSpineTransfer.asset"
	},
	{
		Group = "SelfTarget",
		Overlay = true,
		PlayMode = 2,
		Id = 4,
		Operation = 1,
		Path = "Assets/22_Render/TransferConfig/BattleSpineTransfer.asset"
	},
	{
		Group = "Ghost",
		Overlay = true,
		PlayMode = 2,
		Id = 5,
		Path = "Assets/22_Render/TransferConfig/BattleSpineTransfer.asset"
	},
	{
		Group = "Frozen",
		Id = 6,
		PlayMode = 1,
		Operation = 1,
		SoleFlag = true,
		Weight = 200,
		Path = "Assets/22_Render/TransferConfig/BattleSpineTransfer.asset"
	},
	{
		Group = "Poison",
		Id = 7,
		PlayMode = 2,
		SoleFlag = true,
		Weight = 50,
		Path = "Assets/22_Render/TransferConfig/BattleSpineTransfer.asset"
	},
	{
		Group = "Stealth",
		Overlay = true,
		PlayMode = 2,
		Id = 8,
		Path = "Assets/22_Render/TransferConfig/BattleSpineTransfer.asset"
	},
	{
		Group = "Hit",
		Overlay = true,
		Id = 9,
		Path = "Assets/22_Render/TransferConfig/BattleSpineTransfer.asset"
	},
	{
		Group = "MoveStealth",
		Overlay = true,
		PlayMode = 2,
		Id = 10,
		Path = "Assets/22_Render/TransferConfig/BattleSpineTransfer.asset"
	}
}

setmetatable(CfgTransferResourceTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgTransferResourceTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Group = "",
		Overlay = false,
		PlayMode = 0,
		Weight = 0,
		SoleFlag = false,
		Operation = 0,
		Path = ""
	}
}

for i, data in pairs(CfgTransferResourceTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgTransferResourceTable
