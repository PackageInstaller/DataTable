-- chunkname: @IQIGame\\Module\\Battle\\BattleData\\BattleTroopData.lua

local BattleUnitDataBase = require("IQIGame.Module.Battle.BattleData.BattleUnitDataBase")
local BattleTroopData = Clone(BattleUnitDataBase)

function BattleTroopData.New(battleTroopPOD)
	local obj = Clone(BattleTroopData)

	obj:__Init(battleTroopPOD)

	return obj
end

function BattleTroopData:__Init(battleTroopPOD)
	self.isTroopData = true
	self.joinBattle = true

	self:__InitUnitDataByPOD(battleTroopPOD)
end

function BattleTroopData:Dispose()
	return
end

return BattleTroopData
