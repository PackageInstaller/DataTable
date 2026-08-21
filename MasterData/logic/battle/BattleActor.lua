-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Logic\\battle\\BattleActor.lua

local Entity = require("Entity/Entity")
local Model = require("Entity/Model")
local BattleLogo = require("UI/Control/Logo/BattleLogo")
local BattleConst = require("Common/FrameBattle/BattleConst")
local BattleStateData = require("Common/FrameBattle/BattleObject/BattleStateData")
local ResMonster = require("ClientData/ResMonster")
local Monster = require("Common/Object/Monster")
local ResHero = require("ClientData/ResHero")
local ModelTool = require("Entity/ModelTool")
local ResSkillConfig = require("ClientData/ResSkillConfig")
local BattleActorReceiver = require("Logic/battle/BattleActorReceiver")
local ResRoleImageData = require("ClientData/ResRoleImageData")
local Vector3 = Vector3
local CueManager = CueManager
local CameraManager = Framework.CameraSystem.CameraManager
local Const = Const
local EventCenter = EventCenter
local UserData = require("Helper/UserData")
local IS_PUBLISH_VERSION = IS_PUBLISH_VERSION
local strClassName = "BattleActor"
local BattleActor = Class(strClassName, Entity)

MixinClass(BattleActor, BattleActorReceiver)

function BattleActor:ctor(entitiId, name, actorMgr, playerInfo, activeOnLoaded)
	self.loaded = false
	self.actorMgr = actorMgr
	self.entityId = playerInfo.entityID
	self.camp = playerInfo.camp
	self.pos = playerInfo.pos

	if playerInfo.monsterID then
		self.monsterID = playerInfo.monsterID
		self.battleCommonData = ResMonster[self.monsterID]
		self.tmpMonsterObj = Monster(self.monsterID)
		self.weaponType = self.tmpMonsterObj:getShowAniName()
		self.name = self.battleCommonData.name
		self.controllerPath = ModelTool.getControllerPath(self.battleCommonData.path, self.weaponType)
		self.bigMonster = self.battleCommonData.big_monster and self.battleCommonData.big_monster > 0
	else
		self.heroID = playerInfo.heroID
		self.heroObj = playerInfo.heroObj
		self.battleCommonData = ResHero[self.heroID] or {}
		self.name = self.battleCommonData.hero_name
		self.weaponType = self.heroObj:getShowAniName()
		self.controllerPath = ModelTool.getControllerPath(self.battleCommonData.ani_con_path, self.weaponType)

		if self.battleCommonData.ori_star >= 5 then
			local portId = self.heroID

			if self.heroObj then
				portId = self.heroObj:getShowPortId()
			end

			if ResRoleImageData[portId] then
				self.skillShortShowId = portId
			end
		end
	end

	if self.heroObj then
		self.commonModelId = self.heroObj:getShowModelId()
		self.fashionTag = self.heroObj:getFashionTag()
	else
		self.commonModelId = self.battleCommonData.model

		if self.tmpMonsterObj then
			self.fashionTag = self.tmpMonsterObj:getFashionTag()
		end
	end

	self.coordX = playerInfo.coordX
	self.coordY = playerInfo.coordY

	if self.commonModelId then
		CueManager.preloadCue(self.commonModelId)
	end

	self.activeOnLoaded = activeOnLoaded
	self.hideModelDict = {}
	self.pauseDict = {}
	self.pauseEffDict = {}
	self.stateCues = {}
	self.showDamageNum = true
	self.hideLogo = self.actorMgr.config and self.actorMgr.config.hideBlood or self.bigMonster
	self.rookieHideDamage = self.actorMgr.config and self.actorMgr.config.hideBlood

	self:addMovementAux()
	self:initProp()
	self:createModel()
end

function BattleActor:destroy()
	if self.coDead then
		coroutine.stop(self.coDead)
	end

	if self.coShowLogo then
		coroutine.stop(self.coShowLogo)
	end

	if self.logo then
		self.logo:destroy()

		self.logo = nil
	end

	if self.coHideModelInSkill then
		coroutine.stop(self.coHideModelInSkill)

		self.coHideModelInSkill = nil
	end

	if self.numCacheTimer then
		self.numCacheTimer:Stop()
	end

	self.coDead = nil
	self.coShowLogo = nil
	self.actorMgr = nil

	self:detachListener()
	CueManager.clearCue(self.id, self)
	BattleActor.super.destroy(self)

	self.modelObject = nil
end

function BattleActor:initProp()
	if self.combatUnit == nil then
		self.combatUnit = self.actorMgr.matrixInstance:getObjectByKey(self.entityId)

		if self.combatUnit then
			self:_setPosition()

			self.hp = self.combatUnit.hp
			self.mhp = self.combatUnit.mhp
			self.shield = self.combatUnit.shield
			self.level = self.combatUnit.level
			self.logicWeaponType = self.combatUnit.weaponType
			self.coordX = self.combatUnit.coordX
			self.coordY = self.combatUnit.coordY

			if self.logo then
				self:initLogo()
			end
		end
	end
end

function BattleActor:refreshShow()
	local combatUnit = self.actorMgr.matrixInstance:getObjectByKey(self.entityId)

	if self.loaded and combatUnit then
		self:initProp()
		self:onHpChange(self.hp, self.mhp)
		self:_setPosition()

		if combatUnit:isAlive() then
			if self.logicWeaponType ~= combatUnit.weaponType then
				self:onReborn(1, self.coordX, self.coordY, combatUnit.weaponItem)
			end
		else
			self:_onDead()
		end

		local states = combatUnit.stateGroup.states

		for _attackerId, _states in pairs(states) do
			for stateId, state in pairs(_states) do
				if state.stateData then
					self:onAddState(state.attackerId, state.stateId, state.level, state.timeRemained)
				end
			end
		end
	end
end

function BattleActor:chaseFrameRefresh()
	local combatUnit = self.actorMgr.matrixInstance:getObjectByKey(self.entityId)

	if combatUnit then
		self:initProp()
		self:onHpChange(self.hp, self.mhp)
		self:_setPosition()

		local states = combatUnit.stateGroup.states

		for _attackerId, _states in pairs(states) do
			for stateId, state in pairs(_states) do
				if state.stateData then
					self:onAddState(state.attackerId, state.stateId, state.level, state.timeRemained)
				end
			end
		end

		local inSkill = combatUnit.frameNumber < combatUnit.resumePauseFrame

		if inSkill and combatUnit.skillHideDict then
			local hideArgs = combatUnit.skillHideDict

			self:HandleSkillHide(unpack(hideArgs))
		end
	end
end

function BattleActor:createModel()
	if not self.modelLoadedCallback then
		self.modelLoadedCallback = Slot(self.OnModelLoadedEnd, self)
	end

	if self.entityModel ~= nil then
		self.entityModel:destroy()

		self.entityModel = nil
	end

	if self.entityModel == nil then
		local reuseModel = self.actorMgr:getDragReuseModel(self)

		if reuseModel then
			self.modelReuse = true
			self.entityModel = reuseModel

			reuseModel:changeModelByCommonModelId(self.commonModelId, Const.MODEL_TYPE.Default, self.controllerPath, Const.MODEL_LOD_LV1, self.modelLoadedCallback)
		else
			local modelData = self:_getActorModelInfo()

			if modelData then
				modelData.use_lod = Const.MODEL_LOD_LV1
				self.entityModel = Model(self.modelLoadedCallback, self.id)

				self.entityModel:setModelData(modelData)
				self.entityModel:loadGameObject(nil, false)
			end
		end
	end

	return self.entityModel
end

function BattleActor:_getActorModelInfo()
	local modelData = {}

	if self.commonModelId then
		modelData.model_type = Const.MODEL_TYPE.Default
		modelData.model_id = self.commonModelId
		modelData.animator = self.controllerPath

		if self.battleCommonData.eliteType and self.battleCommonData.eliteType > 0 and not self.bigMonster then
			modelData.scale = 1.2
		end

		return modelData
	end
end

function BattleActor:OnModelLoadedEnd()
	BattleActor.super.OnModelLoadedEnd(self)

	self.loaded = true
	self.modelObject = self.entityModel.modelGameObject

	self:initLogo()
	self.entityModel:setModelAlwaysAnim()
	self.entityModel:setOutline(true)
	self.entityModel:setTonemapping(true)

	if SceneManager.isCurSceneRainy() then
		self.entityModel:setRainyMat(true)
	end

	self:refreshModelFace(self.camp ~= BattleConst.CAMP_PLAYER)

	self.animator = self.entityModel:getAnimator()

	self:attachListener()
	self.entityModel:showModel(false)
	self:_setPosition()

	if self.activeOnLoaded then
		self:onEntityStart()
	end
end

function BattleActor:getLayer()
	return Const.LAYER_PLAYER
end

function BattleActor:initLogo()
	if self.logo == nil then
		self.logo = BattleLogo(self.controller, "System/Battle/BattleField/BattleBloodPanel", 0, 0, self)

		self.logo:setCamp(self.camp == BattleConst.CAMP_PLAYER)
		self.logo:setElite(self.battleCommonData.eliteType)
		self:setLogoVisible(false)
	end

	if self.combatUnit then
		self.logo:setHp(self.combatUnit.hp, self.combatUnit.mhp)
		self.logo:setMana(self.combatUnit.mana, 100, 0)
	end
end

function BattleActor:setLogoVisible(isVisible)
	if self.coShowLogo then
		self.initLogoVisible = isVisible
	end

	if self.hideLogo or GameFsm.getCurState().inWatchMode then
		isVisible = false
	end

	if self.logo then
		self.logo:setHide(not isVisible)
	end
end

function BattleActor:refreshLogoVisible()
	local visible = true

	for reason, value in pairs(self.hideModelDict) do
		visible = false

		break
	end

	self:setLogoVisible(visible)
end

function BattleActor:showNum(num, numType, state, isCache)
	if Const.REVIEW_VERSION then
		return
	end

	if self.showDamageNum and not self.rookieHideDamage then
		if isCache then
			self:addShowNumCache({
				num,
				numType,
				state
			})
		else
			BattleActor.super.showNum(self, num, numType, state or "")
		end
	end
end

function BattleActor:PlayCue(cueId, attacker, fashionTag)
	return CueManager.playCue(self, cueId, attacker, fashionTag or self.fashionTag)
end

function BattleActor:OnEntitySelected()
	return
end

function BattleActor:OnEntityLongTap()
	return
end

function BattleActor:addBoxCollider()
	if not self.gameObject then
		return
	end

	self.boxCollider = self.controller:AddBoxCollider()
	self.boxCollider.center = Vector3(0, 1, 0)
	self.boxCollider.size = Vector3(2, 2, 1)
	self.boxCollider.isTrigger = true
end

function BattleActor:refreshModelVisible()
	if not self.combatUnit:isAlive() then
		return
	end

	local visible = true

	for reason, value in pairs(self.hideModelDict) do
		visible = false

		break
	end

	if self.modelObject and self.modelLoaded and self.entityModel then
		if visible then
			if self.visibleLayer then
				self.entityModel:setModelLayer(self.visibleLayer)

				self.visibleLayer = nil
			end
		else
			if not self.visibleLayer then
				self.visibleLayer = self.entityModel:getModelLayer()
			end

			self.entityModel:setModelLayer(Const.LAYER_PLAYER_HIDE)
		end
	end

	if visible then
		EffectManager:reshowEffectGroup(self.entityId)
	else
		EffectManager:hideEffectGroup(self.entityId)
	end

	self:setLogoVisible(visible)
end

local listenerFuncConfig = {
	onDamage = BattleConst.MATRIX_EVENT_ENTITY_DAMAGE,
	onHitedAnim = BattleConst.MATRIX_EVENT_ENTITY_HITED_AIM,
	onHitedOffset = BattleConst.MATRIX_EVENT_ENTITY_HITED_OFFSET,
	onHpChange = BattleConst.MATRIX_EVENT_ENTITY_HPCHANGE,
	onShieldChange = BattleConst.MATRIX_EVENT_ENTITY_SHIELD_CHANGE,
	onAddState = BattleConst.MATRIX_EVENT_ENTITY_ADDSTATE,
	onDelState = BattleConst.MATRIX_EVENT_ENTITY_DELSTATE,
	onStateShow = BattleConst.MATRIX_EVENT_ENTITY_STATESHOW,
	PauseOn = BattleConst.MATRIX_EVENT_ENTITY_PAUSEBH,
	HandleSkillHide = BattleConst.MATRIX_EVENT_ENTITY_SKILL_HIDE,
	HandleSkillHideCancel = BattleConst.MATRIX_EVENT_ENTITY_SKILL_HIDE_CANCEL,
	PauseOff = BattleConst.MATRIX_EVENT_ENTITY_CANCELPAUSEBH,
	onUseSkill = BattleConst.MATRIX_EVENT_ENTITY_SKILL_BEGIN,
	onUseSkillEnd = BattleConst.MATRIX_EVENT_ENTITY_SKILL_END,
	onSkillJump = BattleConst.MATRIX_EVENT_ENTITY_SKILL_JUMP,
	onSkillBack = BattleConst.MATRIX_EVENT_ENTITY_SKILL_BACK,
	playEffect = BattleConst.MATRIX_EVENT_ENTITY_PLAY_EFFECT,
	onSelfDead = BattleConst.MATRIX_EVENT_ENTITY_DEAD,
	onEntityReborn = BattleConst.MATRIX_EVENT_REBORN_ENTITY,
	onEntityRebornStart = BattleConst.MATRIX_EVENT_REBORN_ENTITY_START,
	onPlayCamera = BattleConst.MATRIX_EVENT_ENTITY_PLAY_CAMERA,
	onSetMana = BattleConst.MATRIX_EVENT_ENTITY_SETMANA,
	onSetMove = BattleConst.MATRIX_EVENT_ENTITY_MOVE,
	onBehaviorAnim = BattleConst.MATRIX_EVENT_ENTITY_BEHAVIOR_ANIM,
	onQuickMove = BattleConst.MATRIX_EVENT_ENTITY_MOVE_TO,
	onStateEnter = BattleConst.MATRIX_EVENT_ENTITY_STATE_ENTER,
	onStateLeave = BattleConst.MATRIX_EVENT_ENTITY_STATE_EXIT,
	onRaiseSomething = BattleConst.MATRIX_EVENT_ENTITY_SOMETHING,
	onManaChanged = BattleConst.MATRIX_EVENT_ENTITY_MANA_CHANGED,
	onIdleAnim = BattleConst.MATRIX_EVENT_ENTITY_IDLE_ANIM,
	onPlaySpecialAnim = BattleConst.MATRIX_EVENT_ENTITY_PLAY_ANIM,
	onSkillMovie = BattleConst.MATRIX_EVENT_ENTITY_SKILL_MOVIE,
	outOfPos = BattleConst.MATRIX_EVENT_ENTITY_MOVE_OUT_POS
}

function BattleActor:attachListener()
	EventCenter.addEventListenerGroup(self, listenerFuncConfig, self.entityId)
end

function BattleActor:detachListener(...)
	EventCenter.removeEventListenerGroup(self, listenerFuncConfig, self.entityId)
end

function BattleActor:onSpecialDamage(damageType)
	if damageType == BattleConst.DAMAGE_TYPE_VAMPIRE then
		if self.actorMgr:shouldPlayCue(self.entityId, 25, self.entityId) then
			CueManager.playCue(self, 25, nil, self.fashionTag)
		end
	elseif damageType == BattleConst.DAMAGE_TYPE_REBOUND and self.actorMgr:shouldPlayCue(self.entityId, 24, self.entityId) then
		CueManager.playCue(self, 24, nil, self.fashionTag)
	end
end

function BattleActor:coOnDead()
	coroutine.wait(2)
	self:_onDead()
end

function BattleActor:_onDead()
	if self.numCacheTimer then
		self.numCacheTimer:Stop()
	end

	CueManager.clearCue(self.id)
	self.entityModel:showModel(false)

	self.hideModelDict.dead = true

	self:refreshModelVisible()

	if self.logo then
		self.logo:setVisible(false)
	end

	self.controller.gameObject:SetActive(false)
end

function BattleActor:onAddState(userId, stateId, level)
	local stateData = BattleStateData.getStateData(stateId, level) or {}

	if stateData.numShowId then
		local isDebuff = stateData.state_type == BattleConst.STATE_TYPE_DEBUFF

		self:showStateNum(isDebuff, stateData.numShowId, stateData.numShowNow ~= 1)
	end

	if stateData.testNumShowId and not IS_PUBLISH_VERSION then
		local isDebuff = stateData.state_type == BattleConst.STATE_TYPE_DEBUFF

		self:showStateNum(isDebuff, stateData.testNumShowId, stateData.numShowNow ~= 1)
	end

	local cueId = stateData.state_effect

	if cueId and self.actorMgr:shouldPlayCue(self.entityId, cueId, userId) then
		if not self.stateCues[userId] then
			self.stateCues[userId] = {}
		end

		local userCues = self.stateCues[userId]

		if userCues[stateId] then
			if userCues[stateId][1] == cueId then
				return
			else
				CueManager.releaseCue(self, userCues[stateId][1], userCues[stateId][2])
			end
		end

		if stateData[BattleConst.STATE_LINK] then
			if userId ~= self.id then
				local startActor = self.actorMgr.actors[userId]

				if startActor then
					local index = CueManager.playLinkEffect(cueId, startActor, self, startActor.fashionTag)

					userCues[stateId] = {
						cueId,
						index
					}
				end
			end
		else
			local startActor = self.actorMgr.actors[userId]

			if startActor and startActor.fashionTag then
				local index = self:PlayCue(cueId, nil, startActor.fashionTag)

				userCues[stateId] = {
					cueId,
					index
				}
			else
				local index = self:PlayCue(cueId)

				userCues[stateId] = {
					cueId,
					index
				}
			end
		end
	end

	if self.logo and stateData.show_state then
		self.logo:onAddState(userId, stateId, level, stateData)
	end
end

function BattleActor:onDelState(userId, stateId)
	local stateData = BattleStateData.getStateData(stateId, 1) or {}

	if self.stateCues[userId] and self.stateCues[userId][stateId] then
		CueManager.releaseCue(self, self.stateCues[userId][stateId][1], self.stateCues[userId][stateId][2])

		self.stateCues[userId][stateId] = nil
	end

	if self.logo and stateData.show_state then
		self.logo:onDelState(userId, stateId)
	end
end

function BattleActor:_refreshStateCue()
	if self.stateCues then
		for userId, userCues in pairs(self.stateCues) do
			for stateId, stateInfo in pairs(userCues) do
				local cueId = stateInfo[1]
				local efxInsId = stateInfo[2]

				if CueManager.isLinkEffect(cueId) then
					CueManager.releaseCue(self, cueId, efxInsId)

					local startActor = self.actorMgr and self.actorMgr.actors and self.actorMgr.actors[userId]

					if startActor then
						local index = CueManager.playLinkEffect(cueId, startActor, self, startActor.fashionTag)

						userCues[stateId] = {
							cueId,
							index
						}
					end
				elseif CueManager.isNormalEffect(cueId) then
					CueManager.releaseCue(self, cueId, efxInsId)

					local index = self:PlayCue(cueId)

					userCues[stateId] = {
						cueId,
						index
					}
				end
			end
		end
	end
end

function BattleActor:onStateShow(propName, isDebuff)
	local showId

	if BattleConst.STATE_PROP_SHOW[propName] then
		if isDebuff then
			showId = BattleConst.STATE_PROP_SHOW[propName][2]
		else
			showId = BattleConst.STATE_PROP_SHOW[propName][1]
		end
	end

	if showId then
		self:showStateNum(isDebuff, showId, true)
	end
end

function BattleActor:addShowNumCache(cache)
	if not self.numCacheTimer then
		self.numCacheTimer = Timer.New(Slot(self.onShowNumCache, self), 1, -1, true)
	end

	if not self.showNumCache then
		self.showNumCache = {}
	end

	if self.numCacheTimer:IsRunning() then
		table.insert(self.showNumCache, cache)
	else
		table.insert(self.showNumCache, cache)
		self:onShowNumCache()
		self.numCacheTimer:Start()
	end
end

function BattleActor:onShowNumCache()
	if not self.showNumCache or not (#self.showNumCache > 0) then
		self.numCacheTimer:Stop()

		return
	end

	local cache = table.remove(self.showNumCache, 1)

	self:showNum(cache[1], cache[2], cache[3])
end

function BattleActor:showStateNum(isDebuff, showId, isCache)
	local showStr = UIConst.getBattleShowStateInfo(showId)

	if showStr and showStr ~= "" then
		if self.camp == BattleConst.CAMP_PLAYER then
			if isDebuff then
				self:showNum(0, Const.NUM_TYPE.STATE_R, showStr, isCache)
			else
				self:showNum(0, Const.NUM_TYPE.STATE_B, showStr, isCache)
			end
		elseif isDebuff then
			self:showNum(0, Const.NUM_TYPE.STATE_B, showStr, isCache)
		else
			self:showNum(0, Const.NUM_TYPE.STATE_R, showStr, isCache)
		end
	end
end

function BattleActor:cancelSkillHide()
	if self.coHideModelInSkill then
		coroutine.stop(self.coHideModelInSkill)

		self.coHideModelInSkill = nil
	end

	if self.hideModelDict.skill then
		self.hideModelDict.skill = nil

		self:refreshModelVisible()
	end
end

function BattleActor:coSkillHide(hideDelayTime)
	coroutine.wait(hideDelayTime)

	self.hideModelDict.skill = true

	self:refreshModelVisible()
end

function BattleActor:HandleSkillHide(skillSelf, targets, hideDelayTime, cardId, hideEffect)
	if self.over then
		return
	end

	self.inSkillPause = true

	self:refreshMana()

	if not skillSelf then
		local selfIsTarget = false

		if targets then
			for _, tid in ipairs(targets) do
				if tid == self.id then
					selfIsTarget = true

					break
				end
			end
		else
			selfIsTarget = true
		end

		if not selfIsTarget then
			if hideDelayTime and hideDelayTime > 0 then
				if self.coHideModelInSkill then
					coroutine.stop(self.coHideModelInSkill)

					self.coHideModelInSkill = nil
				end

				self.coHideModelInSkill = coroutine.start(self.coSkillHide, self, hideDelayTime / 30)
			else
				self.hideModelDict.skill = true

				self:refreshModelVisible()
			end
		else
			self:cancelSkillHide()
		end

		if hideEffect then
			EffectManager:hideEffectGroup(self.entityId)
		end
	else
		local cardData = ResSkillConfig[cardId] or {}

		cardData = cardData[1]

		if cardData and cardData.skill_cue == 1 then
			CueManager.playCue(self, 10002001, nil, self.fashionTag)
		end

		if hideEffect then
			self.actorMgr:onActorSkillHide()
		end

		self.actorMgr:onSkillPause()
	end
end

function BattleActor:HandleSkillHideCancel()
	self.inSkillPause = false

	self:cancelSkillHide()
	self:refreshMana()
	EffectManager:reshowEffectGroup(self.entityId)
	self.actorMgr:onActorSkillHideCancel()

	local sequenceFramePlayer = UIManager.getUI("sequenceFramePlayer", nil, false)

	if sequenceFramePlayer then
		sequenceFramePlayer:stopVideo()
	end

	self.actorMgr:cancelSkillPause()
end

function BattleActor:onEntityStart(showNow)
	if self.loaded then
		self:initProp()

		if self.coShowLogo then
			coroutine.stop(self.coShowLogo)

			self.coShowLogo = nil
		end

		if showNow then
			self.coShowLogo = coroutine.start(self.coStartShowLogo, self, true)
		else
			self.coShowLogo = coroutine.start(self.coStartShowLogo, self)
		end

		EffectManager:getFreedomEffectAsync("Effects/Heros/Common/efx_common_change_03.prefab", self:getPosition(), self:getRotation(), true)
	else
		self.activeOnLoaded = true
	end
end

function BattleActor:coStartShowLogo(showNow)
	if not showNow then
		coroutine.wait(0.6)
	end

	if not self.combatUnit or not not self.combatUnit:isAlive() then
		self.entityModel:showModel(true)

		if self.initLogoVisible == nil then
			self:setLogoVisible(true)
		end

		coroutine.wait(0.01)

		if self.started then
			self:refreshMana()
		end

		if self.preAnim then
			self:playAnimator(self.preAnim)
		end
	else
		self:_onDead()
	end

	self.coShowLogo = nil
end

function BattleActor:lookatGrid()
	if self.combatUnit and self.combatUnit.showCoordX then
		return
	end

	if self.movementAux then
		if self.camp == BattleConst.CAMP_PLAYER then
			self.movementAux:FaceTo(self:getPosition() + self.actorMgr.leftDir)
			self:refreshModelFace(false)

			self.oriMirror = false
		else
			self.movementAux:FaceTo(self:getPosition() - self.actorMgr.leftDir)
			self:refreshModelFace(true)

			self.oriMirror = true
		end
	end
end

function BattleActor:refreshModelFace(needMirror)
	self.modelIsMirror = needMirror

	if self.entityModel then
		self.entityModel:mirrorModel(needMirror)
	end
end

function BattleActor:onSkillPrepareAnimatorOver()
	return
end

function BattleActor:onSkillPrepareCameraTimeout(duration)
	coroutine.wait(duration)
	CameraManager.SwitchToNode(0.3, 0)

	self.coPrepareCamera = nil
end

function BattleActor:getCameraAngleFix(...)
	local nowR = self.gameObject.transform.rotation.eulerAngles

	return self.actorMgr.gridAngle - 90 - nowR.y
end

function BattleActor:onUseSkill(skillID, skillType, cameraPrepare, cameraPrepareDuration, cardId)
	if self.coPrepareCamera then
		coroutine.stop(self.coPrepareCamera)

		self.coPrepareCamera = nil
	end

	if not self.actorMgr.disablePrepareCamera and cameraPrepare and cameraPrepare > 0 then
		local nowR = self.gameObject.transform.rotation.eulerAngles

		CameraManager.PlayCameraAnimator("Camera/CameraCurvy/Battle/cam_battle_ultra_prepare.anim", self.gameObject.transform, self.onSkillPrepareAnimatorOver, 0.3, self.actorMgr.gridAngle - 90 - nowR.y, 0)

		if cameraPrepareDuration and cameraPrepareDuration > 0 then
			self.coPrepareCamera = coroutine.start(self.onSkillPrepareCameraTimeout, self, cameraPrepareDuration / 30)
		end
	end

	local needVocal = false

	if skillType == BattleConst.ATTACK_SKILL then
		if self:_isShortMode() then
			if self.skillShortShowId then
				UIManager.getUI("battleSkillDlg", true):setData(self.skillShortShowId, self.camp == BattleConst.CAMP_PLAYER)
			end

			needVocal = true
		else
			local speed = self:_speedUp()

			if speed == BattleConst.SPEED_UP2 or speed == BattleConst.SPEED_UP3 then
				needVocal = not self:_hasUltimaVocal(cardId, Const.HERO_VOCAL_ULTIMATEX4)
			elseif speed == BattleConst.SPEED_UP1 then
				needVocal = not self:_hasUltimaVocal(cardId, Const.HERO_VOCAL_ULTIMATEX2)
			else
				needVocal = not self:_hasUltimaVocal(cardId, Const.HERO_VOCAL_ULTIMATEX1)
			end
		end
	end

	if needVocal then
		local speed = self:_speedUp()

		if speed == BattleConst.SPEED_UP2 or speed == BattleConst.SPEED_UP3 then
			self:_playUltimatVocal(cardId, Const.HERO_VOCAL_ULTIMATESHORTX4)
		elseif speed == BattleConst.SPEED_UP1 then
			self:_playUltimatVocal(cardId, Const.HERO_VOCAL_ULTIMATESHORTX2)
		else
			self:_playUltimatVocal(cardId, Const.HERO_VOCAL_ULTIMATESHORTX1)
		end
	end
end

function BattleActor:onSkillMovie(movieCue)
	self.actorMgr:onPlayAtkCue(self.id, self.id, movieCue)

	if not self:_isShortMode() then
		local speed = self:_speedUp()

		if speed == BattleConst.SPEED_UP2 or speed == BattleConst.SPEED_UP3 then
			self:_playUltimatVocal(self.combatUnit.nowCardId, Const.HERO_VOCAL_ULTIMATEX4)
		elseif speed == BattleConst.SPEED_UP1 then
			self:_playUltimatVocal(self.combatUnit.nowCardId, Const.HERO_VOCAL_ULTIMATEX2)
		else
			self:_playUltimatVocal(self.combatUnit.nowCardId, Const.HERO_VOCAL_ULTIMATEX1)
		end
	end
end

function BattleActor:_speedUp(...)
	local speed = UserData.loadCommonData(BattleConst.SPEED_KEY) or BattleConst.SPEED_NORMAL

	if self.actorMgr and self.actorMgr.needExtraSpeed then
		local extraSpeed = UserData.loadCommonData(BattleConst.EXTRA_SPEED_KEY) or BattleConst.SPEED_NORMAL

		if extraSpeed == self.actorMgr:getExtraSpeed() then
			return extraSpeed
		else
			return speed
		end
	else
		return speed
	end
end

function BattleActor:_isShortMode(...)
	return self.combatUnit and self.combatUnit.skillInShortMode
end

function BattleActor:_playUltimatVocal(cardId, vocalType)
	if not cardId then
		return
	end

	if ResSkillConfig[cardId] and ResSkillConfig[cardId][1] then
		local vocalIndex = ResSkillConfig[cardId][1].skill_vocal

		if vocalIndex then
			CueManager.playHeroVocal(vocalIndex, vocalType, self.fashionTag)
		end
	end
end

function BattleActor:_hasUltimaVocal(cardId, vocalType)
	if not cardId then
		return false
	end

	if ResSkillConfig[cardId] and ResSkillConfig[cardId][1] then
		local vocalIndex = ResSkillConfig[cardId][1].skill_vocal

		if vocalIndex then
			return CueManager.heroHasVocal(vocalIndex, vocalType)
		end
	end

	return false
end

function BattleActor:onUseSkillEnd()
	return
end

function BattleActor:_setPosition()
	if not self.combatUnit then
		return
	end

	if self.combatUnit.outOfPos then
		self:outOfPos()
	else
		local pos = self.actorMgr:getPosition(self.combatUnit.realCoordX, self.combatUnit.realCoordY)

		self.position = {
			x = pos.x,
			y = pos.y,
			z = pos.z
		}

		self:teleport(pos.x, pos.y, pos.z)
		self:lookatGrid()
	end
end

local BURNING_NUM = 7
local ICE_NUM = 210

function BattleActor:onDamage(dmg, damageType, isCrit, attackerId, extraHitedInfo, cardId)
	local isSkill = ResSkillConfig[cardId] and ResSkillConfig[cardId][1].skill_type == BattleConst.SKILL_CONFIG_SKILL
	local numType

	if BattleConst.HURT_DICT[damageType] or damageType == BattleConst.DAMAGE_TYPE_REBOUND or damageType == BattleConst.DAMAGE_TYPE_LINK or damageType == BattleConst.DAMAGE_TYPE_DISPEL_SHIELD or damageType == BattleConst.DAMAGE_TYPE_HP_REMOVE or damageType == BattleConst.DAMAGE_TYPE_HP_SHIELD_REMOVE then
		local inLeft = self.actorMgr:inLeft(attackerId, self.id)

		if isSkill and damageType ~= BattleConst.DAMAGE_TYPE_HP_REMOVE then
			if isCrit then
				if inLeft then
					numType = Const.NUM_TYPE.SKILLCRIT_L
				else
					numType = Const.NUM_TYPE.SKILLCRIT_R
				end
			elseif inLeft then
				numType = Const.NUM_TYPE.SKILLLOSE_L
			else
				numType = Const.NUM_TYPE.SKILLLOSE_R
			end
		elseif isCrit then
			if inLeft then
				numType = Const.NUM_TYPE.CRIT_L
			else
				numType = Const.NUM_TYPE.CRIT_R
			end
		elseif inLeft then
			numType = Const.NUM_TYPE.LOSE_L
		else
			numType = Const.NUM_TYPE.LOSE_R
		end

		if extraHitedInfo and extraHitedInfo[3] and extraHitedInfo[3] == 1 then
			self:showNum(dmg, numType, UIConst.getBattleShowStateInfo(BURNING_NUM))
		elseif extraHitedInfo and extraHitedInfo[3] and extraHitedInfo[3] == 2 then
			self:showNum(dmg, numType, UIConst.getBattleShowStateInfo(ICE_NUM))
		else
			self:showNum(dmg, numType)
		end
	elseif damageType == BattleConst.DAMAGE_TYPE_HEAL or damageType == BattleConst.DAMAGE_TYPE_VAMPIRE then
		self:showNum(dmg, Const.NUM_TYPE.ADD)
	elseif damageType == BattleConst.DAMAGE_TYPE_SHIELD then
		self:showNum(dmg, Const.NUM_TYPE.ADD, UIConst.getBattleShowStateInfo(BattleConst.STATE_SHOW_SHIELD))
	elseif damageType == BattleConst.DAMAGE_TYPE_MISS then
		self:showStateNum(false, BattleConst.STATE_SHOW_MISS)
	end
end

function BattleActor:onHpChange(hp, mhp, isDamage)
	local preHp = self.hp

	self.hp = hp
	self.mhp = mhp

	if (not preHp or not (preHp <= 0) or not (self.hp <= 0)) and self.logo then
		self.logo:setHp(self.hp, self.mhp, isDamage)
	end
end

function BattleActor:onShieldChange(shield)
	if self.logo then
		self.logo:setShield(shield)
	end
end

function BattleActor:onEntityReborn()
	return
end

function BattleActor:onEntityRebornStart()
	if self.coDead then
		coroutine.stop(self.coDead)
	end

	self.coDead = nil

	CueManager.clearCue(self.id, self)
	self.entityModel:showModel(true)
	self.controller.gameObject:SetActive(true)

	self.hideModelDict.dead = nil

	if self.logo then
		self.logo:setVisible(true)
	end

	self:refreshModelVisible()
	self:_setPosition()

	self.hp = self.combatUnit.hp

	self:onHpChange(self.hp, self.mhp)
	self:refreshMana()
	self.logo:setMana(self.combatUnit.mana, 100, 0)
end

function BattleActor:onSelfDead()
	if self.numCacheTimer then
		self.numCacheTimer:Stop()
	end

	if self.inPause then
		self.pauseDict = {}
		self.pauseEffDict = {}

		self:refreshPause()
	end

	if self.movementAux then
		self.movementAux:PauseOn()
	end

	self.preAnim = "Die"

	self:playAnimator("Die")

	if self.coDead then
		coroutine.stop(self.coDead)
	end

	self.coDead = coroutine.start(self.coOnDead, self)
end

function BattleActor:onBattleStart()
	self.started = true

	self:refreshMana()
end

function BattleActor:refreshMana()
	if self.logo and self.combatUnit then
		if self.inSkillPause or self.actorMgr.actionEnd then
			self.logo:setMana(self.combatUnit.mana, 100, 0)
		else
			self.logo:setMana(self.combatUnit.mana, 100, self.combatUnit.mana_gen)
		end
	end
end

function BattleActor:onSetMana()
	self:refreshMana()
end

function BattleActor:onManaChanged(value, isKill, notShow)
	if notShow then
		return
	end

	if isKill then
		local showStr = UIConst.getBattleShowStateInfo(BattleConst.STATE_SHOW_KILL)

		if self.camp == BattleConst.CAMP_PLAYER then
			self:showNum(value, Const.NUM_TYPE.KILL_B, showStr)
		else
			self:showNum(value, Const.NUM_TYPE.KILL_R, showStr)
		end
	elseif self.camp == BattleConst.CAMP_PLAYER then
		if value > 0 then
			self:showNum(value, Const.NUM_TYPE.KILL_B, nil, true)
		else
			self:showNum(value, Const.NUM_TYPE.KILL_R, nil, true)
		end
	elseif value > 0 then
		self:showNum(value, Const.NUM_TYPE.KILL_R, nil, true)
	else
		self:showNum(value, Const.NUM_TYPE.KILL_B, nil, true)
	end
end

function BattleActor:onPlayCamera(cameraAnimatorPath, fov)
	if self.coPrepareCamera then
		coroutine.stop(self.coPrepareCamera)

		self.coPrepareCamera = nil
	end

	self:playCameraAnimator(cameraAnimatorPath, fov)
end

function BattleActor:playCameraAnimator(cameraAnimatorPath, fov)
	if self.gameObject then
		if fov and fov > 0 then
			CameraManager.CameraGrp:SetFov(fov, 0)
		end

		if self.modelIsMirror then
			CameraManager.PlayCameraAnimator(cameraAnimatorPath, self.gameObject.transform, self.onCameraAnimatorOver, 0, 0, 1)
		else
			CameraManager.PlayCameraAnimator(cameraAnimatorPath, self.gameObject.transform, self.onCameraAnimatorOver, 0, 0, 0)
		end

		CameraManager.SetClipPlane(0.1, BattleConst.FAR_CLIP_PLANE)
	end
end

function BattleActor:onCameraAnimatorOver()
	CameraManager.CameraGrp:SetFov(25, 0)
	CameraManager.SwitchToNode(0.1, 0)
	CameraManager.SetClipPlane(BattleConst.NEAR_CLIP_PLANE, BattleConst.FAR_CLIP_PLANE)
end

function BattleActor:onBattleOver()
	if self.combatUnit then
		self:PauseOff()

		if self.coPrepareCamera then
			coroutine.stop(self.coPrepareCamera)

			self.coPrepareCamera = nil
		end

		if self.logo then
			self.logo:setVisible(false)
		end

		if self.combatUnit:isAlive() and self.movementAux and self.inRunningAnim then
			self:playAnimator("idle")

			local pos = self:getPosition()

			self.movementAux:stopMoving(pos.x, pos.y, pos.z, 1)
		end
	end

	self.over = true
end

function BattleActor:onRaiseSomething(immuneType)
	local showType

	if immuneType == BattleConst.STATE_IMMUNE_REDUCE_MANA then
		showType = BattleConst.STATE_SHOW_IMMUNE_REDUCE_MANA
	elseif immuneType == BattleConst.STATE_IMMUNE_DEBUFF or immuneType == BattleConst.STATE_IMMUNE_TAUNT then
		showType = BattleConst.STATE_SHOW_IMMUNE
	elseif immuneType == BattleConst.STATE_IMMUNE_SILENCE then
		showType = BattleConst.STATE_SHOW_IMMUNE_SILENCE
	elseif immuneType == BattleConst.ENTITY_SOMETHING_IMMUE_PHYSICS then
		showType = BattleConst.STATE_SHOW_IMMUE_PHYSICS
	elseif immuneType == BattleConst.ENTITY_SOMETHING_IMMUE_MAGIC then
		showType = BattleConst.STATE_SHOW_IMMUE_MAGIC
	elseif immuneType == BattleConst.STATE_IMMUNE_DISARM then
		showType = BattleConst.STATE_SHOW_IMMUNE_DISARM
	elseif immuneType == BattleConst.STATE_IMMUNE_CONTROLLED then
		showType = BattleConst.STATE_SHOW_IMMUNE_CONTROL
	elseif immuneType == BattleConst.STATE_BLOCK_RATE then
		showType = BattleConst.STATE_SHOW_BLOCK
	end

	if showType then
		self:showStateNum(false, showType)
	end
end

function BattleActor:modelTransform(commonModelId, animator, defaultAnim)
	self.oldCommonModelId = self.commonModelId
	self.commonModelId = commonModelId
	self.oldControllerPath = self.controllerPath
	self.controllerPath = animator

	if self.modelLoaded and self.entityModel then
		local modelData = self:_getActorModelInfo()

		if self.fashionTag then
			modelData.fashion_tag = self.fashionTag
		end

		local oldLayer = self.entityModel:getModelLayer()

		self.entityModel:changeModelAll(modelData, Functor(self._afterModelTransform, self, oldLayer, defaultAnim))
	end
end

function BattleActor:recoverModelTransform()
	self.commonModelId = self.oldCommonModelId
	self.controllerPath = self.oldControllerPath

	if self.modelLoaded and self.entityModel then
		local modelData = self:_getActorModelInfo()
		local oldLayer = self.entityModel:getModelLayer()

		self.entityModel:changeModelAll(modelData, Functor(self._afterModelTransform, self, oldLayer))
	end
end

function BattleActor:_afterModelTransform(oldLayer, defaultAnim)
	if oldLayer then
		self.entityModel:setModelLayer(oldLayer)
		self.entityModel:setModelAlwaysAnim()
		self.entityModel:setOutline(true)
	end

	if defaultAnim then
		self:playAnimator(defaultAnim)
	end

	self:_refreshStateCue()
end

function BattleActor:onSetShowArgs(showData)
	self.coordX = showData.boss_pos[1]
	self.coordY = showData.boss_pos[2]

	local pos = self.actorMgr:getPosition(self.coordX, self.coordY)

	self:teleport(pos.x, pos.y, pos.z)
	self.movementAux:FaceTo(self:getPosition() - self.actorMgr.leftDir)

	self.showActorSummonAnim = showData.summon_anim
end

function BattleActor:onShowSummonAnim()
	if self.showActorSummonAnim then
		self:playAnimator(self.showActorSummonAnim)
	end
end

return BattleActor
