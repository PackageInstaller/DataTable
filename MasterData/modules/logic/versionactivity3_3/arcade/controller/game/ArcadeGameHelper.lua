-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/ArcadeGameHelper.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.ArcadeGameHelper", package.seeall)

local ArcadeGameHelper = _M

function ArcadeGameHelper.getGridId(x, y)
	if x and y then
		return x * 1000 + y
	else
		logError(string.format("ArcadeGameHelper.getGridId error, invalid param, x:%s, y:%s", x, y))
	end
end

function ArcadeGameHelper.getGridXYById(gridId)
	local numGridId = tonumber(gridId)

	if not numGridId then
		logError(string.format("ArcadeGameHelper.getGridXYById error, invalid gridId:%s", gridId))

		return 0, 0
	end

	local gridX = math.floor(numGridId / 1000)
	local gridY = numGridId - gridX * 1000

	return gridX, gridY
end

function ArcadeGameHelper.getGridPos(gridX, gridY)
	local x, y = 0, 0

	if gridX and gridY then
		local gridSize = ArcadeConfig.instance:getArcadeGameGridSize()
		local startX, startY = ArcadeConfig.instance:getArcadeGameStartPos()

		x = startX + (gridX - 1) * gridSize
		y = startY + (gridY - 1) * gridSize
	end

	return x, y
end

function ArcadeGameHelper.getEffectOffSetPos(dir, sizeX, sizeY)
	local gridSize = ArcadeConfig.instance:getArcadeGameGridSize()
	local offGX = math.max(0, sizeX - 1)
	local offGY = math.max(0, sizeY - 1)

	if dir == ArcadeEnum.Direction.Up then
		return gridSize * offGX * 0.5, gridSize * offGY
	elseif dir == ArcadeEnum.Direction.Down then
		return gridSize * offGX * 0.5, 0
	elseif dir == ArcadeEnum.Direction.Left then
		return 0, gridSize * offGY * 0.5
	elseif dir == ArcadeEnum.Direction.Right then
		return gridSize * offGX, gridSize * offGY * 0.5
	end

	return 0, 0
end

function ArcadeGameHelper.getGridWorldPos(gridX, gridY)
	local x, y, z = 0, 0, ArcadeGameEnum.Const.EntityZLevel

	if gridX and gridY then
		local gridSize = ArcadeConfig.instance:getArcadeGameGridSize()
		local startX, startY = ArcadeConfig.instance:getArcadeGameStartPos()

		x = startX + (gridX - 1) * gridSize
		y = startY + (gridY - 1) * gridSize
	end

	local scene = ArcadeGameController.instance:getGameScene()
	local sceneOffsetY = scene and scene:getSceneOffsetY() or 0

	return x, y + sceneOffsetY, z
end

function ArcadeGameHelper.isRectXYIntersect(minX, maxX, minY, maxY, bMinX, bMaxX, bMinY, bMaxY)
	if math.max(minX, bMinX) <= math.min(maxX, bMaxX) and math.max(minY, bMinY) <= math.min(maxY, bMaxY) then
		return true
	end

	return false
end

function ArcadeGameHelper.isRectXYInside(minX, maxX, minY, maxY, bMinX, bMaxX, bMinY, bMaxY)
	if minX <= bMinX and bMaxX <= maxX and minY <= bMinY and bMaxY <= maxY then
		return true
	end

	return false
end

function ArcadeGameHelper.isOutSideRoom(gridX, gridY)
	if not gridX or not gridY then
		logError(string.format("ArcadeGameHelper.isOutSideRoom error, invalid coordinate, gridX:%s, gridY:%s", gridX, gridY))

		return false
	end

	if gridX < 1 or gridX > ArcadeGameEnum.Const.RoomSize or gridY < 1 or gridY > ArcadeGameEnum.Const.RoomSize then
		return true
	end

	return false
end

function ArcadeGameHelper.getNextXYByDir(gridX, gridY, dir)
	if dir == ArcadeEnum.Direction.Up then
		return gridX, gridY + 1
	elseif dir == ArcadeEnum.Direction.Down then
		return gridX, gridY - 1
	elseif dir == ArcadeEnum.Direction.Left then
		return gridX - 1, gridY
	elseif dir == ArcadeEnum.Direction.Right then
		return gridX + 1, gridY
	end

	return gridX, gridY
end

local _str2DirectionConfig

function ArcadeGameHelper.getStr2Dir(str)
	if not _str2DirectionConfig then
		_str2DirectionConfig = {
			dict = {},
			list = {}
		}
		_str2DirectionConfig.random = {
			Random = true,
			random = true
		}

		for key, value in pairs(ArcadeEnum.Direction) do
			_str2DirectionConfig.dict[key] = value
			_str2DirectionConfig.dict[string.lower(key)] = value

			table.insert(_str2DirectionConfig.list, value)
		end
	end

	if _str2DirectionConfig.random[str] then
		local idx = math.random(1, #_str2DirectionConfig.list)

		return _str2DirectionConfig.list[idx]
	end

	return _str2DirectionConfig.dict[str]
end

function ArcadeGameHelper.getFirsXYByDir(gridX, gridY, sizeX, sizeY, dir)
	if dir == ArcadeEnum.Direction.Up then
		sizeY = sizeY or 1

		return gridX, gridY + math.max(1, sizeY)
	elseif dir == ArcadeEnum.Direction.Down then
		return gridX, gridY - 1
	elseif dir == ArcadeEnum.Direction.Left then
		return gridX - 1, gridY
	elseif dir == ArcadeEnum.Direction.Right then
		sizeX = sizeX or 1

		return gridX + math.max(1, sizeX), gridY
	end

	return gridX, gridY
end

function ArcadeGameHelper.getUnitMidXYInDir(x, y, sizeX, sizeY, dir)
	local midX = x + math.floor(sizeX / 2)
	local midY = y + math.floor(sizeY / 2)

	if dir == ArcadeEnum.Direction.Up then
		return midX, y + sizeY - 1
	elseif dir == ArcadeEnum.Direction.Down then
		return midX, y
	elseif dir == ArcadeEnum.Direction.Left then
		return x, midY
	elseif dir == ArcadeEnum.Direction.Right then
		return x + sizeX - 1, midY
	end

	return x, y
end

function ArcadeGameHelper.callCallbackFunc(cb, cbObj, cbParam)
	if cb then
		if cbObj then
			cb(cbObj, cbParam)
		else
			cb(cbParam)
		end
	end
end

function ArcadeGameHelper.tryCallFunc(func, funcObj, ...)
	if not func then
		return
	end

	local isOk, result

	if funcObj then
		isOk, result = xpcall(func, __G__TRACKBACK__, funcObj, ...)
	else
		isOk, result = xpcall(func, __G__TRACKBACK__, ...)
	end

	return isOk, result
end

function ArcadeGameHelper.checkDictTable(refDict, key)
	if not refDict or not key then
		logError(string.format("ArcadeGameHelper.checkDictTable error, invalid param, refDict:%s, key:%s", tostring(refDict), tostring(key)))

		return
	end

	local table = refDict[key]

	if not table then
		table = {}
		refDict[key] = table
	end

	return table
end

function ArcadeGameHelper.getIsPassiveSkill(skillId)
	if ArcadeConfig.instance:getPassiveSkillCfg(skillId) then
		return true
	end

	return false
end

function ArcadeGameHelper.getRectOffsetVal(size)
	if size <= 0 then
		return 0, 0
	end

	local min = math.floor(size * 0.5)

	return min, size - min
end

function ArcadeGameHelper.getAttrTypeByAttrId(attrId)
	return math.floor(tonumber(attrId) / 100)
end

function ArcadeGameHelper.getRandomIndex(weightList, totalWeight)
	if not weightList or totalWeight <= 0 then
		return
	end

	local sumWeight = 0
	local randomWeight = math.random(totalWeight)

	for i, weight in ipairs(weightList) do
		sumWeight = sumWeight + weight

		if randomWeight <= sumWeight then
			return i
		end
	end
end

function ArcadeGameHelper.getUniqueRandomNumbers(min, max, count)
	local range = max - min + 1

	count = math.min(count, range)

	local numbers = {}

	for i = min, max do
		table.insert(numbers, i)
	end

	for i = range, 2, -1 do
		local j = math.random(1, i)

		numbers[i], numbers[j] = numbers[j], numbers[i]
	end

	local result = {}

	for i = 1, count do
		result[i] = numbers[i]
	end

	return result
end

function ArcadeGameHelper.getDirection(gridX1, gridY1, grid1SizeX, grid1SizeY, gridX2, gridY2)
	grid1SizeX = grid1SizeX or 1
	grid1SizeY = grid1SizeY or 1

	local left = gridX1
	local right = gridX1 + grid1SizeX - 1
	local bottom = gridY1
	local top = gridY1 + grid1SizeY - 1

	if left <= gridX2 and gridX2 <= right and bottom <= gridY2 and gridY2 <= top then
		return
	end

	local nx = math.max(left, math.min(gridX2, right))
	local ny = math.max(bottom, math.min(gridY2, top))
	local dx = gridX2 - nx
	local dy = gridY2 - ny

	if math.abs(dx) > math.abs(dy) then
		if dx > 0 then
			return ArcadeEnum.Direction.Right
		else
			return ArcadeEnum.Direction.Left
		end
	elseif dy > 0 then
		return ArcadeEnum.Direction.Up
	else
		return ArcadeEnum.Direction.Down
	end
end

function ArcadeGameHelper.getHPSeqIndex(hpValue, showHpCount, hpItemIndex)
	local result

	if hpValue > 0 then
		local maxSeqIndex = math.floor((hpValue - 1) / showHpCount)
		local remainder = hpValue % showHpCount

		result = remainder > 0 and remainder < hpItemIndex and maxSeqIndex - 1 or maxSeqIndex
	end

	return result
end

function ArcadeGameHelper.addSettleRewardCount(isHardLevel)
	local diamondAddArr = ArcadeConfig.instance:getArcadeConst(ArcadeEnum.ConstId.DiamondAddCount, true, "#")

	if isHardLevel then
		local var_23_0 = diamondAddArr[2]

		if not diamondAddArr[2] then
			var_23_0 = diamondAddArr[1]

			if not diamondAddArr[1] then
				local diamondAddCount = 0

				ArcadeGameController.instance:changeResCount(ArcadeGameEnum.CharacterResource.Diamond, diamondAddCount)

				local cassetteAddArr = ArcadeConfig.instance:getArcadeConst(ArcadeEnum.ConstId.CassetteAddCount, true, "#")

				if isHardLevel then
					local var_23_1 = cassetteAddArr[2]

					if not cassetteAddArr[2] then
						var_23_1 = cassetteAddArr[1]

						if not cassetteAddArr[1] then
							local cassetteAddCount = 0

							ArcadeGameController.instance:changeResCount(ArcadeGameEnum.CharacterResource.Cassette, cassetteAddCount)
						end
					end
				end
			end
		end
	end
end

function ArcadeGameHelper.isEntityNeedIcon(entityType, id)
	local hasTalk = false
	local showFrame = false

	if entityType == ArcadeGameEnum.EntityType.BaseInteractive then
		hasTalk = ArcadeConfig.instance:isEntityHasTalk(id)
	elseif entityType == ArcadeGameEnum.EntityType.Monster then
		showFrame = ArcadeGameHelper.isShowMonsterFrame(id)
	elseif entityType == ArcadeGameEnum.EntityType.Character then
		showFrame = true
	end

	return (entityType == ArcadeGameEnum.EntityType.Goods or entityType == ArcadeGameEnum.EntityType.Portal or entityType == ArcadeGameEnum.EntityType.PWDValidator or hasTalk or showFrame) and true
end

function ArcadeGameHelper.isShowMonsterFrame(monsterId)
	local race = ArcadeConfig.instance:getMonsterRace(monsterId)

	if race == ArcadeGameEnum.MonsterRace.Boss then
		return true
	end
end

function ArcadeGameHelper.getTalkCharList(strTalk)
	local result = {}

	if not string.nilorempty(strTalk) then
		local str = ""
		local charArr = LuaUtil.getUCharArrWithLineFeed(strTalk)

		for _, char in ipairs(charArr) do
			str = str .. char

			table.insert(result, str)
		end
	end

	return result
end

function ArcadeGameHelper.checkInGuiding()
	local isForbid = GuideController.instance:isForbidGuides()

	if isForbid then
		return false
	end

	local isDoingClickGuide = GuideModel.instance:isDoingClickGuide()
	local isAnyGuideRunning = GuideController.instance:isAnyGuideRunning()
	local isGuiding = GuideController.instance:isGuiding()

	if isDoingClickGuide or isAnyGuideRunning or isGuiding then
		return true
	end
end

function ArcadeGameHelper.checkLastRoomCanNormalEnd()
	local total, cur = ArcadeGameModel.instance:getLevelCount()

	if total ~= cur then
		return true
	end

	local roomId = ArcadeGameModel.instance:getCurRoomId()
	local roomType = ArcadeConfig.instance:getRoomType(roomId)

	if roomType ~= ArcadeGameEnum.RoomType.Boss then
		local difficulty = ArcadeGameModel.instance:getDifficulty()
		local curAreaIndex = ArcadeGameModel.instance:getCurAreaIndex()

		logError(string.format("ArcadeGameHelper.checkLastRoomCanNormalEnd error, last room is not boss room, difficulty:%s areaIndex:%s roomId:%s", difficulty, curAreaIndex, roomId))

		return false
	end

	local hasBoss = false
	local monsterList = ArcadeGameModel.instance:getMonsterList()

	for _, monsterMO in ipairs(monsterList) do
		local monsterId = monsterMO:getId()
		local race = ArcadeConfig.instance:getMonsterRace(monsterId)

		if race == ArcadeGameEnum.MonsterRace.Boss then
			hasBoss = true

			break
		end
	end

	if not hasBoss then
		logError(string.format("ArcadeGameHelper.checkLastRoomCanNormalEnd error, room:%s not have boss", roomId))
	end

	return hasBoss
end

function ArcadeGameHelper.entityIsAdjacent(mo1, mo2)
	local x1, y1 = mo1:getGridPos()
	local x2, y2 = mo2:getGridPos()
	local sizeX1, sizeY1 = mo1:getSize()
	local sizeX2, sizeY2 = mo2:getSize()
	local left1, right1 = x1, x1 + sizeX1 - 1
	local bottom1, top1 = y1, y1 + sizeY1 - 1
	local left2, right2 = x2, x2 + sizeX2 - 1
	local bottom2, top2 = y2, y2 + sizeY2 - 1

	if right1 >= left2 and right2 >= left1 and top1 >= bottom2 and top2 >= bottom1 then
		return true
	end

	local horAdj = right1 + 1 == left2 or right2 + 1 == left1
	local verAdj = top1 + 1 == bottom2 or top2 + 1 == bottom1

	if horAdj and top1 >= bottom2 and top2 >= bottom1 then
		return true
	end

	if verAdj and right1 >= left2 and right2 >= left1 then
		return true
	end

	return false
end

function ArcadeGameHelper.getEntityNearCharacterGrid(entityMO)
	if not entityMO then
		return
	end

	local gridX, gridY = entityMO:getGridPos()
	local sizeX, sizeY = entityMO:getSize()
	local characterMO = ArcadeGameModel.instance:getCharacterMO()

	if not characterMO or sizeX <= 1 and sizeY <= 1 then
		return gridX, gridY
	end

	local left = gridX
	local right = gridX + sizeX - 1
	local bottom = gridY
	local top = gridY + sizeY - 1
	local charGridX, charGridY = characterMO:getGridPos()
	local nearX = Mathf.Clamp(charGridX, left, right)
	local nearY = Mathf.Clamp(charGridY, bottom, top)

	return nearX, nearY
end

local formulaFuncEnvTb = {
	isInSide = false,
	min = math.min,
	max = math.max,
	floor = math.floor,
	ceil = math.ceil,
	abs = math.abs
}

setmetatable(formulaFuncEnvTb, {
	__index = function(t, k)
		local attrVal = 0

		if t.isInSide then
			local attrId = string.gsub(k, "attr_", "")

			attrVal = ArcadeGameModel.instance:getGameAttribute(tonumber(attrId))
		end

		return attrVal
	end
})

function ArcadeGameHelper.phraseDesc(desc, isInSide)
	if string.nilorempty(desc) then
		return desc
	end

	formulaFuncEnvTb.isInSide = not not isInSide
	formulaFuncEnvTb.isInSide = false

	return (string.gsub(desc, "%b{}", ArcadeGameHelper._replFunc))
end

function ArcadeGameHelper._replFunc(formulaStr)
	formulaStr = string.sub(formulaStr, 2, #formulaStr - 1)

	local formulaFunc = loadstring(string.format("return %s", string.lower(formulaStr)))

	if not formulaFunc then
		logError("ArcadeGameHelper._replDescFunc 解析表达式失败：" .. formulaStr)

		return formulaStr
	end

	setfenv(formulaFunc, formulaFuncEnvTb)

	local result, resultString = pcall(formulaFunc)

	if result then
		return resultString
	else
		logError("ArcadeGameHelper._replDescFunc 执行表达式错误：" .. formulaStr)

		return formulaStr
	end
end

function ArcadeGameHelper.getActionShowEffect(showId, showParam)
	local actionEffectIdList, bulletEffect

	if showId == ArcadeGameEnum.ActionShowId.ActiveSkill then
		local spellEffect = ArcadeConfig.instance:getActiveSkillSpellEffect(showParam)

		if spellEffect and spellEffect ~= 0 then
			actionEffectIdList = {
				spellEffect
			}
		end

		bulletEffect = ArcadeConfig.instance:getActiveSkillBulletEffect(showParam)
	elseif showId == ArcadeGameEnum.ActionShowId.ActiveSkillHit then
		local hitEffect = ArcadeConfig.instance:getActiveSkillHitEffect(showParam)

		if hitEffect and hitEffect ~= 0 then
			actionEffectIdList = {
				hitEffect
			}
		end
	elseif showId == ArcadeGameEnum.ActionShowId.GainBuff then
		local gainBuffEffect = ArcadeConfig.instance:getArcadeBuffGainEffect(showParam)

		if gainBuffEffect and gainBuffEffect ~= 0 then
			actionEffectIdList = {
				gainBuffEffect
			}
		end
	elseif showId == ArcadeGameEnum.ActionShowId.Interactive then
		local interactEffectId = ArcadeConfig.instance:getInteractiveActingEffId(showParam)

		if interactEffectId and interactEffectId ~= 0 then
			actionEffectIdList = {
				interactEffectId
			}
		end
	elseif showId == ArcadeGameEnum.ActionShowId.BombWarn then
		local bombAlertEffectId = ArcadeConfig.instance:getBombAlertEffectId(showParam)

		if bombAlertEffectId and bombAlertEffectId ~= 0 then
			actionEffectIdList = {
				bombAlertEffectId
			}
		end
	else
		actionEffectIdList = ArcadeConfig.instance:getActionShowEffectIdList(showId)
	end

	return actionEffectIdList, bulletEffect
end

ArcadeGameHelper.OpStr2CompareFunc = {
	lt = function(a, b)
		return a < b
	end,
	ltet = function(a, b)
		return a <= b
	end,
	et = function(a, b)
		return a == b
	end,
	ne = function(a, b)
		return a ~= b
	end,
	gt = function(a, b)
		return b < a
	end,
	gtet = function(a, b)
		return b <= a
	end
}

function ArcadeGameHelper.getCompareFunc(opStr)
	local func = ArcadeGameHelper.OpStr2CompareFunc[string.lower(opStr or "")]

	if not func then
		logError(string.format("ArcadeGameHelper.getCompareFunc error, invalid opStr:%s", tostring(opStr)))
	end

	return func
end

function ArcadeGameHelper.getBombExplodeTargetList(bombId, bombX, bombY, isCharacterBomb)
	local targetId = ArcadeConfig.instance:getBombTarget(bombId)
	local targetSelector = ArcadeSkillFactory.instance:createSkillTargetById(targetId)

	if not targetSelector then
		return
	end

	local targetMOList, gridMOList

	if isCharacterBomb then
		local addBombRange = ArcadeGameModel.instance:getGameAttribute(ArcadeGameEnum.GameAttribute.AddBombRange)

		targetSelector:setRadius(addBombRange)
	end

	targetSelector:findTarget(bombX, bombY)

	local targetList = targetSelector:getTargetList()

	if targetList then
		targetMOList = tabletool.copy(targetList)
	end

	targetSelector:setTargetTypeByList({
		ArcadeGameEnum.EntityType.Grid
	})
	targetSelector:findTarget(bombX, bombY)

	targetList = targetSelector:getTargetList()

	return targetMOList, (targetList or nil) and tabletool.copy(targetList)
end

function ArcadeGameHelper.getResultViewInfo(isWin, isReset, serverInfo)
	local characterId
	local passLevelCount = 0
	local killMonsterNum = 0
	local allCoinNum = 0
	local maxScore = 0
	local attrDict = {}
	local collectionDataList = {}
	local curWeaponIndex = 1
	local weaponDataList = {}

	if serverInfo then
		characterId = serverInfo.player and serverInfo.player.id

		local propInfo = serverInfo.prop

		if propInfo then
			passLevelCount = propInfo.clearedRoomNum or 0
			killMonsterNum = propInfo.maxKillMonsterNum or 0
			allCoinNum = propInfo.totalGainGoldNum or 0
			maxScore = propInfo.highestScore or 0
		end

		local attrInfo = serverInfo.attrContainer

		if attrInfo then
			for _, value in ipairs(attrInfo.attrValues) do
				attrDict[value.id] = value.base
			end
		end

		for i = 1, (attrDict[ArcadeGameEnum.GameSwitch.DualWielding] and attrDict[ArcadeGameEnum.GameSwitch.DualWielding] > 0 or nil) and ArcadeGameEnum.Const.DualWieldingCarryWeapon do
			weaponDataList[i] = {}
		end

		local collectionInfos = serverInfo.collectibleSlots

		if collectionInfos then
			local weaponList = {}
			local collectionList = {}
			local collectionIndexDict = {}

			for _, collection in ipairs(collectionInfos) do
				local type = collection.type
				local info = collection.collectible

				if type == ArcadeGameEnum.CollectionType.Weapon then
					weaponList[#weaponList + 1] = info
				elseif type == ArcadeGameEnum.CollectionType.Jewelry then
					local id = info.id

					if collectionIndexDict[id] then
						local index = collectionIndexDict[id]

						collectionList[index].durability = collectionList[index].durability + 1
					else
						local index = #collectionList + 1

						collectionIndexDict[id] = index
						collectionList[index] = {
							durability = 1,
							id = id
						}
					end
				end
			end

			for _, weaponInfo in ipairs(weaponList) do
				local id = weaponInfo.id
				local durability = weaponInfo.durability
				local useTimes = weaponInfo.useTimes
				local newWeaponIndex = ArcadeGameHelper._fillCollection(ArcadeGameEnum.CollectionType.Weapon, id, durability, useTimes, collectionDataList, weaponDataList, curWeaponIndex)

				if newWeaponIndex then
					curWeaponIndex = newWeaponIndex
				end
			end

			for _, collection in ipairs(collectionList) do
				local id = collection.id
				local durability = collection.durability

				ArcadeGameHelper._fillCollection(ArcadeGameEnum.CollectionType.Jewelry, id, durability, nil, collectionDataList)
			end
		end
	else
		local characterMO = ArcadeGameModel.instance:getCharacterMO()

		if characterMO then
			local weaponNum = characterMO:getCanCarryWeaponNum()

			for i = 1, weaponNum do
				weaponDataList[i] = {}
			end

			characterId = characterMO:getId()
			passLevelCount = ArcadeGameModel.instance:getPassLevelCount()
			killMonsterNum = ArcadeGameModel.instance:getKillMonsterNum()
			allCoinNum = ArcadeGameModel.instance:getAllCoinNum()
			maxScore = ArcadeGameModel.instance:getMaxScore()

			for _, attrId in pairs(ArcadeGameEnum.BaseAttr) do
				attrDict[attrId] = attrId == ArcadeGameEnum.BaseAttr.hp and characterMO:getHp() or characterMO:getAttributeValue(attrId)
			end

			for _, resId in pairs(ArcadeGameEnum.CharacterResource) do
				local count = characterMO:getResourceCount(resId)

				if resId == ArcadeGameEnum.CharacterResource.Diamond or resId == ArcadeGameEnum.CharacterResource.Cassette then
					local difficulty = ArcadeGameModel.instance:getDifficulty()
					local constId
					local factorList = ArcadeConfig.instance:getArcadeConst(resId == ArcadeGameEnum.CharacterResource.Diamond and ArcadeEnum.ConstId.DiamondDifficultyFactor or ArcadeEnum.ConstId.CassetteDifficultyFactor, true, "#")

					if not factorList[difficulty] then
						local factor = 1

						count = math.floor(count * factor)
					end
				end

				attrDict[resId] = count
			end

			local collectionIdList = characterMO:getCollectionIdList(ArcadeGameEnum.CollectionType.Jewelry)

			for _, collectionId in ipairs(collectionIdList) do
				local uidList = characterMO:getCollectionUidList(collectionId)

				ArcadeGameHelper._fillCollection(ArcadeGameEnum.CollectionType.Jewelry, collectionId, #uidList, nil, collectionDataList)
			end

			local weaponUidList = characterMO:getCollectionUidListWithType(ArcadeGameEnum.CollectionType.Weapon)

			for _, weaponUid in ipairs(weaponUidList) do
				local weaponMO = characterMO:getCollectionMO(weaponUid)
				local id = weaponMO:getId()
				local totalDurability = weaponMO:getTotalDurability()
				local useTimes = weaponMO:getUsedTimes()
				local newWeaponIndex = ArcadeGameHelper._fillCollection(ArcadeGameEnum.CollectionType.Weapon, id, totalDurability, useTimes, nil, weaponDataList, curWeaponIndex)

				if newWeaponIndex then
					curWeaponIndex = newWeaponIndex
				end
			end
		end
	end

	return {
		isWin = isWin,
		isReset = isReset,
		characterId = characterId,
		passLevelCount = passLevelCount or 0,
		killMonsterNum = killMonsterNum or 0,
		allCoinNum = allCoinNum or 0,
		maxScore = maxScore or 0,
		attrDict = attrDict,
		collectionDataList = collectionDataList,
		weaponDataList = weaponDataList
	}
end

function ArcadeGameHelper._fillCollection(type, id, totalDurability, useTimes, refCollectionList, refWeaponDataList, curWeaponIndex)
	if type == ArcadeGameEnum.CollectionType.Jewelry then
		local collectionData = {
			id = id,
			durability = totalDurability
		}

		table.insert(refCollectionList, collectionData)
	elseif type == ArcadeGameEnum.CollectionType.Weapon then
		local weaponData = refWeaponDataList[curWeaponIndex]

		if weaponData then
			weaponData.id = id
			weaponData.durability = totalDurability
			weaponData.useTimes = useTimes

			return curWeaponIndex + 1
		else
			logError(string.format("ArcadeGameHelper._fillCollection error, has too more weapon, max:%s, cur:%s", #refWeaponDataList, curWeaponIndex))
		end
	end
end

function ArcadeGameHelper.getServerArcadeInsideInfo(isWin, isSettle)
	return {
		player = ArcadeGameHelper.getServerArcadePlayerInfo(),
		attrContainer = ArcadeGameHelper.getAttributeInfoDict(isSettle),
		collectibleSlots = ArcadeGameHelper.getCollectionInfo(),
		basicSkillInfo = ArcadeGameHelper.getBombInfo(),
		bigSkillInfo = ArcadeGameHelper.getSkillInfo(),
		prop = ArcadeGameHelper.getPropInfo(),
		extendInfo = ArcadeGameHelper.getExtendInfo(isWin, isSettle),
		passiveSkillIds = ArcadeGameHelper.getPassiveSkillInfo()
	}
end

function ArcadeGameHelper.getServerArcadePlayerInfo()
	local result = {}
	local characterMO = ArcadeGameModel.instance:getCharacterMO()

	if characterMO then
		result.id = characterMO:getId()

		local skillSetMO = characterMO:getSkillSetMO()

		if skillSetMO then
			result.skillCounterBox = skillSetMO:getNeedSaveSkillCounterBox()
		end

		result.attackAttrId = characterMO:getAttackAttrId()
	end

	return result
end

function ArcadeGameHelper.getAttributeInfoDict(isSettle)
	local attrValues = {}
	local characterMO = ArcadeGameModel.instance:getCharacterMO()

	if characterMO then
		for _, attrId in pairs(ArcadeGameEnum.BaseAttr) do
			if attrId == ArcadeGameEnum.BaseAttr.hp then
				local hp = characterMO:getHp()

				attrValues[#attrValues + 1] = {
					id = attrId,
					base = hp
				}
			else
				local attrMO = characterMO:getAttrMO(attrId)

				if attrMO then
					attrValues[#attrValues + 1] = {
						id = attrId,
						base = attrMO:getBase(),
						rate = attrMO:getRate(),
						extra = attrMO:getIncrease()
					}
				end
			end
		end

		for _, resId in pairs(ArcadeGameEnum.CharacterResource) do
			local resMO = characterMO:getResourceMO(resId)

			if resMO then
				local count = resMO:getCount()

				if isSettle and resId == ArcadeGameEnum.CharacterResource.Diamond then
					local difficulty = ArcadeGameModel.instance:getDifficulty()
					local diamondFactorList = ArcadeConfig.instance:getArcadeConst(ArcadeEnum.ConstId.DiamondDifficultyFactor, true, "#")

					if not diamondFactorList[difficulty] then
						count = math.floor(count * diamondFactorList[difficulty])
					end
				end

				attrValues[#attrValues + 1] = {
					id = resId,
					base = count,
					rate = resMO:getGainRate(),
					extra = resMO:getUseDiscount()
				}
			end
		end

		for _, attrId in pairs(ArcadeGameEnum.GameAttribute) do
			local value = ArcadeGameModel.instance:getGameAttribute(attrId)

			attrValues[#attrValues + 1] = {
				id = attrId,
				base = value
			}
		end

		for _, attrId in pairs(ArcadeGameEnum.GameSwitch) do
			local isOn = ArcadeGameModel.instance:getGameSwitchIsOn(attrId)

			attrValues[#attrValues + 1] = {
				id = attrId,
				base = isOn and 1 or 0
			}
		end
	end

	return {
		attrValues = attrValues
	}
end

function ArcadeGameHelper.getCollectionInfo()
	local result = {}
	local characterMO = ArcadeGameModel.instance:getCharacterMO()
	local collectionDict = characterMO and characterMO:getCollectionDict()

	if collectionDict then
		for _, collectionMO in pairs(collectionDict) do
			local skillCounterBox
			local skillSetMO = collectionMO:getSkillSetMO()
			local data = {
				type = collectionMO:getType(),
				collectible = {
					id = collectionMO:getId(),
					durability = collectionMO:getTotalDurability(),
					useTimes = collectionMO:getUsedTimes(),
					counterBox = (skillSetMO or nil) and skillSetMO:getNeedSaveSkillCounterBox()
				}
			}

			table.insert(result, data)
		end
	end

	return result
end

function ArcadeGameHelper.getBombInfo()
	return
end

function ArcadeGameHelper.getSkillInfo()
	return
end

function ArcadeGameHelper.getPropInfo()
	local result = {}

	result.hotfix = {}

	local portalExtractDict = ArcadeGameModel.instance:getPortalExtractDict()

	if portalExtractDict and next(portalExtractDict) then
		local jsonPortalExtract = cjson.encode(portalExtractDict)

		if not string.nilorempty(jsonPortalExtract) then
			result.hotfix[1] = jsonPortalExtract
		end
	end

	result.areaId = ArcadeGameModel.instance:getCurAreaIndex()
	result.roomId = ArcadeGameModel.instance:getCurRoomId()
	result.progress = ArcadeGameModel.instance:getTransferNodeIndex()
	result.difficulty = ArcadeGameModel.instance:getDifficulty()
	result.maxKillMonsterNum = ArcadeGameModel.instance:getKillMonsterNum()
	result.totalGainGoldNum = ArcadeGameModel.instance:getAllCoinNum()
	result.highestScore = ArcadeGameModel.instance:getMaxScore()
	result.clearedRoomNum = ArcadeGameModel.instance:getPassLevelCount()

	return result
end

function ArcadeGameHelper.getExtendInfo(isWin, isSettle)
	local result = {
		settleScore = 0,
		addedBook = {},
		unlockRoleIds = {},
		unlockDifficultyIds = {}
	}
	local books = {}
	local unlockHandBookDict = ArcadeGameModel.instance:getUnlockHandBookDict()

	if unlockHandBookDict then
		for type, typeDict in pairs(unlockHandBookDict) do
			local eleId = {}

			for id, _ in pairs(typeDict) do
				table.insert(eleId, id)
			end

			table.insert(books, {
				type = type,
				eleId = eleId
			})
		end
	end

	result.addedBook.books = books

	local characterMO = ArcadeGameModel.instance:getCharacterMO()

	if characterMO then
		local cassetteCount = characterMO:getResourceCount(ArcadeGameEnum.CharacterResource.Cassette)

		if isSettle then
			local difficulty = ArcadeGameModel.instance:getDifficulty()
			local cassetteFactorList = ArcadeConfig.instance:getArcadeConst(ArcadeEnum.ConstId.CassetteDifficultyFactor, true, "#")

			if not cassetteFactorList[difficulty] then
				local cassetteFactor = 1

				cassetteCount = math.floor(cassetteCount * cassetteFactor)
			end
		end

		result.settleScore = cassetteCount
	end

	local unlockCharacterDict = ArcadeGameModel.instance:getUnlockCharacterDict()

	if unlockCharacterDict then
		for characterId, _ in pairs(unlockCharacterDict) do
			table.insert(result.unlockRoleIds, characterId)
		end
	end

	if isWin then
		local difficulty = ArcadeGameModel.instance:getDifficulty()
		local nextDifficulty = difficulty + 1
		local cfg = ArcadeConfig.instance:getDifficultyCfg(nextDifficulty)

		if cfg then
			table.insert(result.unlockDifficultyIds, nextDifficulty)
		end
	end

	return result
end

function ArcadeGameHelper.getPassiveSkillInfo()
	local result = {}
	local characterMO = ArcadeGameModel.instance:getCharacterMO()
	local skillSetMO = characterMO and characterMO:getSkillSetMO()

	if skillSetMO then
		local skillIdList = skillSetMO:getSkillIdList()

		for i, skillId in ipairs(skillIdList) do
			result[i] = skillId
		end
	end

	return result
end

function ArcadeGameHelper.getDropItem(dropId)
	local dropParam = ArcadeConfig.instance:getDropParam(dropId)

	if not dropParam then
		return
	end

	local id, count
	local dropItemType = dropParam.dropItemType
	local param = dropParam.param

	if dropItemType == ArcadeGameEnum.DropItemType.Resource then
		id, count = ArcadeGameHelper._dropResource(param)
	elseif dropItemType == ArcadeGameEnum.DropItemType.Collection then
		id = ArcadeGameHelper._dropCollection(param)
	elseif dropItemType == ArcadeGameEnum.DropItemType.Character then
		id = ArcadeGameHelper._dropCharacter(param)
	end

	if not id then
		return
	end

	return {
		dropItemType = dropItemType,
		id = id,
		count = count
	}
end

function ArcadeGameHelper._dropResource(param)
	local id, count
	local list = string.split(param, ":")
	local isDrop = ArcadeGameHelper.isProbabilityHit(tonumber(list[1]), ArcadeGameEnum.Const.MaxDropProbability)

	if isDrop then
		local arr = string.splitToNumber(list[2], "#")

		id = arr[1]
		count = arr[2]
	end

	return id, count
end

function ArcadeGameHelper._dropCollection(param)
	local list = string.split(param, ":")

	if list[1] == "random" then
		local totalWeight = 0
		local canDropCollectionList = {}
		local arr = string.split(list[2], "#")
		local qualityDict = {}
		local qualityList = string.splitToNumber(arr[2], ",")

		for _, quality in ipairs(qualityList) do
			qualityDict[quality] = true
		end

		local allCollectionIdList = ArcadeConfig.instance:getCollectionIdListWithType(arr[1], qualityDict)
		local characterMO = ArcadeGameModel.instance:getCharacterMO()

		for _, collectionId in ipairs(allCollectionIdList) do
			local weight = 0
			local isUnique = ArcadeConfig.instance:getCollectionIsUnique(collectionId)
			local characterHas = characterMO and characterMO:getHasCollection(collectionId)

			if not isUnique or not characterHas then
				weight = ArcadeConfig.instance:getCollectionDropWeight(collectionId)
			end

			if weight and weight > 0 then
				totalWeight = totalWeight + weight
				canDropCollectionList[#canDropCollectionList + 1] = collectionId
			end
		end

		local sumWeight = 0
		local randomWeight = math.random(totalWeight)

		for _, collectionId in ipairs(canDropCollectionList) do
			local weight = ArcadeConfig.instance:getCollectionDropWeight(collectionId)

			sumWeight = sumWeight + weight

			if randomWeight <= sumWeight then
				return collectionId
			end
		end
	elseif tonumber(list[1]) then
		local isDrop = ArcadeGameHelper.isProbabilityHit(tonumber(list[1]), ArcadeGameEnum.Const.MaxDropProbability)

		if isDrop then
			return tonumber(list[2])
		end
	end
end

function ArcadeGameHelper._dropCharacter(param)
	return tonumber(param)
end

function ArcadeGameHelper.isProbabilityHit(probability, maxProbability)
	local randomValue = math.random(1, maxProbability)

	return randomValue <= probability
end

function ArcadeGameHelper.getEventOptionHandleFunc(eventOptionType)
	local handler = ArcadeGameEnum.EventOptionHandler[eventOptionType]

	if not handler then
		logError(string.format("ArcadeGameHelper:getEventOptionHandleFunc error, eventOption:%s no handler", eventOptionType))
	end

	return handler
end

function ArcadeGameHelper._eventChangeRoom(entityType, entityId, uid, eventOptionParam, extraParam)
	local curNodeIndex = ArcadeGameModel.instance:getTransferNodeIndex()
	local nextNodeIndex = curNodeIndex + 1

	ArcadeGameModel.instance:setTransferNodeIndex(nextNodeIndex)
	ArcadeGameModel.instance:addPassLevelCount()
	ArcadeGameHelper.addSettleRewardCount()
	ArcadeGameController.instance:change2Room(tonumber(eventOptionParam), true)
	ArcadeGameModel.instance:addPortalExtractionCount(entityId)

	if extraParam then
		ArcadeStatHelper.instance:sendExitRoom(extraParam.exitRoomId, extraParam.portalIdList, entityId)
	end
end

function ArcadeGameHelper._eventNextArea(entityType, entityId, uid, eventOptionParam)
	ArcadeGameModel.instance:addPassLevelCount()
	ArcadeGameHelper.addSettleRewardCount(true)
	ArcadeGameController.instance:enterNextArea(true)
	ArcadeStatHelper.instance:sendNextArea()
end

function ArcadeGameHelper._eventBuy(entityType, entityId, uid, eventOptionParam, extraParam)
	if entityType ~= ArcadeGameEnum.EntityType.Goods or not eventOptionParam then
		return
	end

	local collectionId = tonumber(eventOptionParam)
	local characterMO = ArcadeGameModel.instance:getCharacterMO()
	local costId = ArcadeGameEnum.CharacterResource.GameCoin
	local goodsMO = ArcadeGameModel.instance:getMOWithType(entityType, uid)
	local costNum = goodsMO and goodsMO:getPrice() or 0
	local curCoin = characterMO and characterMO:getResourceCount(costId) or 0

	if curCoin < costNum then
		return
	end

	local gridX, gridY
	local mo = ArcadeGameModel.instance:getMOWithType(entityType, uid)

	if mo then
		local var_62_0, var_62_1 = mo:getGridPos()

		gridY = var_62_1
	end

	local x, y, z = ArcadeGameHelper:getGridWorldPos(gridY)
	local gainPos = {
		x = x,
		y = y,
		z = z
	}

	ArcadeGameController.instance:removeEntity(entityType, uid)
	ArcadeGameController.instance:changeResCount(costId, -costNum)
	ArcadeGameController.instance:gainCollection(collectionId, gainPos)

	if extraParam then
		ArcadeStatHelper.instance:sendBuyGoods(extraParam, collectionId)
	end

	return true
end

function ArcadeGameHelper._eventTriggerPassiveSkill(entityType, entityId, uid, eventOptionParam)
	if not eventOptionParam then
		return
	end

	local interactUnitMO = ArcadeGameModel.instance:getMOWithType(entityType, uid)

	if not interactUnitMO then
		return
	end

	local skillList = string.splitToNumber(eventOptionParam, "#")

	for _, skillId in ipairs(skillList) do
		ArcadeGameSkillController.instance:useSkill(interactUnitMO, skillId)
	end

	return true
end

function ArcadeGameHelper._eventStorePassword(entityType, entityId, uid, eventOptionParam)
	local pwdValidatorMOList = ArcadeGameModel.instance:getEntityMOList(ArcadeGameEnum.EntityType.PWDValidator)
	local pwdValidatorMO = pwdValidatorMOList and pwdValidatorMOList[1]

	if not pwdValidatorMO then
		return
	end

	local passwordLength = pwdValidatorMO:getCurPasswordCount()
	local passwordNum = tonumber(eventOptionParam)

	if passwordLength >= ArcadeGameEnum.Const.MaxPasswordLength or not passwordNum then
		return
	end

	pwdValidatorMO:addPasswordNum(passwordNum)

	local pwdValidatorUid = pwdValidatorMO:getUid()

	ArcadeGameController.instance:dispatchEvent(ArcadeEvent.RefreshEntityIcon, ArcadeGameEnum.EntityType.PWDValidator, pwdValidatorUid)
end

function ArcadeGameHelper._eventConfirmPassword(entityType, entityId, uid, eventOptionParam)
	local paramArr = string.split(eventOptionParam, "#")

	if entityType ~= ArcadeGameEnum.EntityType.PWDValidator or not paramArr then
		return
	end

	local pwdValidatorMO = ArcadeGameModel.instance:getMOWithType(entityType, uid)

	if not pwdValidatorMO then
		return
	end

	local correctPassword = paramArr[1]
	local skillId = tonumber(paramArr[2])
	local password = pwdValidatorMO:getPassword()

	if password == correctPassword then
		ArcadeGameSkillController.instance:useSkill(pwdValidatorMO, skillId)
	else
		GameFacade.showToast(ToastEnum.V3a7ArcadePwdError)
	end

	return true
end

function ArcadeGameHelper._eventResetPassword(entityType, entityId, uid, eventOptionParam)
	if entityType ~= ArcadeGameEnum.EntityType.PWDValidator then
		return
	end

	local pwdValidatorMO = ArcadeGameModel.instance:getMOWithType(entityType, uid)

	if not pwdValidatorMO then
		return
	end

	pwdValidatorMO:clearPassword()

	local pwdValidatorUid = pwdValidatorMO:getUid()

	ArcadeGameController.instance:dispatchEvent(ArcadeEvent.RefreshEntityIcon, ArcadeGameEnum.EntityType.PWDValidator, pwdValidatorUid)
end

function ArcadeGameHelper.getEventOptionConditionCheckFunc(conditionType)
	local handler = ArcadeGameEnum.EventOptionConditionCheckHandler[conditionType]

	if not handler then
		logError(string.format("ArcadeGameHelper:getEventOptionConditionCheckFunc error, conditionType:%s no handler", conditionType))
	end

	return handler
end

function ArcadeGameHelper._checkAttribute(eventOptionId, param)
	if not param then
		return
	end

	local characterMO = ArcadeGameModel.instance:getCharacterMO()

	if not characterMO then
		return
	end

	local attrId = tonumber(param[2]) or 0
	local curValue = 0
	local attrType = ArcadeGameHelper.getAttrTypeByAttrId(attrId)

	if attrType == ArcadeGameEnum.AttrType.Attack then
		curValue = characterMO:getAttributeValue(attrId)
	elseif attrType == ArcadeGameEnum.AttrType.Resource then
		curValue = characterMO:getResourceCount(attrId)
	elseif attrType == ArcadeGameEnum.AttrType.GameAttr then
		curValue = ArcadeGameModel.instance:getGameAttribute(attrId)
	end

	local targetValue = tonumber(param[3]) or 0

	return targetValue <= curValue
end

function ArcadeGameHelper._checkCollection(eventOptionId, param)
	if not param then
		return
	end

	local characterMO = ArcadeGameModel.instance:getCharacterMO()

	if not characterMO then
		return
	end

	local collectionList = string.splitToNumber(param[2], ",")

	for _, collectionId in ipairs(collectionList) do
		if characterMO:getHasCollection(collectionId) then
			return true
		end
	end
end

function ArcadeGameHelper._checkSkillCanSummon(eventOptionId, param)
	if not param then
		return
	end

	local curRoom = ArcadeGameController.instance:getCurRoom()

	if not curRoom then
		return
	end

	local eventOptionType = ArcadeConfig.instance:getEventOptionType(eventOptionId)

	if eventOptionType ~= ArcadeGameEnum.EventOptionType.TriggerPassiveSkill then
		return true
	end

	local summonMonsterDataList = {}
	local cfgEffList = ArcadeGameEnum.TriggerCfgKeys.Effect
	local eventOptionParam = ArcadeConfig.instance:getEventOptionParam(eventOptionId)
	local skillList = string.splitToNumber(eventOptionParam, "#")

	for _, skillId in ipairs(skillList) do
		local skillCfg = ArcadeConfig.instance:getPassiveSkillCfg(skillId)

		for _, strEffKey in ipairs(cfgEffList) do
			local effectStr = skillCfg[strEffKey]
			local params = string.split(effectStr, "#")
			local hitName = params and params[1]

			if hitName == ArcadeGameEnum.SkillHitName.Summon then
				for i = 2, #params do
					local arr = string.splitToNumber(params[i], ",")
					local monsterId = arr[1]
					local sizeX, sizeY = ArcadeConfig.instance:getMonsterSize(monsterId)

					if sizeX > 0 and sizeY > 0 then
						local entityData = {
							id = monsterId,
							x = arr[2],
							y = arr[3],
							sizeX = sizeX,
							sizeY = sizeY,
							entityType = ArcadeGameEnum.EntityType.Monster
						}

						table.insert(summonMonsterDataList, entityData)
					end
				end
			end
		end
	end

	if #summonMonsterDataList <= 0 then
		return true
	end

	local canPlaceDataList = curRoom:filterCanPlaceEntityList(summonMonsterDataList, false)

	if not canPlaceDataList or #canPlaceDataList ~= #summonMonsterDataList then
		return false
	end

	return true
end

function ArcadeGameHelper.sortSkillList(aSkill, bSkill)
	local aOrder = aSkill:getTriggerOrder()
	local bOrder = bSkill:getTriggerOrder()

	return aOrder < bOrder
end

return ArcadeGameHelper
