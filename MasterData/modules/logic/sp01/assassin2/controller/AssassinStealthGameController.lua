-- chunkname: @modules/logic/sp01/assassin2/controller/AssassinStealthGameController.lua

module("modules.logic.sp01.assassin2.controller.AssassinStealthGameController", package.seeall)

local AssassinStealthGameController = class("AssassinStealthGameController", BaseController)

function AssassinStealthGameController:onInit()
	self:_clearEnemyFlow()
end

function AssassinStealthGameController:reInit()
	self:_clearEnemyFlow()
end

function AssassinStealthGameController:pickAssassinHeroItemInHeroView(questId, assassinHeroId, isFightQuest)
	if not questId or not assassinHeroId then
		return true
	end

	local pickIndex = AssassinStealthGameModel.instance:getHeroPickIndex(assassinHeroId)

	if pickIndex then
		local isRequired = AssassinHeroModel.instance:isRequiredAssassin(assassinHeroId)

		if not isRequired then
			AssassinStealthGameModel.instance:removeHeroPick(assassinHeroId)
		end
	else
		local maxHeroCount = 0

		if isFightQuest then
			local strEpisodeId = AssassinConfig.instance:getQuestParam(questId)
			local episodeId = tonumber(strEpisodeId)
			local episodeCO = episodeId and lua_episode.configDict[episodeId]
			local battleCO = episodeCO and lua_battle.configDict[episodeCO.battleId]

			maxHeroCount = battleCO and battleCO.playerMax or ModuleEnum.HeroCountInGroup
		else
			local strMapId = AssassinConfig.instance:getQuestParam(questId)

			maxHeroCount = AssassinConfig.instance:getStealthMapNeedHeroCount(tonumber(strMapId))
		end

		local curPickCount = AssassinStealthGameModel.instance:getPickHeroCount()

		if maxHeroCount <= curPickCount then
			GameFacade.showToast(ToastEnum.AssassinStealthHeroFull)

			return false
		end

		AssassinStealthGameModel.instance:addHeroPick(assassinHeroId)
	end

	return true
end

function AssassinStealthGameController:startStealthGame(questId)
	local strMapId = AssassinConfig.instance:getQuestParam(questId)
	local mapId = tonumber(strMapId)

	if not mapId then
		return
	end

	local pickCount = AssassinStealthGameModel.instance:getPickHeroCount()
	local needHeroCount = AssassinConfig.instance:getStealthMapNeedHeroCount(mapId)

	if pickCount < needHeroCount then
		return
	end

	local assassinHeroList = AssassinStealthGameModel.instance:getPickHeroList()

	AssassinSceneRpc.instance:sendEnterAssassinSceneRequest(questId, assassinHeroList, self._realStartStealthGame, self)
end

function AssassinStealthGameController:_realStartStealthGame(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	self._gameStartTime = UnityEngine.Time.realtimeSinceStartup

	self:_initGameData(msg.scene)
	AssassinStealthGameModel.instance:setIsFightReturn()
	AssassinStealthGameModel.instance:setMapPosRecordOnFight()
	AssassinStealthGameModel.instance:setMapPosRecordOnTurn()
	AssassinStealthGameModel.instance:setIsShowHeroHighlight(true)
	ViewMgr.instance:openView(ViewName.AssassinStealthGameView)
end

function AssassinStealthGameController:_initGameData(serverSceneData)
	AssassinStealthGameModel.instance:initGameSceneData(serverSceneData)
end

function AssassinStealthGameController:checkGameState()
	local gameState = AssassinStealthGameModel.instance:getGameState()

	if gameState == AssassinEnum.GameState.Win or gameState == AssassinEnum.GameState.Fail then
		AssassinController.instance:openAssassinStealthGameResultView()
	end

	return gameState ~= AssassinEnum.GameState.InProgress
end

function AssassinStealthGameController:checkGameRequest()
	local changingMapId = AssassinStealthGameModel.instance:getNeedChangingMap()
	local battleGridIds = AssassinStealthGameModel.instance:getBattleGridIds()
	local needNextRound = AssassinStealthGameModel.instance:getNeedNextRound()

	AssassinStealthGameModel.instance:setGameRequestData()

	local gameState = AssassinStealthGameModel.instance:getGameState()

	if gameState ~= AssassinEnum.GameState.InProgress then
		local isPlayerTurn = AssassinStealthGameModel.instance:isPlayerTurn()

		if not isPlayerTurn then
			self:checkGameState()
		end

		return
	end

	if changingMapId and changingMapId ~= 0 then
		self:changeMap(changingMapId)

		return
	end

	local battleGrid = battleGridIds and battleGridIds[1]

	if battleGrid then
		self:enterBattleGrid(battleGrid)

		return
	end

	if needNextRound and needNextRound ~= 0 then
		self:_beginNewRound()

		return
	end
end

function AssassinStealthGameController:initBaseMap(goMap)
	AssassinStealthGameEffectMgr.instance:init()
	AssassinStealthGameEntityMgr.instance:onInitBaseMap(goMap)
end

function AssassinStealthGameController:updateGrids(assassinGridList, effectId)
	if not assassinGridList then
		return
	end

	local updateGridIdDict = {}

	AssassinStealthGameModel.instance:setGridDataByList(assassinGridList)

	for _, gridData in ipairs(assassinGridList) do
		local gridId = gridData.gridId

		updateGridIdDict[gridId] = gridId

		AssassinStealthGameEntityMgr.instance:refreshGrid(gridId, effectId)
	end

	self:dispatchEvent(AssassinEvent.OnGridUpdate, updateGridIdDict)
end

function AssassinStealthGameController:updateGrid(assassinGrid)
	if not assassinGrid then
		return
	end

	local gridId = assassinGrid.gridId

	AssassinStealthGameModel.instance:setGridData(assassinGrid)
	AssassinStealthGameEntityMgr.instance:refreshGrid(gridId)
	self:dispatchEvent(AssassinEvent.OnGridUpdate, {
		gridId = gridId
	})
end

function AssassinStealthGameController:updateHeroes(heroUnitList, effectId)
	if not heroUnitList then
		return
	end

	local updateHeroUidDict = {}

	AssassinStealthGameModel.instance:updateHeroDataByList(heroUnitList)

	for _, heroUnit in ipairs(heroUnitList) do
		local uid = heroUnit.uid

		updateHeroUidDict[uid] = uid

		AssassinStealthGameEntityMgr.instance:refreshHeroEntity(uid, effectId)
	end

	self:dispatchEvent(AssassinEvent.OnHeroUpdate, updateHeroUidDict)
end

function AssassinStealthGameController:updateHero(heroUnit, effectId)
	if not heroUnit then
		return
	end

	local uid = heroUnit.uid

	AssassinStealthGameModel.instance:updateHeroData(heroUnit)
	AssassinStealthGameEntityMgr.instance:refreshHeroEntity(uid, effectId)
	self:dispatchEvent(AssassinEvent.OnHeroUpdate, {
		[uid] = uid
	})
end

function AssassinStealthGameController:updateEnemies(monsterUnitList, effectId)
	if not monsterUnitList then
		return
	end

	local updateEnemyUidDict = {}

	AssassinStealthGameModel.instance:updateEnemyDataByList(monsterUnitList)

	for _, monsterUnit in ipairs(monsterUnitList) do
		local uid = monsterUnit.uid

		updateEnemyUidDict[uid] = uid

		AssassinStealthGameEntityMgr.instance:refreshEnemyEntity(uid, effectId)
	end

	self:dispatchEvent(AssassinEvent.OnEnemyUpdate, updateEnemyUidDict)
end

function AssassinStealthGameController:updateEnemy(monsterUnit, effectId)
	if not monsterUnit then
		return
	end

	local uid = monsterUnit.uid

	AssassinStealthGameModel.instance:updateEnemyData(monsterUnit)
	AssassinStealthGameEntityMgr.instance:refreshEnemyEntity(uid, effectId)
	self:dispatchEvent(AssassinEvent.OnEnemyUpdate, {
		uid = uid
	})
end

function AssassinStealthGameController:clickHeroEntity(uid, needFocus)
	local isCanUseSkillProp2Hero = AssassinStealthGameHelper.isSelectedHeroCanUseSkillPropToHero(uid)

	if isCanUseSkillProp2Hero then
		self:_useSkillProp(uid)

		return
	end

	local isCanSelect = AssassinStealthGameHelper.isCanSelectHero(uid)

	if isCanSelect then
		self:selectHero(uid, needFocus)
	end
end

function AssassinStealthGameController:selectHero(uid, needFocus)
	local lastSelectedHeroUid = AssassinStealthGameModel.instance:getSelectedHero()

	if lastSelectedHeroUid and lastSelectedHeroUid == uid then
		uid = nil
	end

	AssassinStealthGameModel.instance:setIsShowHeroHighlight(false)
	AssassinStealthGameModel.instance:setSelectedHero(uid)
	self:selectEnemy()
	self:selectSkillProp()
	AssassinStealthGameEntityMgr.instance:refreshAllHeroEntities()
	AssassinStealthGameEntityMgr.instance:refreshAllGrid()
	self:dispatchEvent(AssassinEvent.OnStealthGameSelectHero, {
		lastSelectedHeroUid = lastSelectedHeroUid,
		needFocus = needFocus
	})
end

function AssassinStealthGameController:clickEnemyEntity(uid)
	local isCanUseSkillProp2Enemy = AssassinStealthGameHelper.isSelectedHeroCanUseSkillPropToEnemy(uid)

	if isCanUseSkillProp2Enemy then
		self:_useSkillProp(uid)

		return
	end

	local isCanRemoveBody = AssassinStealthGameHelper.isSelectedHeroCanRemoveEnemyBody(uid)

	if isCanRemoveBody then
		self:_handleEnemyBody(uid)

		return
	end

	local isCanSelect = AssassinStealthGameHelper.isSelectedHeroCanSelectEnemy(uid)

	if isCanSelect then
		self:selectEnemy(uid)
	end
end

function AssassinStealthGameController:selectEnemy(uid)
	local oldSelectedEnemy = AssassinStealthGameModel.instance:getSelectedEnemy()

	if oldSelectedEnemy and oldSelectedEnemy == uid then
		uid = nil
	end

	AssassinStealthGameModel.instance:setSelectedEnemy(uid)

	if uid then
		AssassinStealthGameEntityMgr.instance:refreshEnemyEntity(uid)
	end

	self:dispatchEvent(AssassinEvent.OnStealthGameSelectEnemy, oldSelectedEnemy)
end

function AssassinStealthGameController:clickGridItem(gridId, pointIndex)
	local isCanUseSkillProp2Grid = AssassinStealthGameHelper.isSelectedHeroCanUseSkillPropToGrid(gridId)

	if isCanUseSkillProp2Grid then
		self:_useSkillProp(gridId)

		return
	end

	local isCanMove = AssassinStealthGameHelper.isSelectedHeroCanMoveTo(gridId, pointIndex)

	if isCanMove then
		self:_heroMove(gridId, pointIndex)

		return
	end
end

function AssassinStealthGameController:clickSkillProp(skillPropId, isSkill)
	local selectedHeroUid = AssassinStealthGameModel.instance:getSelectedHero()
	local isCanUse = AssassinStealthGameHelper.isCanUseSkillProp(selectedHeroUid, skillPropId, isSkill)

	if not isCanUse then
		return
	end

	local targetType = AssassinConfig.instance:getSkillPropTargetType(skillPropId, isSkill)

	if targetType ~= AssassinEnum.SkillPropTargetType.None then
		self:selectSkillProp(skillPropId, isSkill)
	else
		self:_useSkillProp(nil, skillPropId, isSkill)
	end
end

function AssassinStealthGameController:selectSkillProp(skillPropId, isSkill, notPlay)
	local selectedSkillPropId, selectedIsSkill = AssassinStealthGameModel.instance:getSelectedSkillProp()

	if selectedSkillPropId == skillPropId and isSkill == selectedIsSkill then
		skillPropId = nil
		isSkill = nil
	end

	AssassinStealthGameModel.instance:setSelectedSkillProp(skillPropId, isSkill)
	AssassinStealthGameEntityMgr.instance:refreshAllGrid()
	AssassinStealthGameEntityMgr.instance:refreshAllHeroEntities()
	AssassinStealthGameEntityMgr.instance:refreshAllEnemyEntities()
	self:dispatchEvent(AssassinEvent.OnSelectSkillProp, notPlay)
end

function AssassinStealthGameController:heroInteract()
	local heroGameMo = AssassinStealthGameModel.instance:getSelectedHeroGameMo()

	if not heroGameMo then
		return
	end

	local curAp = heroGameMo:getActionPoint()
	local curGridId = heroGameMo:getPos()
	local interactId = AssassinStealthGameModel.instance:getGridInteractId(curGridId)
	local apCost = AssassinConfig.instance:getInteractApCost(interactId)

	if curAp < apCost then
		GameFacade.showToast(ToastEnum.AssassinStealthApNotEnough)

		return
	end

	local heroUid = heroGameMo:getUid()

	AssassinSceneRpc.instance:sendHeroInteractiveRequest(heroUid, interactId, self._onHeroInteract, self)
end

function AssassinStealthGameController:playerEndTurn()
	local isPlayerTurn = AssassinStealthGameModel.instance:isPlayerTurn()

	if not isPlayerTurn then
		return
	end

	AssassinStealthGameModel.instance:setIsPlayerTurn(false)

	local round = AssassinStealthGameModel.instance:getRound()

	AssassinSceneRpc.instance:sendFinishUserTurnRequest(round, self._onEndPlayerTurn, self)
end

function AssassinStealthGameController:_useSkillProp(targetId, argsSkillProp, argsIsSkill)
	local skillPropId, isSkill
	local selectedHeroUid = AssassinStealthGameModel.instance:getSelectedHero()

	if targetId then
		skillPropId, isSkill = AssassinStealthGameModel.instance:getSelectedSkillProp()
	else
		targetId = selectedHeroUid
		skillPropId = argsSkillProp
		isSkill = argsIsSkill
	end

	if isSkill then
		AssassinSceneRpc.instance:sendAssassinUseSkillRequest(selectedHeroUid, targetId, self._onUseSkill, self)
	else
		AssassinSceneRpc.instance:sendUseAssassinItemRequest(selectedHeroUid, skillPropId, targetId, self._onUseItem, self)
	end

	self:selectSkillProp()
end

function AssassinStealthGameController:_onUseSkill(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local havePlayedEff = false
	local heroGameMo = AssassinStealthGameModel.instance:getHeroMo(msg.uid, true)
	local skillId = heroGameMo and heroGameMo:getActiveSkillId()
	local effectId = AssassinConfig.instance:getAssassinSkillTargetEff(skillId)
	local grids = msg.grid

	if skillId == AssassinEnum.Skill.LightGrid then
		if grids and #grids > 0 then
			havePlayedEff = true

			self:updateGrids(grids, effectId)
		end
	else
		self:updateGrids(grids)
	end

	if skillId == AssassinEnum.Skill.CureAll then
		havePlayedEff = true

		self:updateHeroes(msg.hero, effectId)
	else
		self:updateHeroes(msg.hero)
	end

	if skillId == AssassinEnum.Skill.Petrifaction then
		havePlayedEff = true

		self:updateEnemies(msg.monster, effectId)
	else
		self:updateEnemies(msg.monster)
	end

	self:changeAlertLevel(msg.alertLevel)

	local delMonsterUidList = msg.delMonsterUid

	if delMonsterUidList then
		for _, delMonsterUid in ipairs(delMonsterUidList) do
			if delMonsterUid and delMonsterUid > 0 then
				AssassinStealthGameModel.instance:removeEnemyData(delMonsterUid)
				AssassinStealthGameEntityMgr.instance:removeEnemyEntity(delMonsterUid)
			end
		end
	end

	AssassinStealthGameEntityMgr.instance:refreshAllGrid()
	AssassinStealthGameEntityMgr.instance:refreshAllEnemyEntities()

	if not havePlayedEff then
		local targetId = msg.targetId
		local targetType = AssassinConfig.instance:getSkillPropTargetType(skillId, true)

		if targetType == AssassinEnum.SkillPropTargetType.None or targetType == AssassinEnum.SkillPropTargetType.Hero then
			AssassinStealthGameEntityMgr.instance:playHeroEff(targetId, effectId)
		elseif targetType == AssassinEnum.SkillPropTargetType.Enemy then
			AssassinStealthGameEntityMgr.instance:playEnemyEff(targetId, effectId)
		elseif targetType == AssassinEnum.SkillPropTargetType.Grid then
			if skillId == AssassinEnum.Skill.Transfer then
				AssassinStealthGameEntityMgr.instance:playHeroEff(msg.uid, effectId)
			else
				AssassinStealthGameEntityMgr.instance:playGridEff(targetId, effectId)
			end
		end
	end

	self:dispatchEvent(AssassinEvent.OnUseSkillProp)
end

function AssassinStealthGameController:_onUseItem(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local havePlayedEff = false
	local itemId = msg.itemId
	local effectId = AssassinConfig.instance:getAssassinItemTargetEff(itemId)
	local itemType = AssassinConfig.instance:getAssassinItemType(itemId)

	self:updateGrid(msg.grid)
	self:updateHeroes(msg.hero)

	if itemType == AssassinEnum.ItemType.PoisonKnife then
		havePlayedEff = true

		self:updateEnemies(msg.monster, effectId)
	else
		self:updateEnemies(msg.monster)
	end

	AssassinStealthGameEntityMgr.instance:refreshAllGrid()
	AssassinStealthGameEntityMgr.instance:refreshAllEnemyEntities()

	if not havePlayedEff then
		local targetId = msg.targetId
		local targetType = AssassinConfig.instance:getSkillPropTargetType(itemId)

		if targetType == AssassinEnum.SkillPropTargetType.None or targetType == AssassinEnum.SkillPropTargetType.Hero then
			AssassinStealthGameEntityMgr.instance:playHeroEff(targetId, effectId)
		elseif targetType == AssassinEnum.SkillPropTargetType.Enemy then
			AssassinStealthGameEntityMgr.instance:playEnemyEff(targetId, effectId)
		elseif targetType == AssassinEnum.SkillPropTargetType.Grid then
			AssassinStealthGameEntityMgr.instance:playHeroEff(msg.uid, effectId)
		end
	end

	self:dispatchEvent(AssassinEvent.OnUseSkillProp)
end

function AssassinStealthGameController:_onHeroInteract(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	self:updateHero(msg.hero)
	AssassinStealthGameModel.instance:setFinishedInteractive(msg.interactiveId)
	AssassinStealthGameEntityMgr.instance:refreshAllGrid()
	AssassinStealthGameEntityMgr.instance:refreshAllEnemyEntities()
	self:dispatchEvent(AssassinEvent.OnQTEInteractUpdate)
end

function AssassinStealthGameController:_onEndPlayerTurn(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	self:changeAlertLevel(msg.alertLevel)
	AssassinStealthGameModel.instance:setGridDataByList(msg.grid)
	AssassinStealthGameModel.instance:setEnemyOperationData(msg)
	self:_startEnemyOperationFlow()
	self:dispatchEvent(AssassinEvent.OnPlayerEndTurn)
end

function AssassinStealthGameController:_heroMove(gridId, pointIndex)
	local selectedHeroUid = AssassinStealthGameModel.instance:getSelectedHero()
	local moveActId = AssassinStealthGameHelper.getSelectedHeroMoveActId(gridId, pointIndex)
	local param = gridId
	local isLeaveHide = moveActId == AssassinEnum.HeroAct.LeaveHide

	if moveActId == AssassinEnum.HeroAct.Hide or isLeaveHide then
		if isLeaveHide then
			param = AssassinStealthGameModel.instance:getGridEmptyPointIndex(gridId)

			if not param then
				return
			end
		else
			param = pointIndex
		end
	elseif moveActId == AssassinEnum.HeroAct.ClimbTower or moveActId == AssassinEnum.HeroAct.Jump then
		param = string.format("%s#%s", gridId, pointIndex)
	end

	self:dispatchEvent(AssassinEvent.ShowHeroActImg, moveActId, {
		actId = moveActId,
		selectedHeroUid = selectedHeroUid,
		param = tostring(param or "")
	})
end

function AssassinStealthGameController:heroAttack(actId)
	if not actId then
		return
	end

	local heroGameMo = AssassinStealthGameModel.instance:getSelectedHeroGameMo()

	if not heroGameMo then
		return
	end

	local curAp = heroGameMo:getActionPoint()
	local needAp = AssassinConfig.instance:getAssassinActPower(actId)

	if curAp < needAp then
		GameFacade.showToast(ToastEnum.AssassinStealthApNotEnough)

		return
	end

	local heroUid = heroGameMo:getUid()
	local enemyUid = AssassinStealthGameModel.instance:getSelectedEnemy()

	self:selectEnemy()
	self:dispatchEvent(AssassinEvent.ShowHeroActImg, actId, {
		actId = actId,
		heroUid = heroUid,
		enemyUid = enemyUid
	})
end

function AssassinStealthGameController:heroAssassinate(actId)
	if not actId then
		return
	end

	local heroGameMo = AssassinStealthGameModel.instance:getSelectedHeroGameMo()
	local enemyGameMo = AssassinStealthGameModel.instance:getSelectedEnemyGameMo()

	if not heroGameMo or not enemyGameMo then
		return
	end

	local curAp = heroGameMo:getActionPoint()
	local needAp = AssassinConfig.instance:getAssassinActPower(actId)

	if curAp < needAp then
		GameFacade.showToast(ToastEnum.AssassinStealthApNotEnough)

		return
	end

	local enemyUid = enemyGameMo:getUid()
	local heroUid = heroGameMo:getUid()
	local param = tostring(enemyUid)

	if actId == AssassinEnum.HeroAct.AirAssassinate then
		local targetGridId = enemyGameMo:getPos()

		param = string.format("%s#%s", targetGridId, enemyUid)
	end

	self:selectEnemy()
	self:dispatchEvent(AssassinEvent.ShowHeroActImg, actId, {
		actId = actId,
		heroUid = heroUid,
		param = param
	})
end

function AssassinStealthGameController:_handleEnemyBody(targetEnemyUid)
	local selectedHeroUid = AssassinStealthGameModel.instance:getSelectedHero()

	self:dispatchEvent(AssassinEvent.ShowHeroActImg, AssassinEnum.HeroAct.HandleBody, {
		actId = AssassinEnum.HeroAct.HandleBody,
		selectedHeroUid = selectedHeroUid,
		param = tostring(targetEnemyUid)
	})
end

function AssassinStealthGameController:showActImgFinish(actId, actParam)
	if not actId or not actParam then
		return
	end

	local actEnum = AssassinEnum.HeroAct

	if actId == actEnum.Move or actId == actEnum.Hide or actId == actEnum.LeaveHide or actId == actEnum.ClimbTower or actId == actEnum.LeaveTower or actId == actEnum.Jump then
		AssassinSceneRpc.instance:sendHeroMoveRequest(actParam.selectedHeroUid, actId, actParam.param, self._onHeroMove, self)
	elseif actId == actEnum.Attack or actId == actEnum.AttackTogether or actId == actEnum.Ambush or actId == actEnum.AmbushTogether then
		local _, enemyEffectId = AssassinConfig.instance:getAssassinActEffect(actId)

		AssassinStealthGameEntityMgr.instance:playEnemyEff(actParam.enemyUid, enemyEffectId, self._afterAttackEffect, self, actParam, AssassinEnum.BlockKey.PlayAttackEff)
	elseif actId == actEnum.Assassinate or actId == actEnum.AirAssassinate or actId == actEnum.HideAssassinate then
		AssassinSceneRpc.instance:sendHeroAssassinRequest(actParam.heroUid, actId, actParam.param, self._onHeroAssassinate, self)
	elseif actId == actEnum.HandleBody then
		AssassinSceneRpc.instance:sendHeroAssassinRequest(actParam.selectedHeroUid, actId, actParam.param, self._onHandleEnemyBody, self)
	else
		logError(string.format("AssassinStealthGameController:showActImgFinish error, not support act:%s", actId))
	end
end

function AssassinStealthGameController:_afterAttackEffect(actParam)
	AssassinSceneRpc.instance:sendHeroAttackRequest(actParam.heroUid, actParam.actId, actParam.enemyUid, self._onHeroAttack, self)
end

function AssassinStealthGameController:_onHeroMove(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local heroEffectId = AssassinConfig.instance:getAssassinActEffect(msg.actId)
	local heroUid = msg.hero.uid
	local gridId = msg.hero.gridId
	local gameHeroMo = AssassinStealthGameModel.instance:getHeroMo(heroUid, true)
	local oldStatus = gameHeroMo and gameHeroMo:getStatus()

	self:updateHero(msg.hero, heroEffectId)

	if msg.actId == AssassinEnum.HeroAct.Move then
		AudioMgr.instance:trigger(AudioEnum2_9.StealthGame.play_ui_cikeshang_heromove)
	end

	AssassinStealthGameModel.updateEnemyDataByList(msg.monster)

	for _, moveData in ipairs(msg.moves) do
		local path = moveData.path[1]

		self:enemyMove(moveData.uid, path.gridId, path.pos)
	end

	AssassinStealthGameEntityMgr.instance:refreshAllEnemyEntities()
	AssassinStealthGameModel.instance:setGridDataByList(msg.grid)
	AssassinStealthGameEntityMgr.instance:refreshAllGrid()
	self:changeAlertLevel(msg.alertLevel)

	local isCanBeScan = AssassinStealthGameHelper.isHeroCanBeScan(heroUid, oldStatus, msg.actId)

	if isCanBeScan then
		local enemyWillScan = AssassinStealthGameHelper.isGridEnemyWillScan(gridId)

		if enemyWillScan then
			local newStatus = gameHeroMo:getStatus()
			local isExpose = newStatus == AssassinEnum.HeroStatus.Expose

			if isExpose and oldStatus ~= newStatus then
				AssassinStealthGameEntityMgr.instance:playGridScanEff(gridId, self._playScanEffFinish, self, {
					heroUid
				})
			else
				AssassinStealthGameEntityMgr.instance:playGridScanEff(gridId, self._playScanEffFinish, self)
			end

			AssassinHelper.lockScreen(AssassinEnum.BlockKey.EnemyScanEffPlaying, true)
		end
	end

	self:dispatchEvent(AssassinEvent.OnHeroMove)
end

function AssassinStealthGameController:_playScanEffFinish(exposeHeroUidList)
	if exposeHeroUidList then
		self:heroBeExposed(exposeHeroUidList)
	end

	AssassinHelper.lockScreen(AssassinEnum.BlockKey.EnemyScanEffPlaying, false)
end

function AssassinStealthGameController:_onHeroAttack(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	self:_enterFight(resultCode, msg)
end

function AssassinStealthGameController:_onHeroAssassinate(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local heroEffectId, enemyEffectId = AssassinConfig.instance:getAssassinActEffect(msg.actId)

	self:updateHero(msg.hero, heroEffectId)
	self:updateEnemies(msg.monster, enemyEffectId)

	local delMonsterUidList = msg.delMonsterUid

	if delMonsterUidList then
		for _, delMonsterUid in ipairs(delMonsterUidList) do
			if delMonsterUid and delMonsterUid > 0 then
				AssassinStealthGameModel.instance:removeEnemyData(delMonsterUid)
				AssassinStealthGameEntityMgr.instance:removeEnemyEntity(delMonsterUid)
			end
		end
	end

	AssassinStealthGameEntityMgr.instance:refreshAllGrid()
	AssassinStealthGameEntityMgr.instance:refreshAllEnemyEntities()
	self:dispatchEvent(AssassinEvent.TriggerGuideAfterHeroAssassinate)
end

function AssassinStealthGameController:_onHandleEnemyBody(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	self:updateHero(msg.hero)
	self:updateEnemies(msg.monster)

	local delMonsterUidList = msg.delMonsterUid

	if delMonsterUidList then
		for _, delMonsterUid in ipairs(delMonsterUidList) do
			if delMonsterUid and delMonsterUid > 0 then
				AssassinStealthGameModel.instance:removeEnemyData(delMonsterUid)
				AssassinStealthGameEntityMgr.instance:removeEnemyEntity(delMonsterUid)
			end
		end
	end
end

function AssassinStealthGameController:_clearEnemyFlow()
	if self._enemyOperationFlow then
		self._enemyOperationFlow:unregisterDoneListener(self._enemyOperationFlowDone, self)
		self._enemyOperationFlow:destroy()
	end

	self._enemyOperationFlow = nil

	AssassinStealthGameModel.instance:setEnemyOperationData()
	AssassinHelper.lockScreen(AssassinEnum.BlockKey.EnemyOperation, false)
end

function AssassinStealthGameController:_startEnemyOperationFlow()
	if self._enemyOperationFlow then
		logError("AssassinStealthGameController:_startEnemyOperationFlow error, already have flow")

		return
	end

	AssassinHelper.lockScreen(AssassinEnum.BlockKey.EnemyOperation, true)

	self._enemyOperationFlow = FlowSequence.New()

	self._enemyOperationFlow:addWork(StealthEnemyTurnBeginWork.New())
	self._enemyOperationFlow:addWork(StealthEnemyBornWork.New())
	self._enemyOperationFlow:addWork(StealthEnemyArcheryWork.New())
	self._enemyOperationFlow:addWork(StealthEnemyMoveWork.New())
	self._enemyOperationFlow:addWork(StealthEnemyDetectsWork.New())
	self._enemyOperationFlow:addWork(StealthEnemyFightWork.New())
	self._enemyOperationFlow:addWork(StealthEnemyTurnEndWork.New())
	self._enemyOperationFlow:registerDoneListener(self._enemyOperationFlowDone, self)
	self._enemyOperationFlow:start()
end

function AssassinStealthGameController:enemyBornByList(enemyDataList)
	for _, enemyData in ipairs(enemyDataList) do
		self:enemyBorn(enemyData, true)
	end
end

function AssassinStealthGameController:enemyBorn(enemyData)
	AssassinStealthGameModel.instance:addEnemyData(enemyData)
	AssassinStealthGameEntityMgr.instance:addEnemyEntity(enemyData.uid)
end

function AssassinStealthGameController:enemyMove(enemyUid, gridId, pointIndex)
	AssassinStealthGameModel.instance:updateEnemyPos(enemyUid, gridId, pointIndex)
	AssassinStealthGameEntityMgr.instance:refreshEnemyEntity(enemyUid)
	AssassinStealthGameEntityMgr.instance:refreshGrid(gridId)
end

function AssassinStealthGameController:heroBeExposed(exposeHeroUidList)
	if not exposeHeroUidList or #exposeHeroUidList <= 0 then
		return
	end

	self:dispatchEvent(AssassinEvent.ShowExposeTip, exposeHeroUidList)
end

function AssassinStealthGameController:_enemyOperationFlowDone(success)
	self:_clearEnemyFlow()

	local isGameEnd = self:checkGameState()

	if isGameEnd then
		return
	end

	if success then
		self:_beginNewRound()
	end

	AssassinStealthGameEntityMgr.instance:refreshAllGrid()
end

function AssassinStealthGameController:_beginNewRound()
	local round = AssassinStealthGameModel.instance:getRound()

	AssassinSceneRpc.instance:sendNextRoundRequest(round, self._onBeginNewRound, self)
end

function AssassinStealthGameController:finishMission()
	local missionId = AssassinStealthGameModel.instance:getMissionId()

	AssassinSceneRpc.instance:sendFinishMissionRequest(missionId, self._onFinishMission, self)
end

function AssassinStealthGameController:returnAssassinStealthGame(questId, fightReturn)
	local questType = AssassinConfig.instance:getQuestType(questId)

	if questType ~= AssassinEnum.QuestType.Stealth then
		logError(string.format("AssassinStealthGameOverView:returnAssassinStealthGame error, quest is not stealth, questId:%s", questId))

		return
	end

	local mapId

	if questId then
		local strMapId = AssassinConfig.instance:getQuestParam(questId)

		mapId = tonumber(strMapId)
	else
		mapId = AssassinStealthGameModel.instance:getMapId()
	end

	AssassinStealthGameModel.instance:setIsFightReturn(fightReturn)
	AssassinSceneRpc.instance:sendReturnAssassinSceneRequest(mapId, self._onReturnAssassinStealthGame, self)
end

function AssassinStealthGameController:recoverAssassinStealthGame()
	local mapId = AssassinStealthGameModel.instance:getMapId()

	if mapId then
		AssassinSceneRpc.instance:sendRecoverSceneRequest(mapId, self._onRecoverAssassinStealthGame, self)
	end
end

function AssassinStealthGameController:changeMap(mapId)
	AssassinSceneRpc.instance:sendAssassinChangeMapRequest(mapId, self._onChangeMap, self)
end

function AssassinStealthGameController:enterBattleGrid(gridId)
	local gameState = AssassinStealthGameModel.instance:getGameState()
	local isGameEnd = gameState ~= AssassinEnum.GameState.InProgress

	if isGameEnd then
		return
	end

	AssassinSceneRpc.instance:sendEnterBattleGridRequest(gridId, self._onEnterBattleGrid, self)
end

function AssassinStealthGameController:resetGame()
	local mapId = AssassinStealthGameModel.instance:getMapId()

	AssassinSceneRpc.instance:sendRestartAssassinSceneRequest(mapId, self._onResetGame, self)
end

function AssassinStealthGameController:abandonGame()
	local mapId = AssassinStealthGameModel.instance:getMapId()

	AssassinSceneRpc.instance:sendGiveUpAssassinSceneRequest(mapId, self._onAbandonGame, self)
end

function AssassinStealthGameController:exitGame()
	ViewMgr.instance:closeView(ViewName.AssassinStealthGameView)
end

function AssassinStealthGameController:changeAlertLevel(alertLevel)
	if not alertLevel then
		return
	end

	AssassinStealthGameModel.instance:setAlertLevel(alertLevel)
	AssassinStealthGameEntityMgr.instance:refreshAllGrid()
	self:dispatchEvent(AssassinEvent.OnChangeAlertLevel)
end

function AssassinStealthGameController:_onBeginNewRound(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	AssassinStealthGameModel.instance:updateGameSceneDataOnNewRound(msg.scene)
	AssassinStealthGameModel.instance:setIsPlayerTurn(true)
	AssassinStealthGameEntityMgr.instance:refreshAllGrid()
	AssassinStealthGameEntityMgr.instance:refreshAllHeroEntities()
	AssassinStealthGameEntityMgr.instance:refreshAllEnemyEntities()
	self:dispatchEvent(AssassinEvent.OnBeginNewRound)
end

function AssassinStealthGameController:_onFinishMission(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	AssassinStealthGameModel.instance:setMissionData(msg.mission)
	AssassinStealthGameEntityMgr.instance:refreshAllGrid()
	AssassinStealthGameEntityMgr.instance:refreshAllEnemyEntities()
	self:dispatchEvent(AssassinEvent.OnMissionChange)
end

function AssassinStealthGameController:_onReturnAssassinStealthGame(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local isFightReturn = AssassinStealthGameModel.instance:getIsFightReturn()

	AssassinStealthGameModel.instance:setIsFightReturn()

	local posX, posY, scale = AssassinStealthGameModel.instance:getMapPosRecordOnFight()

	AssassinStealthGameModel.instance:setMapPosRecordOnFight()
	self:_initGameData(msg.scene)

	local needNextRound = AssassinStealthGameModel.instance:getNeedNextRound()

	if needNextRound and needNextRound ~= 0 then
		posX, posY, scale = AssassinStealthGameModel.instance:getMapPosRecordOnTurn()

		AssassinStealthGameModel.instance:setMapPosRecordOnTurn()
	end

	ViewMgr.instance:openView(ViewName.AssassinStealthGameView, {
		fightReturn = isFightReturn,
		mapPosX = posX,
		mapPosY = posY,
		mapScale = scale
	})
end

function AssassinStealthGameController:_onRecoverAssassinStealthGame(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	self:sendSettleTrack(StatEnum.Result2Cn[StatEnum.Result.BackTrace], true)
	self:_initGameData(msg.scene)
	AssassinStealthGameEntityMgr.instance:setupMap()
	self:dispatchEvent(AssassinEvent.OnGameSceneRecover)
end

function AssassinStealthGameController:_onChangeMap(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	self:_clearEnemyFlow()
	self:_initGameData(msg.scene)
	AssassinStealthGameEntityMgr.instance:setupMap()
	self:dispatchEvent(AssassinEvent.OnGameChangeMap)
end

function AssassinStealthGameController:_onEnterBattleGrid(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	self:_enterFight(resultCode, msg)
end

function AssassinStealthGameController:_enterFight(resultCode, msg)
	self:dispatchEvent(AssassinEvent.BeforeEnterFight)

	local episodeId = msg.fight.episodeId
	local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)
	local chapterId = episodeConfig.chapterId

	DungeonModel.instance:SetSendChapterEpisodeId(chapterId, episodeId)

	local fightParam = FightController.instance:setFightParamByEpisodeId(episodeId)

	fightParam:setDungeon(chapterId, episodeId)
	DungeonFightController.instance:onReceiveStartDungeonReply(resultCode, msg)
end

function AssassinStealthGameController:_onResetGame(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	self:sendSettleTrack(StatEnum.Result2Cn[StatEnum.Result.Reset], true)
	self:_initGameData(msg.scene)
	AssassinStealthGameEntityMgr.instance:setupMap()
	self:dispatchEvent(AssassinEvent.OnGameSceneRestart)
end

function AssassinStealthGameController:_onAbandonGame(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	self:sendSettleTrack(StatEnum.Result2Cn[StatEnum.Result.Abort])
	self:exitGame()
end

function AssassinStealthGameController:onGameViewDestroy()
	self:_clearEnemyFlow()
	AssassinStealthGameEffectMgr.instance:dispose()
	AssassinStealthGameEntityMgr.instance:clearAll()
	AssassinStealthGameModel.instance:clearAll()
	AssassinController.instance:getAssassinOutsideInfo()
end

function AssassinStealthGameController:sendSettleTrack(result, resetTime)
	if not self._gameStartTime then
		return
	end

	local mapId = AssassinStealthGameModel.instance:getMapId()
	local mapTitle = AssassinConfig.instance:getStealthMapTitle(mapId)
	local round = AssassinStealthGameModel.instance:getRound()
	local heroNameList = {}
	local heroArray = {}
	local heroUidList = AssassinStealthGameModel.instance:getHeroUidList()

	for _, heroUid in ipairs(heroUidList) do
		local heroGameMo = AssassinStealthGameModel.instance:getHeroMo(heroUid, true)

		if heroGameMo then
			local assassinHeroId = heroGameMo:getHeroId()
			local heroName = AssassinHeroModel.instance:getAssassinHeroName(assassinHeroId)

			heroNameList[#heroNameList + 1] = heroName
			heroArray[#heroArray + 1] = {
				name = heroName,
				career = heroGameMo:getCareerId(),
				item = heroGameMo:getItemIdList(),
				remaining_hp = heroGameMo:getHp()
			}
		end
	end

	local buildingArray = {}
	local buildingMapMo = AssassinOutsideModel.instance:getBuildingMapMo()

	if buildingMapMo then
		for _, buildingType in pairs(AssassinEnum.BuildingType) do
			local buildingMo = buildingMapMo:getBuildingMo(buildingType)

			if buildingMo then
				local buildingCo = buildingMo:getConfig()
				local var_68_0 = {}

				if buildingCo then
					var_68_0.name = buildingCo.title or ""
				end

				var_68_0.level = buildingMo:getLv()
				buildingArray[#buildingArray + 1] = var_68_0
			end
		end
	end

	StatController.instance:track(StatEnum.EventName.S01StealthGame, {
		[StatEnum.EventProperties.MapId] = tostring(mapId),
		[StatEnum.EventProperties.MapName] = mapTitle,
		[StatEnum.EventProperties.Result] = result,
		[StatEnum.EventProperties.TotalRound] = round,
		[StatEnum.EventProperties.UseTime] = UnityEngine.Time.realtimeSinceStartup - self._gameStartTime,
		[StatEnum.EventProperties.StealthGame_HeroGroup] = heroNameList,
		[StatEnum.EventProperties.StealthGame_HeroGroupArray] = heroArray,
		[StatEnum.EventProperties.StealthGame_BuildingInfo] = buildingArray
	})

	self._gameStartTime = resetTime and UnityEngine.Time.realtimeSinceStartup or nil
end

AssassinStealthGameController.instance = AssassinStealthGameController.New()

return AssassinStealthGameController
