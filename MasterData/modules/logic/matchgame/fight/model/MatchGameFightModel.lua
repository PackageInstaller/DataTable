-- chunkname: @modules/logic/matchgame/fight/model/MatchGameFightModel.lua

module("modules.logic.matchgame.fight.model.MatchGameFightModel", package.seeall)

local MatchGameFightModel = class("MatchGameFightModel", BaseModel)

function MatchGameFightModel:onInit()
	self:reInit()
end

function MatchGameFightModel:reInit()
	self:reInitData()
end

function MatchGameFightModel:reInitData()
	self.isFeverState = false
	self.gameInfoData = {}
	self.heroFightInfoMap = {}
	self.fightGoalDataMap = {}
	self.matchElementNunMap = {}
	self.beadTypePool = nil
	self.skillExcuteMatchElementNumMap = {}
	self.skillExcuteMap = {}
	self.skillElementDropRateMap = {}
	self.curGameTime = 0
	self.isGuiding = false
	self.heroCarrerMap = {}
end

function MatchGameFightModel:initConfigData(episodeId)
	self:reInitData()

	local episodeCo = lua_activity244_episode.configDict[episodeId]
	local matchLevelId = episodeCo and episodeCo.matchLevelId

	self.actId = MatchGameModel.instance:getCurActId()

	local matchLevelConfig = MatchGameConfig.instance:getLevelConfig(matchLevelId)
	local mapData = addGlobalModule("modules.configs.matchgame.lua_matchgame_map_" .. matchLevelConfig.boardLayoutId)

	self.gameInfoData.episodeId = episodeId
	self.gameInfoData.mapLevelId = matchLevelId
	self.gameInfoData.gameConfig = matchLevelConfig
	self.gameInfoData.elementConfig = mapData.elementConfig
	self.gameInfoData.enemyCoDataList = {}

	local monsterIdList = string.splitToNumber(matchLevelConfig.monsterId, "#")

	for _, monsterId in ipairs(monsterIdList) do
		local enemyCoData = self:initEnemyCoDataList(monsterId)

		table.insert(self.gameInfoData.enemyCoDataList, enemyCoData)
	end

	self.planeWidthNum = tonumber(MatchGameConfig.instance:getConstValue(self.actId, MatchGameFightEnum.ConstId.PlaneWidthNum))
	self.planeHeightNum = tonumber(MatchGameConfig.instance:getConstValue(self.actId, MatchGameFightEnum.ConstId.PlaneHeightNum))

	math.randomseed(os.time())

	self.maxChainNum = 0
	self.weakAttackNum = 0
	self.totalCureNum = 0
	self.totalSkillUseNum = 0
	self.totalHeroDamage = 0
end

function MatchGameFightModel:getGameInfoData()
	return self.gameInfoData
end

function MatchGameFightModel:initEnemyCoDataList(monsterId)
	local enemyCoData = {}

	enemyCoData.monsterId = monsterId
	enemyCoData.config = MatchGameFightConfig.instance:getMonsterConfig(monsterId)
	enemyCoData.attrConfig = MatchGameFightConfig.instance:getMonsterAttrConfig(enemyCoData.config.template)

	if not enemyCoData.attrConfig then
		logError("怪物:" .. monsterId .. "属性配置不存在,请检查")
	end

	enemyCoData.skillTemplateConfig = MatchGameFightConfig.instance:getMonsterSkillTemplateConfig(enemyCoData.config.skillTemplate)

	if not enemyCoData.skillTemplateConfig then
		logError("怪物:" .. monsterId .. "技能模板配置不存在,请检查")
	end

	return enemyCoData
end

function MatchGameFightModel:getFightGoalData(matchLevelId)
	local matchLevelConfig = MatchGameConfig.instance:getLevelConfig(matchLevelId)
	local goalData = self.fightGoalDataMap[matchLevelId]

	if not goalData then
		goalData = {
			matchLevelId = matchLevelId,
			goalList = {}
		}

		for goalIndex = 1, 3 do
			local goalStr = matchLevelConfig["levelGoal" .. goalIndex]

			if not string.nilorempty(goalStr) then
				local goalInfo = string.splitToNumber(goalStr, "#")

				table.insert(goalData.goalList, goalInfo)
			end
		end

		self.fightGoalDataMap[matchLevelId] = goalData
	end

	return goalData
end

function MatchGameFightModel:setFeverState(state)
	self.isFeverState = state
end

function MatchGameFightModel:getisFeverState()
	return self.isFeverState
end

function MatchGameFightModel:getPlaneItemAnchorPos(posXIndex, posYIndex)
	local posX = (posXIndex - 1) * (MatchGameFightEnum.planeItemWidth + MatchGameFightEnum.planeItemSpace) + MatchGameFightEnum.planeItemWidth / 2
	local posY = (posYIndex - 1) * (MatchGameFightEnum.planeItemHeight + MatchGameFightEnum.planeItemSpace) + MatchGameFightEnum.planeItemHeight / 2

	return posX, -posY
end

function MatchGameFightModel:buildRuntimeGrid(elementItemMap)
	local grid = {}

	for x = 1, self.planeWidthNum do
		grid[x] = {}

		for y = 1, self.planeHeightNum do
			if elementItemMap[x] then
				grid[x][y] = elementItemMap[x] and elementItemMap[x].comp and {
					itemType = elementItemMap[x].comp.itemType,
					itemParam = elementItemMap[x].comp.itemParam
				} or {
					itemParam = 0,
					itemType = MatchGameFightEnum.ElementItemType.Empty
				}
			end
		end
	end

	return grid
end

function MatchGameFightModel:cannotFallVertically(grid, x, y)
	if y + 1 > self.planeHeightNum then
		return true
	end

	return grid[x][y + 1].itemType ~= MatchGameFightEnum.ElementItemType.Empty
end

function MatchGameFightModel:chooseDiagonalSource(grid, x, y)
	local Empty = MatchGameFightEnum.ElementItemType.Empty
	local Box = MatchGameFightEnum.ElementItemType.Box
	local leftOk = false
	local rightOk = false

	if x - 1 >= 1 and y - 1 >= 1 then
		local c = grid[x - 1][y - 1]

		if c.itemType ~= Empty and c.itemType ~= Box and self:cannotFallVertically(grid, x - 1, y - 1) then
			leftOk = true
		end
	end

	if x + 1 <= self.planeWidthNum and y - 1 >= 1 then
		local c = grid[x + 1][y - 1]

		if c.itemType ~= Empty and c.itemType ~= Box and self:cannotFallVertically(grid, x + 1, y - 1) then
			rightOk = true
		end
	end

	if leftOk and rightOk then
		if (x + y) % 2 == 0 then
			return {
				sx = x - 1,
				sy = y - 1
			}
		else
			return {
				sx = x + 1,
				sy = y - 1
			}
		end
	elseif leftOk then
		return {
			sx = x - 1,
			sy = y - 1
		}
	elseif rightOk then
		return {
			sx = x + 1,
			sy = y - 1
		}
	end

	return nil
end

function MatchGameFightModel:computeGravityAndFill(elementItemMap)
	local grid = self:buildRuntimeGrid(elementItemMap)
	local Empty = MatchGameFightEnum.ElementItemType.Empty
	local Box = MatchGameFightEnum.ElementItemType.Box
	local rounds = {}
	local maxLoop = self.planeWidthNum * self.planeHeightNum * 2 + self.planeWidthNum
	local loopCount = 0

	while loopCount < maxLoop do
		loopCount = loopCount + 1

		local roundMoves = {}
		local verticalMoved = false
		local topSpawned = false

		for x = 1, self.planeWidthNum do
			for y = self.planeHeightNum - 1, 1, -1 do
				local cell = grid[x][y]

				if cell.itemType ~= Empty and cell.itemType ~= Box and grid[x][y + 1].itemType == Empty then
					grid[x][y + 1] = cell
					grid[x][y] = {
						itemParam = 0,
						itemType = Empty
					}

					table.insert(roundMoves, {
						fromX = x,
						fromY = y,
						toX = x,
						toY = y + 1
					})

					verticalMoved = true
				end
			end
		end

		for x = 1, self.planeWidthNum do
			if grid[x][1].itemType == Empty then
				local newItemType, newItemParam = self:getRandomBeadType()

				grid[x][1] = {
					itemType = newItemType,
					itemParam = newItemParam
				}

				table.insert(roundMoves, {
					toY = 1,
					spawnY = 0,
					isNew = true,
					toX = x,
					itemType = newItemType,
					itemParam = newItemParam,
					spawnX = x
				})

				topSpawned = true
			end
		end

		if not verticalMoved and not topSpawned then
			local usedSource = {}
			local plans = {}

			for y = self.planeHeightNum, 2, -1 do
				for x = 1, self.planeWidthNum do
					if grid[x][y].itemType == Empty then
						local chosen = self:chooseDiagonalSource(grid, x, y)

						if chosen then
							local key = chosen.sx * (self.planeWidthNum + 1) + chosen.sy

							if not usedSource[key] then
								usedSource[key] = true

								table.insert(plans, {
									sx = chosen.sx,
									sy = chosen.sy,
									tx = x,
									ty = y
								})
							end
						end
					end
				end
			end

			for _, p in ipairs(plans) do
				grid[p.tx][p.ty] = grid[p.sx][p.sy]
				grid[p.sx][p.sy] = {
					itemParam = 0,
					itemType = Empty
				}

				table.insert(roundMoves, {
					fromX = p.sx,
					fromY = p.sy,
					toX = p.tx,
					toY = p.ty
				})
			end

			if #plans == 0 then
				break
			end
		end

		if #roundMoves > 0 then
			table.insert(rounds, roundMoves)
		else
			break
		end
	end

	return rounds
end

function MatchGameFightModel:getBeadTypePool()
	if self.beadTypePool then
		return self.beadTypePool
	end

	if self.gameInfoData and self.gameInfoData.gameConfig then
		if not self.gameInfoData.gameConfig.gemTypeNum then
			local gemTypeNum = MatchGameFightEnum.BeadTypeCount

			if gemTypeNum > MatchGameFightEnum.BeadTypeCount then
				gemTypeNum = MatchGameFightEnum.BeadTypeCount
			end

			local pool = {}
			local usedTypeMap = {}

			if self.heroFightInfoMap then
				for _, heroFightMo in pairs(self.heroFightInfoMap) do
					local career = heroFightMo and heroFightMo.career

					if career and career >= 1 and career <= MatchGameFightEnum.BeadTypeCount and not usedTypeMap[career] then
						usedTypeMap[career] = true

						table.insert(pool, career)

						if gemTypeNum <= #pool then
							break
						end
					end
				end
			end

			if gemTypeNum > #pool then
				local remaining = {}

				for i = 1, MatchGameFightEnum.BeadTypeCount do
					if not usedTypeMap[i] then
						table.insert(remaining, i)
					end
				end

				while gemTypeNum > #pool and #remaining > 0 do
					local idx = math.random(1, #remaining)

					table.insert(pool, remaining[idx])
					table.remove(remaining, idx)
				end
			end

			self.beadTypePool = pool

			return pool
		end
	end
end

function MatchGameFightModel:getSkillElementDropRate(type, param)
	local elementId = MatchGameFightConfig.instance:getElementId(type, param or 0)

	if not elementId then
		return nil
	end

	return self.skillElementDropRateMap[elementId]
end

function MatchGameFightModel:getSkillElementDropRateMap()
	return self.skillElementDropRateMap
end

function MatchGameFightModel:getRandomBeadType(onlyBead)
	local var_18_0 = self.gameInfoData

	if self.gameInfoData then
		var_18_0 = self.gameInfoData.gameConfig

		if self.gameInfoData.gameConfig then
			local dropTemplateId = self.gameInfoData.gameConfig.gemTemplateId

			if dropTemplateId then
				::label_18_0::

				local dropRateData = MatchGameFightConfig.instance:getDropRateConfig(dropTemplateId)

				if not self:getSkillElementDropRate(MatchGameFightEnum.ElementItemType.Cure, 0) then
					if dropRateData then
						local var_18_1 = dropRateData.healDropRate

						if not dropRateData.healDropRate then
							var_18_1 = 0

							local healDropRate = 0

							if not self:getSkillElementDropRate(MatchGameFightEnum.ElementItemType.Bomb, 0) then
								if dropRateData then
									local var_18_2 = dropRateData.bombDropRate

									if not dropRateData.bombDropRate then
										var_18_2 = 0

										local bombDropRate = 0

										if not onlyBead then
											local randomDropRate = math.random(1, 1000)

											if randomDropRate <= healDropRate then
												return MatchGameFightEnum.ElementItemType.Cure, 0
											elseif healDropRate < randomDropRate and randomDropRate <= healDropRate + bombDropRate then
												return MatchGameFightEnum.ElementItemType.Bomb, 0
											end
										end

										local pool = self:getBeadTypePool()

										if not pool or #pool == 0 then
											return MatchGameFightEnum.ElementItemType.Bead, math.random(1, MatchGameFightEnum.BeadTypeCount)
										end

										local fixedRateMap = {}
										local fixedTotalRate = 0
										local fixedCount = 0

										for _, beadType in ipairs(pool) do
											local skillDropRate = self:getSkillElementDropRate(MatchGameFightEnum.ElementItemType.Bead, beadType)

											if skillDropRate then
												fixedRateMap[beadType] = skillDropRate
												fixedTotalRate = fixedTotalRate + skillDropRate
												fixedCount = fixedCount + 1
											end
										end

										if fixedCount == 0 then
											return MatchGameFightEnum.ElementItemType.Bead, pool[math.random(1, #pool)]
										end

										local remainCount = #pool - fixedCount
										local remainRate = Mathf.Max(0, 1000 - fixedTotalRate)

										if remainCount > 0 then
											if not (remainRate / remainCount) then
												local averRate = 0
												local randomBeadRate = math.random(1, 1000)
												local accumRate = 0

												for _, beadType in ipairs(pool) do
													accumRate = accumRate + (fixedRateMap[beadType] or averRate)

													if randomBeadRate <= accumRate then
														return MatchGameFightEnum.ElementItemType.Bead, beadType
													end
												end

												return MatchGameFightEnum.ElementItemType.Bead, pool[#pool]
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
end

function MatchGameFightModel:getBoxDropElement()
	local var_19_0 = self.gameInfoData

	if self.gameInfoData then
		var_19_0 = self.gameInfoData.gameConfig

		if self.gameInfoData.gameConfig then
			local dropTemplateId = self.gameInfoData.gameConfig.gemTemplateId

			if dropTemplateId then
				::label_19_0::

				local dropRateData = MatchGameFightConfig.instance:getDropRateConfig(dropTemplateId)
				local healDropRate = 0
				local bombDropRate = 0

				if #dropRateData.boxDropRateDataList > 0 then
					for _, boxDropRateData in ipairs(dropRateData.boxDropRateDataList) do
						if boxDropRateData[1] == MatchGameFightEnum.ElementItemType.Cure then
							healDropRate = self:getSkillElementDropRate(MatchGameFightEnum.ElementItemType.Cure, 0) or boxDropRateData[2]
						elseif boxDropRateData[1] == MatchGameFightEnum.ElementItemType.Bomb then
							bombDropRate = self:getSkillElementDropRate(MatchGameFightEnum.ElementItemType.Bomb, 0) or boxDropRateData[2]
						end
					end

					local randomDropRate = math.random(1, 1000)

					if randomDropRate <= healDropRate then
						return MatchGameFightEnum.ElementItemType.Cure
					elseif healDropRate < randomDropRate and randomDropRate <= healDropRate + bombDropRate then
						return MatchGameFightEnum.ElementItemType.Bomb
					end
				end

				return MatchGameFightEnum.ElementItemType.Empty
			end
		end
	end
end

function MatchGameFightModel:restartGame(episodeId)
	local restartEpisodeId = episodeId or self.gameInfoData.episodeId

	self:initConfigData(restartEpisodeId)
	self:initHeroFightInfo()
end

function MatchGameFightModel:initHeroFightInfo()
	local heroGroupMap = MatchGameHeroGroupModel.instance:getCurTeamHeroes(true)
	local maxRoleNum = MatchGameConfig.instance:getEpisodeRoleNum(self.gameInfoData.episodeId)

	for posIndex, heroSingleGroupMo in pairs(heroGroupMap) do
		local heroFightMo = self.heroFightInfoMap[posIndex]

		if not heroFightMo and posIndex <= maxRoleNum and heroSingleGroupMo and heroSingleGroupMo.id ~= 0 then
			heroFightMo = MatchGameHeroFightMo.New()

			heroFightMo:initData({
				heroSingleGroupMo = heroSingleGroupMo,
				posIndex = posIndex
			})

			self.heroFightInfoMap[posIndex] = heroFightMo
		end
	end
end

function MatchGameFightModel:getHeroFightInfoMap()
	return self.heroFightInfoMap
end

function MatchGameFightModel:setMatchElementNum(type, param)
	local elementId = MatchGameFightConfig.instance:getElementId(type, param)

	if not elementId then
		return
	end

	self.matchElementNunMap[elementId] = self.matchElementNunMap[elementId] or 0
	self.matchElementNunMap[elementId] = self.matchElementNunMap[elementId] + 1
end

function MatchGameFightModel:getMatchElementNum(elementId)
	return self.matchElementNunMap[elementId] or 0
end

function MatchGameFightModel:setSkillExcuteMatchElementNum(type, param)
	local elementId = MatchGameFightConfig.instance:getElementId(type, param)

	if not elementId then
		return
	end

	self.skillExcuteMatchElementNumMap[elementId] = self.skillExcuteMatchElementNumMap[elementId] or 0
	self.skillExcuteMatchElementNumMap[elementId] = self.skillExcuteMatchElementNumMap[elementId] + 1
end

function MatchGameFightModel:getSkillExcuteMatchElementNum(skillElementId)
	if skillElementId == 0 then
		local matchNum = 0

		for elementId, num in pairs(self.skillExcuteMatchElementNumMap) do
			if elementId > 0 then
				local elementConfig = MatchGameFightConfig.instance:getElementConfig(elementId)

				if elementConfig.type == MatchGameFightEnum.ElementItemType.Bead then
					matchNum = matchNum + num
				end
			end
		end

		return matchNum
	end

	return self.skillExcuteMatchElementNumMap[skillElementId] or 0
end

function MatchGameFightModel:cleanSkillExcuteMatchElementNum()
	self.skillExcuteMatchElementNumMap = {}
end

function MatchGameFightModel:cleanMatchGameData()
	self.matchElementNunMap = {}
	self.skillExcuteMatchElementNumMap = {}
	self.skillExcuteMap = {}
	self.beadTypePool = nil
	self.skillElementDropRateMap = {}
	self.heroFightInfoMap = {}
	self.curGameTime = 0
end

function MatchGameFightModel:addPendingSkill(skillConfig, skillUserMo)
	if not skillConfig then
		return
	end

	if not self.skillExcuteMap[skillConfig.skillId] then
		local skillData = {}

		skillData.skillUserMo = skillUserMo
		skillData.skillId = skillConfig.skillId
		skillData.config = skillConfig
		skillData.skillEffectList = {}

		for index = 1, MatchGameFightEnum.MaxSkillIndex do
			local effectStr = skillData.config["effect" .. index]

			if not string.nilorempty(effectStr) then
				local skillEffectData = {}

				skillEffectData.conditionCoDataList = GameUtil.splitString2(skillData.config["condition" .. index], true)
				skillEffectData.targetCoDataList = GameUtil.splitString2(skillData.config["target" .. index], true)
				skillEffectData.effectCoDataList = GameUtil.splitString2(effectStr, true)

				table.insert(skillData.skillEffectList, skillEffectData)
			end
		end

		self.skillExcuteMap[skillConfig.skillId] = skillData
	end
end

function MatchGameFightModel:getSkillExcuteMap()
	return self.skillExcuteMap
end

function MatchGameFightModel:removeExcutedSkill(skillId)
	if self.skillExcuteMap[skillId] then
		self.skillExcuteMap[skillId] = nil
	end
end

function MatchGameFightModel:setElementDropRateMap(elementId, dropRate)
	local elementConfig = MatchGameFightConfig.instance:getElementConfig(elementId)

	if elementConfig.type == MatchGameFightEnum.ElementItemType.Bead then
		for curElementId, dropRate in pairs(self.skillElementDropRateMap) do
			local curElementConfig = MatchGameFightConfig.instance:getElementConfig(curElementId)

			if curElementConfig.type == MatchGameFightEnum.ElementItemType.Bead then
				self.skillElementDropRateMap[curElementId] = nil
			end
		end
	end

	self.skillElementDropRateMap[elementId] = dropRate
end

function MatchGameFightModel:setCurGameTime(time)
	self.curGameTime = time
end

function MatchGameFightModel:getCurGameTime()
	return self.curGameTime
end

function MatchGameFightModel:getActiveTalentNodeList()
	local activeTalentList = {}

	for index, config in ipairs(lua_activity244_talent.configList) do
		if MatchGameModel.instance:getTalentNodeStatus(config.nodeId) == MatchGameEnum.TalentNodeStatus.Active then
			table.insert(activeTalentList, config)
		end
	end

	return activeTalentList
end

function MatchGameFightModel:setMaxChainNum(num)
	if self.maxChainNum == num then
		return
	end

	self.maxChainNum = num

	MatchGameController.instance:dispatchEvent(MatchGameFightEvent.RefreshChallengeScore)
end

function MatchGameFightModel:getMaxChainNum()
	return self.maxChainNum
end

function MatchGameFightModel:addWeakAttackNum(addNum)
	self.weakAttackNum = self.weakAttackNum + addNum

	MatchGameController.instance:dispatchEvent(MatchGameFightEvent.RefreshChallengeScore)
end

function MatchGameFightModel:getWeakAttackNum()
	return self.weakAttackNum
end

function MatchGameFightModel:addTotalCureNum(addNum)
	self.totalCureNum = self.totalCureNum + addNum

	MatchGameController.instance:dispatchEvent(MatchGameFightEvent.RefreshChallengeScore)
end

function MatchGameFightModel:getTotalCureNum()
	return self.totalCureNum
end

function MatchGameFightModel:addTotalSkillUseNum(addNum)
	self.totalSkillUseNum = self.totalSkillUseNum + addNum

	MatchGameController.instance:dispatchEvent(MatchGameFightEvent.RefreshChallengeScore)
end

function MatchGameFightModel:getTotalSkillUseNum()
	return self.totalSkillUseNum
end

function MatchGameFightModel:setGuideState(state)
	self.isGuiding = state
end

function MatchGameFightModel:getGuideState()
	return self.isGuiding
end

function MatchGameFightModel:setFeverElementPath(posXIndex, posYIndex)
	self.feverElementPath = string.format("UIRoot/POPUP_TOP/MatchGameFightView/root/planeRoot/#go_plane/#go_planeContent/planeItem%d_%d/btn_click", posXIndex, posYIndex)
end

function MatchGameFightModel:getFeverElementPath()
	return self.feverElementPath or ""
end

function MatchGameFightModel:addTotalHeroDamage(addDamage)
	self.totalHeroDamage = self.totalHeroDamage + addDamage
end

function MatchGameFightModel:getTotalHeroDamage()
	return self.totalHeroDamage
end

function MatchGameFightModel:getHeroCareerMap()
	if self.heroCarrerMap and next(self.heroCarrerMap) then
		return self.heroCarrerMap
	end

	if self.heroFightInfoMap then
		for _, heroFightMo in pairs(self.heroFightInfoMap) do
			local career = heroFightMo and heroFightMo.career

			if career and career >= 1 and career <= MatchGameFightEnum.BeadTypeCount then
				self.heroCarrerMap[career] = true
			end
		end
	end

	return self.heroCarrerMap
end

MatchGameFightModel.instance = MatchGameFightModel.New()

return MatchGameFightModel
