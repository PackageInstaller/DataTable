-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/skill/performance/standard/VictoryPerformance.lua

module("logic.battle.skill.performance.standard.VictoryPerformance", package.seeall)

local M = class("VictoryPerformance", AbstractGlobalReusable)

function M:ctor()
	self._resLoader = BattleMultiResLoaderIncludeModel.New()
	self._goVictory = nil
	self._entityId = false
	self._modelCode = false
end

function M:reset()
	if self._goVictory then
		goutil.destroy(self._goVictory)

		self._goVictory = nil
	end

	self._resLoader:clear()
	self:_resumeSceneEnvironment()

	self._entityId = nil
	self._modelCode = nil
	self._hasSetupEnvironment = false
end

function M:destroy()
	self:reset()
end

function M:start()
	if goutil.isNil(self._goVictory) then
		self:_startloadRes()
	else
		self:showVictory()
	end
end

function M:_setupSceneEnvironment()
	self._hasSetupEnvironment = true

	SkillPerformanceAssistant:hideSceneObjectRoot()
	SkillPerformanceAssistant:hideUIProperties()

	local fullscreenRoot = ViewMgr.instance:getRoot(ViewRootType.FullScreen)

	goutil.setActive(fullscreenRoot, false)

	local battleScene = SceneMgr.instance:getScene(SceneType.Battle)

	battleScene.stage:activeAdditionScene()
	battleScene.light:activePerformanceLight()

	local lightGo = battleScene.light:getAdditionLightGameObject()

	self._lightWrapper = lightGo:GetComponent(typeof(SpaceX.LightWrapper))
	self._sceneId = battleScene:getSceneId()
end

function M:_resumeSceneEnvironment()
	if not self._hasSetupEnvironment then
		return
	end

	self._hasSetupEnvironment = false

	SkillPerformanceAssistant:showSceneObjectRoot()
	SkillPerformanceAssistant:showUIProperties()

	local fullscreenRoot = ViewMgr.instance:getRoot(ViewRootType.FullScreen)

	goutil.setActive(fullscreenRoot, true)

	local curSceneType = SceneMgr.instance:getCurSceneType()
	local curSceneId = SceneMgr.instance:getCurSceneId()
	local battleScene = SceneMgr.instance:getScene(SceneType.Battle)

	if curSceneId == self._sceneId and curSceneType > 0 then
		self._lightWrapper:ApplyOriginalColorAndRotation()
		battleScene.stage:activeMainScene()
		battleScene.light:activeNormalLight()
	end

	self._sceneId = false
end

function M:_startloadRes()
	VirtualCameraMgr.instance:setBlendDuration(0)

	self._entityId, self._modelCode = self:_getRandomEnityIdAndModelId()

	self._resLoader:addNormalRes(BattleResourceName.CalculateVictory)

	if self._entityId then
		local modelCO = ModelConfig.instance:getModelConfig(self._modelCode)

		self._resLoader:addModelRes(ModelCOUtil.getHighModelUrl(modelCO))
	end

	self._resLoader:load(self._onResourceLoaded, self)
end

function M:_onResourceLoaded()
	local resource = self._resLoader:getResource(BattleResourceName.CalculateVictory)

	self._goVictory = goutil.clone(resource:GetMainAsset())

	self:_setupSceneEnvironment()
	self:_setupPosAndForward()
	self:_showSelectUnit()
	self:_playTimeline()
end

function M:_setupPosAndForward()
	local checkerBoardCO = BattleConfig.instance:getCheckerBoardCO(self._sceneId)
	local battleSceneResName = checkerBoardCO.battleSceneResName
	local calcuteCO = SceneConfig.instance:getBattleCalcuteCO()
	local calcuteInfo = calcuteCO[battleSceneResName]

	if calcuteInfo then
		self._victoryPos = calcuteInfo.victoryPos
		self._victoryRotation = calcuteInfo.victoryRotation
	else
		self._victoryPos = Vector3.New(5, 0, 5)
		self._victoryRotation = Vector3.New(0, 0, 0)
	end

	if self._goVictory then
		local sceneRoot = SceneMgr.instance:getSceneRoot()

		goutil.addChildToParent(self._goVictory, sceneRoot)
		goutil.setActive(self._goVictory, true)
		Astral.TransformUtil.SetPos(self._goVictory.transform, self._victoryPos.x, self._victoryPos.y, self._victoryPos.z)
		Astral.TransformUtil.SetLocalRotation(self._goVictory.transform, self._victoryRotation.x, self._victoryRotation.y, self._victoryRotation.z)
		self._lightWrapper:SetRotation(self._victoryRotation.x + 20, self._victoryRotation.y + 180 - 44, self._victoryRotation.z)
	end
end

function M:_showSelectUnit()
	local unit = self:_getUnit(self._entityId)

	if unit then
		local calcuteCO = SceneConfig.instance:getBattleCalcuteHeroCO()
		local calcuteInfo = calcuteCO[unit.property:getModelCode()]

		if calcuteInfo then
			self._heroPos = calcuteInfo.victoryPos
			self._heroRotation = calcuteInfo.victoryRotation
		else
			self._heroPos = Vector3.New(0, 0, 0)
			self._heroRotation = Vector3.New(0, 0, 0)
		end

		local heroroot = goutil.findChild(self._goVictory, "heroroot")

		SkillPerformanceAssistant:switchUnit2HighModel(unit)
		unit.property:clearAllState()
		unit.stateEffect:clearAllStateEffect()
		unit.meshModel:lookAtDirVec3(MeshModelDirection.Forward)
		unit.meshModel:setPlaySpeed(1)
		unit.meshModel:play(UnitAnimState.VictoryIdle, true, true)
		unit.effectPlayer:clearAllEffect()

		local goUnit = unit:getGameObject()

		BattleUnitGenerator.addUnitToRoot(unit, heroroot)
		Astral.TransformUtil.SetLocalPos(unit.go.transform, 0, 0, 0)
		Astral.TransformUtil.SetLocalPos(heroroot.transform, self._heroPos.x, self._heroPos.y, self._heroPos.z)
		Astral.TransformUtil.SetLocalRotation(heroroot.transform, self._heroRotation.x, self._heroRotation.y, self._heroRotation.z)
	end
end

function M:_playTimeline()
	if self._entityId then
		local audioName = "speech_" .. self._entityId .. "_shengli"

		if CriwareAudioEnum == nil or CriwareAudioEnum[audioName] == nil then
			if enableLog then
				print("play victory audio error!")
			end

			return
		end

		CriwareAudioFacade.instance:playOnceSEbyId(CriwareAudioEnum[audioName], nil, nil, nil)
	end
end

function M:_getUnit(entityId)
	local unitMgr = BattleMgr.instance:getUnitMgr()
	local unit = unitMgr:getUnitByEntityCode(entityId)

	return unit
end

function M:_getRandomEnityIdAndModelId()
	local entityIds = BattleMgr.instance:getUnitMgr():getMyUnits(false)

	if #entityIds == 0 then
		entityIds = BattleCalculateModel.instance:getCalculateHeroIdList()
	end

	local aliveEntityIds = BattleTableUtil.getTempList()

	for k, entityId in ipairs(entityIds) do
		if not BattleMgr.instance:getUnitMgr():isDeadUnit(entityId) then
			local entityCO = BattleEntityCOAdapter:getSharedEntityCOAdapter(entityId)
			local modelCode = entityCO:getModelCode()
			local modelCO = ModelConfig.instance:getModelConfig(modelCode)
			local isMonsterModel = ModelCOUtil.isMonsterModel(modelCO)

			if not isMonsterModel then
				table.insert(aliveEntityIds, {
					entityId = entityId,
					modelCode = modelCode
				})
			end
		end
	end

	local entityId, modelCode

	if #aliveEntityIds > 0 then
		math.randomseed(os.time())

		local idx = math.random(1, #aliveEntityIds)

		entityId = aliveEntityIds[idx].entityId
		modelCode = aliveEntityIds[idx].modelCode
	end

	BattleTableUtil.releaseTempList(aliveEntityIds)

	return entityId, modelCode
end

function M:hideVictory()
	goutil.setActive(self._goVictory, false)
end

function M:showVictory()
	goutil.setActive(self._goVictory, true)
end

return M
