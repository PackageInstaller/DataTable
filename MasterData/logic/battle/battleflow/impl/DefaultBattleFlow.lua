-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/impl/DefaultBattleFlow.lua

module("logic.battle.battleflow.impl.DefaultBattleFlow", package.seeall)

local DefaultBattleFlow = class("DefaultBattleFlow", CoreBattleFlow)

function DefaultBattleFlow:handleInit()
	self._dungeonCode = 20011001
end

function DefaultBattleFlow:buildBattleFieldInfo(battleInfoNO)
	return BattleNOConverter:convert(battleInfoNO)
end

function DefaultBattleFlow:createCalculateWork()
	return WorkCalculate.New()
end

function DefaultBattleFlow:createExitBattleWork()
	return WorkBattleExitScene.New()
end

function DefaultBattleFlow:isEnableCampAdjustment()
	return true
end

function DefaultBattleFlow:handleExitBattleFinish()
	return
end

function DefaultBattleFlow:fillAvailableHeroMOList(availableHeroMOList)
	table.insertto(availableHeroMOList, HeroDepotModel.instance:getHeroDepotData():getHeroDataList())
end

function DefaultBattleFlow:getEntityCountLimitOfCamp(campId)
	local dungeonCO = BattleConfig.instance:getBattleLevelCO(self._dungeonCode)

	return dungeonCO.maxPerson
end

function DefaultBattleFlow:fillBornUnionIndexListOfCamp(campId, bornUnionIndexList, bornDirectionList)
	local dungeonCO = BattleConfig.instance:getBattleLevelCO(self._dungeonCode)
	local bornCells = dungeonCO.bornPosList

	for _, bornCell in ipairs(bornCells) do
		table.insert(bornDirectionList, bornCell.direction)
		table.insert(bornUnionIndexList, BoardIndexConverter.coordinatesToUnionIndex(bornCell.x, bornCell.y))
	end
end

function DefaultBattleFlow:getMaxRoundCount()
	local dungeonCO = BattleConfig.instance:getBattleLevelCO(self._dungeonCode)

	return dungeonCO.maxRound
end

return DefaultBattleFlow
