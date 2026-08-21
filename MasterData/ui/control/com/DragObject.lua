-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Control\\Com\\DragObject.lua

local UIUtils = require("Framework.UI.UIUtils")
local Model = require("Entity/Model")
local ModelTool = require("Entity/ModelTool")
local DragLogo = require("UI/Control/Logo/DragLogo")
local BattleConst = require("Common/FrameBattle/BattleConst")
local BattleStateData = require("Common/FrameBattle/BattleObject/BattleStateData")
local EntityFactory = Framework.Entity.EntityFactory
local START_ENTITY_ID = BattleConst.DRAG_OBJECT_START
local DragObject = Class("DragObject")

DragObject._curID = START_ENTITY_ID

function DragObject:ctor(mgr, objectInfo, pos, camp)
	self.mgr = mgr
	self.did = DragObject._curID
	DragObject._curID = self.did + 1
	self.pos = pos
	self.isPlayer = camp == BattleConst.CAMP_PLAYER
	self.blockPos = {}

	self:put2Pos(pos)
	self:_initModel(objectInfo)

	self.mEventDragPut = nil
	self.mEventDragEnter = nil
	self.mEventDragLeave = nil
	self.mEventDragCatch = nil
	self.mEventDragClick = nil
	self.ready = false
end

function DragObject:onReady()
	self.ready = true

	if self.logo and self.modelVisible then
		self.logo:setVisible(true)
	end
end

function DragObject:onBattleStart()
	if self.logo then
		self.logo:setVisible(false)
	end
end

function DragObject:checkStartCue(playerState)
	if not playerState then
		return
	end

	if not self.isPlayer then
		return
	end

	local stateData = BattleStateData.getStateData(playerState, 1)

	if not stateData then
		return
	end

	local formationCue = stateData.formationCue

	if stateData.conditionName == "race" and formationCue then
		if self.modelLoaded then
			if self.hero and self.hero.camp == stateData.conditionValue or self.monster and self.monster.camp == stateData.conditionValue then
				CueManager.playCue(self, formationCue)
			end
		else
			self.cachedPlayerState = playerState
		end
	end
end

local SUPPORT_ALL_CUE = 10000043

function DragObject:showSupportAllCue(pos)
	if not self.supportAllCueId then
		self.supportAllCueId = EffectManager:getFreedomEffectAsync("Effects/Scene/Battlefield/efx_Battlefield_support_04.prefab", pos, nil, true)
	else
		local controller = Framework.EffectSystem.EffectFactory.GetEffectController(self.supportAllCueId)

		if controller then
			controller:SetFreedomEffect(pos, Vector3.zero)
		end
	end
end

function DragObject:hideSupportAllCue()
	if self.supportAllCueId then
		EffectManager:releaseEffect(self.supportAllCueId)

		self.supportAllCueId = nil
	end
end

function DragObject:destroy()
	if self.entityModel then
		self.entityModel:destroy()

		self.entityModel = nil
	end

	if self.logo then
		self.logo:destroy()

		self.logo = nil
	end

	self:hideSupportAllCue()
	EntityFactory.ReleaseEntity(self.did)
end

function DragObject:_initModel(info)
	local modelData = {}

	modelData.model_type = Const.MODEL_TYPE.ShowDrag

	if info.monster then
		self.monster = info.monster
		self.isMisteryMan = self.monster.id == BattleConst.HIDE_FORMATION_MONSTER_ID

		local data = self.monster.resData

		modelData.model_id = data.model

		if data.eliteType and data.eliteType > 0 and (not data.big_monster or not (data.big_monster > 0)) then
			modelData.scale = 1.2
		end

		if GameFsm.getCurState().battleType == BattleConst.BATTLE_TYPE_RENT then
			local rentData = GameFsm.getCurState().battlePreInfo.rentData

			if rentData then
				local taskId = rentData.taskId
				local teamBattle = rentData.teamId and rentData.teamId > 0
				local stageConfig = utils.getRentStageData(taskId, teamBattle, ClientUtils.getMainStageLevelNum(), rentData.svrMaxStage)

				self.monster.level = stageConfig.show_level
			end
		end
	else
		self.hero = info.hero
		modelData.model_id = self.hero:getShowModelId()
		self.fashionTag = self.hero:getFashionTag()
	end

	modelData.use_lod = Const.MODEL_LOD_LV1
	self.entityModel = Model(Slot(self.onModelLoadedEnd, self))

	self.entityModel:setModelData(modelData)
	self.entityModel:loadGameObject()
end

function DragObject:onModelLoadedEnd()
	self.modelLoaded = true

	local go = self.entityModel.modelGameObject

	go.transform.parent = self._obj.transform
	go.transform.localPosition = Vector3.zero

	self.entityModel:setModelLayer(self._obj.layer)

	if not self.isPlayer then
		self.entityModel:mirrorModel(true)
	end

	self.entityModel:setOutline(true)
	self.entityModel:setTonemapping(true)

	if self.hero then
		ModelTool.addBaseModel(self.entityModel:getModelInsId(), self.hero:getShowBaseModelId(), 1, Const.HERO_BASE_TYPE.Battle)
	else
		ModelTool.addBaseModel(self.entityModel:getModelInsId(), self.monster.resData.model, 1, Const.HERO_BASE_TYPE.Battle)
	end

	if SceneManager.isCurSceneRainy() then
		self.entityModel:setRainyMat(true)
	end

	local collider = self.controller:AddBoxCollider()

	collider.size = Vector3(1.5, 1.5, 1.5)

	local rotStart = -(GameFsm.getCurState().gridAngle or 0)

	if self.pos and self.pos < 0 then
		self.controller:SetRotation(0, rotStart + 90, 0)
	else
		self.controller:SetRotation(0, rotStart - 90, 0)
	end

	self:initLogo()

	if self.cachedPlayerState then
		self:checkStartCue(self.cachedPlayerState)

		self.cachedPlayerState = nil
	end

	if self.mgr.inObjectEntering and self.pos then
		self:setModelVisible(false)
		self.mgr.onCheckObjEnter()
	else
		self:setModelVisible(true)
	end
end

function DragObject:onEnterGame()
	if self.modelLoaded then
		self:setModelVisible(true)
		self:playAnimator("OnDrag")
	end
end

function DragObject:isModelInShow()
	return self.modelLoaded and self:getModelVisible()
end

function DragObject:getModelVisible()
	return self.modelVisible
end

function DragObject:setModelVisible(visible)
	if self.modelLoaded then
		self.modelVisible = visible

		self.entityModel:setVisible(visible)

		if self.logo then
			self.logo:setVisible(visible)
		end
	end
end

function DragObject:playAnimator(animName)
	if self.entityModel then
		self.entityModel:playAnimation(animName, true)
	end
end

function DragObject:playDragVoice()
	if self.hero then
		CueManager.playHeroVocal(self.hero.id, Const.HERO_VOCAL_DRAG, self.fashionTag)
	end
end

function DragObject:onSupportEffect()
	if self.logo then
		self.logo:playBattleSupport()
	end
end

function DragObject:onSupportedEffect()
	if self.logo then
		self.logo:playBattleSupport()
	end
end

function DragObject:playBattleOvercome(isLoop)
	if self.logo then
		self.logo:playBattleOvercome(isLoop)
	end
end

function DragObject:stopBattleOvercome()
	if self.logo then
		self.logo:stopBattleOvercome()
	end
end

function DragObject:initLogo()
	if self.isMisteryMan then
		return
	end

	self.logo = DragLogo(self.controller, "System/TeamSet/TeamSetLogo")

	if self.logo then
		self.logo:setTarget(self.hero or self.monster, self.hero)

		if GameFsm.getCurState().battleType == BattleConst.BATTLE_TYPE_MAZE then
			self.logo:showHP(self.hero or self.monster)
		elseif GameFsm.getCurState().battleType == BattleConst.BATTLE_TYPE_SEASON_TOWER then
			if self.monster and self.monster.mazeHp then
				self.logo:showHP(self.monster)
			end
		elseif GameFsm.getCurState().battleType == BattleConst.BATTLE_TYPE_CIRCLE then
			local state = GameFsm.getCurState()

			if not state.battlePreInfo.circleBattleData.isBoss and self.monster then
				self.logo:showHP(self.monster)
			end
		elseif GameFsm.getCurState().battleType == BattleConst.BATTLE_TYPE_NEW_MAZE and self.hero then
			self.logo:setSolder(self.hero)
		end

		if self.hero and self.isPlayer and self.mgr.teamLimitCheck then
			local isOk = false

			for _, team in ipairs(self.mgr.teamLimitCheck.limitTeam) do
				if self.hero.team == team then
					isOk = true

					break
				end
			end

			if not isOk then
				self.logo:showCheck(true)
			end
		end
	end
end

function DragObject:setTargetEff(skillType)
	if self.logo then
		self.logo:setTargetEff(skillType)
	end
end

function DragObject:closeTargetEff()
	if self.logo then
		self.logo:closeTargetEff()
	end
end

function DragObject:setSelect(isSelect)
	if self.logo then
		self.logo:setSelect(isSelect)
	end
end

function DragObject:put2Pos(pos)
	self.controller = UIUtils.SetDragTarget(self, self.did, pos or 99)
	self._obj = self.controller.gameObject
end

function DragObject:OnDragEnter(gridInfo)
	if self.mEventDragEnter then
		self:mEventDragEnter(gridInfo)
	end
end

function DragObject:OnDragLeave(gridInfo)
	if self.mEventDragLeave then
		self:mEventDragLeave(gridInfo)
	end
end

function DragObject:OnDragGet(gridInfo)
	if self.mEventDragCatch then
		self:mEventDragCatch(gridInfo)
	end
end

function DragObject:OnDragClick(gridInfo)
	if self.mEventDragClick then
		self:mEventDragClick(gridInfo)
	end
end

function DragObject:OnDragPut(gridInfo)
	if self.mEventDragPut then
		self:mEventDragPut(gridInfo)
	end
end

return DragObject
