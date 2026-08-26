-- chunkname: @modules/logic/sp01/assassin2/controller/AssassinStealthGameHelper.lua

module("modules.logic.sp01.assassin2.controller.AssassinStealthGameHelper", package.seeall)

local AssassinStealthGameHelper = _M

function AssassinStealthGameHelper.getSelectedHeroPointType()
	local result
	local heroGameMo = AssassinStealthGameModel.instance:getSelectedHeroGameMo()

	if heroGameMo then
		local mapId = AssassinStealthGameModel.instance:getMapId()
		local heroGridId, heroPointIndex = heroGameMo:getPos()

		result = AssassinConfig.instance:getGridPointType(mapId, heroGridId, heroPointIndex)
	end

	return result
end

function AssassinStealthGameHelper.getSelectedHeroMoveActId(targetGridId, targetPointIndex)
	local heroGameMo = AssassinStealthGameModel.instance:getSelectedHeroGameMo()

	if not heroGameMo then
		return
	end

	local result
	local heroGridId = heroGameMo:getPos()
	local heroStatus = heroGameMo:getStatus()
	local heroPointType = AssassinStealthGameHelper.getSelectedHeroPointType()
	local isHeroInTower = heroPointType == AssassinEnum.StealthGamePointType.Tower
	local isSameGrid = heroGridId == targetGridId

	if targetPointIndex then
		local mapId = AssassinStealthGameModel.instance:getMapId()
		local targetPointType = AssassinConfig.instance:getGridPointType(mapId, targetGridId, targetPointIndex)
		local targetPointIsHayStack = targetPointType == AssassinEnum.StealthGamePointType.HayStack
		local targetPointIsGarden = targetPointType == AssassinEnum.StealthGamePointType.Garden
		local targetPointIsTower = targetPointType == AssassinEnum.StealthGamePointType.Tower

		if isHeroInTower then
			if targetPointIsHayStack then
				result = AssassinEnum.HeroAct.Jump
			end
		elseif targetPointIsTower then
			local towerGridDict = AssassinConfig.instance:getTowerGridDict(mapId, targetGridId, targetPointIndex)

			if towerGridDict[heroGridId] then
				result = AssassinEnum.HeroAct.ClimbTower
			end
		elseif isSameGrid and (targetPointIsHayStack or targetPointIsGarden) and heroStatus == AssassinEnum.HeroStatus.Stealth then
			result = AssassinEnum.HeroAct.Hide
		end
	elseif isHeroInTower then
		result = AssassinEnum.HeroAct.LeaveTower
	elseif isSameGrid then
		if heroStatus == AssassinEnum.HeroStatus.Hide then
			result = AssassinEnum.HeroAct.LeaveHide
		end
	else
		result = AssassinEnum.HeroAct.Move
	end

	return result
end

function AssassinStealthGameHelper.getSelectedHeroAttackActId(argsEnemyUid)
	local heroGameMo = AssassinStealthGameModel.instance:getSelectedHeroGameMo()
	local enemyGameMo = argsEnemyUid and AssassinStealthGameModel.instance:getEnemyMo(argsEnemyUid, true) or AssassinStealthGameModel.instance:getSelectedEnemyGameMo()

	if not heroGameMo or not enemyGameMo then
		return
	end

	local heroPointType = AssassinStealthGameHelper.getSelectedHeroPointType()
	local isInTower = heroPointType == AssassinEnum.StealthGamePointType.Tower

	if isInTower then
		return
	end

	local heroGridId = heroGameMo:getPos()
	local enemyGridId = enemyGameMo:getPos()

	if heroGridId ~= enemyGridId then
		return
	end

	local actId, togetherActId
	local selectedHeroStatus = heroGameMo:getStatus()
	local selectedHeroIsStealth = selectedHeroStatus == AssassinEnum.HeroStatus.Stealth
	local selectedHeroIsExpose = selectedHeroStatus == AssassinEnum.HeroStatus.Expose

	if selectedHeroIsStealth then
		actId = AssassinEnum.HeroAct.Ambush
	elseif selectedHeroIsExpose then
		actId = AssassinEnum.HeroAct.Attack
	end

	if selectedHeroIsStealth or selectedHeroIsExpose then
		local curHeroUid = heroGameMo:getUid()
		local sameGridHeroUidList = AssassinStealthGameModel.instance:getGridEntityIdList(heroGridId, false, curHeroUid)

		if #sameGridHeroUidList > 0 then
			local mapId = AssassinStealthGameModel.instance:getMapId()

			for _, heroUid in ipairs(sameGridHeroUidList) do
				local heroMo = AssassinStealthGameModel.instance:getHeroMo(heroUid, true)
				local _, pointIndex = heroMo:getPos()
				local pointType = AssassinConfig.instance:getGridPointType(mapId, heroGridId, pointIndex)

				if pointType ~= AssassinEnum.StealthGamePointType.Tower then
					local status = heroMo:getStatus()

					if status == AssassinEnum.HeroStatus.Stealth then
						togetherActId = AssassinEnum.HeroAct.AmbushTogether

						break
					elseif status == AssassinEnum.HeroStatus.Expose then
						if selectedHeroIsStealth then
							togetherActId = AssassinEnum.HeroAct.AmbushTogether

							break
						else
							togetherActId = AssassinEnum.HeroAct.AttackTogether
						end
					end
				end
			end
		end
	end

	return actId, togetherActId
end

function AssassinStealthGameHelper.getSelectedHeroAssassinateActId(argsEnemyUid)
	local isBoss = true
	local heroGameMo = AssassinStealthGameModel.instance:getSelectedHeroGameMo()
	local enemyGameMo = argsEnemyUid and AssassinStealthGameModel.instance:getEnemyMo(argsEnemyUid, true) or AssassinStealthGameModel.instance:getSelectedEnemyGameMo()

	if enemyGameMo then
		local monsterId = enemyGameMo:getMonsterId()

		isBoss = AssassinConfig.instance:getEnemyIsBoss(monsterId)
	end

	if not heroGameMo or isBoss then
		return
	end

	local result
	local status = heroGameMo:getStatus()

	if status == AssassinEnum.HeroStatus.Stealth then
		result = AssassinEnum.HeroAct.Assassinate

		local mapId = AssassinStealthGameModel.instance:getMapId()
		local heroGridId, heroPointIndex = heroGameMo:getPos()
		local pointType = AssassinConfig.instance:getGridPointType(mapId, heroGridId, heroPointIndex)
		local heroGridType = AssassinConfig.instance:getGridType(mapId, heroGridId)
		local enemyGridId = enemyGameMo:getPos()
		local enemyGridType = AssassinConfig.instance:getGridType(mapId, enemyGridId)
		local enemyIsInRoof = enemyGridType == AssassinEnum.StealthGameGridType.Roof

		if not enemyIsInRoof and (heroGridType == AssassinEnum.StealthGameGridType.Roof or pointType == AssassinEnum.StealthGamePointType.Tower) then
			result = AssassinEnum.HeroAct.AirAssassinate
		end
	elseif status == AssassinEnum.HeroStatus.Hide then
		result = AssassinEnum.HeroAct.HideAssassinate
	end

	return result
end

function AssassinStealthGameHelper.checkHero(argsHeroUid)
	local heroGameMo = argsHeroUid and AssassinStealthGameModel.instance:getHeroMo(argsHeroUid) or AssassinStealthGameModel.instance:getSelectedHeroGameMo()

	return ((heroGameMo or nil) and heroGameMo:getStatus()) ~= AssassinEnum.HeroStatus.Dead
end

function AssassinStealthGameHelper.isDeadEnemy(enemyUid)
	local enemyGameMo = AssassinStealthGameModel.instance:getEnemyMo(enemyUid)

	return (enemyGameMo or nil) and enemyGameMo:getIsDead()
end

function AssassinStealthGameHelper.isCanSelectHero(heroUid)
	local checkHeroResult = AssassinStealthGameHelper.checkHero(heroUid)

	if not checkHeroResult then
		return false
	end

	local selectedSkillPropId = AssassinStealthGameModel.instance:getSelectedSkillProp()

	if selectedSkillPropId then
		return false
	end

	return (AssassinStealthGameModel.instance:isPlayerTurn())
end

function AssassinStealthGameHelper.isSelectedHeroCanMoveTo(targetGridId, targetPointIndex)
	local checkHeroResult = AssassinStealthGameHelper.checkHero()

	if not checkHeroResult then
		return false
	end

	local selectedSkillPropId = AssassinStealthGameModel.instance:getSelectedSkillProp()

	if selectedSkillPropId then
		return false
	end

	local mapId = AssassinStealthGameModel.instance:getMapId()
	local isShow = AssassinConfig.instance:isShowGrid(mapId, targetGridId)

	if not isShow then
		return false
	end

	if targetPointIndex then
		local posEntityUid = AssassinStealthGameModel.instance:getGridPointEntity(targetGridId, targetPointIndex)

		if posEntityUid then
			return false
		end
	else
		local emptyPointIndex = AssassinStealthGameModel.instance:getGridEmptyPointIndex(targetGridId)

		if not emptyPointIndex then
			return false
		end
	end

	local heroGameMo = AssassinStealthGameModel.instance:getSelectedHeroGameMo()
	local heroGridId, heroPointIndex = heroGameMo:getPos()
	local heroPointType = AssassinStealthGameHelper.getSelectedHeroPointType()
	local isInTower = heroPointType == AssassinEnum.StealthGamePointType.Tower

	if isInTower then
		local towerGridDict = AssassinConfig.instance:getTowerGridDict(mapId, heroGridId, heroPointIndex)

		if not towerGridDict[targetGridId] then
			return false
		end
	else
		local heroStatus = heroGameMo:getStatus()
		local isHide = heroStatus == AssassinEnum.HeroStatus.Hide

		if targetPointIndex then
			::label_8_0::

			local targetPointType = AssassinConfig.instance:getGridPointType(mapId, targetGridId, targetPointIndex)

			if targetPointType == AssassinEnum.StealthGamePointType.Tower then
				local towerGridDict = AssassinConfig.instance:getTowerGridDict(mapId, targetGridId, targetPointIndex)

				if isHide or not towerGridDict[heroGridId] then
					return false
				end
			elseif isHide then
				if not AssassinEnum.StealthConst.HideMoveDis then
					local moveDis = AssassinEnum.StealthConst.MoveDis
					local heroX, heroY = AssassinConfig.instance:getGridPos(mapId, heroGridId)
					local targetX, targetY = AssassinConfig.instance:getGridPos(mapId, targetGridId)
					local dx = heroX - targetX
					local dy = heroY - targetY

					if moveDis * moveDis < dx * dx + dy * dy then
						return false
					end
				end
			end
		end
	end

	local isHasWall = AssassinStealthGameHelper.isHasWallBetweenGrid(heroGridId, targetGridId)

	if isHasWall then
		return false
	end

	local moveActId = AssassinStealthGameHelper.getSelectedHeroMoveActId(targetGridId, targetPointIndex)

	if not moveActId then
		return false
	end

	local curAp = heroGameMo:getActionPoint()
	local needAp = AssassinConfig.instance:getAssassinActPower(moveActId)

	return needAp <= curAp
end

function AssassinStealthGameHelper.isAdjacentGrid(gridId1, gridId2)
	local mapId = AssassinStealthGameModel.instance:getMapId()
	local x1, y1 = AssassinConfig.instance:getGridPos(mapId, gridId1)
	local x2, y2 = AssassinConfig.instance:getGridPos(mapId, gridId2)

	if not x1 or not y1 or not x2 or not y2 then
		return false
	end

	local xDis = math.abs(x1 - x2)
	local yDis = math.abs(y1 - y2)
	local totalDis = xDis + yDis

	return totalDis == AssassinEnum.StealthConst.AdjacentDis
end

function AssassinStealthGameHelper.isHasWallBetweenGrid(gridId1, gridId2)
	local isAdjacent = AssassinStealthGameHelper.isAdjacentGrid(gridId1, gridId2)

	if not isAdjacent then
		return false
	end

	local strWallId
	local mapId = AssassinStealthGameModel.instance:getMapId()
	local x1, y1 = AssassinConfig.instance:getGridPos(mapId, gridId1)
	local x2, y2 = AssassinConfig.instance:getGridPos(mapId, gridId2)

	if x1 ~= x2 then
		local wallX = x1 < x2 and x1 or x2

		strWallId = string.format("%s%s%s", AssassinEnum.StealthConst.VerWallSign, wallX, y1)
	else
		local wallY = y1 < y2 and y1 or y2

		strWallId = string.format("%s%s%s", AssassinEnum.StealthConst.HorWallSign, x1, wallY)
	end

	return (AssassinConfig.instance:isShowWall(mapId, tonumber(strWallId)))
end

function AssassinStealthGameHelper.isSelectedHeroCanInteract()
	local checkHeroResult = AssassinStealthGameHelper.checkHero()

	if not checkHeroResult then
		return false
	end

	local heroGameMo = AssassinStealthGameModel.instance:getSelectedHeroGameMo()
	local heroGridId = heroGameMo:getPos()

	return (AssassinStealthGameModel.instance:isQTEInteractGrid(heroGridId))
end

function AssassinStealthGameHelper.isSelectedHeroCanSelectEnemy(enemyUid)
	local checkHeroResult = AssassinStealthGameHelper.checkHero()

	if not checkHeroResult then
		return false
	end

	local isDead = AssassinStealthGameHelper.isDeadEnemy(enemyUid)

	if isDead then
		return false
	end

	local gridCheckResult = false
	local heroGameMo = AssassinStealthGameModel.instance:getSelectedHeroGameMo()
	local enemyGameMo = AssassinStealthGameModel.instance:getEnemyMo(enemyUid)
	local heroGridId, heroPointIndex = heroGameMo:getPos()
	local enemyGridId = enemyGameMo:getPos()

	if enemyGridId ~= heroGridId then
		local mapId = AssassinStealthGameModel.instance:getMapId()
		local enemyGridType = AssassinConfig.instance:getGridType(mapId, enemyGridId)
		local enemyIsInRoof = enemyGridType == AssassinEnum.StealthGameGridType.Roof
		local monsterId = enemyGameMo:getMonsterId()
		local isBoss = AssassinConfig.instance:getEnemyIsBoss(monsterId)
		local canBeAirAssassin = not isBoss and not enemyIsInRoof
		local status = heroGameMo:getStatus()

		if status == AssassinEnum.HeroStatus.Stealth and canBeAirAssassin then
			local heroGridType = AssassinConfig.instance:getGridType(mapId, heroGridId)
			local heroPointType = AssassinStealthGameHelper.getSelectedHeroPointType()

			if heroGridType == AssassinEnum.StealthGameGridType.Roof then
				local isAdjacent = AssassinStealthGameHelper.isAdjacentGrid(heroGridId, enemyGridId)

				if isAdjacent then
					gridCheckResult = true
				end
			elseif heroPointType == AssassinEnum.StealthGamePointType.Tower then
				local towerGridDict = AssassinConfig.instance:getTowerGridDict(mapId, heroGridId, heroPointIndex)

				if towerGridDict[enemyGridId] then
					gridCheckResult = true
				end
			end
		end
	else
		gridCheckResult = true
	end

	if gridCheckResult then
		local assassinateActId = AssassinStealthGameHelper.getSelectedHeroAssassinateActId(enemyUid)
		local attackId, togetherAttackActId = AssassinStealthGameHelper.getSelectedHeroAttackActId(enemyUid)

		if assassinateActId or attackId or togetherAttackActId then
			return true
		end
	end

	return false
end

function AssassinStealthGameHelper.isSelectedHeroCanRemoveEnemyBody(enemyUid)
	local checkHeroResult = AssassinStealthGameHelper.checkHero()

	if not checkHeroResult then
		return false
	end

	local selectedSkillPropId = AssassinStealthGameModel.instance:getSelectedSkillProp()

	if selectedSkillPropId then
		return false
	end

	local heroPointType = AssassinStealthGameHelper.getSelectedHeroPointType()
	local isHeroInTower = heroPointType == AssassinEnum.StealthGamePointType.Tower

	if isHeroInTower then
		return false
	end

	local isDead = AssassinStealthGameHelper.isDeadEnemy(enemyUid)

	if not isDead then
		return false
	end

	local enemyGameMo = AssassinStealthGameModel.instance:getEnemyMo(enemyUid)

	if not enemyGameMo then
		return
	end

	local heroGameMo = AssassinStealthGameModel.instance:getSelectedHeroGameMo()
	local enemyGridId = enemyGameMo:getPos()
	local heroGridId = heroGameMo:getPos()

	if enemyGridId ~= heroGridId then
		return false
	end

	local hasAliveEnemy = AssassinStealthGameModel.instance:isHasAliveEnemy(heroGridId)

	if hasAliveEnemy then
		return false
	end

	local curAp = heroGameMo:getActionPoint()
	local needAp = AssassinConfig.instance:getAssassinActPower(AssassinEnum.HeroAct.HandleBody)

	return needAp <= curAp
end

function AssassinStealthGameHelper.isCanUseSkillProp(heroUid, skillPropId, isSkill)
	local gameHeroMo = AssassinStealthGameModel.instance:getHeroMo(heroUid, true)

	if not ((gameHeroMo or nil) and gameHeroMo:hasSkillProp(skillPropId, isSkill, true)) then
		return false
	end

	local mapId = AssassinStealthGameModel.instance:getMapId()
	local heroGridId, heroPointIndex = gameHeroMo:getPos()
	local heroGridType = AssassinConfig.instance:getGridType(mapId, heroGridId)

	if isSkill then
		if heroGridType == AssassinEnum.StealthGameGridType.Water then
			return false
		end
	else
		local itemType = AssassinConfig.instance:getAssassinItemType(skillPropId)

		if itemType == AssassinEnum.ItemType.AirCraft and heroGridType ~= AssassinEnum.StealthGameGridType.Roof then
			local heroPointType = AssassinConfig.instance:getGridPointType(mapId, heroGridId, heroPointIndex)

			if heroPointType ~= AssassinEnum.StealthGamePointType.Tower then
				return false
			end
		end
	end

	local checkLimit = AssassinStealthGameHelper._checkSkillPropUseLimit(heroUid, skillPropId, isSkill)

	if not checkLimit then
		return false
	end

	local checkCost = AssassinStealthGameHelper._checkSkillPropCost(heroUid, skillPropId, isSkill)

	if not checkCost then
		return false
	end

	return true
end

function AssassinStealthGameHelper._checkSkillPropUseLimit(heroUid, skillPropId, isSkill)
	local roundLimit, timesLimit = 0, 0

	if isSkill then
		roundLimit = AssassinConfig.instance:getAssassinSkillRoundLimit(skillPropId)
		timesLimit = AssassinConfig.instance:getAssassinSkillTimesLimit(skillPropId)
	else
		roundLimit = AssassinConfig.instance:getAssassinItemRoundLimit(skillPropId)
	end

	local gameHeroMo = AssassinStealthGameModel.instance:getHeroMo(heroUid, true)
	local roundUseCount = gameHeroMo:getSkillPropRoundUseCount(skillPropId, isSkill)
	local totalUseCount = gameHeroMo:getSkillPropTotalUseCount(skillPropId, isSkill)
	local isRoundLimit = roundLimit ~= 0 and roundLimit <= roundUseCount
	local isTimeLimit = timesLimit ~= 0 and timesLimit <= totalUseCount

	return not isRoundLimit and not isTimeLimit
end

function AssassinStealthGameHelper._checkSkillPropCost(heroUid, skillPropId, isSkill)
	local costAP = 0

	if isSkill then
		local costType, cost = AssassinConfig.instance:getAssassinSkillCost(skillPropId)

		if costType == AssassinEnum.SkillCostType.AP then
			costAP = cost
		else
			logError(string.format("AssassinStealthGameHelper._checkSkillPropCost error, not support cost type:%s", costType))

			return false
		end
	else
		costAP = AssassinConfig.instance:getAssassinItemCostPoint(skillPropId)
	end

	local gameHeroMo = AssassinStealthGameModel.instance:getHeroMo(heroUid, true)
	local curAP = gameHeroMo:getActionPoint()

	return costAP <= curAP
end

function AssassinStealthGameHelper.isSelectedHeroCanUseSkillPropToHero(targetHeroUid)
	local checkHeroResult = AssassinStealthGameHelper.checkHero()

	if not checkHeroResult then
		return false
	end

	local targetHeroGameMo = AssassinStealthGameModel.instance:getHeroMo(targetHeroUid, true)

	if not targetHeroGameMo then
		return false
	end

	local selectedSkillPropId, selectedIsSkill = AssassinStealthGameModel.instance:getSelectedSkillProp()

	if not selectedSkillPropId then
		return false
	end

	local targetType = AssassinConfig.instance:getSkillPropTargetType(selectedSkillPropId, selectedIsSkill)

	if targetType ~= AssassinEnum.SkillPropTargetType.Hero then
		return false
	end

	local targetCheck = AssassinStealthGameHelper._skillPropTargetCheck(selectedSkillPropId, selectedIsSkill, targetType, targetHeroUid)

	if not targetCheck then
		return false
	end

	local selectedHeroGameMo = AssassinStealthGameModel.instance:getSelectedHeroGameMo()
	local selectedHeroGridId = selectedHeroGameMo:getPos()
	local targetGridId = targetHeroGameMo:getPos()
	local rangeCheck = AssassinStealthGameHelper._checkSkillPropRange(selectedSkillPropId, selectedIsSkill, selectedHeroGridId, targetGridId)

	if not rangeCheck then
		return false
	end

	if selectedIsSkill then
		local isTargetDead = false

		if selectedSkillPropId ~= AssassinEnum.Skill.Cure and selectedSkillPropId ~= AssassinEnum.Skill.CureAll then
			local targetHeroGameMO = AssassinStealthGameModel.instance:getHeroMo(targetHeroUid, true)

			if targetHeroGameMO then
				local targetHeroStatus = targetHeroGameMO:getStatus()

				isTargetDead = targetHeroStatus == AssassinEnum.HeroStatus.Dead
			else
				isTargetDead = true
			end
		end

		if isTargetDead then
			return false
		end

		if selectedSkillPropId == AssassinEnum.Skill.AddAp then
			local selectedHeroUid = AssassinStealthGameModel.instance:getSelectedHero()

			if targetHeroUid == selectedHeroUid then
				return false
			end
		end
	end

	return true
end

function AssassinStealthGameHelper.isSelectedHeroCanUseSkillPropToEnemy(targetEnemyUid)
	local checkHeroResult = AssassinStealthGameHelper.checkHero()

	if not checkHeroResult then
		return false
	end

	local selectedSkillPropId, selectedIsSkill = AssassinStealthGameModel.instance:getSelectedSkillProp()

	if not selectedSkillPropId then
		return false
	end

	local targetType = AssassinConfig.instance:getSkillPropTargetType(selectedSkillPropId, selectedIsSkill)

	if targetType ~= AssassinEnum.SkillPropTargetType.Enemy then
		return false
	end

	local enemyGameMo = AssassinStealthGameModel.instance:getEnemyMo(targetEnemyUid)
	local monsterId = enemyGameMo:getMonsterId()
	local isBoss = AssassinConfig.instance:getEnemyIsBoss(monsterId)

	if isBoss then
		return false
	end

	if not selectedIsSkill then
		local itemType = AssassinConfig.instance:getAssassinItemType(selectedSkillPropId)

		if itemType == AssassinEnum.ItemType.ThrowingKnife then
			local enemyType = AssassinConfig.instance:getEnemyType(monsterId)

			if enemyType == AssassinEnum.EnemyType.Heavy then
				return false
			end
		end
	end

	local isDead = AssassinStealthGameHelper.isDeadEnemy(targetEnemyUid)

	if isDead then
		return false
	end

	local targetCheck = AssassinStealthGameHelper._skillPropTargetCheck(selectedSkillPropId, selectedIsSkill, targetType, targetEnemyUid)

	if not targetCheck then
		return false
	end

	local heroGameMo = AssassinStealthGameModel.instance:getSelectedHeroGameMo()
	local selectedHeroGridId = heroGameMo:getPos()
	local targetGridId = enemyGameMo:getPos()
	local rangeCheck = AssassinStealthGameHelper._checkSkillPropRange(selectedSkillPropId, selectedIsSkill, selectedHeroGridId, targetGridId)

	if not rangeCheck then
		return false
	end

	return true
end

function AssassinStealthGameHelper.isSelectedHeroCanUseSkillPropToGrid(targetGridId)
	local mapId = AssassinStealthGameModel.instance:getMapId()
	local isShow = AssassinConfig.instance:isShowGrid(mapId, targetGridId)

	if not isShow then
		return false
	end

	local checkHeroResult = AssassinStealthGameHelper.checkHero()

	if not checkHeroResult then
		return false
	end

	local selectedSkillPropId, selectedIsSkill = AssassinStealthGameModel.instance:getSelectedSkillProp()

	if not selectedSkillPropId then
		return false
	end

	local targetType = AssassinConfig.instance:getSkillPropTargetType(selectedSkillPropId, selectedIsSkill)

	if targetType ~= AssassinEnum.SkillPropTargetType.Grid then
		return false
	end

	local targetCheck = AssassinStealthGameHelper._skillPropTargetCheck(selectedSkillPropId, selectedIsSkill, targetType, targetGridId)

	if not targetCheck then
		return false
	end

	local heroGameMo = AssassinStealthGameModel.instance:getSelectedHeroGameMo()
	local selectedHeroGridId = heroGameMo:getPos()
	local rangeCheck = AssassinStealthGameHelper._checkSkillPropRange(selectedSkillPropId, selectedIsSkill, selectedHeroGridId, targetGridId)

	if not rangeCheck then
		return false
	end

	return true
end

function AssassinStealthGameHelper._skillPropTargetCheck(skillPropId, isSkill, targetType, targetId)
	local result = true
	local targetGridId = targetId

	if targetType == AssassinEnum.SkillPropTargetType.Hero then
		local heroMo = AssassinStealthGameModel.instance:getHeroMo(targetId, true)

		targetGridId = heroMo and heroMo:getPos()
	elseif targetType == AssassinEnum.SkillPropTargetType.Enemy then
		local enemyGameMo = AssassinStealthGameModel.instance:getEnemyMo(targetId, true)

		targetGridId = enemyGameMo and enemyGameMo:getPos()
	end

	local checkType, checkParam

	if isSkill then
		checkType, checkParam = AssassinConfig.instance:getAssassinSkillTargetCheck(skillPropId)
	else
		checkType, checkParam = AssassinConfig.instance:getAssassinItemTargetCheck(skillPropId)
	end

	if checkType then
		if checkType == AssassinEnum.SkillPropTargetCheckType.GridType then
			local mapId = AssassinStealthGameModel.instance:getMapId()
			local gridType = AssassinConfig.instance:getGridType(mapId, targetGridId)

			result = gridType == checkParam
		elseif checkType == AssassinEnum.SkillPropTargetCheckType.EnemyRefreshPoint then
			local missionId = AssassinStealthGameModel.instance:getMissionId()
			local isAlertBellRing = AssassinStealthGameModel.instance:isAlertBellRing()
			local refreshId1, refreshId2 = AssassinConfig.instance:getStealthMissionRefresh(missionId)
			local refreshId = isAlertBellRing and refreshId2 or refreshId1

			if refreshId and refreshId > 0 then
				local isRefreshPoint = false
				local refreshPositionList = AssassinConfig.instance:getEnemyRefreshPositionList(refreshId)

				for _, position in ipairs(refreshPositionList) do
					local gridId = position[1]

					if targetGridId == gridId then
						isRefreshPoint = true

						break
					end
				end

				result = isRefreshPoint
			end
		else
			result = false

			logError(string.format("AssassinStealthGameHelper._skillPropTargetCheck error, not support check type:%s", checkType))
		end
	end

	return result
end

function AssassinStealthGameHelper._checkSkillPropRange(skillPropId, isSkill, curGridId, targetGridId)
	local result = true
	local rangeType, range

	if isSkill then
		rangeType, range = AssassinConfig.instance:getAssassinSkillRange(skillPropId)
	else
		rangeType, range = AssassinConfig.instance:getAssassinItemRange(skillPropId)
	end

	if rangeType then
		local mapId = AssassinStealthGameModel.instance:getMapId()

		if rangeType == AssassinEnum.RangeType.StraightLine then
			local curX, curY = AssassinConfig.instance:getGridPos(mapId, curGridId)
			local targetX, targetY = AssassinConfig.instance:getGridPos(mapId, targetGridId)
			local dx = curX - targetX
			local dy = curY - targetY

			if range * range < dx * dx + dy * dy then
				return false
			end
		else
			result = false

			logError(string.format("AssassinStealthGameHelper._checkSkillPropRange error, not support range type:%s", rangeType))
		end
	end

	return result
end

function AssassinStealthGameHelper.getEffectUrl(resName)
	return string.format("ui/viewres/sp01/assassin2/assassinstealth_skill/%s.prefab", resName)
end

function AssassinStealthGameHelper.isHeroCanBeScan(heroUid, argsHeroStatus, actId)
	local result = false
	local eventId = AssassinStealthGameModel.instance:getEventId()
	local eventType = AssassinConfig.instance:getEventType(eventId)
	local heroGameMo = AssassinStealthGameModel.instance:getHeroMo(heroUid, true)

	if eventType ~= AssassinEnum.EventType.NotExpose and heroGameMo then
		if actId and actId ~= AssassinEnum.HeroAct.Move then
			if actId == AssassinEnum.HeroAct.LeaveHide or actId == AssassinEnum.HeroAct.LeaveTower then
				result = true
			end
		else
			local mapId = AssassinStealthGameModel.instance:getMapId()
			local gridId, pointIndex = heroGameMo:getPos()
			local pointType = AssassinConfig.instance:getGridPointType(mapId, gridId, pointIndex)
			local isInTower = pointType == AssassinEnum.StealthGamePointType.Tower
			local status = argsHeroStatus or heroGameMo:getStatus()
			local isStealth = status == AssassinEnum.HeroStatus.Stealth

			if not isInTower and isStealth then
				result = true
			end
		end
	end

	return result
end

function AssassinStealthGameHelper.isGridEnemyWillScan(gridId)
	local mapId = AssassinStealthGameModel.instance:getMapId()
	local isShow = AssassinConfig.instance:isShowGrid(mapId, gridId)

	if not isShow then
		return false
	end

	local result = false
	local gridMo = AssassinStealthGameModel.instance:getGridMo(gridId)
	local gridHasSmog = gridMo and gridMo:hasTrapType(AssassinEnum.StealGameTrapType.Smog)

	if gridMo and not gridHasSmog then
		local enemyUidList = AssassinStealthGameModel.instance:getGridEntityIdList(gridId, true)

		for _, enemyUid in ipairs(enemyUidList) do
			local enemyGameMo = AssassinStealthGameModel.instance:getEnemyMo(enemyUid, true)
			local isDead = enemyGameMo and enemyGameMo:getIsDead()
			local isPetrified = enemyGameMo and enemyGameMo:hasBuffType(AssassinEnum.StealGameBuffType.Petrifaction)

			if enemyGameMo and not isDead and not isPetrified then
				result = true

				break
			end
		end
	end

	return result
end

return AssassinStealthGameHelper
