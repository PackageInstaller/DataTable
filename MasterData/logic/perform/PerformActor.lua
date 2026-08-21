-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Logic\\perform\\PerformActor.lua

local Entity = require("Entity/Entity")
local Model = require("Entity/Model")
local BattleConst = require("Common/FrameBattle/BattleConst")
local BattleStateData = require("Common/FrameBattle/BattleObject/BattleStateData")
local ResMonster = require("ClientData/ResMonster")
local Monster = require("Common/Object/Monster")
local ResHero = require("ClientData/ResHero")
local ModelTool = require("Entity/ModelTool")
local DragPlane = require("UI/Control/Com/DragPlane")
local ResSkillConfig = require("ClientData/ResSkillConfig")
local FlyIconUtils = require("UI/Common/FlyIconUtils")
local BattleActorReceiver = require("Logic/battle/BattleActorReceiver")
local Vector3 = Vector3
local CueManager = CueManager
local CameraManager = Framework.CameraSystem.CameraManager
local Const = Const
local EventCenter = EventCenter
local listenerFuncConfig = {
	onHitedAnim = BattleConst.MATRIX_EVENT_ENTITY_HITED_AIM,
	onHitedOffset = BattleConst.MATRIX_EVENT_ENTITY_HITED_OFFSET,
	PauseOn = BattleConst.MATRIX_EVENT_ENTITY_PAUSEBH,
	PauseOff = BattleConst.MATRIX_EVENT_ENTITY_CANCELPAUSEBH,
	onSkillJump = BattleConst.MATRIX_EVENT_ENTITY_SKILL_JUMP,
	onSkillBack = BattleConst.MATRIX_EVENT_ENTITY_SKILL_BACK,
	playEffect = BattleConst.MATRIX_EVENT_ENTITY_PLAY_EFFECT,
	onSetMove = BattleConst.MATRIX_EVENT_ENTITY_MOVE,
	onBehaviorAnim = BattleConst.MATRIX_EVENT_ENTITY_BEHAVIOR_ANIM,
	onQuickMove = BattleConst.MATRIX_EVENT_ENTITY_MOVE_TO,
	onStateEnter = BattleConst.MATRIX_EVENT_ENTITY_STATE_ENTER,
	onStateLeave = BattleConst.MATRIX_EVENT_ENTITY_STATE_EXIT,
	onIdleAnim = BattleConst.MATRIX_EVENT_ENTITY_IDLE_ANIM,
	onPlaySpecialAnim = BattleConst.MATRIX_EVENT_ENTITY_PLAY_ANIM,
	onSelfDead = BattleConst.MATRIX_EVENT_ENTITY_DEAD,
	onAddState = BattleConst.MATRIX_EVENT_ENTITY_ADDSTATE,
	onDelState = BattleConst.MATRIX_EVENT_ENTITY_DELSTATE,
	outOfPos = BattleConst.MATRIX_EVENT_ENTITY_MOVE_OUT_POS
}
local strClassName = "PerformActor"
local PerformActor = Class(strClassName, Entity)

MixinClass(PerformActor, BattleActorReceiver)

function PerformActor:ctor(entitiId, name, actorMgr, playerInfo)
	self.actorMgr = actorMgr
	self.camp = playerInfo.camp
	self.entityId = playerInfo.entityID
	self.gameObject = self.controller.gameObject

	if playerInfo.monsterID then
		self.monsterID = playerInfo.monsterID
		self.battleCommonData = ResMonster[self.monsterID]
		self.tmpMonsterObj = Monster(self.monsterID)
		self.weaponType = self.tmpMonsterObj:getShowAniName()
		self.name = self.battleCommonData.name
		self.controllerPath = ModelTool.getControllerPath(self.battleCommonData.path, self.weaponType)
		self.bigMonster = self.battleCommonData.big_monster and self.battleCommonData.big_monster > 0
	else
		self.gid = playerInfo.gid
		self.heroObj = playerInfo.heroObj
		self.heroID = playerInfo.heroID
		self.battleCommonData = ResHero[self.heroID] or {}
		self.name = self.battleCommonData.hero_name
		self.weaponType = self.heroObj:getShowAniName()
		self.controllerPath = ModelTool.getControllerPath(self.battleCommonData.ani_con_path, self.weaponType)
	end

	self.pos = playerInfo.pos

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
	self.hideModelDict = {}
	self.pauseDict = {}
	self.pauseEffDict = {}
	self.stateCues = {}

	self:addMovementAux()

	self.modelLoaded = false

	self:createModel()
end

function PerformActor:onReuse(entityId, playerInfo)
	self.hideModelDict = {}
	self.stateCues = {}

	if self.coAutoRun then
		coroutine.stop(self.coAutoRun)

		self.coAutoRun = nil
	end

	if self.coDead then
		coroutine.stop(self.coDead)

		self.coDead = nil
	end

	if self.coHideModelInSkill then
		coroutine.stop(self.coHideModelInSkill)

		self.coHideModelInSkill = nil
	end

	CueManager.clearCue(self.entityId, self)
	EventCenter.removeEventListenerGroup(self, listenerFuncConfig, self.entityId)

	self.entityId = entityId
	self.pos = playerInfo.pos
	self.coordX = playerInfo.coordX
	self.coordY = playerInfo.coordY

	EventCenter.addEventListenerGroup(self, listenerFuncConfig, self.entityId)
	self.controller.gameObject:SetActive(true)
end

function PerformActor:createModel()
	if not self.modelLoadedCallback then
		self.modelLoadedCallback = Slot(self.OnModelLoadedEnd, self)
	end

	if self.entityModel ~= nil then
		self.entityModel:destroy()

		self.entityModel = nil
	end

	self.modelLoaded = false

	if self.entityModel == nil then
		local modelData = self:_getActorModelInfo()

		if modelData then
			modelData.use_lod = Const.MODEL_LOD_LV1
			self.entityModel = Model(self.modelLoadedCallback)

			self.entityModel:setModelData(modelData)
			self.entityModel:loadGameObject(nil, false)
		end
	end

	return self.entityModel
end

function PerformActor:_getActorModelInfo()
	local modelData = {}

	if self.commonModelId then
		modelData.model_type = Const.MODEL_TYPE.Default
		modelData.model_id = self.commonModelId
		modelData.animator = ModelTool.getControllerPathByType(self.commonModelId, Const.MODEL_TYPE.PerformAct)

		if self.battleCommonData.eliteType and self.battleCommonData.eliteType > 0 and not self.bigMonster then
			modelData.scale = 1.2
		end

		return modelData
	end
end

function PerformActor:lookatGrid()
	if self.combatUnit and self.combatUnit.showCoordX then
		return
	end

	if self.movementAux then
		if self.camp == self.actorMgr.LEFT_CAMP then
			self.movementAux:FaceTo(self:getPosition() + self.actorMgr.leftDir)
			self:refreshModelFace(false)
		else
			self.movementAux:FaceTo(self:getPosition() - self.actorMgr.leftDir)
			self:refreshModelFace(true)
		end
	end
end

function PerformActor:getLayer()
	return Const.LAYER_PLAYER
end

function PerformActor:OnModelLoadedEnd()
	PerformActor.super.OnModelLoadedEnd(self)

	self.modelObject = self.entityModel.modelGameObject

	self.entityModel:setModelAlwaysAnim()
	self.entityModel:setOutline(true)
	self.entityModel:setTonemapping(true)

	if self.heroID then
		self.entityModel:setFootStep(CueManager.getFootStepGroupId(self.heroID))
	end

	if SceneManager.isCurSceneRainy() then
		self.entityModel:setRainyMat(true)
	end

	self:refreshModelFace(self.camp ~= self.actorMgr.LEFT_CAMP)

	self.animator = self.entityModel:getAnimator()

	self.entityModel:showModel(true)
	EventCenter.addEventListenerGroup(self, listenerFuncConfig, self.entityId)
	self.actorMgr:onOneModelLoaded()
end

function PerformActor:startBattle()
	self:initProp()
end

function PerformActor:destroy()
	if self.coAutoRun then
		coroutine.stop(self.coAutoRun)
	end

	if self.coHideModelInSkill then
		coroutine.stop(self.coHideModelInSkill)

		self.coHideModelInSkill = nil
	end

	if self.coDead then
		coroutine.stop(self.coDead)
	end

	self.coDead = nil
	self.coAutoRun = nil
	self.actorMgr = nil

	EventCenter.removeEventListenerGroup(self, listenerFuncConfig, self.entityId)
	CueManager.clearCue(self.entityId, self)
	PerformActor.super.destroy(self)

	self.modelObject = nil
end

function PerformActor:initProp()
	self.combatUnit = self.actorMgr.matrixInstance:getObjectByKey(self.entityId)

	if self.combatUnit then
		self.hp = self.combatUnit.hp
		self.mhp = self.combatUnit.mhp
		self.shield = self.combatUnit.shield
		self.level = self.combatUnit.level
		self.coordX = self.combatUnit.coordX
		self.coordY = self.combatUnit.coordY
	end
end

function PerformActor:setMute(isMute)
	self.isMute = isMute

	if self.entityModel then
		self.entityModel:setMute(isMute, true)
	end
end

function PerformActor:PlayCue(cueId, attacker, fashionTag)
	return CueManager.playCue(self, cueId, attacker, fashionTag or self.fashionTag)
end

function PerformActor:refreshModelVisible()
	if not self.combatUnit:isAlive() then
		return
	end

	local visible = true

	if self.modelObject then
		for reason, value in pairs(self.hideModelDict) do
			visible = false

			break
		end

		if self.modelLoaded and self.entityModel then
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
	end
end

function PerformActor:autoRunTo(startPos, endPos)
	self.preAnim = "Run"

	self:playAnimator("Run")

	self.inRunningAnim = true

	local speedDir = endPos - startPos
	local len = speedDir:Magnitude()
	local moveTime = len / BattleConst.ACTOR_SPEED

	if self.coAutoRun then
		coroutine.stop(self.coAutoRun)
	end

	self.coAutoRun = coroutine.start(self.autoStopRun, self, moveTime)
	speedDir = Vector3.Normalize(speedDir) * BattleConst.ACTOR_SPEED

	if speedDir then
		self.movementAux:startMoving(speedDir.x, speedDir.y, speedDir.z, moveTime)
		self.movementAux:FaceTo(endPos)
	end
end

function PerformActor:autoStopRun(moveTime)
	coroutine.wait(moveTime)

	self.coAutoRun = nil

	if self.inRunningAnim then
		self.preAnim = "idle"

		self:playAnimator("idle")

		self.inRunningAnim = false
	end
end

function PerformActor:runToEnd(endPos)
	if not self.inRunningAnim then
		self.preAnim = "Run"

		self:playAnimator("Run")

		self.inRunningAnim = true
	end

	local startPos = self:getPosition()
	local speedDir = endPos - startPos
	local len = speedDir:Magnitude()
	local moveTime = len / BattleConst.ACTOR_SPEED

	if self.coAutoRun then
		coroutine.stop(self.coAutoRun)
	end

	self.coAutoRun = coroutine.start(self.autoStopRun, self, moveTime)
	speedDir = Vector3.Normalize(speedDir) * BattleConst.ACTOR_SPEED

	if speedDir then
		self.movementAux:startMoving(speedDir.x, speedDir.y, speedDir.z, moveTime)
		self.movementAux:FaceTo(endPos)
	end
end

function PerformActor:onAddState(userId, stateId, level)
	local stateData = BattleStateData.getStateData(stateId, level) or {}
	local cueId = stateData.state_effect

	if cueId and CueManager.shouldPlayCue(cueId, false, true) then
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
			if userId ~= self.entityId then
				local startActor = self.actorMgr.actors[userId]

				if startActor then
					local index = CueManager.playLinkEffect(cueId, startActor, self, startActor.fashionTag)

					userCues[stateId] = {
						cueId,
						index
					}
				end
			end
		elseif CueManager.cueIsAudio(cueId) and self.isMute then
			-- block empty
		else
			local index = self:PlayCue(cueId)

			userCues[stateId] = {
				cueId,
				index
			}
		end
	end
end

function PerformActor:onDelState(userId, stateId)
	local stateData = BattleStateData.getStateData(stateId, 1) or {}

	if self.stateCues[userId] and self.stateCues[userId][stateId] then
		CueManager.releaseCue(self, self.stateCues[userId][stateId][1], self.stateCues[userId][stateId][2])

		self.stateCues[userId][stateId] = nil
	end
end

function PerformActor:showStateNum(isDebuff, showId)
	return
end

function PerformActor:refreshModelFace(needMirror)
	self.modelIsMirror = needMirror
end

function PerformActor:getCameraAngleFix(...)
	local nowR = self.gameObject.transform.rotation.eulerAngles

	return self.actorMgr.gridAngle - 90 - nowR.y
end

function PerformActor:onSelfDead()
	if self.inPause then
		self:PauseOff()
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

function PerformActor:coOnDead()
	coroutine.wait(2)

	self.coDead = nil

	CueManager.clearCue(self.id)
end

function PerformActor:onBattleOver()
	if self.inPause then
		self:PauseOff()
	end

	if self.combatUnit:isAlive() and self.movementAux and self.inRunningAnim then
		self:playAnimator("idle")

		self.inRunningAnim = false

		local pos = self:getPosition()

		self.movementAux:stopMoving(pos.x, pos.y, pos.z, 1)
	end

	self.over = true
end

function PerformActor:onDeadEffect()
	EffectManager:getFreedomEffectAsync("Effects/Heros/Common/efx_common_death.prefab", self:getPosition(), self:getRotation(), true, nil, nil, true)
end

function PerformActor:onSpecDeadEffect(speEff)
	local rot = self:getRotation()
	local newFace = math.random(360)

	rot.y = newFace

	EffectManager:getFreedomEffectAsync(speEff, self:getPosition(), rot, true, nil, nil, true)
end

function PerformActor:onDeadHide()
	self.entityModel:showModel(false)

	self.hideModelDict.dead = true

	self:refreshModelVisible()
	self.controller.gameObject:SetActive(false)
end

function PerformActor:onMoneyEffect()
	local mainStageDlg = UIManager.getUI("mainStageDlg", nil, false)

	if mainStageDlg then
		FlyIconUtils.setFlyEffect3DToUI(self:getPosition(), mainStageDlg.efxEndAnchor, "Effects/UI/efx_ui_icon_trail.prefab", true)
	end
end

function PerformActor:modelTransform(commonModelId, animator, defaultAnim)
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

function PerformActor:recoverModelTransform()
	if not self.oldCommonModelId then
		return
	end

	self.commonModelId = self.oldCommonModelId
	self.controllerPath = self.oldControllerPath

	if self.modelLoaded and self.entityModel then
		local modelData = self:_getActorModelInfo()

		self.entityModel:changeModelAll(modelData)
	end
end

function PerformActor:_afterModelTransform(oldLayer, defaultAnim)
	if oldLayer then
		self.entityModel:setModelLayer(oldLayer)
		self.entityModel:setModelAlwaysAnim()
		self.entityModel:setOutline(true)
	end

	if defaultAnim then
		self:playAnimator(defaultAnim)
	end
end

return PerformActor
