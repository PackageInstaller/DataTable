-- chunkname: @IQIGame\\Module\\Battle\\BattleData\\BattleTileData.lua

local BattlePODData = require("IQIGame.Module.Battle.BattleData.BattlePODData")
local BattleTileData = Clone(BattlePODData)

BattleTileData.BattleTileData = 0
BattleTileData.FightBattleUnitID = 0

function BattleTileData.New(battleTilePOD)
	local obj = Clone(BattleTileData)

	obj:__Init(battleTilePOD)

	return obj
end

function BattleTileData:__Init(battleTilePOD)
	self:__InitPODData(battleTilePOD)

	self.tileIndex = BattleModule.BattleTilePosStoC(self.PODData.TroopType, self.PODData.BattlePos)
end

function BattleTileData:UpdateFightBattleUnitID(battleUnitID)
	self.FightBattleUnitID = battleUnitID
end

function BattleTileData:Dispose()
	return
end

return BattleTileData
