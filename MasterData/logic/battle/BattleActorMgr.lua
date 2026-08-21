-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Logic\\battle\\BattleActorMgr.lua

local BattleConst = require("Common/FrameBattle/BattleConst")
local BattleActor = require("Logic/battle/BattleActor")
local SkillDataBank = require("Common/FrameBattle/BattleObject/SkillDataBank")
local CueDataBank = require("System/CueDataBank")
local ResBattleWaveShow = require("ClientData/ResBattleWaveShow")
local ResBattleTrap = require("ClientData/ResBattleTrap")
local ResBattleWeather = require("ClientData/ResBattleWeather")
local DragPlane = require("UI/Control/Com/DragPlane")
local AnimActor = require("Logic/battle/AnimActor")
local EventCenter = EventCenter
local CueManager = CueManager
local Timer = Timer
local strClassName = "BattleActorMgr"
local BattleActorMgr = Class(strClassName)
local listenerFuncConfig = {
	onBattleStart = BattleConst.MATRIX_EVENT_BATTLE_START,
	onPlayAtkCue = BattleConst.MATRIX_EVENT_ENTITY_PLAYATKCUE,
	onPlayHitCue = BattleConst.MATRIX_EVENT_ENTITY_PLAYHITCUE,
	onEntityDead = BattleConst.MATRIX_EVENT_ENTITY_DEAD,
	onBattleOver = BattleConst.MATRIX_EVENT_BATTLE_OVER,
	onSummonMonster = BattleConst.MATRIX_EVENT_SUMMON_MONSTER,
	onAddEntity = BattleConst.MATRIX_EVENT_ADD_ENTITY,
	onDelEntity = BattleConst.MATRIX_EVENT_DEL_ENTITY,
	onEntityEnter = BattleConst.MATRIX_EVENT_MONSTER_ENTER,
	onBattleWave = BattleConst.MATRIX_EVENT_MONSTER_WAVE,
	onAddTrap = BattleConst.MATRIX_EVENT_ADD_TRAP,
	onDelTrap = BattleConst.MATRIX_EVENT_DEL_TRAP,
	onAddWeather = BattleConst.MATRIX_EVENT_ADD_WEATHER,
	onDelWeather = BattleConst.MATRIX_EVENT_DEL_WEATHER,
	onActionEnd = BattleConst.MATRIX_EVENT_ACTION_END,
	onSpecialDamageRecord = BattleConst.MATRIX_EVENT_SPECIAL_DAMAGE_RECORD,
	onUseSkill = BattleConst.MATRIX_EVENT_ENTITY_SKILL_BEGIN
}

function BattleActorMgr:ctor(battleState, matrixInstance, entityDict)
	self.matrixInstance = matrixInstance
	self.leftDir = self.matrixInstance.bObjMgr.leftDir
	self.upDir = self.matrixInstance.bObjMgr.upDir
	self.LR_LEN = self.matrixInstance.bObjMgr.LR_LEN

	if self.LR_LEN > 6 then
		self.LR_LEN = 7
	end

	self.UD_LEN = self.matrixInstance.bObjMgr.UD_LEN
	self.LEFT_CAMP = self.matrixInstance.bObjMgr.LEFT_CAMP
	self.gridSize = self.matrixInstance.bObjMgr.gridSize
	self.gridAngle = battleState.gridAngle

	local lrSub = self.gridSize * (self.LR_LEN - 1) / 2
	local udSub = self.gridSize * 0.866 * (self.UD_LEN - 1) / 2

	self.gridUpDir = self.upDir * 0.866 * self.gridSize
	self.gridLeftDir = self.leftDir * self.gridSize
	self.centerPosition = battleState:getCenterPointPos()
	self.oriPosition = self.centerPosition - self.leftDir * lrSub - self.upDir * udSub
	self.battleState = battleState

	if battleState:isZombieBattle() then
		self.disablePrepareCamera = true
	end

	self.needExtraSpeed, self.maxSpeed = battleState:needExtraSpeed()
	self.actors = {}

	self:initActors(entityDict)
	self:initCueData()
	EventCenter.addEventListenerGroup(self, listenerFuncConfig)

	self.upRoutine = Timer.New(Slot(self.checkEveryActorLoaded, self), 0.5, -1, false)

	self.upRoutine:Start()
	self:initShowActors(self.matrixInstance.bObjMgr)
end

function BattleActorMgr:getPosition(orderX, orderY)
	return self.gridLeftDir * orderX + self.oriPosition + self.gridUpDir * orderY
end

function BattleActorMgr:getOutPosition(camp)
	local gridConfig = self.matrixInstance.bObjMgr.GridConfig
	local outPosX = gridConfig.CHUYIN_POS[1]
	local outPosY = gridConfig.CHUYIN_POS[2]

	if camp ~= BattleConst.CAMP_PLAYER then
		outPosX = self.LR_LEN - 1 - outPosX
	end

	local pos = self:getPosition(outPosX, outPosY)

	if gridConfig.CHUYIN_POS[3] then
		pos.y = pos.y + gridConfig.CHUYIN_POS[3]
	end

	return pos
end

function BattleActorMgr:checkEveryActorLoaded()
	if self.actors then
		for id, actor in pairs(self.actors) do
			if not actor:isModelLoaded() then
				return false
			end
		end
	end

	self.upRoutine:Stop()
	self:whenEveryActorLoaded()
end

function BattleActorMgr:whenEveryActorLoaded()
	self.battleState:onActorsReady()
end

function BattleActorMgr:destroy()
	EventCenter.removeEventListenerGroup(self, listenerFuncConfig)

	if self.upRoutine then
		self.upRoutine:Stop()
	end

	if self.actors then
		for id, actor in pairs(self.actors) do
			actor:destroy()
		end

		self.actors = {}
	end

	if self.showActor then
		self.showActor:destroy()

		self.showActor = nil
	end

	self:clearAllTrap()
	self:clearHeroRelicEff()
	CueManager.clearCue(0)
end

function BattleActorMgr:prepareChaseFrame()
	EventCenter.removeEventListenerGroup(self, listenerFuncConfig)

	if self.actors then
		for id, actor in pairs(self.actors) do
			actor:destroy()
		end

		self.actors = {}
	end
end

function BattleActorMgr:chaseFrameRefresh()
	local bObjMgr = self.matrixInstance.bObjMgr

	for objId, unit in pairs(bObjMgr.objects) do
		if unit.heroID or unit:isAlive() then
			self.actors[objId] = BattleActor(objId, "", self, unit.playerinfo, true)
		end
	end

	for _, actor in pairs(self.actors) do
		actor:chaseFrameRefresh()
	end

	self:onBattleStart()
	EventCenter.addEventListenerGroup(self, listenerFuncConfig)
end

function BattleActorMgr:refreshShow()
	for id, actor in pairs(self.actors) do
		actor:refreshShow()
	end
end

function BattleActorMgr:onMatrixOutput(matrixOutputType, args)
	if self.outputFuncDict[matrixOutputType] then
		self.outputFuncDict[matrixOutputType](args)
	end
end

function BattleActorMgr:initActors(entityDict)
	self.actors = {}

	self:addActors(entityDict, true)
end

local SHOW_ACTOR_ID_START = BattleConst.SHOW_ACTOR_ID_START

function BattleActorMgr:initShowActors(bObjMgr)
	local showData = ResBattleWaveShow[self.battleState.battleNo]

	if showData and showData.boss_id then
		local player = {}

		player.entityID = SHOW_ACTOR_ID_START
		player.monsterID = showData.boss_id
		self.showActor = BattleActor(SHOW_ACTOR_ID_START, "", self, player, true)

		self.showActor:onSetShowArgs(showData)
	end

	if self.battleState.relicHero then
		self:checkWeatherEff()

		self.heroCue = self.battleState.relicHero:getRelicValueByKey(Const.RELIC_BATTLE_CUE)

		if self.heroCue and self.battleState.centerPointGo then
			self.heroCueInst = {}

			for index, cueId in ipairs(self.heroCue) do
				self.heroCueInst[cueId] = CueManager.playCue(self.battleState.centerPointGo, cueId)
			end
		end
	end

	self.friendPet = nil
	self.enemyPet = nil

	for _, pet in ipairs(bObjMgr.activePets) do
		if pet.camp == BattleConst.CAMP_PLAYER then
			self.friendPet = pet
		else
			self.enemyPet = pet
		end
	end

	if self.friendPet or self.enemyPet then
		self.hasPet = true

		CueDataBank.initCueData("34000")
	end
end

function BattleActorMgr:playShowActorAnim(animName)
	if self.showActor then
		self.showActor:playAnimator(animName)
	end
end

function BattleActorMgr:addActors(entityDict, activeOnLoaded)
	for id, playerInfo in pairs(entityDict) do
		self.actors[id] = BattleActor(id, "", self, playerInfo, activeOnLoaded)
	end
end

function BattleActorMgr:onAddEntity(eid, playerInfo)
	self.actors[eid] = BattleActor(eid, "", self, playerInfo, false)
end

function BattleActorMgr:onDelEntity(objectId)
	if self.actors[objectId] then
		self.actors[objectId]:destroy()

		self.actors[objectId] = nil
	end
end

function BattleActorMgr:onEntityEnter(objectId)
	if self.actors[objectId] then
		self.actors[objectId]:onEntityStart(true)
		self.actors[objectId]:onBattleStart()
	end
end

function BattleActorMgr:onSummonMonster(masterId, eid, monsterInfo)
	self.actors[eid] = BattleActor(eid, "", self, monsterInfo, true)

	self.actors[eid]:onBattleStart()
end

function BattleActorMgr:inLeft(attackId, targetId)
	local attacker = self.matrixInstance:getObjectByKey(attackId)
	local target = self.matrixInstance:getObjectByKey(targetId)

	if attacker and target then
		return attacker.coordX > target.coordX
	end
end

function BattleActorMgr:initCueData()
	CueManager.preloadCue("Common")
end

function BattleActorMgr:getActor(actorId)
	if self.actors then
		return self.actors[actorId]
	end
end

function BattleActorMgr:getActorGameObject(actorId)
	local actor = self.actors[actorId]

	if actor then
		local obj = actor.gameObject

		if obj and not tolua.isnull(obj) then
			return obj
		end
	end
end

function BattleActorMgr:onBattleStart()
	for k, actor in pairs(self.actors) do
		actor:onBattleStart()
	end

	UIManager.getUI(self.battleState.mainDlgName):initConfig()
end

function BattleActorMgr:onBattleOver()
	for k, actor in pairs(self.actors) do
		actor:onBattleOver()
	end
end

function BattleActorMgr:actBeforeStart(enterAction)
	self:_everyBodyShow(enterAction)
end

function BattleActorMgr:_everyBodyShow(enterAction)
	return
end

function BattleActorMgr:onPlayHitCue(attackerId, targetId, hitCue)
	local attacker = self.actors[attackerId]
	local fashionTag

	if attacker then
		fashionTag = attacker.fashionTag
	end

	local target = self.actors[targetId]

	if hitCue then
		self:_playCueList(targetId, target, hitCue, attackerId, fashionTag)
	end
end

function BattleActorMgr:onPlayAtkCue(attackerId, baseId, atkCue, baseCue)
	local attacker = self.actors[attackerId]
	local fashionTag

	if attacker then
		fashionTag = attacker.fashionTag
	end

	local target = self.actors[baseId]

	if atkCue then
		self:_playCueList(attackerId, attacker, atkCue, nil, fashionTag)
	end

	if baseCue then
		self:_playCueList(baseId, target, baseCue, attackerId, fashionTag)
	end
end

function BattleActorMgr:_playCueList(cueTargetId, cueTarget, cueData, attackerId, fashionTag)
	local cues = cueData.cueList

	attackerId = attackerId or cueTargetId

	if not cueTarget then
		return
	end

	for i, cueId in ipairs(cues) do
		self:tryPlayCue(cueTargetId, cueTarget, cueId, attackerId, fashionTag)
	end
end

function BattleActorMgr:shouldPlayCue(actorId, cueId, attackerId)
	return CueManager.shouldPlayCue(cueId, false, true)
end

function BattleActorMgr:onSpecialDamage(target, dmg, damageType, isCrit, attackerId)
	local attacker = self.actors[attackerId]

	if attacker then
		attacker:onSpecialDamage(damageType)
	end
end

function BattleActorMgr:tryPlayCue(targetId, target, cueId, attackerId, fashionTag)
	if self:shouldPlayCue(targetId, cueId, attackerId) then
		target:PlayCue(cueId, self.actors[attackerId], fashionTag)
	end
end

function BattleActorMgr:onPause()
	for _, actor in pairs(self.actors) do
		actor.pauseDict.battle = true
		actor.pauseEffDict.battle = true

		actor:refreshPause()
	end

	CueManager.pauseTimerCue()
	Framework.CameraSystem.CameraManager.PauseCameraAnimator(1)
end

function BattleActorMgr:onResume()
	for _, actor in pairs(self.actors) do
		actor.pauseDict.battle = nil
		actor.pauseEffDict.battle = nil

		actor:refreshPause()
		actor:refreshMana()
	end

	CueManager.resumeTimerCue()
	Framework.CameraSystem.CameraManager.PauseCameraAnimator(0)

	local battleDlg = UIManager.tryGetUI(self.battleState.mainDlgName)

	if battleDlg and battleDlg.onResume then
		battleDlg:onResume()
	end
end

function BattleActorMgr:onBattleWave()
	if self.showActor then
		self.showActor:onShowSummonAnim()
	end
end

function BattleActorMgr:onAddTrap(trapId, coordX, coordY)
	local trapData = ResBattleTrap[trapId]

	if trapData and trapData.effect then
		if not self.trapDict then
			self.trapDict = {}
		end

		local newData = {
			trapId,
			coordX,
			coordY
		}
		local pos = self:getPosition(coordX, coordY)

		newData[4] = EffectManager:getFreedomEffectAsync("Effects/" .. trapData.effect, pos, nil, true, Const.EFFECT_LIFE_MODE.LogicControl, 0)

		table.insert(self.trapDict, newData)
	end
end

function BattleActorMgr:onDelTrap(trapId, coordX, coordY)
	if self.trapDict then
		for index, info in ipairs(self.trapDict) do
			if info[1] == trapId and info[2] == coordX and info[3] == coordY then
				EffectManager:releaseEffect(info[4])
				table.remove(self.trapDict, index)

				break
			end
		end
	end

	local trapData = ResBattleTrap[trapId]

	if trapData and trapData.del_effect then
		local pos = self:getPosition(coordX, coordY)

		EffectManager:getFreedomEffectAsync("Effects/" .. trapData.del_effect, pos, nil, true)
	end
end

function BattleActorMgr:onAddWeather(weather, attacker)
	self:clearHeroWeatherEff()

	local weatherData = ResBattleWeather[weather]

	if weatherData and weatherData.effect then
		if not self.weatherEffs then
			self.weatherEffs = {}
		end

		if not self.weatherEffs[weather] then
			self.weatherEffs[weather] = EffectManager:getFreedomEffectAsync(weatherData.effect, self.centerPosition, nil, true, Const.EFFECT_LIFE_MODE.LogicControl, 0)
		end
	end
end

function BattleActorMgr:onDelWeather(weather)
	if self.weatherEffs and self.weatherEffs[weather] then
		EffectManager:releaseEffect(self.weatherEffs[weather])

		self.weatherEffs[weather] = nil
	end

	self:checkWeatherEff()
end

function BattleActorMgr:checkWeatherEff()
	if (self.weatherEffs == nil or next(self.weatherEffs) == nil) and self.battleState.relicHero and not self.heroWeatherEff then
		local heroEff = self.battleState.relicHero:getRelicValueByKey(Const.RELIC_WEATHER_EFF)

		if heroEff then
			self.heroWeatherEff = EffectManager:getFreedomEffectAsync(heroEff, self.centerPosition, nil, true, Const.EFFECT_LIFE_MODE.LogicControl, 0)
		end
	end
end

function BattleActorMgr:clearHeroRelicEff()
	self:clearHeroWeatherEff()

	if self.heroCueInst then
		for cueId, insId in pairs(self.heroCueInst) do
			CueManager.releaseCue(nil, cueId, insId)
		end

		self.heroCueInst = nil
	end
end

function BattleActorMgr:clearHeroWeatherEff()
	if self.heroWeatherEff then
		EffectManager:releaseEffect(self.heroWeatherEff)

		self.heroWeatherEff = nil
	end
end

function BattleActorMgr:onActionEnd(actionEnd)
	self.actionEnd = actionEnd

	for _, actor in pairs(self.actors) do
		actor:refreshMana()
	end
end

function BattleActorMgr:onSpecialDamageRecord(actId, isInit, args)
	local battleDlg = UIManager.tryGetUI(self.battleState.mainDlgName)

	if battleDlg and battleDlg.panelBossBlood then
		battleDlg.panelBossBlood:onSpecialDamageRecord(isInit, args)
	elseif isInit then
		self.specialDamageArgs = args
	end
end

function BattleActorMgr:onUseSkill(entityId, skillID, skillType, cameraPrepare, cameraPrepareDuration, cardId)
	if self.hasPet then
		if self.friendPet and entityId == self.friendPet.id then
			self:_playPetActorSkillAnim(self.friendPet.battleCommonData, self.friendPet.camp)
		elseif self.enemyPet and entityId == self.enemyPet.id then
			self:_playPetActorSkillAnim(self.enemyPet.battleCommonData, self.enemyPet.camp)
		end
	end
end

function BattleActorMgr:_playPetActorSkillAnim(petData, camp)
	local pos = self:getPetInitPosition(camp)

	if pos then
		local modelId = petData.model
		local animator = petData.anim_name
		local actionId = petData.action_id
		local newActor = AnimActor.GetAnimActor(modelId, animator, Const.MODEL_TYPE.ShowDrag)

		if camp == BattleConst.CAMP_PLAYER then
			newActor:initPosition(pos, self.leftDir)
		else
			newActor:initPosition(pos, -self.leftDir)
			newActor:setModelMirror(true)
		end

		newActor:playActionById(actionId)
		newActor:setAliveTime(petData.skill_all_time / 30)
	end
end

function BattleActorMgr:getPetInitPosition(camp)
	local gridConfig = self.matrixInstance.bObjMgr.GridConfig

	if gridConfig.PET_INIT_POS then
		local outPosX = gridConfig.PET_INIT_POS[1]
		local outPosY = gridConfig.PET_INIT_POS[2]

		if camp ~= BattleConst.CAMP_PLAYER then
			outPosX = self.LR_LEN - 1 - outPosX
		end

		local pos = self:getPosition(outPosX, outPosY)

		if gridConfig.PET_INIT_POS[3] then
			pos.y = pos.y + gridConfig.PET_INIT_POS[3]
		end

		return pos
	end
end

function BattleActorMgr:onPetSkill()
	return
end

function BattleActorMgr:getDragReuseModel(actor)
	local pos = actor.pos

	if DragPlane.inRunning and pos then
		if actor.camp ~= BattleConst.CAMP_PLAYER then
			pos = -pos
		end

		local dragObj = DragPlane.fieldObjs[pos]

		if dragObj and dragObj.entityModel and dragObj.entityModel:isLoaded() and dragObj.entityModel:canReuse(actor.commonModelId, Const.MODEL_TYPE.Default, Const.MODEL_LOD_LV1) then
			local reuseModel = dragObj.entityModel

			dragObj.entityModel = nil

			if reuseModel and reuseModel.modelGameObject then
				reuseModel.modelGameObject.transform.parent = nil
			end

			return reuseModel
		end
	end
end

function BattleActorMgr:clearAllTrap()
	if self.trapDict then
		for _, info in ipairs(self.trapDict) do
			EffectManager:releaseEffect(info[4])
		end

		self.trapDict = nil
	end

	if self.weatherEffs then
		for _, info in pairs(self.weatherEffs) do
			EffectManager:releaseEffect(info)
		end

		self.weatherEffs = nil
	end
end

function BattleActorMgr:onActorSkillHide()
	EffectManager:hideEffectGroup(0)

	self.sceneEfxHide = true
end

function BattleActorMgr:onActorSkillHideCancel()
	if self.sceneEfxHide then
		EffectManager:reshowEffectGroup(0)

		self.sceneEfxHide = nil
	end
end

function BattleActorMgr:onSkillPause()
	if not self.inSkillPause then
		self.inSkillPause = true

		EffectManager:pauseEffectGroup(BattleConst.SKILL_PAUSE_EFF_GROUP)
	end
end

function BattleActorMgr:cancelSkillPause()
	if self.inSkillPause then
		self.inSkillPause = false

		EffectManager:resumeEffectGroup(BattleConst.SKILL_PAUSE_EFF_GROUP)
	end
end

function BattleActorMgr:getExtraSpeed()
	if self.maxSpeed == 8 then
		return BattleConst.SPEED_UP3
	else
		return BattleConst.SPEED_UP2
	end
end

return BattleActorMgr
