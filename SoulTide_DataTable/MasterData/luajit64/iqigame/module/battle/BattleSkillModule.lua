-- chunkname: @IQIGame\\Module\\Battle\\BattleSkillModule.lua

BattleSkillModule = {}

function BattleSkillModule.GetSelectableUnits(cfgSkillData, selfUnitId)
	local cfgSkillDetailData = CfgSkillDetailTable[cfgSkillData.SkillDetail]
	local cfgSearchTargetData = CfgSearchTargetTable[cfgSkillDetailData.TargetTypeID]
	local troopType, units, canSelectArea, attackArea

	if cfgSearchTargetData.SelectCamp == 1 and cfgSearchTargetData.PositionType == 0 and not cfgSearchTargetData.IsGroup then
		troopType = Constant.BattleTroopType.Defend
		canSelectArea = Constant.BattlePositionArea.All
		units, canSelectArea = BattleModule.GetCanHitUnitsInArea(troopType, canSelectArea, cfgSearchTargetData)
		attackArea = Constant.SkillTargetArea.Single
	elseif cfgSearchTargetData.SelectCamp == 1 and cfgSearchTargetData.PositionType == 1 and not cfgSearchTargetData.IsGroup then
		troopType = Constant.BattleTroopType.Defend
		canSelectArea = Constant.BattlePositionArea.Front
		units, canSelectArea = BattleModule.GetCanHitUnitsInArea(troopType, canSelectArea, cfgSearchTargetData)
		attackArea = Constant.SkillTargetArea.Single
	elseif cfgSearchTargetData.SelectCamp == 1 and cfgSearchTargetData.PositionType == 2 and not cfgSearchTargetData.IsGroup then
		troopType = Constant.BattleTroopType.Defend
		canSelectArea = Constant.BattlePositionArea.Back
		units, canSelectArea = BattleModule.GetCanHitUnitsInArea(troopType, canSelectArea, cfgSearchTargetData)
		attackArea = Constant.SkillTargetArea.Single
	elseif cfgSearchTargetData.SelectCamp == 1 and cfgSearchTargetData.PositionType == 0 and cfgSearchTargetData.IsGroup then
		troopType = Constant.BattleTroopType.Defend
		canSelectArea = Constant.BattlePositionArea.All
		units, canSelectArea = BattleModule.GetCanHitUnitsInArea(troopType, canSelectArea, cfgSearchTargetData)
		attackArea = Constant.SkillTargetArea.All
	elseif cfgSearchTargetData.SelectCamp == 1 and cfgSearchTargetData.PositionType == 1 and cfgSearchTargetData.IsGroup then
		troopType = Constant.BattleTroopType.Defend
		canSelectArea = Constant.BattlePositionArea.Front
		units, canSelectArea = BattleModule.GetCanHitUnitsInArea(troopType, canSelectArea, cfgSearchTargetData)
		attackArea = Constant.SkillTargetArea.Row
	elseif cfgSearchTargetData.SelectCamp == 1 and cfgSearchTargetData.PositionType == 2 and cfgSearchTargetData.IsGroup then
		troopType = Constant.BattleTroopType.Defend
		canSelectArea = Constant.BattlePositionArea.Back
		units, canSelectArea = BattleModule.GetCanHitUnitsInArea(troopType, canSelectArea, cfgSearchTargetData)
		attackArea = Constant.SkillTargetArea.Row
	elseif cfgSearchTargetData.SelectCamp == 2 and cfgSearchTargetData.PositionType == 0 and not cfgSearchTargetData.IsGroup then
		troopType = Constant.BattleTroopType.Attack
		canSelectArea = Constant.BattlePositionArea.All
		units, canSelectArea = BattleModule.GetCanHitUnitsInArea(troopType, canSelectArea, cfgSearchTargetData)
		attackArea = Constant.SkillTargetArea.Single
	elseif cfgSearchTargetData.SelectCamp == 2 and cfgSearchTargetData.PositionType == 1 and not cfgSearchTargetData.IsGroup then
		troopType = Constant.BattleTroopType.Attack
		canSelectArea = Constant.BattlePositionArea.Front
		units, canSelectArea = BattleModule.GetCanHitUnitsInArea(troopType, canSelectArea, cfgSearchTargetData)
		attackArea = Constant.SkillTargetArea.Single
	elseif cfgSearchTargetData.SelectCamp == 2 and cfgSearchTargetData.PositionType == 2 and not cfgSearchTargetData.IsGroup then
		troopType = Constant.BattleTroopType.Attack
		canSelectArea = Constant.BattlePositionArea.Back
		units, canSelectArea = BattleModule.GetCanHitUnitsInArea(troopType, canSelectArea, cfgSearchTargetData)
		attackArea = Constant.SkillTargetArea.Single
	elseif cfgSearchTargetData.SelectCamp == 2 and cfgSearchTargetData.PositionType == 0 and cfgSearchTargetData.IsGroup then
		troopType = Constant.BattleTroopType.Attack
		canSelectArea = Constant.BattlePositionArea.All
		units, canSelectArea = BattleModule.GetCanHitUnitsInArea(troopType, canSelectArea, cfgSearchTargetData)
		attackArea = Constant.SkillTargetArea.All
	elseif cfgSearchTargetData.SelectCamp == 2 and cfgSearchTargetData.PositionType == 1 and cfgSearchTargetData.IsGroup then
		troopType = Constant.BattleTroopType.Attack
		canSelectArea = Constant.BattlePositionArea.Front
		units, canSelectArea = BattleModule.GetCanHitUnitsInArea(troopType, canSelectArea, cfgSearchTargetData)
		attackArea = Constant.SkillTargetArea.Row
	elseif cfgSearchTargetData.SelectCamp == 2 and cfgSearchTargetData.PositionType == 2 and cfgSearchTargetData.IsGroup then
		troopType = Constant.BattleTroopType.Attack
		canSelectArea = Constant.BattlePositionArea.Back
		units, canSelectArea = BattleModule.GetCanHitUnitsInArea(troopType, canSelectArea, cfgSearchTargetData)
		attackArea = Constant.SkillTargetArea.Row
	elseif cfgSearchTargetData.SelectCamp == 3 then
		troopType = Constant.BattleTroopType.Attack
		canSelectArea = Constant.BattlePositionArea.OnlySelf
		units = {
			selfUnitId
		}
		attackArea = Constant.SkillTargetArea.Single
	else
		logError("找不到技能可选目标类型(TargetIndicator)。SelectCamp: " .. cfgSearchTargetData.SelectCamp .. ", PositionType: " .. cfgSearchTargetData.PositionType .. ", IsGroup" .. tostring(cfgSearchTargetData.IsGroup))
	end

	return troopType, units, canSelectArea, attackArea
end

function BattleSkillModule.GetTargetsBySampleUnit(sampleUnitId, attackArea)
	local battleUnitPOD = BattleModule.GetBattleUnitPOD(sampleUnitId)
	local targetTroopType = battleUnitPOD.TroopType
	local targets

	if attackArea == Constant.SkillTargetArea.Single then
		targets = {
			sampleUnitId
		}
	elseif attackArea == Constant.SkillTargetArea.All then
		targets = BattleModule.GetAllUnitsInArea(targetTroopType, Constant.BattlePositionArea.All)
	elseif attackArea == Constant.SkillTargetArea.Row then
		local battlePositionArea

		if battleUnitPOD.BattlePos <= 5 then
			battlePositionArea = Constant.BattlePositionArea.Front
		else
			battlePositionArea = Constant.BattlePositionArea.Back
		end

		targets = BattleModule.GetAllUnitsInArea(targetTroopType, battlePositionArea)
	end

	return targets
end
