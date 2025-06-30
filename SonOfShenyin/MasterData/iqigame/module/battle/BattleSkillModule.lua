-- chunkname: @IQIGame\\Module\\Battle\\BattleSkillModule.lua

local BattleCastSkillComponent = require("IQIGame/Module/Battle/Skill/BattleCastSkillComponent")

BattleSkillModule = {
	__SkillTileRelativeCenterPos = 44,
	AutoFightDefaultTargetBattlePos = -1
}

function BattleSkillModule.CasterSkills(castSkills, callback)
	local castSkillComponent = BattleCastSkillComponent.New(castSkills)

	castSkillComponent:Play(function()
		castSkillComponent:Dispose()

		castSkillComponent = nil

		if callback ~= nil then
			callback()
		end
	end)
end

function BattleSkillModule.__GetSkillTargetTiles(battleSkillData, mainTileIndex, horizontalSize, verticalSize)
	local results = {}

	table.insert(results, mainTileIndex)

	local positionParam = battleSkillData.searchTargetData.PositionParam

	if #positionParam == 0 then
		return results
	end

	local tilePosOffset = math.modf(mainTileIndex / BattleConstant.BattleTilePosTroopTypeOffset)
	local index = math.fmod(mainTileIndex, BattleConstant.BattleTilePosTroopTypeOffset)
	local horizontalIndex, verticalIndex = BattleSkillModule.__GetTileColAndRow(index, horizontalSize, verticalSize)
	local centerCol = math.modf(BattleSkillModule.__SkillTileRelativeCenterPos / 10)
	local centerRow = math.fmod(BattleSkillModule.__SkillTileRelativeCenterPos, 10)

	ForArray(positionParam, function(_index, value)
		local _value = value

		if _value == BattleSkillModule.__SkillTileRelativeCenterPos then
			return
		end

		local tileIndex = BattleSkillModule.__ConvertRelativeTilePos(_value, tilePosOffset, horizontalIndex, verticalIndex, centerCol, centerRow, horizontalSize, verticalSize)

		if tileIndex < 0 then
			return
		end

		table.insert(results, tileIndex)
	end)

	return results
end

function BattleSkillModule.ConvertRelativeTilePos(mainTileIndex, relativePos)
	local horizontalSize = BattleModule.battleTileHorizontalSize
	local verticalSize = BattleModule.battleTileVerticalSize
	local tilePosOffset = math.modf(mainTileIndex / BattleConstant.BattleTilePosTroopTypeOffset)
	local index = math.fmod(mainTileIndex, BattleConstant.BattleTilePosTroopTypeOffset)
	local horizontalIndex, verticalIndex = BattleSkillModule.__GetTileColAndRow(index, horizontalSize, verticalSize)
	local centerCol = math.modf(BattleSkillModule.__SkillTileRelativeCenterPos / 10)
	local centerRow = math.fmod(BattleSkillModule.__SkillTileRelativeCenterPos, 10)
	local tileIndex = BattleSkillModule.__ConvertRelativeTilePos(relativePos, tilePosOffset, horizontalIndex, verticalIndex, centerCol, centerRow, horizontalSize, verticalSize)

	return tileIndex
end

function BattleSkillModule.__ConvertRelativeTilePos(relativePos, tilePosOffset, horizontalIndex, verticalIndex, centerCol, centerRow, horizontalSize, verticalSize)
	local tempCol = math.modf(relativePos / 10)
	local tempRow = math.fmod(relativePos, 10)
	local offsetCol = centerCol - tempCol
	local offsetRow = centerRow - tempRow
	local col = horizontalIndex - offsetCol
	local row = verticalIndex - offsetRow

	if col < 1 or horizontalSize < col or row < 1 or verticalSize < row then
		return -1
	end

	local tileIndex = tilePosOffset * BattleConstant.BattleTilePosTroopTypeOffset + (col - 1) * verticalSize + row

	return tileIndex
end

function BattleSkillModule.GetBattleHitTilesBySkillPreviewData(battleUnitData, previewSkillData)
	local battleSkillData = battleUnitData:GetSkillData(previewSkillData.skillCid)
	local realTroopType = battleUnitData.troopType

	if battleSkillData:TargetIsSelf() then
		-- block empty
	elseif battleSkillData:TargetIsFriendly() then
		-- block empty
	elseif battleUnitData.troopType == BattleModule.attackBattleTroopType then
		realTroopType = BattleModule.defineBattleTroopType
	else
		realTroopType = BattleModule.attackBattleTroopType
	end

	local clientTilePos = BattleModule.BattleTilePosStoC(realTroopType, previewSkillData.anchorTilePos)

	return clientTilePos, BattleSkillModule.__GetSkillTargetTiles(battleSkillData, clientTilePos, BattleModule.battleTileHorizontalSize, BattleModule.battleTileVerticalSize)
end

function BattleSkillModule.GetBattleUnitCanCastSkill(battleUnitID)
	local battleUnitData = BattleModule.GetBattleUnitDataByUnitID(battleUnitID)
	local skillData = battleUnitData:GetSkillBySkillType(Constant.SkillType.TYPE_NORMAL)

	if skillData ~= nil then
		return skillData.skillCid, Constant.SkillType.TYPE_NORMAL
	end

	skillData = battleUnitData:GetSkillBySkillType(Constant.SkillType.TYPE_ULTIMATE)

	if skillData ~= nil then
		return skillData.skillCid, Constant.SkillType.TYPE_ULTIMATE
	end

	return 0
end

function BattleSkillModule.ShowSkillAreaWarning(battleUnitID, skillCid, callback)
	local battleUnitData = BattleModule.GetBattleUnitDataByUnitID(battleUnitID)

	if battleUnitData.troopType ~= BattleModule.defineBattleTroopType then
		if callback ~= nil then
			callback()
		end

		return
	end

	local anchorClientTilePos, targetTiles

	if battleUnitData.previewSkillData ~= nil and battleUnitData.previewSkillData.skillCid == skillCid then
		anchorClientTilePos, targetTiles = BattleSkillModule.GetBattleHitTilesBySkillPreviewData(battleUnitData, battleUnitData.previewSkillData)
	else
		targetTiles = BattleSkillModule.__GetSkillHitTiles(battleUnitID, skillCid)
		anchorClientTilePos = targetTiles[1]
	end

	EventDispatcher.Dispatch(EventID.ShowEnemyBattleSkillAreaWarning, battleUnitID, skillCid, anchorClientTilePos, targetTiles)
	BattleModule.AddCustomWaitSecondCondition(BattleApi:ShowSkillAreaWarningSecond(), function()
		EventDispatcher.Dispatch(EventID.HideEnemyBattleSkillAreaWarning)

		if callback ~= nil then
			callback()
		end
	end)
end

function BattleSkillModule.ShowManualChooseSkill(battleUnitID, skillCid)
	EventDispatcher.Dispatch(EventID.HideBattleSkillTargetRolePreview)
	BattleTeamActionModule.SendPreviewSkillOrder(skillCid)
end

function BattleSkillModule.__GetSkillHitTiles(battleUnitID, skillCid)
	local battleUnitData = BattleModule.GetBattleUnitDataByUnitID(battleUnitID)
	local battleSkillData = battleUnitData:GetSkillData(skillCid)
	local clientTilePos = BattleSkillModule.__GetSkillAnchorPoint(battleUnitData.troopType, battleUnitData.battlePos, battleSkillData)

	return BattleSkillModule.__GetSkillTargetTiles(battleSkillData, clientTilePos, BattleModule.battleTileHorizontalSize, BattleModule.battleTileVerticalSize)
end

function BattleSkillModule.GetSkillAnchorPointBySkillCid(battleUnitID, skillCid)
	local battleUnitData = BattleModule.GetBattleUnitDataByUnitID(battleUnitID)
	local battleSkillData = battleUnitData:GetSkillData(skillCid)

	return BattleSkillModule.__GetSkillAnchorPoint(battleUnitData.troopType, battleUnitData.battlePos, battleSkillData)
end

function BattleSkillModule.__GetSkillAnchorPoint(casterTroopType, casterTilePos, battleSkillData)
	if battleSkillData:TargetIsSelf() then
		return BattleModule.BattleTilePosStoC(casterTroopType, casterTilePos)
	end

	local inverted = false

	if battleSkillData.searchTargetData.PointSelectOrder == 2 then
		inverted = true
	end

	local anchorPointList = BattleSkillModule.__GetAlternateAnchorPointListByCasterTilePos_Horizontal(BattleModule.battleTileHorizontalSize, BattleModule.battleTileVerticalSize, inverted, casterTilePos)

	if battleSkillData:TargetIsFriendly() then
		local anchorTilePos = BattleSkillModule.__GetSkillAnchorPointWithFriendly(casterTroopType, anchorPointList, battleSkillData)

		return BattleModule.BattleTilePosStoC(casterTroopType, anchorTilePos)
	end

	local realTroopType = BattleModule.defineBattleTroopType

	if casterTroopType == BattleModule.defineBattleTroopType then
		realTroopType = BattleModule.attackBattleTroopType
	end

	local anchorTilePos = BattleSkillModule.__GetSkillAnchorPointWithEnemy(realTroopType, anchorPointList, battleSkillData)

	return BattleModule.BattleTilePosStoC(realTroopType, anchorTilePos)
end

function BattleSkillModule.__GetSkillAnchorPointWithFriendly(casterTroopType, anchorPointList, battleSkillData)
	local anchorPoint = 0

	ForArray(anchorPointList, function(_, _tilePos)
		local tmpTileIndex = BattleModule.BattleTilePosStoC(casterTroopType, _tilePos)
		local battleTileData = BattleModule.GetBattleTileDataByTileIndex(tmpTileIndex)

		if battleTileData.FightBattleUnitID == 0 then
			return
		end

		local battleUnitData = BattleModule.GetBattleUnitDataByUnitID(battleTileData.FightBattleUnitID)

		if battleUnitData:IsDead() then
			return
		end

		anchorPoint = _tilePos

		return true
	end)

	return anchorPoint
end

function BattleSkillModule.__GetSkillAnchorPointWithEnemy(casterTroopType, anchorPointList, battleSkillData)
	local anchorPoint = 0
	local firstStealthAnchorPoint = 0

	ForArray(anchorPointList, function(_, _tilePos)
		local tmpTileIndex = BattleModule.BattleTilePosStoC(casterTroopType, _tilePos)
		local battleTileData = BattleModule.GetBattleTileDataByTileIndex(tmpTileIndex)

		if battleTileData == nil then
			return
		end

		if battleTileData.FightBattleUnitID == 0 then
			return
		end

		local battleUnitData = BattleModule.GetBattleUnitDataByUnitID(battleTileData.FightBattleUnitID)

		if battleUnitData:IsDead() then
			return
		end

		local isTauntUnit = battleUnitData:IsInFightStatus(Constant.BattleFightStatus.TAUNT)

		if isTauntUnit then
			anchorPoint = _tilePos

			return true
		end

		local isStealth = battleUnitData:IsInFightStatus(Constant.BattleFightStatus.STEALTH)

		if isStealth and firstStealthAnchorPoint == 0 then
			firstStealthAnchorPoint = _tilePos

			return
		end

		if anchorPoint == 0 then
			anchorPoint = _tilePos
		end
	end)

	if anchorPoint == 0 and firstStealthAnchorPoint ~= 0 then
		anchorPoint = firstStealthAnchorPoint
	end

	return anchorPoint
end

function BattleSkillModule.__GetAlternateAnchorPointListByCasterTilePos_Horizontal(horizontalSize, verticalSize, inverted, casterTilePos)
	local result = {}
	local _, verticalIndex = BattleSkillModule.__GetTileColAndRow(casterTilePos, horizontalSize, verticalSize)
	local verticalIndexTable = {}

	if verticalIndex == 1 then
		verticalIndexTable = {
			1,
			2,
			3
		}
	elseif verticalIndex == 2 then
		verticalIndexTable = {
			2,
			1,
			3
		}
	elseif verticalIndex == 3 then
		verticalIndexTable = {
			3,
			2,
			1
		}
	end

	local begin = 1

	if inverted then
		begin = horizontalSize
	end

	local count = horizontalSize

	if inverted then
		count = 1
	end

	local step = 1

	if inverted then
		step = -1
	end

	ForArray(verticalIndexTable, function(_, _verticalIndex)
		ForArrayByCount(begin, count, step, function(_horizontalIndex)
			local value = _verticalIndex + (_horizontalIndex - 1) * verticalSize

			table.insert(result, value)
		end)
	end)

	return result
end

function BattleSkillModule.__GetAlternateAnchorPointListByCasterTilePos_Vertical(horizontalSize, verticalSize, casterTilePos)
	local result = {}
	local verticalIndex, _ = math.modf((casterTilePos - 1) / horizontalSize)
	local totalCount = horizontalSize * verticalSize
	local beginIndex = verticalIndex * verticalSize + 1

	ForArrayByCount(beginIndex, totalCount, 1, function(_tileIndex)
		table.insert(result, _tileIndex)
	end)
	ForArrayByCount(1, beginIndex - 1, 1, function(_tileIndex)
		table.insert(result, _tileIndex)
	end)

	return result
end

function BattleSkillModule.__GetTileColAndRow(tileIndex, horizontalSize, verticalSize)
	local index = tileIndex - 1
	local horizontalIndex = math.modf(index / verticalSize) + 1
	local verticalIndex = math.fmod(index, verticalSize) + 1

	return horizontalIndex, verticalIndex
end

function BattleSkillModule.CheckCanCastSkill(battleUnitID, skillCid)
	local battleUnitData = BattleModule.GetBattleUnitDataByUnitID(battleUnitID)

	return BattleSkillModule.CheckCanCastSkillWithBattleUnitData(battleUnitData, skillCid)
end

function BattleSkillModule.CheckCanCastSkillWithBattleUnitData(battleUnitData, skillCid)
	local battleSkillData = battleUnitData:GetSkillData(skillCid)

	return BattleSkillModule.CheckCanCastSkillWithData(battleUnitData, battleSkillData)
end

function BattleSkillModule.CheckCanCastSkillWithData(battleUnitData, battleSkillData)
	if battleSkillData.isSeal then
		return BattleConstant.CastSkillCheckResult.Sealed
	end

	local totalEnergy, _ = BattleSkillModule.GetCommonEnergyData()
	local apCost = 0

	if battleSkillData.apCost > 0 then
		apCost = battleSkillData.apCost
	end

	if totalEnergy < apCost then
		return BattleConstant.CastSkillCheckResult.EnergyNotEnough
	end

	local usedLimit = 999

	if battleSkillData.usedLimit > 0 then
		-- block empty
	end

	if usedLimit <= battleSkillData.usedCount then
		return BattleConstant.CastSkillCheckResult.UseCountLimit
	end

	if battleSkillData.coolDown > 0 then
		return BattleConstant.CastSkillCheckResult.InCD
	end

	if battleUnitData.commonSkillCD > 0 then
		return BattleConstant.CastSkillCheckResult.InCommonCD
	end

	log("Check Skill {0} AP:{1}/{2} CD:{3}&{4}", battleSkillData.skillCid, totalEnergy, battleSkillData.apCost, battleSkillData.coolDown, battleUnitData.commonSkillCD)

	return BattleConstant.CastSkillCheckResult.Legal
end

function BattleSkillModule.GetCommonEnergyData()
	local battleUnitData = BattleModule.GetBattleUnitDataByUnitID(BattleModule.attackTeamBattleUnitID)

	if battleUnitData == nil then
		return 0, 0
	end

	return battleUnitData:GetAPData()
end
